import test.suites.accuracy.src.sql_zero_context_comprehensive as suite
from src.llm.gpt_neox_20b import gpt_neox_llm

import test

import os
import sys
import argparse


# Parse command line arguments
parser = argparse.ArgumentParser(description="Validate argument paths")
parser.add_argument("dataset_path", help="Path to the dataset directory")
parser.add_argument("output_path",  help="Path to the output directory")
parser.add_argument("result_path",  help="Path to the result file")

arguments = parser.parse_args()

dataset_path: str = arguments.dataset_path
output_path:  str = arguments.output_path
result_path:  str = arguments.result_path

# Check if each path exists
for path_name, path in vars(arguments).items():
    if not os.path.exists(path):
        test.logging.error(f"The {path_name} arguement does not exist: {path}")
        sys.exit(1)

# Load model
test.logging.info("LOADING MODEL")
model: gpt_neox_llm = gpt_neox_llm()

# Run test
test.logging.info("STARTING TEST")

suite.llm_sql_test(
    model,
    dataset_path,
    output_path,
    result_path
)

test.logging.info(f"ENDING TEST; note: output in {output_path} and result in {result_path}")
