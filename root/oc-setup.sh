#! /bin/bash
# https://www.howtoforge.com/how-to-install-and-configure-openshift-origin-paas-server-on-ubuntu-2004/

echo "Setting up Docker, type q once the output from systemd has been displyaed."
systemctl start docker
systemctl enable docker
systemctl status docker

echo "Log into the Redhat Registry... specify your username and password."
docker login registry.redhat.io

echo "Downloading the Openshift client..."
wget https://github.com/openshift/origin/releases/download/v3.6.1/openshift-origin-client-tools-v3.6.1-008f2d5-linux-64bit.tar.gz
