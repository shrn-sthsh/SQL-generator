import os
import sys
import json

# config requirements
python_version: str = sys.version.split()[0]

conda_env_path: str = os.environ.get("CONDA_PREFIX", "")
if not conda_env_path:
    response = input(
        "WARNING: Not in a Conda environment. "
        "Do you want to continue? [y/N]: "
    ).strip().lower()

    if response != 'y':
        print("Exiting...")
        exit(0)

def list_subdirectories(root_dir):
    subdirectories: list[str] = []

    for dir_paths, dir_names, _ in os.walk(root_dir):
        for name in dir_names:
            subdirectories.append(os.path.join(dir_paths, name))

    return subdirectories


conda_env_name: str = conda_env_path.split('/')[-1]
print(
    f"PROCESS: Generating pyrightconfig.json under Conda environment: {conda_env_name}", 
    end=""
)

subdirectories = list_subdirectories('.')

# config JSON
config = {
    "include": subdirectories,
    "exclude": [
        "**/__pycache__",
        "**/*.pyc",
        "**/*.pyo"
    ],
    "reportMissingImports": True,
    "reportUnusedImports": True,
    "reportUnusedFunction": True,
    "reportUnusedVariable": True,
    "pythonVersion": python_version,
    "venv": conda_env_path
}

# config file
file_name: str = 'pyrightconfig.json'
pdir_path: str = os.path.dirname(os.path.abspath(__file__))
file_path: str = os.path.join(pdir_path, file_name)
link_path: str = os.path.join(os.path.dirname(pdir_path), file_name)

# write config into config file
with open(file_name, 'w') as file:
    json.dump(config, file, indent=4)

    if os.path.exists(link_path):
        os.unlink(link_path)
    os.symlink(file_path, link_path)

print(f"done", end="")
