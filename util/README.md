## Utility Directory

This directory primarily contains utilities to setting up the project to run well on a machine.  No need to tweak anything here, but you can add configurations and source them in the root's `setup.sh`.


#### Anaconda Environment 

The file `conda_env.yml` contains a configuration to build the Anaconda enviroment required for this project.  Note, this configuration works for NVIDIA GPU nodes primarily connected to a x86-64 CPU node.  Extendabilty to other platforms has not been tested.

#### Python Project 

The file `setup.py` sets up the project as a python project to be exported and distributed.

#### LSP Set Up

The file `pyright.py` is not neccessary but sets up the pyright LSP configuration for editors like vim, noevim, and emacs.