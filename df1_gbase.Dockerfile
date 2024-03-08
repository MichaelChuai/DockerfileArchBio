### Ubuntu == 22.04
### CUDA == 12.1
### CUDNN == 8
### Python == 3.11
### pytorch == 2.1
### R == 4.x

FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

ENV CUDA_ROOT /usr/local/cuda
ENV LD_LIBRARY_PATH /usr/lib64:$CUDA_ROOT/lib64:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
ENV PATH /usr/local/anaconda3/bin:$CUDA_ROOT/bin:$PATH
ENV LANG en_US.UTF-8
ENV LC_ALL C

RUN rm -rf /etc/apt/sources.list.d/* && \
	sed -i 's/deb-src/# dev-src/g; s/deb http:\/\/archive.ubuntu.com/deb http:\/\/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
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
COPY Mambaforge-23.3.1-1-Linux-x86_64.sh /root
RUN bash /root/Mambaforge-23.3.1-1-Linux-x86_64.sh -b -p /usr/local/anaconda3 && \
	rm -f /root/Mambaforge-23.3.1-1-Linux-x86_64.sh

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
COPY longintrepr.h /usr/local/anaconda3/include/python3.11


RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple tqdm pylint autopep8 twine

# Install pytorch and related packages
COPY nvidia_cublas_cu12-12.1.3.1-py3-none-manylinux1_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/nvidia_cublas_cu12-12.1.3.1-py3-none-manylinux1_x86_64.whl && \
    rm -f /root/nvidia_cublas_cu12-12.1.3.1-py3-none-manylinux1_x86_64.whl

COPY nvidia_cudnn_cu12-8.9.2.26-py3-none-manylinux1_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/nvidia_cudnn_cu12-8.9.2.26-py3-none-manylinux1_x86_64.whl && \
    rm -f /root/nvidia_cudnn_cu12-8.9.2.26-py3-none-manylinux1_x86_64.whl

COPY nvidia_cufft_cu12-11.0.2.54-py3-none-manylinux1_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/nvidia_cufft_cu12-11.0.2.54-py3-none-manylinux1_x86_64.whl && \
    rm -f /root/nvidia_cufft_cu12-11.0.2.54-py3-none-manylinux1_x86_64.whl

COPY nvidia_cusparse_cu12-12.1.0.106-py3-none-manylinux1_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/nvidia_cusparse_cu12-12.1.0.106-py3-none-manylinux1_x86_64.whl && \
    rm -f /root/nvidia_cusparse_cu12-12.1.0.106-py3-none-manylinux1_x86_64.whl

COPY nvidia_cusolver_cu12-11.4.5.107-py3-none-manylinux1_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/nvidia_cusolver_cu12-11.4.5.107-py3-none-manylinux1_x86_64.whl && \
    rm -f /root/nvidia_cusolver_cu12-11.4.5.107-py3-none-manylinux1_x86_64.whl

COPY nvidia_nccl_cu12-2.19.3-py3-none-manylinux1_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/nvidia_nccl_cu12-2.19.3-py3-none-manylinux1_x86_64.whl && \
    rm -f /root/nvidia_nccl_cu12-2.19.3-py3-none-manylinux1_x86_64.whl


COPY triton-2.2.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/triton-2.2.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl && \
    rm -f /root/triton-2.2.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl

COPY torch-2.2.1-cp311-cp311-manylinux1_x86_64.whl /root
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple /root/torch-2.2.1-cp311-cp311-manylinux1_x86_64.whl  tensorboard && \
    rm -f /root/torch-2.2.1-cp311-cp311-manylinux1_x86_64.whl && \
    cp /usr/local/anaconda3/lib/python3.11/site-packages/nvidia/cudnn/lib/*.so.8 /usr/lib64

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple torchvision torchaudio dask

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple  captum torchinfo wandb spacy gputil


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


### Install go
COPY go1.21.4.linux-amd64.tar.gz /root

RUN tar -zxv -f /root/go1.21.4.linux-amd64.tar.gz -C /usr/local && \
    chown -R root:root /usr/local/go && \
    rm -f /root/go1.21.4.linux-amd64.tar.gz

ENV PATH /usr/local/go/bin:$PATH
ENV GOPATH /go
ENV GOPROXY https://goproxy.cn,direct
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 1777 "$GOPATH"

CMD ["/bin/bash"]
