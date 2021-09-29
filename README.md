## Ubuntu Dockerfile

This repository contains **Dockerfile** of [Ubuntu](http://www.ubuntu.com/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/dockerfile/ubuntu/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Base Docker Image

* [ubuntu:20.04](https://registry.hub.docker.com/u/library/ubuntu/)

### Prerequisities

1. Install [Docker](https://www.docker.com/).
1. You need to register an account on the Red Hat Customer Portal. This will be used when the `oc-setup.sh` is run later in the process, you will need to login into Docker via the command-line in order to allow for Openshift to be installed.
1. Save your username and password, you will need them in the next section.

### Installation and Usage

1. `docker build -t oc-ubuntu.`
1. `docker run -itd --privileged oc-ubuntu:latest /usr/sbin/init`
1. `docker exec -it --privileged <container id> bash`
1. Run `./oc-setup.sh` once you're logged in as *root* in the Docker image.
1. Run the following commands in sequence:
   - `tar -xzf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz`
   - `cd openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit`
   - `cp oc kubectl /usr/local/bin/`
   - `oc version`
   - `systemctl restart docker`
1. In a separate tab or window of your command-line client, run `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container id>`. Save the IP address somewhere, you will need it later when you launch the Openshift cluster inside the Docker image.
