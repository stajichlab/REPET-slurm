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

1. Host genome (FASTA format)
2. [REPET-specific Pfam HMM File](https://urgi.versailles.inra.fr/download/repet/ProfilesBankForREPET_Pfam27.0_GypsyDB.hmm)
3. rDNA (FASTA format) of host genome
    - [RNAmmer](http://www.cbs.dtu.dk/services/RNAmmer/)
4. [RepBase](http://www.girinst.org/repbase/) Protein Database
5. RepBase Nucleotide Database
6. cDNA of host genome (FASTA format)

## Getting Started

### TEdenovo

```
$ git clone https://github.com/stajichlab/REPET-slurm
$ cd REPET-slurm/TEdenovo
$ cp /path/to/REPET/config/TEdenovo.cfg .
```

Change the settings in `TEdenovo.cfg` and `TEdenovo_AllSteps.sh` to match your
environment/project.

```
$ sh TEdenovo_AllSteps.sh
```

