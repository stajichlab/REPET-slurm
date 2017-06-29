#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=01:00:00
#SBATCH --output=TEAnnotscheduler.stdout
#SBATCH --job-name="TEannot_Scheduler"
#SBATCH -p intel

# REPET TEannot Whole Pipeline Scheduler

# Setup/reset MySQL database for new run
# WARNING: Do NOT drop the "jobs" table if multiple instances of REPET
#          are concurrently using the same database
MYSQL_HOST=$(grep "repet_host" TEannot.cfg | cut -d" " -f2)
MYSQL_USER=$(grep "repet_user" TEannot.cfg | cut -d" " -f2)
MYSQL_PASS=$(grep "repet_pw" TEannot.cfg | cut -d" " -f2)
MYSQL_DB=$(grep "repet_db" TEannot.cfg | cut -d" " -f2)

# Set project-specific variables
export ProjectName=$(grep "project_name" TEannot.cfg | cut -d" " -f2)
export SMPL_ALIGNER="Blaster"
export CLUSTERERS_AVAIL="Grouper,Recon"
export CLUSTERERS="GrpRec"
export MLT_ALIGNER="Map"
export FINAL_CLUSTERER="Blastclust"

# Clear the jobs table, in case last run failed while sub-jobs were running
# NOTE: Don't worry if this gives an error saying the "jobs" table
#       doesn't exist because TRUNCATE doesn't support checking
#       whether a table exists first
#echo "TRUNCATE TABLE jobs;" | mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB

# Drop all tables in the MySQL database associated with the same project name
echo "SHOW TABLES" | mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB | \
egrep "^${ProjectName}_" | xargs -I "@@" mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS -D$MYSQL_DB -e "DROP TABLE \`@@\`"

# Submit jobs to SLURM
jid_step1=$(sbatch --kill-on-invalid-dep=yes TEannot_Step1.sh | cut -d" " -f4)
jid_step2=$(sbatch --kill-on-invalid-dep=yes --dependency=afterok:$jid_step1 TEannot_Step2.sh | cut -d" " -f4)
jid_step3=$(sbatch --kill-on-invalid-dep=yes --dependency=afterok:$jid_step2 TEannot_Step3.sh | cut -d" " -f4)
jid_step4=$(sbatch --kill-on-invalid-dep=yes --dependency=afterok:$jid_step3 TEannot_Step4.sh | cut -d" " -f4)

jid_step5=$(sbatch --kill-on-invalid-dep=yes --dependency=afterok:$jid_step4:$jid_step4s TEannot_Step5.sh | cut -d" " -f4)

jid_step6=$(sbatch --kill-on-invalid-dep=yes --dependency=afterok:$jid_step5 TEannot_Step6.sh | cut -d" " -f4)

jid_step7=$(sbatch --kill-on-invalid-dep=yes --dependency=afterok:$jid_step6 TEannot_Step7.sh | cut -d" " -f4)

jid_step8=$(sbatch --kill-on-invalid-dep=yes --dependency=afterok:$jid_step7 TEannot_Step8.sh | cut -d" " -f4)

echo "Finished submitting all jobs at $(date)"
