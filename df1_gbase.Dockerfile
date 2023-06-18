### Ubuntu == 22.04
### CUDA == 11.8
### CUDNN == 8
### Anaconda3 == 2023.03
### Python == 3.10
### pytorch == 2.0.0
### RAPIDS == 23.04
### pyspark == 3.2.0
### R == 4.2

FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04


ENV CUDA_ROOT /usr/local/cuda
ENV LD_LIBRARY_PATH /usr/lib64:$CUDA_ROOT/lib64:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
ENV PATH /usr/local/anaconda3/bin:$CUDA_ROOT/bin:$PATH
ENV LANG en_US.UTF-8
ENV LC_ALL C

RUN rm -rf /etc/apt/sources.list.d/* && \
	sed -i 's/deb-src/# dev-src/g; s/deb http:\/\/archive.ubuntu.com/deb http:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN	apt-get update --fix-missing
RUN	apt-get install -y netbase binutils xz-utils less patch
RUN apt-get install -y libatomic1 perl manpages-dev liblsan0
RUN apt-get install -y libgomp1 libasan8 libtsan0 libitm1
RUN apt-get install -y libssl-dev libcurl4-openssl-dev libbz2-dev zlib1g-dev
RUN apt-get install -y build-essential
RUN apt-get install -y net-tools iputils-ping iproute2 screen libarchive-dev

# Install and config git
RUN apt-get install -y git

# Install Anaconda
COPY Anaconda3-2023.03-1-Linux-x86_64.sh /root
RUN bash /root/Anaconda3-2023.03-1-Linux-x86_64.sh -b -p /usr/local/anaconda3 && \
	rm -f /root/Anaconda3-2023.03-1-Linux-x86_64.sh

# Install related packages
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple tqdm pylint autopep8 twine orderedset

# Install pytorch and related packages
COPY torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl /root
COPY torchaudio-2.0.1+cu118-cp310-cp310-linux_x86_64.whl /root
COPY torchvision-0.15.1+cu118-cp310-cp310-linux_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl /root/torchaudio-2.0.1+cu118-cp310-cp310-linux_x86_64.whl /root/torchvision-0.15.1+cu118-cp310-cp310-linux_x86_64.whl tensorboard && \
    rm -f /root/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl /root/torchaudio-2.0.1+cu118-cp310-cp310-linux_x86_64.whl /root/torchvision-0.15.1+cu118-cp310-cp310-linux_x86_64.whl


# Install mamba
COPY condarc /root/.condarc
RUN conda install -y mamba -n base -c conda-forge

# Install RAPIDS
RUN mamba install -c rapidsai -c conda-forge -c nvidia -y rapids=23.04

# Install pyspark
RUN apt-get update && apt-get install -y openjdk-8-jdk
COPY pyspark-3.2.0.tar.gz /root
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/pyspark-3.2.0.tar.gz && \
    rm -f /root/pyspark-3.2.0.tar.gz	
COPY pyspark /usr/local/anaconda3/bin
RUN chmod 755 /usr/local/anaconda3/bin/pyspark

## Visualization
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple upsetplot plotly dash

## Perl
RUN apt-get update && apt-get install -y cpanminus
RUN  rm -f /usr/local/anaconda3/bin/perl && \
    ln -s /usr/bin/perl /usr/local/anaconda3/bin/perl && \
    rm -f /usr/local/anaconda3/bin/cpanm && \
    ln -s /usr/bin/cpanm /usr/local/anaconda3/bin/cpanm

## Install R
RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends software-properties-common dirmngr
RUN apt-get install -y wget && \
    wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
	add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
RUN echo 'Asia/Shanghai' > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive TZ=Asia/Shanghai apt-get install -y --no-install-recommends tzdata 
RUN apt-get install -y --no-install-recommends r-base liblzma-dev gfortran
RUN sed -i 's/cloud.r-project.org/mirrors.sjtug.sjtu.edu.cn\/cran/g' /etc/R/Rprofile.site
RUN sed -i 's/make/make -j 12/g' /etc/R/Renviron
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple radian

### Install R packages
RUN Rscript -e 'install.packages("languageserver"); install.packages("IRkernel"); IRkernel::installspec();'
RUN Rscript -e 'install.packages("tidyverse"); install.packages("circlize");'
RUN Rscript -e 'install.packages("BiocManager");'
COPY FField_0.1.0.tar.gz /root
RUN Rscript -e 'install.packages("/root/FField_0.1.0.tar.gz");' && \
    rm -f /root/FField_0.1.0.tar.gz
RUN apt-get install -y libjpeg-dev libblas-dev liblapack-dev

CMD ["/bin/bash"]