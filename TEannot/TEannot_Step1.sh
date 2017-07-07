#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --output=TEannot-step1.stdout
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
    # if re-running step, drop MySQL tables
    MYSQL_HOST=$(grep "repet_host" TEannot.cfg | cut -d" " -f2)
    MYSQL_USER=$(grep "repet_user" TEannot.cfg | cut -d" " -f2)
    MYSQL_PASS=$(grep "repet_pw" TEannot.cfg | cut -d" " -f2)
    MYSQL_DB=$(grep "repet_db" TEannot.cfg | cut -d" " -f2)

    echo "DROP TABLE IF EXISTS ${ProjectName}_chr_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_chk_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_chk_map;" \
    "DROP TABLE IF EXISTS ${ProjectName}_refTEs_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_refTEs_map;" | \
    mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

    TEannot.py -P $ProjectName -C TEannot.cfg -S 1
else
    echo "Step 1 output folder detected, skipping..."
fi
