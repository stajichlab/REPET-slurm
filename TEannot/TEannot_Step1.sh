#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEannot_step1.stdout
#SBATCH --job-name="S1_TEannot"
#SBATCH -p intel

module load repet/2.5

# REPET TEannot - Step 1
# Prepare data banks for next steps

if  [ ! -n "$ProjectName" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_db" ]; then
    TEannot.py -P $ProjectName -C TEannot.cfg -S 1
else
    echo "Step 1 output folder detected, skipping..."
fi
