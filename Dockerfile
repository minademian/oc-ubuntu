#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# Install.
RUN \
  # apt clean && \
  # rm -rf /var/lib/apt/lists/* && \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common systemd && \
  apt-get install -y byobu curl git htop man unzip vim wget dnsutils && \
  apt-get install -y x11vnc xvfb firefox && \
  apt-get install -y docker.io

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts
ADD root/oc-setup.sh /root/oc-setup.sh
ADD root/daemon.json /etc/docker/daemon.json

# Install vnc, xvfb in order to create a 'fake' display and firefox
RUN     mkdir ~/.vnc

# Setup a password
RUN     x11vnc -storepasswd 1234 ~/.vnc/passwd

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]

RUN bash -c "chmod +x ./oc-setup.sh"

RUN bash -c 'echo "firefox" >> /.bashrc'