#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step1.stdout
#SBATCH --job-name="S1_TEdenovo_Step"
#SBATCH -p intel

module load repet/2.5

# REPET TEdenovo - Step 1
# Genomic sequence split into batches

if  [ ! -n "$ProjectName" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_db" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 1
fi
