#!/bin/bash
#SBATCH --account=def-account
#SBATCH --time=01:00:00
#SBATCH --mem 32000M
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-node=1

#Use this template script to export msprior models, mainly for v2<2.3
#-----------------------------------------------
module load python/3.10
module load scipy-stack
RUNS=/path/to/runs #where you keep all training runs
NAME=name #name of your training run, add _prior at end for clarity
DATA=/path/to/dataset
PROC="$DATA/msprocessed"
REQS=/path/to/reqs #path to .txt file with requirements fro RAVE
MSWHEEL=/path/to/wheel #path to msprior wheel, not provided by compute canada
MODEL=/path/to/model #need an exported .ts model exported WITHOUT the --streaming flag,
CONFIG=decoder_only
virtualenv --no-download $SLURM_TMPDIR/env
pip install --no-index --upgrade pip
pip install --no-index -r "$REQS"
pip install --no-index pathos
pip install --no-deps "$WHEEL"
msprior preprocess --audio $DATA --out_path $PROC --rave $MODEL
echo "Preprocessed"
msprior train --config $CONFIG --db_path $PROC --name $NAME --pretrained_embedding $MODEL
echo "Trained"
RUN=$(find "$RUNS" -type d -name "$NAME")
msprior export --run "$RUN" --continuous
echo Done! #You will find the exported .ts model in your run folder.