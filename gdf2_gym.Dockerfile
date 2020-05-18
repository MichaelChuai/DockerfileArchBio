FROM gconda:latest


# Install gym
RUN apt-get update && apt-get install -y cmake

RUN apt-get install -y libpython3.6-dev

RUN apt-get install -y libharfbuzz0b libboost-graph-dev libglib2.0-dev-bin

RUN apt-get install -y libpsm-infinipath1 libharfbuzz-gobject0 libpython2.7-dev dh-python libharfbuzz-gobject0

RUN apt-get install -y libboost-filesystem1.65-dev libiculx60 librdmacm1 librdmacm1 libpcre32-3

RUN apt-get install -y xtrans-dev

RUN apt-get install -y libboost-all-dev

RUN apt-get install -y libfribidi0 libhwloc5 libtool libmp3lame0 libzvbi0 libasound2 libdrm-intel1 x11proto-record-dev libgl1-mesa-glx

RUN apt-get install -y zlib1g-dev libjpeg-dev libopenblas-base

RUN apt-get install -y libxkbcommon-dev

RUN apt-get install -y xorg-dev xvfb swig

RUN apt-get install -y ffmpeg libsdl2-dev

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple PyOpenGL piglet pyglet==1.2.4

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple gym && \
/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple gym[atari] && \
/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple gym[box2d]  && \
/usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.douban.com/simple gym[classic_control]
