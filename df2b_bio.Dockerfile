FROM gbase:latest


## SRA Tools
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/  -y sra-tools entrez-direct

## Genome Mapping
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ -y libgcc-ng
#RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install  -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y bowtie2
COPY bowtie2-2.5.2-linux-x86_64.zip /root
RUN unzip /root/bowtie2-2.5.2-linux-x86_64.zip -d /usr/local && \
    ln -s /usr/local/bowtie2-2.5.2-linux-x86_64 /usr/local/bowtie2 && \
    mv /usr/local/bowtie2/bowtie2* /usr/local/bin && \
    rm -f /root/bowtie2-2.5.2-linux-x86_64.zip

## File Tools
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y samtools bedtools gffread gffcompare

## RNA-Seq
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y star stringtie

## IGV
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y igvtools

## GATK4
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y gatk4

## vcftools
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y vcftools ensembl-vep

COPY vcf2maf /root
RUN mv /root/vcf2maf /usr/local/anaconda3/bin && \
    chmod 755 /usr/local/anaconda3/bin/vcf2maf

## bcftools

RUN apt-get install -y libopenblas-base
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ -y bcftools

## Biopython
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple biopython pyfaidx pysam HTSeq


## scRNA && Spacial transcriptome

COPY spaceranger-2.1.1.tar.gz /root
ENV SPACERANGE_HOME /usr/local/spaceranger
ENV PATH $SPACERANGE_HOME/bin:$PATH

RUN tar -zxv -f /root/spaceranger-2.1.1.tar.gz -C /usr/local && \
    chown -R root:root /usr/local/spaceranger-2.1.1 && \
    ln -s /usr/local/spaceranger-2.1.1 $SPACERANGE_HOME && \
    rm -f /root/spaceranger-2.1.1.tar.gz

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple --ignore-installed scanpy leidenalg spatialde 

## R packages

RUN apt-get install -y libgeos-dev

RUN Rscript -e 'BiocManager::install("DESeq2");'
RUN Rscript -e 'install.packages("Seurat");'
RUN Rscript -e 'install.packages("devtools");'
RUN Rscript -e 'devtools::install_github("satijalab/seurat-data");'


