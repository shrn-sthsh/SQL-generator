## Test Directory

This folder contains a large set of functions that use the other modules to put together the primary function of testing in exploration.  

Since each of the subdirectories are quite detailed, they each have a README.md.  Please read them before usage.

### Out

The location of outputs from tests, both raw outputs and metrics' results on runs sorted by, one, dataset, two, tuning technique, three, output type, and lastly, hardware set.

### Run

A host of bash scripts for batching jobs together, sorted by, one, hardware set and, two, tuning techniques.

### Suites

The source collection of tests to actually run in model-by-model use cases of each test along with the sources of the tests. 