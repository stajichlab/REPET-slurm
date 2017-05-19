#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEAnnot_step5.stdout
#SBATCH --job-name="S5_TEannot"
#SBATCH -p intel

module load repet/2.5
source config.txt
TEannot.py -P $ProjectName -C TEannot.cfg -S 5
