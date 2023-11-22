# Setting up the conda environment for pbmm2 on LSSC0

module load anaconda3/23.1.0

conda create -p /share/malooflab/Packages/Conda_Envs/pacbio-minimap2

conda init

conda source ~/.bashrc

conda activate /share/malooflab/Packages/Conda_Envs/pacbio-minimap2

conda install -c bioconda pbmm2