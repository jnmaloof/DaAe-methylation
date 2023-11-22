#!/bin/bash
#SBATCH --partition=production # partition to submit to
#SBATCH --job-name="Minimap-DaAe" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=8 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --exclusive
#SBATCH --mem-per-cpu=4000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-04:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=sb_%A_Minimap-DaAe.out # File to which STDOUT will be written
#SBATCH --error=sb_%A_Minimap-DaAe.err # File to which STDERR will be written
#SBATCH --mail-user=jnmaloof@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load minimap2/2.24
module load samtools/1.17

## set up environment

cd /share/malooflab/Julin/git/DaAe-methylation/input

DaAe_Fasta=/share/malooflab/John/KIAT_Revisions/Assemblies/KIAT_Assemblies/PreRevision_Final/DaAe_20210520.fa

fastq-dir1=/share/rwmstore/Reads_DNA_RWM/PacBio/Brassica/2023_10_27/PB1011_BrassicaPool_User-HiFiv3_Revio_cell1/Brassica_7plex_cell1_Demux_6545/outputs

fastq=dir2=/share/rwmstore/Reads_DNA_RWM/PacBio/Brassica/2023_10_27/PB1011_BrassicaPool_User-HiFiv3_Revio_cell2/Brassica_6plex_cell2_Demux_6558/outputs


# Run program

## for DaAe Reads

minimap2 -ax map-pb -t 8 \
  DaAe_Fasta \
  $fastq-dir1/m84066_231012_001601_s4.bc2036--bc2036.hifi_reads.fastq.gz \
  $fastq-dir1/m84066_231012_001601_s4.bc2037--bc2037.hifi_reads.fastq.gz \
  $fastq-dir1/m84066_231012_001601_s4.bc2038--bc2038.hifi_reads.fastq.gz \
  $fastq-dir2/m84066_231018_220419_s2.bc2036--bc2036.hifi_reads.fastq.gz \
  $fastq-dir2/m84066_231018_220419_s2.bc2037--bc2037.hifi_reads.fastq.gz \
  $fastq-dir2/m84066_231018_220419_s2.bc2038--bc2038.hifi_reads.fastq.gz \
  | samtools sort | samtools view -b --threads 8  --write-index  --output DaAe-PacBio-to-DaAe.bam

## For L121

minimap2 -ax map-pb -t 8 \
  DaAe_Fasta \
  $fastq-dir1/m84066_231012_001601_s4.bc2034--bc2034.hifi_reads.fastq.gz \
  $fastq-dir1/m84066_231012_001601_s4.bc2039--bc2039.hifi_reads.fastq.gz \
  $fastq-dir2/m84066_231018_220419_s2.bc2034--bc2034.hifi_reads.fastq.gz \
  $fastq-dir2/m84066_231018_220419_s2.bc2039--bc2039.hifi_reads.fastq.gz \
  | samtools sort | samtools view -b --threads 8  --write-index  --output L121-PacBio-to-DaAe.bam

  
# Run stats

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
