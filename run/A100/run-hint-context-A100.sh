#!/bin/bash

if [[ "$(pwd)" != "$PROJECT_ROOT" ]]; then
  cd "$PROJECT_ROOT" || echo "ERROR: Unable to move into project root"; return 1
fi

### Hinted Table Context

## mistral
python test/suites/accuracy/case/hint_context/mistral_7b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv       test/out/NORP/Crime/hint/output/A100/mistral_A100.out      test/out/NORP/Crime/hint/result/A100/mistral_A100.txt;
python test/suites/accuracy/case/hint_context/mistral_7b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv     test/out/NORP/Housing/hint/output/A100/mistral_A100.out    test/out/NORP/Housing/hint/result/A100/mistral_A100.txt;
python test/suites/accuracy/case/hint_context/mistral_7b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv   test/out/NORP/Shootings/hint/output/A100/mistral_A100.out  test/out/NORP/Shootings/hint/result/A100/mistral_A100.txt;

## llama
python test/suites/accuracy/case/hint_context/llama_11b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv        test/out/NORP/Crime/hint/output/A100/llama_A100.out        test/out/NORP/Crime/hint/result/A100/llama_A100.txt;
python test/suites/accuracy/case/hint_context/llama_11b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv      test/out/NORP/Housing/hint/output/A100/llama_A100.out      test/out/NORP/Housing/hint/result/A100/llama_A100.txt;
python test/suites/accuracy/case/hint_context/llama_11b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv    test/out/NORP/Shootings/hint/output/A100/llama_A100.out    test/out/NORP/Shootings/hint/result/A100/llama_A100.txt;

## falcon
python test/suites/accuracy/case/hint_context/falcon_11b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv       test/out/NORP/Crime/hint/output/A100/falcon_A100.out       test/out/NORP/Crime/hint/result/A100/falcon_A100.txt;
python test/suites/accuracy/case/hint_context/falcon_11b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv     test/out/NORP/Housing/hint/output/A100/falcon_A100.out     test/out/NORP/Housing/hint/result/A100/falcon_A100.txt;
python test/suites/accuracy/case/hint_context/falcon_11b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv   test/out/NORP/Shootings/hint/output/A100/falcon_A100.out   test/out/NORP/Shootings/hint/result/A100/falcon_A100.txt;

## codegen
python test/suites/accuracy/case/hint_context/codegen_16b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv      test/out/NORP/Crime/hint/output/A100/codegen_A100.out      test/out/NORP/Crime/hint/result/A100/codegen_A100.txt;
python test/suites/accuracy/case/hint_context/codegen_16b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv    test/out/NORP/Housing/hint/output/A100/codegen_A100.out    test/out/NORP/Housing/hint/result/A100/codegen_A100.txt;
python test/suites/accuracy/case/hint_context/codegen_16b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv  test/out/NORP/Shootings/hint/output/A100/codegen_A100.out  test/out/NORP/Shootings/hint/result/A100/codegen_A100.txt;

## gpt neox
python test/suites/accuracy/case/hint_context/gpt_neox_20b_hint_context_accuracy.py data/NORP/Crime_Annotated_Dataset.csv     test/out/NORP/Crime/hint/output/A100/gpt_neox_A100.out     test/out/NORP/Crime/hint/result/A100/gpt_neox_A100.txt;
python test/suites/accuracy/case/hint_context/gpt_neox_20b_hint_context_accuracy.py data/NORP/Housing_Annotated_Dataset.csv   test/out/NORP/Housing/hint/output/A100/gpt_neox_A100.out   test/out/NORP/Housing/hint/result/A100/gpt_neox_A100.txt;
python test/suites/accuracy/case/hint_context/gpt_neox_20b_hint_context_accuracy.py data/NORP/Shootings_Annotated_Dataset.csv test/out/NORP/Shootings/hint/output/A100/gpt_neox_A100.out test/out/NORP/Shootings/hint/result/A100/gpt_neox_A100.txt;
