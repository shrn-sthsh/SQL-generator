## Out Directory

This directory contains all outputs, both raw and results, organized by dataset provider, dataset, tuning technique, output type (raw or result), and hardware used (A100 or H100).


### *.out files

These files are the raw output files and should be in `output/` subdirectories.  These files are sometimes very large in size so be cautious in loading these.

### *.txt files

These file are the result files contains all the accuracy metrics mentioned in source's directory README.md file along with the latency metrics.  They are in a labeled manner ut do require a parser to write into a structured file type.