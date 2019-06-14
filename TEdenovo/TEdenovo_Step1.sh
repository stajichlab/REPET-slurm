#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem 8G
#SBATCH --time=1-00:00:00
#SBATCH --out TEdenovo-step1.stdout
#SBATCH -J "S1_TEdenovo"
#SBATCH -p stajichlab

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
else
    echo "Step 1 output folder detected, skipping..."
fi
