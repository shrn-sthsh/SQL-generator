#!/bin/bash

if [[ "$(pwd)" != "$PROJECT_ROOT" ]]; then
  cd "$PROJECT_ROOT" || echo "ERROR: Unable to move into project root"; return 1
fi

### Zero Context

## mistral
python test/suites/accuracy/case/zero_context/mistral_7b_zero_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv       test/out/NORP/Crime/zero/output/H100/mistral_H100.out      test/out/NORP/Crime/zero/result/H100/mistral_H100.txt;
python test/suites/accuracy/case/zero_context/mistral_7b_zero_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv     test/out/NORP/Housing/zero/output/H100/mistral_H100.out    test/out/NORP/Housing/zero/result/H100/mistral_H100.txt;
python test/suites/accuracy/case/zero_context/mistral_7b_zero_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv   test/out/NORP/Shootings/zero/output/H100/mistral_H100.out  test/out/NORP/Shootings/zero/result/H100/mistral_H100.txt;

## llama
python test/suites/accuracy/case/zero_context/llama_11b_zero_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv        test/out/NORP/Crime/zero/output/H100/llama_H100.out        test/out/NORP/Crime/zero/result/H100/llama_H100.txt;
python test/suites/accuracy/case/zero_context/llama_11b_zero_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv      test/out/NORP/Housing/zero/output/H100/llama_H100.out      test/out/NORP/Housing/zero/result/H100/llama_H100.txt;
python test/suites/accuracy/case/zero_context/llama_11b_zero_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv    test/out/NORP/Shootings/zero/output/H100/llama_H100.out    test/out/NORP/Shootings/zero/result/H100/llama_H100.txt;

## falcon
python test/suites/accuracy/case/zero_context/falcon_11b_zero_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv       test/out/NORP/Crime/zero/output/H100/falcon_H100.out       test/out/NORP/Crime/zero/result/H100/falcon_H100.txt;
python test/suites/accuracy/case/zero_context/falcon_11b_zero_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv     test/out/NORP/Housing/zero/output/H100/falcon_H100.out     test/out/NORP/Housing/zero/result/H100/falcon_H100.txt;
python test/suites/accuracy/case/zero_context/falcon_11b_zero_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv   test/out/NORP/Shootings/zero/output/H100/falcon_H100.out   test/out/NORP/Shootings/zero/result/H100/falcon_H100.txt;

## codegen
python test/suites/accuracy/case/zero_context/codegen_16b_zero_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv      test/out/NORP/Crime/zero/output/H100/codegen_H100.out      test/out/NORP/Crime/zero/result/H100/codegen_H100.txt;
python test/suites/accuracy/case/zero_context/codegen_16b_zero_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv    test/out/NORP/Housing/zero/output/H100/codegen_H100.out    test/out/NORP/Housing/zero/result/H100/codegen_H100.txt;
python test/suites/accuracy/case/zero_context/codegen_16b_zero_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv  test/out/NORP/Shootings/zero/output/H100/codegen_H100.out  test/out/NORP/Shootings/zero/result/H100/codegen_H100.txt;

## gpt neox
python test/suites/accuracy/case/zero_context/gpt_neox_20b_zero_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv     test/out/NORP/Crime/zero/output/H100/gpt_neox_H100.out     test/out/NORP/Crime/zero/result/H100/gpt_neox_H100.txt;
python test/suites/accuracy/case/zero_context/gpt_neox_20b_zero_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv   test/out/NORP/Housing/zero/output/H100/gpt_neox_H100.out   test/out/NORP/Housing/zero/result/H100/gpt_neox_H100.txt;
python test/suites/accuracy/case/zero_context/gpt_neox_20b_zero_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv test/out/NORP/Shootings/zero/output/H100/gpt_neox_H100.out test/out/NORP/Shootings/zero/result/H100/gpt_neox_H100.txt;
