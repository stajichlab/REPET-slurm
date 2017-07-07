#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEannot-step4-%a.stdout
#SBATCH --job-name="S4_TEannot"
#SBATCH -p intel

module load repet/2.5

# REPET TEannot - Step 4
# Search for satellites in the genomic sequence

IFS='+' read -ra SSR_DETECTORS_AVAIL_ARRAY <<< "${SSR_DETECTORS_AVAIL}"
SSR_DETECTOR=${SSR_DETECTORS_AVAIL_ARRAY[$SLURM_ARRAY_TASK_ID]}

if [ ! -d "${ProjectName}_SSRdetect/${SSR_DETECTOR}" ]; then
    TEannot.py -P $ProjectName -C TEannot.cfg -S 4 -s $SSR_DETECTOR
else
    echo "Step 4 output folder detected, skipping..."
fi
