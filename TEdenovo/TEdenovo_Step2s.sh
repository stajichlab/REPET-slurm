#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step2s.stdout
#SBATCH --job-name="S2s_TEdenovo"
#SBATCH -p intel

module load repet/2.5

# REPET TEdenovo - Step 2 - Structural
# LTRharvest ran on each batch to find LTR retrotransposons

if [ ! -d "${ProjectName}_LTRharvest" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 2 --struct
fi
