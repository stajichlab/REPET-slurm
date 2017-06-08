#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2-00:00:00
#SBATCH --output=classifier.stdout
#SBATCH --job-name="RepeatClassifier"
#SBATCH -p intel

module load RepeatModeler/1.0.8

if [ ! $CONSENSUS ]; then
 source config.txt
fi
if [ ! $CONSENSUS ]; then
 CONSENSUS=$1
fi

if [ ! $CONSENSUS ]; then
 echo "Need CONSENSUS env variable set to run"
 exit
fi
RepeatClassifier -consensi $CONSENSUS
