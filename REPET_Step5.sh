#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step5.stdout
#SBATCH --job-name="REPET_Step5"
#SBATCH -p intel

module load repet/2.5

# REPET - Step 5 - Combined Standard and Structural

if [ (! -d "${ProjectName}_${SMPL_ALIGNER}_${CLUSTERERS}_${MLT_ALIGNER}_TEclassif") && (! -d "${ProjectName}_LTRharvest_Blastclust_${MLT_ALIGNER}_TEclassif") ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 5 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
fi
