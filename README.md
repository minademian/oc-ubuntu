## Openshift and Firefox Ubuntu Docker Image

This repository contains a customized [Ubuntu](http://www.ubuntu.com/) Dockerfile to allow for [Openshift Cluster](https://docs.openshift.com/container-platform/3.11/welcome/index.html) to be installed and configured on it. It also includes Firefox so that you can access the Openshift Cluster GUI in the browser, once you have configured it.

This is aimed for those who are unable to install Openshift locally on their machine!

### Base Docker Image

* [ubuntu:20.04](https://registry.hub.docker.com/u/library/ubuntu/)

### Prerequisities

1. Install [Docker](https://www.docker.com/).
1. Install a VNC client like [VNC Viewer](https://www.realvnc.com/en/connect/). You'll need this to use Firefox in the image.
1. You need to register an account on the [Red Hat Customer Portal](https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/registrations?client_id=https%3A%2F%2Fwww.redhat.com%2Fwapps%2Fugc-oidc&redirect_uri=https%3A%2F%2Fwww.redhat.com%2Fwapps%2Fugc%2Fprotected%2Faccount.html&response_type=code&scope=openid). This will be used when the `oc-setup.sh` is run later in the process, you will need to login into Docker via the command-line in order to allow for Openshift to be installed.
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
1. In a separate tab or window of your command-line client, run `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container id>`. Save the IP address somewhere, you will need it later when:
   - you launch the Openshift cluster inside the Docker image
   - and, you want to use Firefox from the VNC client
