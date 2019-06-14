#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem=8G
#SBATCH --time=7-00:00:00
#SBATCH --output=TEdenovo-step5.stdout
#SBATCH --job-name="S5_TEdenovo"
#SBATCH -p stajichlab

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

if [ ! -d "${ProjectName}_${SMPL_ALIGNER}_${CLUSTERERS}_Struct_${MLT_ALIGNER}_TEclassif/detectFeatures" ]; then
    # if re-running step, drop MySQL tables
    MYSQL_HOST=$(grep "repet_host" TEdenovo.cfg | cut -d" " -f2)
    MYSQL_USER=$(grep "repet_user" TEdenovo.cfg | cut -d" " -f2)
    MYSQL_PASS=$(grep "repet_pw" TEdenovo.cfg | cut -d" " -f2)
    MYSQL_DB=$(grep "repet_db" TEdenovo.cfg | cut -d" " -f2)

    echo "DROP TABLE IF EXISTS ${ProjectName}_TE_BLRn_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_TE_BLRtx_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_TE_BLRx_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_TR_set;" \
    "DROP TABLE IF EXISTS ${ProjectName}_SSR_set;" \
    "DROP TABLE IF EXISTS ${ProjectName}_polyA_set;" \
    "DROP TABLE IF EXISTS ${ProjectName}_ORF_map;" \
    "DROP TABLE IF EXISTS ${ProjectName}_RepbaseNT_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_RepbaseAA_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_HG_BLRn_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_rDNA_BLRn_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_tRNA_map;" \
    "DROP TABLE IF EXISTS ${ProjectName}_Profiles_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_ProfilesDB_map;" | \
    mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

    CLUSTERERS=$( echo $CLUSTERERS_AVAIL | tr -d ',' )

    TEdenovo.py -P $ProjectName -C TEdenovo.cfg -S 5 -s $SMPL_ALIGNER -c $CLUSTERERS -m $MLT_ALIGNER --struct
else
    echo "Step 5 output folder detected, skipping..."
fi
