import data.parse  as parse
import src.model   as model
import src.metrics as metrics

import test

import os
import time
import torch
import progressbar

from typing_extensions import Iterable


def llm_sql_test(
    model:       model.llm,
    data_path:   str,
    output_path: str,
    result_path: str,
    **hyperparameters
) -> None:

    # Check files are valid
    if not os.path.exists(data_path):
       test.logging.error("Invalid dataset file path")  
       exit(1)

    if not os.path.exists(output_path):
       test.logging.error("Invalid output file path") 
       exit(1)

    if not os.path.exists(result_path):
       test.logging.error("Invalid result file path") 
       exit(1)


    # Set hyperparameters
    if not hyperparameters:
        hyperparameters = {
            "max_length" : 60,          # Adjust for length of SQL statements
            "min_length" : 10,          # Minimum length to avoid incomplete output
            "temperature" : 0.2,        # Low randomness for more deterministic output
            "top_k" : 40,               # Limit token choices to the top 40 tokens
            "top_p" : 0.85,             # Top-p sampling for concise, higher-probability tokens
            "repetition_penalty" : 1.3, # Discourages repetitive structures
            "no_repeat_ngram_size" : 2
        }


    # Set up saves for iterations
    dataset: list[tuple[str, str, str]] = parse.load_dataset(data_path)
    generated_and_expected_queries: list[tuple[str, str]] = []
    runtimes: list[float] = []

    # Generate outputs for prompts
    test.logging.info("RUNNING TEST CASES")
    bar: progressbar.ProgressBar = progressbar.ProgressBar(maxval=len(dataset)).start()
    with open(output_path, 'w+') as output_file:
        for index, data in enumerate(dataset):
            question, query, schema = data

            # prompt engineering
            prompt: str = (
                f"Given the schema of the relavent database(s), generate an SQL statement to answer a question.\n\n"
                f"Prompt: \n\t{question}\n\n"
                f"Schema: \n\t{schema}\n\n"
                f"Note, only respond with a single most accurate SQL statement.\n"
                f"If more information is required, simply respond with \'INSUFFICENT\'."
            )

            # run inference and time it
            runtime: float = time.perf_counter()
            output:  str   = model.infer(
                prompt, 
                hyperparameters=hyperparameters
            )
            runtimes.append(time.perf_counter() - runtime)

            # save results
            generated_and_expected_queries.append((output, query))
            output_file.write(f"PROMPT {index + 1}:\n\n{prompt}\n\n")
            output_file.write(f"RESPONSE {index + 1}:\n\n{output}\n\n")
            output_file.write("=" * 100 + "\n\n")
            
            bar.update(index + 1)
    bar.finish()

    # Check accuracy
    test.logging.info("EVALUATING RESULTS")
    with open(result_path, 'w+') as result_file:

        # Test metadata
        dataset_name:      str   = os.path.splitext(os.path.basename(data_path))[0]
        number_of_queries: int   = len(generated_and_expected_queries)
        hardware_details:  str = ""
        if torch.cuda.is_available():
            hardware_details: str = torch.cuda.get_device_name() + ":" + str(torch.cuda.device_count())

        # Test scores
        BLEU_metric:       float    = metrics.BLEU(generated_and_expected_queries)
        ROUGE_metric:      float    = metrics.ROUGE(generated_and_expected_queries)
        METEOR_metric:     float    = metrics.METEOR(generated_and_expected_queries)
        BERTScore_metrics: Iterable = metrics.BERTScore(generated_and_expected_queries) 
        SemScore_metric:   float    = metrics.SemScore(generated_and_expected_queries)

        # Test results
        result_file.write(
            (
                f"MODEL:    {model.name}\n"
                f"GPU:      {hardware_details}"
                f"DATASET:  {dataset_name}\n"
                f"QUERIES:  {number_of_queries}\n"
                
                "\nACCURACY\n"
                f"BLEU:      {BLEU_metric}\n"
                f"ROUGE:     {ROUGE_metric}\n"
                f"METEOR:    {METEOR_metric}\n"
                f"BERTScore: {BERTScore_metrics}\n"
                f"SemScore:  {SemScore_metric}\n"

                "\nLATENCY\n"
                f"AVG TIME: {sum(runtimes) / len(runtimes)} seconds\n"
                f"MAX TIME: {max(runtimes)} seconds\n"
                f"MIN TIME: {min(runtimes)} seconds"
            )
        )
