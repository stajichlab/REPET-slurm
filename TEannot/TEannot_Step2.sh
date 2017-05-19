#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEAnnot_step2.stdout
#SBATCH --job-name="S2_TEannot"
#SBATCH -p intel

module load repet/2.5
source config.txt
# REPET - Step 2

TEannot.py -P $ProjectName -C TEannot.cfg -S 2 -a BLR
TEannot.py -P $ProjectName -C TEannot.cfg -S 2 -a RM
TEannot.py -P $ProjectName -C TEannot.cfg -S 2 -a CEN

TEannot.py -P $ProjectName -C TEannot.cfg -S 2 -a BLR -r
TEannot.py -P $ProjectName -C TEannot.cfg -S 2 -a RM -r
TEannot.py -P $ProjectName -C TEannot.cfg -S 2 -a CEN -r
