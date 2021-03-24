FROM conda:latest

# Setup Bioconda channels
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/

RUN conda config --set show_channel_urls yes

# Install related softwares
## SRA Tools
RUN conda install -c bioconda -y sra-tools entrez-direct

## Genome Mapping
RUN conda install -c bioconda -y bowtie2 bwa

## File Tools
RUN conda install -c bioconda -y samtools bedtools gffread gffcompare

## RNA-Seq
RUN conda install -c bioconda -y hisat2 star stringtie

## IGV
RUN conda install -c bioconda -y igvtools

## GATK4
RUN conda install -c bioconda -y gatk4

## vcftools
RUN conda install -c bioconda -y vcftools

## bcftools

RUN apt-get install -y libopenblas-base
RUN conda install -c bioconda -y bcftools

## Biopython
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple biopython