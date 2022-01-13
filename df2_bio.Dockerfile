FROM gconda:latest

# Setup Bioconda channels
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/

RUN conda config --set show_channel_urls yes

# Install related softwares
## SRA Tools
RUN conda install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y sra-tools entrez-direct

## Genome Mapping
RUN conda install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y bowtie2 bwa

## File Tools
RUN conda install -c bioconda -y samtools bedtools gffread gffcompare

## RNA-Seq
RUN conda install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y hisat2 star stringtie

## IGV
RUN conda install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y igvtools

## GATK4
RUN conda install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y gatk4

## vcftools
RUN conda install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y vcftools

## bcftools

RUN apt-get install -y libopenblas-base
RUN conda install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y bcftools

## Biopython
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple biopython


## scRNA && Spacial transcriptome
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple scanpy leidenalg spatialde 

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple scvi-tools