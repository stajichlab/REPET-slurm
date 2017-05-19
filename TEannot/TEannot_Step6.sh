#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEAnnot_step6.stdout
#SBATCH --job-name="S6_TEannot"
#SBATCH -p intel

module load repet/2.5
source config.txt
TEannot.py -P $ProjectName -C TEannot.cfg -S 6 -b tblastx
TEannot.py -P $ProjectName -C TEannot.cfg -S 6 -b blastx
