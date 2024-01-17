cd ~/git/DaAe-methylation/input

aligned_bam_to_cpg_scores \
  --bam aligned_bams/DaAe_to_DaAe.bam \
  --output-prefix cpg_scores/DaAe_to_DaAe_cpg \
  --model /usr/local/bin/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite \
  --threads 15
  
aligned_bam_to_cpg_scores \
  --bam aligned_bams/L121_to_DaAe.bam \
  --output-prefix cpg_scores/L121_to_DaAe_cpg \
  --model /usr/local/bin/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite \
  --threads 15
  
