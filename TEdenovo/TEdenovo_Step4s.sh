#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=step4s.stdout
#SBATCH --job-name="S4s_TEdenovo"
#SBATCH -p intel

module load repet/2.5

# REPET TEdenovo - Step 4 - Structural
# Multiple alignment computed for each LTRharvest cluster and consensus sequence produced

if [ ! -d "${ProjectName}_"*"_${MLT_ALIGNER}" ]; then
    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 4 --struct -m $MLT_ALIGNER
fi
