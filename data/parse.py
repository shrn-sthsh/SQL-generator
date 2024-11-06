import pandas as pd

def load_dataset(file_path: str) -> list[tuple[str, str, str]]:
    """
    Load prompts and schema from a CSV file.

    Args:
        file_path (str): Path to the CSV file.

    Returns:
        list[tuple[str, str, str]]: A list of tuples containing prompts and associated schema.
    """

    try:
        # Read the CSV file into a DataFrame
        frame: pd.DataFrame = pd.read_csv(file_path)

        # Check that necessary columns exist
        required_columns: list[str] = ["Natural Language Query", "SQL Query", "Schema"]
        if not all(column in frame.columns for column in required_columns):
            raise ValueError(f"CSV must contain the following columns: {required_columns}")

        # Extract the pairs of (prompt, schema)
        dataset: list[tuple[str, str, str]] = list(
            zip(
                frame["Natural Language Query"].tolist(), 
                frame["SQL Query"].tolist(),
                frame["Schema"].tolist()
            )
        )

        return dataset

    except Exception as exception:
        print(f"Error reading CSV file: {exception}")
        exit(1)
