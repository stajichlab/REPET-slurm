#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=7-00:00:00
#SBATCH --output=step6.stdout
#SBATCH --job-name="S6_TEdenovo"
#SBATCH -p intel

module load repet/2.5
source config.txt
# REPET - Step 6 - Combined Standard and Structural

if [ ! -d "${ProjectName}_*_${MLT_ALIGNER}_TEclassif" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 6 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
fi
