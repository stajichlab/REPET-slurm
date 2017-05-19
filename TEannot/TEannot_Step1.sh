#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEAnnot_step1.stdout
#SBATCH --job-name="S1_TEannot"
#SBATCH -p intel

module load repet/2.5
source config.txt
# REPET - Step 1

TEannot.py -P $ProjectName -C TEannot.cfg -S 1
