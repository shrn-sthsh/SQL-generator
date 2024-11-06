import data.parse  as parse
import src.model   as model
import src.metrics as metrics

import test

import os
import time
import torch
import progressbar

def accuracy_test(
    model:       model.llm,
    data_path:   str,
    output_path: str,
    result_path: str
) -> None:

    # Check files are valid
    if not os.path.exists(data_path):
       test.logging.error("Invalid dataset file path") 
    
    if not os.path.exists(output_path):
       test.logging.error("Invalid output file path") 

    if not os.path.exists(result_path):
       test.logging.error("Invalid result file path") 


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
                max_length=1_000,
                temperature=0.7,
                top_k=50,
                top_p=0.9,
                no_repeat_ngram_size=2
            )
            runtimes.append(time.perf_counter() - runtime)

            # save results
            generated_and_expected_queries.append((output, query))
            output_file.write(f"\n\nPROMPT {index + 1}:\n\n" + prompt)
            output_file.write(f"\n\nRESPONSE {index + 1}:\n\n" + output)
            
            bar.update(index + 1)
    bar.finish()

    # Check accuracy
    test.logging.info("EVALUATING RESULTS")
    with open(result_path, 'w+') as result_file:
        number_of_queries: int   = len(generated_and_expected_queries)
        dataset_name:      str   = os.path.splitext(os.path.basename(data_path))[0]
        accuracy:          float = metrics.determine_accuracy(generated_and_expected_queries)

        hardware_details: str = ""
        if torch.cuda.is_available():
            hardware_details: str = torch.cuda.get_device_name() + ":" + str(torch.cuda.device_count())
        
        result_file.write(
            (
                f"MODEL:    {model.name}\n"
                f"GPU:      {hardware_details}"
                f"DATASET:  {dataset_name}\n"
                f"QUERIES:  {number_of_queries}\n"
                
                "\nACCURACY\n"
                f"BLEU:      "
                f"ROUGE:     "
                f"METEOR:    "
                f"BERTScore: "
                f"SemScore:  "

                "\nLATENCY\n"
                f"AVG TIME: {sum(runtimes) / len(runtimes)} seconds\n"
                f"MAX TIME: {max(runtimes)} seconds\n"
                f"MIN TIME: {min(runtimes)} seconds"
            )
        )
