### Ubuntu == 22.04
### Python == 3.11

FROM ubuntu:22.04

ENV LD_LIBRARY_PATH /usr/lib64:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
ENV PATH /usr/local/anaconda3/bin:$PATH
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

RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple wandb

## Visualization
RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple upsetplot plotly dash

CMD ["/bin/bash"]
