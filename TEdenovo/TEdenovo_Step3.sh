#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEdenovo-step3-%a.stdout
#SBATCH --job-name="S3_TEdenovo"
#SBATCH -p intel

module load repet/2.5

# REPET TEdenovo - Step 3
# HSP clustering by Recon, Grouper, and/or Piler

if  [ ! -n "$ProjectName" ] || [ ! -n "$CLUSTERERS_AVAIL" ] || [ ! -n "$SMPL_ALIGNER" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

# split CLUSTERERS_AVAIL string into bash array
IFS=',' read -ra CLUSTERERS_AVAIL_ARRAY <<< "$CLUSTERERS_AVAIL"
CLUSTERER=${CLUSTERERS_AVAIL_ARRAY[$SLURM_ARRAY_TASK_ID]}

if [ ! -d "${ProjectName}_${SMPL_ALIGNER}_${CLUSTERER}" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 3 -s $SMPL_ALIGNER -c $CLUSTERER
else
    echo "Step 3 output folder detected, skipping..."
fi
