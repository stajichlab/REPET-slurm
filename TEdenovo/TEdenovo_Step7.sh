#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step7.stdout
#SBATCH --job-name="TEdenovo_Step7"
#SBATCH -p intel

module load repet/2.5

# REPET - Step 7 - Combined Standard and Structural

if [ ! -d "${ProjectName}_*_${MLT_ALIGNER}_TEclassif_Filtered" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 7 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
fi
