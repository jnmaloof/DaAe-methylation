#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="Minimap-DaAe" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=8 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --exclusive
#SBATCH --mem-per-cpu=8000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=sb_%A_Minimap-DaAe.out # File to which STDOUT will be written
#SBATCH --error=sb_%A_Minimap-DaAe.err # File to which STDERR will be written
#SBATCH --mail-user=jnmaloof@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load samtools/1.17
module load anaconda3/23.1.0

## set up environment

### conda for pbmm2
source ~/.bashrc
conda activate /share/malooflab/Packages/Conda_Envs/pacbio-minimap2

cd /share/malooflab/Julin/git/DaAe-methylation/input

DaAe_Fasta=/share/malooflab/John/KIAT_Revisions/Assemblies/KIAT_Assemblies/PreRevision_Final/DaAe_20210520.fa

fastq_dir1=/share/rwmstore/Reads_DNA_RWM/PacBio/Brassica/2023_10_27/PB1011_BrassicaPool_User-HiFiv3_Revio_cell1/SMRT_LIMA

fastq_dir2=/share/rwmstore/Reads_DNA_RWM/PacBio/Brassica/2023_10_27/PB1011_BrassicaPool_User-HiFiv3_Revio_cell2/r84066_20231018_212357_1_B01/hifi_reads

# DaAe bam files

# not sure why I cant get my regex to work directly with find, but this works...

find $fastq_dir1/ | grep -E "(2036|2037|2038).*bam$" > DaAe.fofn
find $fastq_dir2/ | grep -E "(2036|2037|2038).*bam$" >> DaAe.fofn

# L121 Bam files

find $fastq_dir1/ | grep -E "(2034|2039).*bam$" > L121.fofn
find $fastq_dir2/ | grep -E "(2034|2039).*bam$" >> L121.fofn


# Run program

## for DaAe Reads

pbmm2 align $DaAe_Fasta DaAe.fofn DaAe_to_DaAe.bam --preset HIFI --unmapped --sort -j 8

## For L121

pbmm2 align $DaAe_Fasta L121.fofn L121_to_DaAe.bam --preset HIFI --unmapped --sort -j 8


  
# Run stats

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
