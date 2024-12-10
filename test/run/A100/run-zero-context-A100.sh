#!/bin/bash

if [[ "$(pwd)" != "$PROJECT_ROOT" ]]; then
  cd "$PROJECT_ROOT" || echo "ERROR: Unable to move into project root"; return 1
fi

### Zero Context

## mistral
python test/suites/comprehensive/case/zero_context/mistral_7b_zero_context_comprehensive.py data/NORP/Crime_Annotated_Dataset.csv       test/out/NORP/Crime/zero/output/A100/mistral_A100.out      test/out/NORP/Crime/zero/result/A100/mistral_A100.txt;
python test/suites/comprehensive/case/zero_context/mistral_7b_zero_context_comprehensive.py data/NORP/Housing_Annotated_Dataset.csv     test/out/NORP/Housing/zero/output/A100/mistral_A100.out    test/out/NORP/Housing/zero/result/A100/mistral_A100.txt;
python test/suites/comprehensive/case/zero_context/mistral_7b_zero_context_comprehensive.py data/NORP/Shootings_Annotated_Dataset.csv   test/out/NORP/Shootings/zero/output/A100/mistral_A100.out  test/out/NORP/Shootings/zero/result/A100/mistral_A100.txt;

## llama
python test/suites/comprehensive/case/zero_context/llama_11b_zero_context_comprehensive.py data/NORP/Crime_Annotated_Dataset.csv        test/out/NORP/Crime/zero/output/A100/llama_A100.out        test/out/NORP/Crime/zero/result/A100/llama_A100.txt;
python test/suites/comprehensive/case/zero_context/llama_11b_zero_context_comprehensive.py data/NORP/Housing_Annotated_Dataset.csv      test/out/NORP/Housing/zero/output/A100/llama_A100.out      test/out/NORP/Housing/zero/result/A100/llama_A100.txt;
python test/suites/comprehensive/case/zero_context/llama_11b_zero_context_comprehensive.py data/NORP/Shootings_Annotated_Dataset.csv    test/out/NORP/Shootings/zero/output/A100/llama_A100.out    test/out/NORP/Shootings/zero/result/A100/llama_A100.txt;

## falcon
python test/suites/comprehensive/case/zero_context/falcon_11b_zero_context_comprehensive.py data/NORP/Crime_Annotated_Dataset.csv       test/out/NORP/Crime/zero/output/A100/falcon_A100.out       test/out/NORP/Crime/zero/result/A100/falcon_A100.txt;
python test/suites/comprehensive/case/zero_context/falcon_11b_zero_context_comprehensive.py data/NORP/Housing_Annotated_Dataset.csv     test/out/NORP/Housing/zero/output/A100/falcon_A100.out     test/out/NORP/Housing/zero/result/A100/falcon_A100.txt;
python test/suites/comprehensive/case/zero_context/falcon_11b_zero_context_comprehensive.py data/NORP/Shootings_Annotated_Dataset.csv   test/out/NORP/Shootings/zero/output/A100/falcon_A100.out   test/out/NORP/Shootings/zero/result/A100/falcon_A100.txt;

## codegen
python test/suites/comprehensive/case/zero_context/codegen_16b_zero_context_comprehensive.py data/NORP/Crime_Annotated_Dataset.csv      test/out/NORP/Crime/zero/output/A100/codegen_A100.out      test/out/NORP/Crime/zero/result/A100/codegen_A100.txt;
python test/suites/comprehensive/case/zero_context/codegen_16b_zero_context_comprehensive.py data/NORP/Housing_Annotated_Dataset.csv    test/out/NORP/Housing/zero/output/A100/codegen_A100.out    test/out/NORP/Housing/zero/result/A100/codegen_A100.txt;
python test/suites/comprehensive/case/zero_context/codegen_16b_zero_context_comprehensive.py data/NORP/Shootings_Annotated_Dataset.csv  test/out/NORP/Shootings/zero/output/A100/codegen_A100.out  test/out/NORP/Shootings/zero/result/A100/codegen_A100.txt;

## gpt neox
python test/suites/comprehensive/case/zero_context/gpt_neox_20b_zero_context_comprehensive.py data/NORP/Crime_Annotated_Dataset.csv     test/out/NORP/Crime/zero/output/A100/gpt_neox_A100.out     test/out/NORP/Crime/zero/result/A100/gpt_neox_A100.txt;
python test/suites/comprehensive/case/zero_context/gpt_neox_20b_zero_context_comprehensive.py data/NORP/Housing_Annotated_Dataset.csv   test/out/NORP/Housing/zero/output/A100/gpt_neox_A100.out   test/out/NORP/Housing/zero/result/A100/gpt_neox_A100.txt;
python test/suites/comprehensive/case/zero_context/gpt_neox_20b_zero_context_comprehensive.py data/NORP/Shootings_Annotated_Dataset.csv test/out/NORP/Shootings/zero/output/A100/gpt_neox_A100.out test/out/NORP/Shootings/zero/result/A100/gpt_neox_A100.txt;
