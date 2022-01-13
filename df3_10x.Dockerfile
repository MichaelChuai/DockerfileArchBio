FROM bio:latest


COPY spaceranger-1.3.1.tar.gz /root
ENV SPACERANGE_HOME /usr/local/spaceranger
ENV PATH $SPACERANGE_HOME/bin:$PATH

RUN tar -zxv -f /root/spaceranger-1.3.1.tar.gz -C /usr/local && \
    chown -R root:root /usr/local/spaceranger-1.3.1 && \
    ln -s /usr/local/spaceranger-1.3.1 $SPACERANGE_HOME && \
    rm -f /root/spaceranger-1.3.1.tar.gz

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple scanpy leidenalg spatialde 

