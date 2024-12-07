#!/bin/bash

if [[ "$(pwd)" != "$PROJECT_ROOT" ]]; then
  cd "$PROJECT_ROOT" || echo "ERROR: Unable to move into project root"; return 1
fi

### Hinted Table Context

## mistral
python test/suites/accuracy/case/hint_context/mistral_7b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv       test/out/NORP/Crime/hint/output/H100/mistral_H100.out      test/out/NORP/Crime/hint/result/H100/mistral_H100.txt;
python test/suites/accuracy/case/hint_context/mistral_7b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv     test/out/NORP/Housing/hint/output/H100/mistral_H100.out    test/out/NORP/Housing/hint/result/H100/mistral_H100.txt;
python test/suites/accuracy/case/hint_context/mistral_7b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv   test/out/NORP/Shootings/hint/output/H100/mistral_H100.out  test/out/NORP/Shootings/hint/result/H100/mistral_H100.txt;

## llama
python test/suites/accuracy/case/hint_context/llama_11b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv        test/out/NORP/Crime/hint/output/H100/llama_H100.out        test/out/NORP/Crime/hint/result/H100/llama_H100.txt;
python test/suites/accuracy/case/hint_context/llama_11b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv      test/out/NORP/Housing/hint/output/H100/llama_H100.out      test/out/NORP/Housing/hint/result/H100/llama_H100.txt;
python test/suites/accuracy/case/hint_context/llama_11b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv    test/out/NORP/Shootings/hint/output/H100/llama_H100.out    test/out/NORP/Shootings/hint/result/H100/llama_H100.txt;

## falcon
python test/suites/accuracy/case/hint_context/falcon_11b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv       test/out/NORP/Crime/hint/output/H100/falcon_H100.out       test/out/NORP/Crime/hint/result/H100/falcon_H100.txt;
python test/suites/accuracy/case/hint_context/falcon_11b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv     test/out/NORP/Housing/hint/output/H100/falcon_H100.out     test/out/NORP/Housing/hint/result/H100/falcon_H100.txt;
python test/suites/accuracy/case/hint_context/falcon_11b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv   test/out/NORP/Shootings/hint/output/H100/falcon_H100.out   test/out/NORP/Shootings/hint/result/H100/falcon_H100.txt;

## codegen
python test/suites/accuracy/case/hint_context/codegen_16b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv      test/out/NORP/Crime/hint/output/H100/codegen_H100.out      test/out/NORP/Crime/hint/result/H100/codegen_H100.txt;
python test/suites/accuracy/case/hint_context/codegen_16b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv    test/out/NORP/Housing/hint/output/H100/codegen_H100.out    test/out/NORP/Housing/hint/result/H100/codegen_H100.txt;
python test/suites/accuracy/case/hint_context/codegen_16b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv  test/out/NORP/Shootings/hint/output/H100/codegen_H100.out  test/out/NORP/Shootings/hint/result/H100/codegen_H100.txt;

## gpt neox
python test/suites/accuracy/case/hint_context/gpt_neox_20b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv     test/out/NORP/Crime/hint/output/H100/gpt_neox_H100.out     test/out/NORP/Crime/hint/result/H100/gpt_neox_H100.txt;
python test/suites/accuracy/case/hint_context/gpt_neox_20b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv   test/out/NORP/Housing/hint/output/H100/gpt_neox_H100.out   test/out/NORP/Housing/hint/result/H100/gpt_neox_H100.txt;
python test/suites/accuracy/case/hint_context/gpt_neox_20b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv test/out/NORP/Shootings/hint/output/H100/gpt_neox_H100.out test/out/NORP/Shootings/hint/result/H100/gpt_neox_H100.txt;
