#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEdenovo-step2.stdout
#SBATCH --job-name="S2_TEdenovo"
#SBATCH -p intel

module load repet/2.5

# REPET TEdenovo - Step 2
# Genome self-alignment

if  [ ! -n "$ProjectName" ] || [ ! -n "$SMPL_ALIGNER" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_${SMPL_ALIGNER}" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 2 -s $SMPL_ALIGNER
else
    echo "Step 2 output folder detected, skipping..."
fi
