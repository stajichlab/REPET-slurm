#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step2.stdout
#SBATCH --job-name="S2_TEdenovo"
#SBATCH -p intel

module load repet/2.5

# REPET TEdenovo - Step 2
# Genome self-alignment

if [ ! -d "${ProjectName}_${SMPL_ALIGNER}" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 2 -s $SMPL_ALIGNER
fi
