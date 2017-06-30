#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=7-00:00:00
#SBATCH --output=step5.stdout
#SBATCH --job-name="S5_TEdenovo"
#SBATCH -p intel

module load repet/2.5

# REPET TEdenovo - Step 5 - Combined Standard and Structural
# Features detected on each consensus (structural or homology-based)

if  [ ! -n "$ProjectName" ] || [ ! -n "$CLUSTERERS_AVAIL" ] || [ ! -n "$SMPL_ALIGNER" ] || [ ! -n "$MLT_ALIGNER" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

CLUSTERERS=$( echo $CLUSTERERS_AVAIL | tr -d ',' )
if [ ! -d "${ProjectName}_${SMPL_ALIGNER}_${CLUSTERERS}_Struct_${MLT_ALIGNER}_TEclassif" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 5 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
else
    echo "Step 5 output folder detected, skipping..."
fi
