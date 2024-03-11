#!/bin/bash
#SBATCH --account=def-vigliens
#SBATCH --time=01-00:00:00
#SBATCH --mem=4000M
#SBATCH --cpus-per-task=1

RUNS="/project/def-vigliens/tpeschl/runs"
REQS="/project/def-vigliens/tpeschl/ravereqs.txt"

module load python/3.10
module load scipy-stack
virtualenv --no-download $Slurm_TMPDIR/env
pip install --no-index --upgrade pip
pip install -- no-index -r "$REQS"

cd "$RUNS"

tensorboard --logdir . --bind_all

