FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive 

RUN apt -y update 
RUN apt -y upgrade 
RUN apt -y full-upgrade
RUN apt -y autoremove
RUN apt -y autoclean

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade
RUN apt-get -y autoremove
RUN apt-get -y autoclean

RUN apt install -y                  \
                    git             \
                    vim             \
                    gdb             \
                    nano            \
                    wget            \
                    curl            \
                    htop            \
                    tmux            \
                    cmake           \
                    xterm           \
                    gnupg           \
                    locales         \
                    valgrind        \
                    dbus-x11        \
                    python3-tk      \
                    mesa-utils      \
                    subversion      \
                    terminator      \
                    libssl-dev      \
                    default-jre     \
                    default-jdk     \
                    lsb-release     \
                    build-essential \
                    libgl1-mesa-glx \
                    libgl1-mesa-dri \
                    software-properties-common

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN apt-add-repository universe
RUN apt update
RUN apt install -y              \
                    python      \
                    python-pip  \
                    build-essential
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*
RUN /usr/bin/yes | pip install --upgrade "pip < 21.0"
RUN /usr/bin/yes | pip install --upgrade virtualenv
RUN /usr/bin/yes | pip install --upgrade paramiko
RUN /usr/bin/yes | pip install --ignore-installed --upgrade numpy protobuf

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update
RUN apt install -y                                      \
                    --allow-downgrades                  \
                    --allow-remove-essential            \    
                    --allow-change-held-packages        \
                    libpcap-dev                         \
                    python-wstool                       \
                    python-rosdep                       \
                    build-essential                     \
                    libopenblas-dev                     \
                    python-rosinstall                   \
                    gstreamer1.0-tools                  \
                    libgstreamer1.0-dev                 \
                    ros-melodic-geodesy                 \
                    ros-melodic-desktop-full            \
                    python-rosinstall-generator         \
                    ros-melodic-socketcan-bridge        \
                    libgstreamer-plugins-base1.0-dev    \
                    libgstreamer-plugins-good1.0-dev

RUN sh -c 'echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc'

RUN apt clean
RUN rm -rf /var/lib/apt/lists/*
RUN apt -y update 
RUN apt -y upgrade 
RUN apt -y full-upgrade
RUN apt -y autoremove
RUN apt -y autoclean

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade
RUN apt-get -y autoremove
RUN apt-get -y autoclean

ARG USER=venv
ARG GROUPUSER=venv
ARG UID=1000
ARG GID=1000
ARG PASSWORD=venv
RUN groupadd -g $GID $GROUPUSER
RUN useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USER
RUN echo $USER:$PASSWORD | chpasswd
RUN echo "$USER   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
WORKDIR /home/$USER

RUN sh -c 'echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc'

CMD ["/bin/bash"]
