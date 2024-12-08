#!/bin/bash


# interactive echo wrapper helper
function iecho()
{
  if [ -n "$TERM" ]; then
    echo "$@"
  fi
}


# Check for base dependencies
if ! type python3 &> /dev/null; then
  iecho "ERROR: Python needs to be installed before running project (base dependency)"
  exit 1
fi
if ! type conda &> /dev/null; then
  # macOS & Linux
  if [[ "$(uname -s)" == "Darwin" ]]; then
    conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
      eval "$conda_setup"
    else
      if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        source "/opt/anaconda3/etc/profile.d/conda.sh"
      else
        export PATH="/opt/anaconda3/bin:$PATH"
      fi
    fi

  # Windows (git bash, cygwin, or WSL)
  elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    if [ -f "/c/Users/$(whoami)/Anaconda3/Scripts/activate" ]; then
      source "/c/Users/$(whoami)/Anaconda3/Scripts/activate"
    else
      export PATH="/c/Users/$(whoami)/Anaconda3/Scripts:$PATH"
    fi
    
  # Unsupported system
  else      
    echo "ERROR: Unknown OS; cannot locate anaconda3"
    exit 1
  fi
  unset conda_setup
fi
if ! type conda &> /dev/null; then
  iecho "ERROR: Python needs to be installed before running project (base dependency)"
  exit 1
fi


# Configuration file paths
CONDA_ENV_CONFIG="util/conda_env.yml"
PYPROJECT_CONFIG="util/setup.py"
LOCAL_ENV_CONFIG=".envrc"
PYTHONLSP_CONFIG="util/pyright.py"

# Require configs to continue
if [ ! -f "$CONDA_ENV_CONFIG" ]; then
  iecho "ERROR: $CONDA_ENV_CONFIG could not be found in util/ directory"
  exit 1
fi
if [ ! -f "$PYPROJECT_CONFIG" ]; then
  iecho "ERROR: $PYPROJECT_CONFIG could not be found in util/ directory"
  exit 1
fi
if [ ! -f "$LOCAL_ENV_CONFIG" ]; then
  iecho "ERROR: $LOCAL_ENV_CONFIG could not be found in project root directory"
  exit 1
fi

lsp_setup=true
if [ ! -f "$LOCAL_ENV_CONFIG" ]; then
  iecho "WARNING: $PYTHONLSP_CONFIG could not be found in util/ directory"
  lsp_setup=false
fi


# Add required channels
conda config --add channels conda-forge
conda config --add channels nvidia
conda config --set channel_priority strict

# Make or update enviroment
CONDA_ENV_NAME=$(grep "name:" "$CONDA_ENV_CONFIG" | awk '{print $2}')
if [[ -z "$CONDA_ENV_NAME" ]]; then
  iecho "ERROR: Unable to find enviroment name from configuration file"
  exit 1
fi

# Enviroment exists
if conda env list | grep -q "$CONDA_ENV_NAME"; then
  iecho "PROCESS: Updating conda environment '$CONDA_ENV_NAME' for NORP project"
  conda env update --file "$CONDA_ENV_CONFIG" --prune
  if [[ $? -ne 0 ]]; then
    iecho "ERROR: Failed to update conda environment '$CONDA_ENV_NAME'."
    exit 1
  fi

# Enviroment doesn't exist
else
  iecho "PROCESS: Creating conda environment '$CONDA_ENV_NAME' for NORP project"
  conda env create --file "$CONDA_ENV_CONFIG"
  if [[ $? -ne 0 ]]; then
    iecho "ERROR: Failed to create conda environment '$CONDA_ENV_NAME'."
    exit 1
  fi
fi

conda config --add channels conda-forge
conda config --add channels nvidia
conda config --set channel_priority strict

# Activate enviroment
iecho -n "STATUS: Activating environment: $CONDA_ENV_NAME... "
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$CONDA_ENV_NAME"
iecho "done"

# Run setup.py to set up python project
iecho -n "STATUS: Running $PYPROJECT_CONFIG... "
python3 "$PYPROJECT_CONFIG" install
iecho "done"

# Source the .envrc file if it exists
iecho -n "Sourcing $LOCAL_ENV_CONFIG... "
source "$LOCAL_ENV_CONFIG"
iecho "done"

iecho -e "STATUS: Done. Environment '$CONDA_ENV_NAME' is ready.\n"


# Set up pyright LSP config
if [[ "$lsp_setup" == true ]]; then
  iecho "PROCESS: Creating project LSP configuration"
  python3 "$PYTHONLSP_CONFIG"
fi
