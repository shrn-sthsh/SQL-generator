import data.parse  as parse
import src.model   as model
import src.metrics as metrics

import test

import os
import time
import progressbar

from typing_extensions import Iterable, Any


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
            "max_length" : 2048,  # Adjust for length of SQL statements
            "min_length" : 10,    # Minimum length to avoid incomplete output
        }


    # Data
    dataset: list[tuple[str, str, str]] = parse.load_dataset(data_path)

    # Set up saves for iterations
    runtimes:                       list[float]           = []
    generated_and_expected_queries: list[tuple[str, str]] = []

    # Generate outputs for prompts
    test.logging.info("RUNNING TEST CASES")

    test.logging.info(f"TEST MODEL: {model.name.upper()}")
    dataset_name: str = data_path
    if '/' in dataset_name:
        parts: list[str] = dataset_name.split('/')
        if parts:
            dataset_name = parts[-1]
    test.logging.info(f"TEST DATASET: {dataset_name.upper()}")
    
    bar: progressbar.ProgressBar = progressbar.ProgressBar(maxval=len(dataset)).start()
    with open(output_path, 'w+') as output_file:
        for index, data in enumerate(dataset):
            question, query, _ = data

            # prompt engineering
            prompt: str = (
                f"Generate an SQL statement to answer a question.\n\n"
                f"Prompt: \n\t{question}\n\n"
                f"Note, only respond with a single most accurate SQL statement.\n"
                f"If more information is required, simply respond with \'INSUFFICENT\'."
            )

            # run inference and time it
            runtime: float = time.perf_counter()
            output:  str   = model.infer(
                prompt, 
                **hyperparameters
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
        number_of_queries: int = len(generated_and_expected_queries)
        hardware_details:  str = ""

        import torch
        if torch.cuda.is_available():
            hardware_details: str = torch.cuda.get_device_name() + ":" + str(torch.cuda.device_count())


        # Test scores
        try:
            BLEU_metric: float = metrics.BLEU(generated_and_expected_queries)
        except Exception as exception:
            test.logging.warning(
                f"Exception thrown in BLEU score calculation: {exception}", 
                exc_info=True
            )
            BLEU_metric: float = float("nan")

        try:
            ROUGE_metrics: dict[str, dict[str, float]] = metrics.ROUGE(generated_and_expected_queries)
        except Exception as exception:
            test.logging.warning(
                f"Exception thrown in ROUGE score calculation: {exception}", 
                exc_info=True
            )
            ROUGE_metrics: dict[str, dict[str, float]] = {
                "rouge1": {"precision": float("nan"), "recall": float("nan"), "fmeasure": float("nan")},
                "rouge2": {"precision": float("nan"), "recall": float("nan"), "fmeasure": float("nan")},
                "rougeL": {"precision": float("nan"), "recall": float("nan"), "fmeasure": float("nan")},
            }

        try:
            METEOR_metric: float = metrics.METEOR(generated_and_expected_queries)
        except Exception as exception:
            test.logging.warning(
                f"Exception thrown in METEOR score calculation: {exception}", 
                exc_info=True
            )
            METEOR_metric: float = float('nan')

        try:
            BERTScore_metrics: Iterable = metrics.BERTScore(generated_and_expected_queries) 
        except Exception as exception:
            test.logging.warning(
                f"Exception thrown in BERT score calculation: {exception}", 
                exc_info=True
            )
            BERTScore_metrics: tuple[float, float, float] = (float('nan'), float('nan'), float('nan'))

        try:
            SemScore_metric: tuple[Any, Any, Any] = metrics.SemScore(generated_and_expected_queries)
        except Exception as exception:
            test.logging.warning(
                f"Exception thrown in SemScore calculation: {exception}", 
                exc_info=True
            )
            SemScore_metric: float = float('nan')


        # Test results
        result_file.write(
            (
                f"MODEL:    {model.name}\n"
                f"GPU:      {hardware_details}\n"
                f"DATASET:  {dataset_name}\n"
                f"QUERIES:  {number_of_queries}\n"
                
                "\nACCURACY\n"
                f"BLEU:      {BLEU_metric}\n"

                f"ROUGE:\n"
                f"\t- rouge-1:   {ROUGE_metrics['rouge1']}\n"
                f"\t- rouge-2:   {ROUGE_metrics['rouge2']}\n"
                f"\t- rouge-L:   {ROUGE_metrics['rougeL']}\n"

                f"METEOR:    {METEOR_metric}\n"

                f"BERTScore:\n"
                f"\t- precision: {BERTScore_metrics[0]}\n"
                f"\t- recall:    {BERTScore_metrics[1]}\n"
                f"\t- F1-score:  {BERTScore_metrics[2]}\n"

                f"SemScore:  {SemScore_metric}\n"

                "\nLATENCY\n"
                f"AVG TIME: {sum(runtimes) / len(runtimes)} seconds\n"
                f"MAX TIME: {max(runtimes)} seconds\n"
                f"MIN TIME: {min(runtimes)} seconds"
            )
        )
