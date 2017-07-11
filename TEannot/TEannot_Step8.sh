#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEannot-step8.stdout
#SBATCH --job-name="S8_TEannot"
#SBATCH -p intel

module load repet/2.5

if [ ! -d "${ProjectName}_GFF3" ]; then
    TEannot.py -P $ProjectName -C TEannot.cfg -S 8 -o GFF3
fi

