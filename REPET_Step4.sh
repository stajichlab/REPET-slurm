#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step4.stdout
#SBATCH --job-name="REPET_Step4"
#SBATCH --array=0-1
#SBATCH -p intel

module load repet/2.5

# REPET - Step 4

CLUSTERER=${CLUSTERERS_AVAIL[$SLURM_ARRAY_TASK_ID]}

if [ ! -d "${ProjectName}_${SMPL_ALIGNER}_${CLUSTERER}_Map" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 4 -s $SMPL_ALIGNER -c $CLUSTERER -m Map
fi
