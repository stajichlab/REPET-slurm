#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step8.stdout
#SBATCH --job-name="TEdenovo_Step8"
#SBATCH -p intel

module load repet/2.5
module load ncbi-blast/2.2.26

# REPET - Step 8 - Combined Standard and Structural

if [ ! -d "${ProjectName}_*_${MLT_ALIGNER}_TEclassif_Filtered_${FINAL_CLUSTERER}" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 8 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER -f $FINAL_CLUSTERER --struct
fi
