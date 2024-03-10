#!/bin/bash 
#SBATCH --account=def-vigliens
#SBATCH --array=1-7%1
#SBATCH --time=01-00:00:00
#SBATCH --mem=64000M
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-node=1
#Array job length is set to 7 (1-7%1), but can be changed depending on the projected length of your training

#-------------------------------------------variables

WORK="$PWD"
NAME="musica_ds2" #name of the training run
RUNS="/project/def-vigliens/tpeschl/runs/musica" #directory where your training run is stored
DATA="/project/def-vigliens/tpeschl/datasets/musica" #directory where audio data is stored
PROC="${DATA}/processed" #directory where processed data is stored
TMPDIR="${SLURM_TMPDIR}/processed" #temporary storage on compute node for processed data
REQS="/project/def-vigliens/tpeschl/ravereqs.txt" #location of list of requirements for RAVE
PHASEONE=5000000 #length of first phase of training (VAE)
PHASETWO=2000000 #length of second phase of training (GAN)
MAXSTEPS=$(($PHASEONE+$PHASETWO))
CKPTFREQ=10000 #Frequency of checkpoint writing

#-------------------------------------------load dependencies

module load python/3.10
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
pip install --no-index --upgrade pip
pip install --no-index -r "$REQS"

#-------------------------------------------prepare training data

if [ ! -d "$PROC" ];then #preprocess data if it hasn't already, or if folder cannot be found.

mkdir "$PROC"
rave preprocess --input_path "$DATA" --output_path "$PROC"

fi

cp -rv "$PROC" "${SLURM_TMPDIR}/" #copy preporocessed data to compute node's temporary storage.

#-------------------------------------------train
if [ "$SLURM_ARRAY_TASK_ID" -eq 1 ] || [ "$SLURM_ARRAY_TASK_ID" == "1" ]; then #Check if first job in job array

cd "$RUN"
tensorboard --logdir "$RUNS" --bind_all & #enables tensorboard in the background for live monitoring

rave train --config v2 --db_path "$TMPDIR" --name "$NAME" --max_steps $MAXSTEPS --workers 8 --val_every $CKPTFREQ --override PHASE_1_DURATION=$PHASEONE

else #If not first job in array, find checkpoint before continuing training

RUN=$(find "$RUNS" -type d -name "${NAME}_*") #Find run folder
CKPT=$(find "$RUN" -type f -name "last.ckpt") #find latest checkpoint
if [ ! -d "$CKPT" ]; then
CKPT=$(find "$RUN" -type f -name "last-v1.ckpt")
fi
echo "path to checkpoint"
echo $CKPT

cd "$RUN"
tensorboard --logdir "$RUNS" --bind_all & #enables tensorboard in the background for live monitoring

rave train --config v2 --db_path "$TMPDIR" --name "$NAME" --max_steps $MAXSTEPS --workers 8 --ckpt "$CKPT" --val_every $CKPTFREQ --override PHASE_1_DURATION=$PHASEONE

fi

