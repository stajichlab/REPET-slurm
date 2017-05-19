#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=7-00:00:00
#SBATCH --output=step7.stdout
#SBATCH --job-name="S7_TEdenovo"
#SBATCH -p intel

module load repet/2.5
source config.txt
# REPET - Step 7 - Combined Standard and Structural

if [ ! -d "${ProjectName}_*_${MLT_ALIGNER}_TEclassif_Filtered" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 7 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
fi
