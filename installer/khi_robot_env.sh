#!/bin/bash
sudo rosdep init
rosdep update

mkdir -p ~/ws
cd ~/ws
mkdir src
catkin init
catkin build
source ~/ws/devel/setup.bash
echo "source ~/ws/devel/setup.bash" >> ~/.bashrc
cd ~/ws/src
git clone https://github.com/Kawasaki-Robotics/khi_robot.git
cd ~/ws
rosdep install -y -r --from-paths src --ignore-src
source ~/.bashrc
catkin build 
source ~/.bashrc
