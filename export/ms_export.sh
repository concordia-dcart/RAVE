#!/bin/bash
#SBATCH --account=def-vigliens
#SBATCH --time=00:50:00
module load python/3.10
module load scipy-stack
RUN=/home/tpeschl/work/runs/myfirstprior
DATA=/home/tpeschl/work/test_audio/chirps/chirps
PROC=/home/tpeschl/work/test_audio/chirps/msprocessed
virtualenv --no-download $SLURM_TMPDIR/env
pip install --no-index --upgrade pip
pip install --no-index -r ravereqs.txt
pip install --no-index pathos
pip install --no-deps /home/tpeschl/work/wheels/acids_msprior-1.1.3-py3-none-any.whl
msprior export --run "$RUN" --continuous
echo done!
