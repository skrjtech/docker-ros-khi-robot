FROM ubuntu:18.04
# USE BASH
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt update && apt -y upgrade
RUN apt-get update && apt -y upgrade
RUN apt install -y software-properties-common
RUN apt install -y sudo curl wget git make
RUN set -x \
    && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt update \ 
    && DEBIAN_FRONTEND=noninteractive apt install -y ros-melodic-desktop-full \
    && echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc \
    && . ~/.bashrc \ 
    && apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential \ 
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list \
    set +x
CMD [ "/bin/bash"]
