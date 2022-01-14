FROM bio:latest


COPY mujoco210-linux-x86_64.tar.gz /root
RUN mkdir -p /root/.mujoco
RUN tar -zxv -f /root/mujoco210-linux-x86_64.tar.gz -C /root/.mujoco && \
    chown -R root:root /root/.mujoco/mujoco210 && \
    rm -f /root/mujoco210-linux-x86_64.tar.gz
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/root/.mujoco/mujoco210/bin

RUN apt-get install -y libosmesa6-dev libgl1-mesa-glx libglfw3 swig

RUN ln -s /usr/lib/x86_64-linux-gnu/libGL.so.1 /usr/lib/x86_64-linux-gnu/libGL.so

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple 'mujoco-py<2.2,>=2.1'

# Test
RUN /usr/local/anaconda3/bin/python3 -c 'import mujoco_py; import os; mj_path = mujoco_py.utils.discover_mujoco(); xml_path = os.path.join(mj_path, "model", "humanoid.xml"); model = mujoco_py.load_model_from_path(xml_path); sim = mujoco_py.MjSim(model); print(sim.data.qpos); sim.step(); print(sim.data.qpos)'


RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple gym

RUN /usr/local/anaconda3/bin/pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple gym[atari] gym[accept-rom-license] gym[box2d] gym[classic_control] gym[toy_text] gym[other] 

