#!/bin/bash
docker run --rm                                 \
            -it                                 \
            --net=host                          \
            --ipc=host                          \
            --privileged                        \
            -e ROS_IP=127.0.0.1                 \
            -e DISPLAY=$DISPLAY                 \
            --env="QT_X11_NO_MITSHM=1"          \
            --device=/dev/dri:/dev/dri          \
	        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
            ros/melodic:cpu