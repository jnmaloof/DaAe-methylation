conda activate pacbio-minimap2

cd ~/git/DaAe-methylation/input

DaAe_Fasta=DaAe_20210520.fa

Brapa_Fasta=Brapa_Z1_V2/BrapaZ1_v2_chromosomes.fasta

# DaAe bam files

# not sure why I cant get my regex to work directly with find, but this works...

find ./unaligned_bams | grep -E "(2036|2037|2038).*bam$" > DaAe.fofn

# L121 Bam files

find ./unaligned_bams | grep -E "(2034|2039).*bam$" > L121.fofn

# Run program

## for DaAe Reads

pbmm2 align $DaAe_Fasta DaAe.fofn aligned_bams/DaAe_to_DaAe.bam --preset HIFI --log-level DEBUG --unmapped --sort --sort-memory 8G -j 30

## For L121

pbmm2 align $DaAe_Fasta L121.fofn aligned_bams/L121_to_DaAe.bam --preset HIFI --log-level DEBUG --unmapped --sort --sort-memory 8G -j 30

## For L121 against B. rapa

pbmm2 align $Brapa_Fasta L121.fofn aligned_bams/L121_to_Brapa.bam --preset HIFI --log-level DEBUG --unmapped --sort --sort-memory 8G -j 30



  
# Run stats

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
