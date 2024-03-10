#!/bin/bash
#SBATCH --account=def-account
#SBATCH --time=00:30:00

#Use this script to export a RAVE model, simply replace the values of REQS, RUN, and the account at the top.

REQS = "path/to/reqs" #absolute filepath to your .txt file with requirements to install
RUN = "path/to run" #path to your training run folder

module load python/3.10
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
pip install --no-index --upgrade pip
pip install --no-index -r $REQS
rave export --run $RUN --streaming
echo done!

#The exported model will appear in your specified RUN folder.
