#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEannot-step3.stdout
#SBATCH --job-name="S3_TEannot"
#SBATCH -p intel

module load repet/2.5

# REPET TEannot - Step 3
# Filter and combine HSPs from Step 2 alignment

if  [ ! -n "$ProjectName" ] || [ ! -n "$ALIGNERS_AVAIL" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi

if [ ! -d "${ProjectName}_TEdetect/Comb" ]; then
    # if re-running step, drop MySQL tables
    MYSQL_HOST=$(grep "repet_host" TEannot.cfg | cut -d" " -f2)
    MYSQL_USER=$(grep "repet_user" TEannot.cfg | cut -d" " -f2)
    MYSQL_PASS=$(grep "repet_pw" TEannot.cfg | cut -d" " -f2)
    MYSQL_DB=$(grep "repet_db" TEannot.cfg | cut -d" " -f2)

    echo "DROP TABLE IF EXISTS ${ProjectName}_chk_allTEs_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_chr_allTEs_path;" | \
    mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

    TEannot.py -P $ProjectName -C TEannot.cfg -S 3 -c $ALIGNERS_AVAIL
else
    echo "Step 3 output folder detected, skipping..."
fi
