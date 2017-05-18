#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=01:00:00
#SBATCH --output=scheduler.stdout
#SBATCH --job-name="Cp_TEannot_Scheduler"
#SBATCH -p intel

# REPET - Whole Pipeline Scheduler
if [ ! -f config.txt ]; then
 echo "Need a config.txt which defines ProjectName"
 exit
fi
source config.txt

#jid_step1=$(sbatch --export=ProjectName --kill-on-invalid-dep=yes TEannot_Step1.sh | cut -d" " -f4)

#jid_step2=$(sbatch --export=ProjectName --kill-on-invalid-dep=yes --dependency=afterok:$jid_step1 TEannot_Step2.sh | cut -d" " -f4)
#jid_step3=$(sbatch --export=ProjectName --kill-on-invalid-dep=yes --dependency=afterok:$jid_step2 TEannot_Step3.sh | cut -d" " -f4)
jid_step3=$(sbatch --export=ProjectName TEannot_Step3.sh | cut -d" " -f4)

jid_step4=$(sbatch --export=ProjectName --kill-on-invalid-dep=yes --dependency=afterok:$jid_step3 TEannot_Step4.sh | cut -d" " -f4)

jid_step5=$(sbatch --export=ProjectName --kill-on-invalid-dep=yes --dependency=afterok:$jid_step4:$jid_step4s TEannot_Step5.sh | cut -d" " -f4)

jid_step6=$(sbatch --export=ProjectName --kill-on-invalid-dep=yes --dependency=afterok:$jid_step5 TEannot_Step6.sh | cut -d" " -f4)

jid_step7=$(sbatch --export=ProjectName --kill-on-invalid-dep=yes --dependency=afterok:$jid_step6 TEannot_Step7.sh | cut -d" " -f4)

jid_step8=$(sbatch --export=ProjectName --kill-on-invalid-dep=yes --dependency=afterok:$jid_step7 TEannot_Step8.sh | cut -d" " -f4)

echo "Finished submitting all jobs at $(date)"