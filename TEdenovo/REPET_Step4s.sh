#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step4s.stdout
#SBATCH --job-name="REPET_Step4s"
#SBATCH -p intel

module load repet/2.5

# REPET - Step 4 - Structural

if [ ! -d "${ProjectName}_"*"_${MLT_ALIGNER}" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 4 --struct -m $MLT_ALIGNER
fi
