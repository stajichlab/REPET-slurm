#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEAnnot_step4.stdout
#SBATCH --job-name="S4_TEannot"
#SBATCH -p intel

module load repet/2.5
source config.txt
# REPET - Step 4

TEannot.py -P $ProjectName -C TEannot.cfg -S 4 -s TRF
TEannot.py -P $ProjectName -C TEannot.cfg -S 4 -s Mreps
TEannot.py -P $ProjectName -C TEannot.cfg -S 4 -s RMSSR
