### Ubuntu == 22.04
### CUDA == 11.8
### CUDNN == 8
### Anaconda3 == 2023.03
### Python == 3.10
### pytorch == 2.0.0
### RAPIDS == 23.04
### pyspark == 3.2.0
### R == 4.2

FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

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

# Install Conda
COPY Mambaforge-Linux-x86_64.sh /root
RUN bash /root/Mambaforge-Linux-x86_64.sh -b -p /usr/local/anaconda3 && \
	rm -f /root/Mambaforge-Linux-x86_64.sh

COPY condarc /root
RUN mv /root/condarc /root/.condarc

COPY miniconda_extra00.txt /root
COPY miniconda_extra01.txt /root
COPY miniconda_extra02.txt /root
COPY miniconda_extra03.txt /root
COPY miniconda_extra04.txt /root
COPY miniconda_extra05.txt /root
COPY miniconda_extra06.txt /root
COPY miniconda_extra07.txt /root
COPY miniconda_extra08.txt /root
COPY miniconda_extra09.txt /root
COPY miniconda_extra10.txt /root
COPY miniconda_extra11.txt /root
COPY miniconda_extra12.txt /root

RUN mamba install -y python=3.11
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra00.txt && rm -f /root/miniconda_extra00.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra01.txt && rm -f /root/miniconda_extra01.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra02.txt && rm -f /root/miniconda_extra02.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra03.txt && rm -f /root/miniconda_extra03.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra04.txt && rm -f /root/miniconda_extra04.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra05.txt && rm -f /root/miniconda_extra05.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra06.txt && rm -f /root/miniconda_extra06.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra07.txt && rm -f /root/miniconda_extra07.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra08.txt && rm -f /root/miniconda_extra08.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra09.txt && rm -f /root/miniconda_extra09.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra10.txt && rm -f /root/miniconda_extra10.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra11.txt && rm -f /root/miniconda_extra11.txt
RUN MAMBA_NO_LOW_SPEED_LIMIT=1 && mamba install -y --file /root/miniconda_extra12.txt && rm -f /root/miniconda_extra12.txt

# Install related packages
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple tqdm pylint autopep8 twine orderedset

# Install pytorch and related packages
COPY torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl /root
COPY torchaudio-2.0.1+cu118-cp310-cp310-linux_x86_64.whl /root
COPY torchvision-0.15.1+cu118-cp310-cp310-linux_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl /root/torchaudio-2.0.1+cu118-cp310-cp310-linux_x86_64.whl /root/torchvision-0.15.1+cu118-cp310-cp310-linux_x86_64.whl tensorboard && \
    rm -f /root/torch-2.0.0+cu118-cp310-cp310-linux_x86_64.whl /root/torchaudio-2.0.1+cu118-cp310-cp310-linux_x86_64.whl /root/torchvision-0.15.1+cu118-cp310-cp310-linux_x86_64.whl

# RAPIDS
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple cudf-cu11 dask-cudf-cu11 cuml-cu11 cugraph-cu11 cuspatial-cu11 cucim --extra-index-url=https://pypi.nvidia.com


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
RUN cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/local/anaconda3/lib
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple radian

### Install R packages
RUN apt-get install -y --no-install-recommends libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libblas-dev liblapack-dev
RUN Rscript -e 'install.packages("languageserver"); install.packages("IRkernel"); IRkernel::installspec();'
RUN Rscript -e 'install.packages("tidyverse"); install.packages("circlize");'
RUN Rscript -e 'install.packages("BiocManager");'
COPY FField_0.1.0.tar.gz /root
RUN Rscript -e 'install.packages("/root/FField_0.1.0.tar.gz");' && \
    rm -f /root/FField_0.1.0.tar.gz


CMD ["/bin/bash"]
