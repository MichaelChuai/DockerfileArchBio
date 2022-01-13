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
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple biopython

## circos

RUN apt-get update && apt-get install -y libgd-dev cpanminus
COPY circos-current.tgz /root
ENV CIRCOS_HOME /usr/local/circos
ENV PATH $CIRCOS_HOME/bin:$PATH

RUN tar -zxv -f /root/circos-current.tgz -C /usr/local && \
    chown -R root:root /usr/local/circos-0.69-9 && \
    ln -s /usr/local/circos-0.69-9 $CIRCOS_HOME && \
    rm -f /root/circos-current.tgz && \
    rm -f /usr/local/anaconda3/bin/perl && \
    ln -s /usr/bin/perl /usr/local/anaconda3/bin/perl && \
    rm -f /usr/local/anaconda3/bin/cpanm && \
    ln -s /usr/bin/cpanm /usr/local/anaconda3/bin/cpanm

RUN cpanm --no-wget --notest GD

RUN cpanm --no-wget --notest \
    Text::Format \
    Set::IntSpan \
    Statistics::Basic \
    SVG \
    Params::Validate \
    Regexp::Common \
    Readonly \
    Math::VecStat \
    Math::Bezier \
    Clone \
    Config::General \
    Font::TTF::Font \
    Math::Round

