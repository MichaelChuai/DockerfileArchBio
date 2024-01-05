FROM gbase:latest


COPY go1.21.4.linux-amd64.tar.gz /root

RUN tar -zxv -f /root/go1.21.4.linux-amd64.tar.gz -C /usr/local && \
    chown -R root:root /usr/local/go && \
    rm -f /root/go1.21.4.linux-amd64.tar.gz

ENV PATH /usr/local/go/bin:$PATH
ENV GOPATH /go
ENV GOPROXY https://goproxy.cn,direct
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 1777 "$GOPATH"
