#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=7-00:00:00
#SBATCH --output=step6.stdout
#SBATCH --job-name="S6_TEdenovo"
#SBATCH -p intel

module load repet/2.5
# REPET TEdenovo - Step 6 - Combined Standard and Structural
# Wicker classification of each consensus sequence

if  [ ! -n "$ProjectName" ] || [ ! -n "$CLUSTERERS_AVAIL" ] || [ ! -n "$SMPL_ALIGNER"] || [ ! -n "$MLT_ALIGNER"]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

CLUSTERERS=$( echo $CLUSTERERS_AVAIL | tr -d ',' )
if [ ! -d "${ProjectName}_*_${MLT_ALIGNER}_TEclassif" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 6 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
else
    echo "Step 6 output folder detected, skipping..."
fi
