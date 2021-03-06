#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem 2G
#SBATCH --time=7-00:00:00
#SBATCH --output=TEdenovo-step7.stdout
#SBATCH --job-name="S7_TEdenovo"
#SBATCH -p stajichlab

module load repet/2.5
# REPET TEdenovo - Step 7 - Combined Standard and Structural
# Filter consensus sequences

if  [ ! -n "$ProjectName" ] || [ ! -n "$CLUSTERERS_AVAIL" ] || [ ! -n "$SMPL_ALIGNER" ] || [ ! -n "$MLT_ALIGNER" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_${SMPL_ALIGNER}_${CLUSTERERS}_Struct_${MLT_ALIGNER}_TEclassif_Filtered" ]; then
    CLUSTERERS=$( echo $CLUSTERERS_AVAIL | tr -d ',' )

    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 7 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
else
    echo "Step 7 output folder detected, skipping..."
fi
