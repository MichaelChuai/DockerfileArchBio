### Ubuntu == 18.04
### Anaconda3 == 2021.11
### Python == 3.9.7

FROM ubuntu:18.04


ENV LD_LIBRARY_PATH /usr/lib64:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
ENV PATH /usr/local/anaconda3/bin:$PATH
ENV LANG en_US.UTF-8
ENV LC_ALL C

RUN rm -rf /etc/apt/sources.list.d/* && \
	sed -i 's/deb-src/# dev-src/g; s/deb http:\/\/archive.ubuntu.com/deb http:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
	apt-get update -o Acquire-by-hash=yes -o Acquire::https::No-Cache=True -o Acquire::http::No-Cache=True

RUN	apt-get install -y netbase binutils xz-utils less patch

RUN apt-get install -y libatomic1 perl manpages-dev liblsan0

RUN apt-get install -y libgomp1 libasan4 libtsan0 libitm1

RUN apt-get install -y libssl-dev libcurl4-openssl-dev libbz2-dev zlib1g-dev

RUN apt-get install -y build-essential

RUN apt-get install -y net-tools iputils-ping iproute2 screen

# Install and config git
RUN apt-get install -y git

RUN git config --global user.name "MichaelChuai" && \
    git config --global user.email alexanderm16@163.com

# Install Anaconda
COPY Anaconda3-2021.11-Linux-x86_64.sh /root

RUN bash /root/Anaconda3-2021.11-Linux-x86_64.sh -b -p /usr/local/anaconda3 && \
	rm -f /root/Anaconda3-2021.11-Linux-x86_64.sh

# Install related packages
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple tqdm pylint autopep8 twine orderedset

# Install simple bioinformatics packages
RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple pyfaidx pysam

# Install PySpark
RUN apt-get update && apt-get install -y openjdk-8-jdk

RUN	/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple pyspark==3.2.0

COPY pyspark /usr/local/anaconda3/bin
RUN chmod 755 /usr/local/anaconda3/bin/pyspark

# Add a notebook profile.
RUN mkdir -p -m 700 /root/.jupyter/ && \
	echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.allow_root = True" >> /root/.jupyter/jupyter_notebook_config.py && \
	echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py


EXPOSE 8888

CMD ["/bin/bash"]
