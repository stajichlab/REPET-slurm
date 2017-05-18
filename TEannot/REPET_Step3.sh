#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step3.stdout
#SBATCH --job-name="REPET_Step3"
#SBATCH -p intel

module load repet/2.5

# REPET - Step 3

TEannot.py -P $ProjectName -C TEannot.cfg -S 3 -c BLR+RM+CEN
