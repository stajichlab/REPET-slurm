#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step1.stdout
#SBATCH --job-name="REPET_Step1"
#SBATCH -p intel

module load repet/2.5

# REPET - Step 1

if [ ! -d "${ProjectName}_db" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 1
fi
