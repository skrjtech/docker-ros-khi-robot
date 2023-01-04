FROM ubuntu:18.04
# USE BASH
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt update && apt -y upgrade
RUN apt-get update && apt -y upgrade
RUN apt install -y software-properties-common
RUN apt install -y sudo curl wget git make tmux
RUN set -x \
    && git clone https://github.com/skrjtech/ros-installer.git \
    && cd ros-installer/installer \
    && sed -i 's/sudo //g' Ros1/melodic/melodic_version.sh \
    && DEBIAN_FRONTEND=noninteractive make ros1_melodic_install \
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list \
    $$ set +x
# catkin latest
RUN apt install -y python-catkin-tools
RUN echo 'export QT_X11_NO_MITSHM=1' >> ~/.bashrc
# Check GUI Apps
RUN apt install -y x11-apps
CMD [ "/bin/bash"]
