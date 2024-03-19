#!/bin/bash
#SBATCH --account=def-vigliens
#SBATCH --time=01:00:00
#SBATCH --mem 32000M
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-node=1
#-----------------------------------------------
module load python/3.10
module load scipy-stack
ROOT=/project/def-vigliens/tpeschl
RUNS=/project/def-vigliens/tpeschl/runs
NAME=musica_ds2_prior
DATA=/project/def-vigliens/tpeschl/datasets/musica
PROC="$DATA/msprocessed"
MODEL=/project/def-vigliens/tpeschl/exported/musica_ds2_nostreaming.ts
CONFIG=decoder_only
virtualenv --no-download $SLURM_TMPDIR/env
pip install --no-index --upgrade pip
pip install --no-index -r ravereqs.txt
pip install --no-index pathos
pip install --no-deps /project/def-vigliens/tpeschl/wheels/acids_msprior-1.1.3-py3-none-any.whl
msprior preprocess --audio $DATA --out_path $PROC --rave $MODEL
echo "Preprocessed"
cd "$ROOT"
msprior train --config $CONFIG --db_path $PROC --name $NAME --pretrained_embedding $MODEL
echo "Trained"
RUN=$(find "$RUNS" -type d -name "$NAME")
msprior export --run "$RUN" --continuous
echo done!
