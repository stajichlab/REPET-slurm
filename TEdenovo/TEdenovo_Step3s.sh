#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEdenovo-step3s.stdout
#SBATCH --job-name="S3s_TEdenovo"
#SBATCH -p stajichlab

module load repet/2.5
module load ncbi-blast/2.2.26

# REPET TEdenovo - Step 3 - Structural
# LTRharvest prediction clustering

if  [ ! -n "$ProjectName" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_LTRharvest_Blastclust" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 3 --struct
else
    echo "Step 3s output folder detected, skipping..."
fi
