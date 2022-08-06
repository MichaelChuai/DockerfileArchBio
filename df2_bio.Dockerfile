FROM gbase:latest

# Setup Bioconda channels

RUN conda config --add channels http://mirrors.aliyun.com/anaconda/pkgs/main

RUN conda config --add channels http://mirrors.aliyun.com/anaconda/cloud/conda-forge/

RUN conda config --add channels http://mirrors.aliyun.com/anaconda/cloud/bioconda/

RUN conda config --set show_channel_urls yes

RUN conda install mamba -n base -c http://mirrors.aliyun.com/anaconda/cloud/conda-forge/


# Install related softwares
## SRA Tools
RUN mamba install -c http://mirrors.aliyun.com/anaconda/cloud/bioconda/ -y sra-tools entrez-direct

## Genome Mapping
RUN mamba install -c http://mirrors.aliyun.com/anaconda/cloud/bioconda/ -y bowtie2 bwa

## File Tools
RUN mamba install -c bioconda -y samtools bedtools gffread gffcompare

## RNA-Seq
RUN mamba install -c http://mirrors.aliyun.com/anaconda/cloud/bioconda/ -y star stringtie htseq

## IGV
RUN mamba install -c http://mirrors.aliyun.com/anaconda/cloud/bioconda/ -y igvtools

## GATK4
RUN mamba install -c http://mirrors.aliyun.com/anaconda/cloud/bioconda/ -y gatk4

## vcftools
RUN mamba install -c http://mirrors.aliyun.com/anaconda/cloud/bioconda/ -y vcftools ensembl-vep

COPY vcf2maf /root
RUN mv /root/vcf2maf /usr/local/anaconda3/bin && \
    chmod 755 /usr/local/anaconda3/bin/vcf2maf

## bcftools

RUN apt-get install -y libopenblas-base
RUN mamba install -c http://mirrors.aliyun.com/anaconda/cloud/bioconda/ -y bcftools

## Biopython
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple biopython pyfaidx pysam


## scRNA && Spacial transcriptome

COPY spaceranger-1.3.1.tar.gz /root
ENV SPACERANGE_HOME /usr/local/spaceranger
ENV PATH $SPACERANGE_HOME/bin:$PATH

RUN tar -zxv -f /root/spaceranger-1.3.1.tar.gz -C /usr/local && \
    chown -R root:root /usr/local/spaceranger-1.3.1 && \
    ln -s /usr/local/spaceranger-1.3.1 $SPACERANGE_HOME && \
    rm -f /root/spaceranger-1.3.1.tar.gz

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple scanpy leidenalg spatialde 

## R packages

RUN Rscript -e 'BiocManager::install("DESeq2");'
RUN Rscript -e 'install.packages("Seurat");'
