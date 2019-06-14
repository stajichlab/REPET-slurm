#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEdenovo-step4s.stdout
#SBATCH --job-name="S4s_TEdenovo"
#SBATCH -p stajichlab

module load repet/2.5

# REPET TEdenovo - Step 4 - Structural
# Multiple alignment computed for each LTRharvest cluster and consensus sequence produced

if  [ ! -n "$ProjectName" ] || [ ! -n "$MLT_ALIGNER" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_LTRharvest_Blastclust_${MLT_ALIGNER}" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 4 --struct -m $MLT_ALIGNER
else
    echo "Step 4s output folder detected, skipping..."
fi
