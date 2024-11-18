import test.suites.case.sql_accuracy as suite
from src.llm.codegen_16b import codegen_llm

import data
import test

import os
import sys
import argparse

# Parse command line arguments
parser = argparse.ArgumentParser(description="Validate argument paths")
parser.add_argument("dataset_path", help="Path to the dataset directory")
parser.add_argument("output_path", help="Path to the output directory")
parser.add_argument("result_path", help="Path to the result file")

args = parser.parse_args()

dataset_path: str = args.dataset_path
output_path:  str = args.output_path
result_path:  str = args.result_path

# Check if each path exists
for path_name, path in vars(args).items():
    if not os.path.exists(path):
        test.logging.error(f"The {path_name} arguement does not exist: {path}")
        sys.exit(1)

# Load model
test.logging.info("LOADING MODEL")
model: codegen_llm = codegen_llm()

# Run test
test.logging.info("STARTING TEST")

suite.llm_sql_test(
    model,
    dataset_path,
    output_path,
    result_path
)

test.logging.info(f"ENDING TEST; note: output in {output_path} and result in {result_path}")