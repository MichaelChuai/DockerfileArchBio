FROM gym:latest


# Install Pytorch
COPY torch-1.11.0+cu113-cp39-cp39-linux_x86_64.whl /root
COPY torchaudio-0.11.0+cu113-cp39-cp39-linux_x86_64.whl /root
COPY torchvision-0.12.0+cu113-cp39-cp39-linux_x86_64.whl /root


RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple/ /root/torch-1.11.0+cu113-cp39-cp39-linux_x86_64.whl && \
    rm -f /root/torch-1.11.0+cu113-cp39-cp39-linux_x86_64.whl

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple/ /root/torchaudio-0.11.0+cu113-cp39-cp39-linux_x86_64.whl && \
    rm -f /root/torchaudio-0.11.0+cu113-cp39-cp39-linux_x86_64.whl

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple/ /root/torchvision-0.12.0+cu113-cp39-cp39-linux_x86_64.whl && \
    rm -f /root/torchvision-0.12.0+cu113-cp39-cp39-linux_x86_64.whl

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.mirrors.ustc.edu.cn/simple/ tensorboard torch_tb_profiler


# Add NLTK datasets
#COPY nltk_data.tar.gz /root

#RUN tar -zxv -f /root/nltk_data.tar.gz -C /usr/local/anaconda3/share && \
#	rm -f /root/nltk_data.tar.gz

EXPOSE 6006

CMD ["/bin/bash"]