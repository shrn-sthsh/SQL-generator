# sqlgen - Exploration of SQL Generation Tasks on LLMs

This project explores the performance of small-scale Large Language Models on the order of 5-20 billion parameters for SQL generation. The primary goals are to **optimize for accuracy and latency** while minimizing the model size, leveraging various **prompt engineering techniques**.

## Project Structure

Consider the following tree structure for this project.

```bash
 .
 ├── data/     # Contains datasets and parsing source code
 ├── src/      # Source code for model objects and metric calculations
 ├── test/     # Source code prompt engineering testing outputs, and results
 ├── util/     # Set up script for project
 └── README.md # Project documentation (this file)
 ```

Each of these folders has a `README.md` detailing much more on how to use the content.


## Key Features

- **Prompt Engineering Techniques**:
  - **Zero Context**: No schema provided.
  - **Full Context**: Entire schema provided.
  - **Hint Context**: Relevant table hints provided.

- **Evaluation Metrics**:
  - **Accuracy**: Correctness of the generated SQL queries.
  - **Latency**: Inference time for each model.

- **Model Size Optimization**:
  - Comparison of models in the range of 5-20 billion parameters.


## Usage

### Prerequisites

- Python 3.12.7 or higher
- Anaconda3 24.1.2 or higher
- HuggingFace token and access to restricted models
- Reasonable hardware to run models (NVIDIA A100 and H100 were tested)
- Runtime requirements listed in `util/conda_env.yml`

### Implementation
- Models were pulled from Hugging Face and are modularized in `src/`.
- To add new models, simply create a new class in `src/LLM`, inherit from  `src/model.py`, and pass in the model name as seen on Hugging Face.
- Tests are implemented in `test/suites` and are also modularized.

### Running the Project

1. **Project Setup**: Once the prerequisites are set up, please proceed to run `setup.sh`; this will create the Conda environment, the python project, the bash enviroment, as well as the LSP utilities required.  Model requirements are loaded as they are run.
1. **Data Preparation**: Place datasets and schemas in the `data/` folder; test  NORP metabase datasets are located here.
2. **Model Execution**: Run SQL generation experiments using the scripts in `test/`; for tests run in our evaluation, run those in `test/run/`; note, tests can be run directly on command line by running a script with the dataset filepath, raw output filepath, and results filepath as arugments.
3. **Analysis**: raw output and results are stored in at the provided filepath arguments mentioned above; in the case of the out evaluation, results are in `test/out/`.


## Results and Findings

This project evaluates the impact of prompt engineering styles on the following:
- **Accuracy**: Performance of models in generating syntactically and semantically correct SQL queries.
- **Latency**: Trade-offs between query generation time and model size.
- **Hardware**: Differences in performances of above two dependent on inference hardware.

Results documentation is distributed on request.


## Contributing

Contributions are welcome! 

Please ensure:
- Code follows the style guidelines.
- Contributions are submitted via pull requests.


## License

This project is licensed under the MIT License. See `LICENSE` for more details.


## Contact

For questions or collaborations, please reach out to shrn-sthsh github user.

