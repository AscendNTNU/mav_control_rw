FROM ros:melodic-ros-base
MAINTAINER Ascend NTNU "www.ascendntnu.no"

ENV ROS_WORKSPACE_PATH=/root/catkin_workspace
ENV ROS_PACKAGE_NAME=mav_control_rw
RUN apt-get update -qq && apt-get install -yqq build-essential && apt-get install -yqq \
liblapacke-dev \
ros-melodic-joy \
ros-melodic-octomap-ros \
libeigen3-dev

RUN mkdir -p $ROS_WORKSPACE_PATH/src
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin_init_workspace $ROS_WORKSPACE_PATH/src'

# Run caktin_make once without building any packages to create the setup.bash
# RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; cd $ROS_WORKSPACE_PATH; catkin_make'

COPY ./ $ROS_WORKSPACE_PATH/src/$ROS_PACKAGE_NAME/
WORKDIR $ROS_WORKSPACE_PATH/src
RUN git clone https://github.com/catkin/catkin_simple.git
RUN git clone https://github.com/ethz-asl/rotors_simulator.git
RUN git clone https://github.com/ethz-asl/mav_comm.git
RUN git clone https://github.com/ethz-asl/eigen_catkin.git
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; cd $ROS_WORKSPACE_PATH; catkin_make'
