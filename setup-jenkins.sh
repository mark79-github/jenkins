#!/bin/bash

echo "*** Downloading the repository information..."
sudo wget https://pkg.jenkins.io/redhat/jenkins.repo -O /etc/yum.repos.d/jenkins.repo

echo "*** Importing the repository key..."
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

echo "*** Updating repository info and install jenkins ..."
sudo dnf update && dnf install -y jenkins

echo "*** Adding jenkins user to the sudoers list ..."
sudo echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

echo "*** Enabling jenkins service to start on boot ..."
sudo systemctl enable jenkins

echo "*** Starting the jenkins service ..."
sudo systemctl start jenkins
