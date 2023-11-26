Software installs for this project

# Setting up the conda environment for pbmm2 on LSSC0

module load anaconda3/23.1.0

conda create -p /share/malooflab/Packages/Conda_Envs/pacbio-minimap2

conda init

conda source ~/.bashrc

conda activate /share/malooflab/Packages/Conda_Envs/pacbio-minimap2

conda install -c bioconda pbmm2

# pb-CpG-tools

cd ~/Downloads
wget https://github.com/PacificBiosciences/pb-CpG-tools/releases/download/v2.3.2/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz
tar -xzf pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz

sudo mv pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu /usr/local/bin
cd /usr/local/bin/
sudo ln -s pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores ./

# Run help option to test binary and see latest usage details:
cd
aligned_bam_to_cpg_scores --help

