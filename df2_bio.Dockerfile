FROM conda:latest

# Setup Bioconda channels
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/

RUN conda config --set show_channel_urls yes

# Install related softwares
## SRA Tools
RUN conda install -y sra-tools

## Genome Mapping
RUN conda install -y bowtie2 bwa

## File Tools
RUN conda install -y samtools bedtools gffread gffcompare

## RNA-Seq
RUN conda install -y hisat2 star stringtie

## IGV
RUN conda install -y igvtools

## GATK4
RUN conda install -y gatk4

## vcftools
RUN conda install -y vcftools