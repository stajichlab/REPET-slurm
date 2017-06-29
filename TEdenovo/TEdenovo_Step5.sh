#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=7-00:00:00
#SBATCH --output=step5.stdout
#SBATCH --job-name="S5_TEdenovo"
#SBATCH -p intel

module load repet/2.5

# REPET TEdenovo - Step 5 - Combined Standard and Structural
# Features detected on each consensus (structural or homology-based)

CLUSTERERS=$( echo $CLUSTERERS_AVAIL | tr -d ',' )
if [ ! -d "${ProjectName}_"*"_${MLT_ALIGNER}_TEclassif" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 5 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
fi
