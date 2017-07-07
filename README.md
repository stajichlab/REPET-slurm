# REPET-Slurm

A collection of scripts to get started with running the
[REPET](https://urgi.versailles.inra.fr/Tools/REPET/) pipeline on a cluster
with the [SLURM](https://slurm.schedmd.com/) resource manager and a
[module system](http://modules.sourceforge.net/) installed.

## Caveats/Warnings

1. FASTA Format
    - Header
        - Recommended format: ">XX_i" (XX = letters, i = numbers)
        - **avoid spaces** and symbols like "=;:|"
    - 60 bps (or less) per line for sequences

## Prerequisite Files

### TEdenovo

1. Host genome (FASTA format)
2. [REPET-specific Pfam HMM File](https://urgi.versailles.inra.fr/download/repet/ProfilesBankForREPET_Pfam27.0_GypsyDB.hmm)
3. rDNA (FASTA format) of host genome
    - [RNAmmer](http://www.cbs.dtu.dk/services/RNAmmer/)
4. [RepBase](http://www.girinst.org/repbase/) Amino Acid Database
5. RepBase Nucleotide Database
6. cDNA of host genome (FASTA format)

A [RepeatScout](https://bix.ucsd.edu/repeatscout/) bank can also be provided
but there are additional pre-processing steps before it can be used in the
pipeline. See the [TEdenovo tuto](https://urgi.versailles.inra.fr/Tools/REPET/TEdenovo-tuto)
webpage or text file included with REPET. These scripts currently do NOT
perform this pre-processing steps.

### TEannot

1. Host genome (FASTA format)
2. TE library (FASTA format)
    - from TEdenovo or another source
3. [RepBase](http://www.girinst.org/repbase/) Amino Acid Database
4. RepBase Nucleotide Database

## Getting Started

### TEdenovo

1. Clone the repository and copy the default configuration.

```
$ git clone https://github.com/stajichlab/REPET-slurm
$ cd REPET-slurm/TEdenovo
$ cp /path/to/REPET/config/TEdenovo.cfg .
```

2. Change the settings in `TEdenovo.cfg` and `TEdenovo_AllSteps.sh` to match your
environment/project.
3. Copy/link the prerequisite files into the TEdenovo folder.
4. `sh TEdenovo_AllSteps.sh` or `sbatch TEdenovo_AllSteps.sh`.

### TEannot

If you already ran TEdenovo, then skip step 1.

1. Clone the repository and copy the default configuration.

```
$ git clone https://github.com/stajichlab/REPET-slurm
$ cd REPET-slurm/TEannot
$ cp /path/to/REPET/config/TEannot.cfg .
```

2. Change the settings in `TEannot.cfg` and `TEannot_AllSteps.sh` to match your
environment/project.
3. Copy/link the prerequisite files into the TEannot folder.
    - TE library has a required naming format: `<project_name>_refTEs.fa`
4. `sh TEannot_AllSteps.sh` or `sbatch TEannot_AllSteps.sh`.
