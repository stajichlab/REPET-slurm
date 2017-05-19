#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step3s.stdout
#SBATCH --job-name="S3s_TEdenovo"
#SBATCH -p intel

module load repet/2.5
module load ncbi-blast/2.2.26

# REPET TEdenovo - Step 3 - Structural
# LTRharvest prediction clustering

if [ ! -d "${ProjectName}_LTRharvest_Blastclust" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 3 --struct
fi
