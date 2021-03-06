#!/bin/bash -login
#SBATCH -p bmh
#SBATCH -J sourmash-build
#SBATCH --mail-type=ALL
#SBATCH --mail-user=titus@idyll.org
#SBATCH -t 3-0:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=200gb

# use to build trees

. "/home/ctbrown/miniconda3/etc/profile.d/conda.sh"

cd /home/ctbrown/sourmash_databases

conda activate sgc

set -o nounset
set -o errexit
set -x

snakemake -p outputs/trees/scaled/genbank-bacteria-d2-x1e5-k{21,51}.sbt.json

#echo ${SLURM_JOB_NODELIST}       # Output Contents of the SLURM NODELIST

env | grep SLURM            # Print out values of the current jobs SLURM environment variables

scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits

#sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
