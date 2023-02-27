# DevOps - Containerization, CI/CD &amp; Monitoring - January 2023 - SoftUni

## Basic CI/CD with Jenkins

1. Creating Vagrantfile which creates virtual machine with the following configuration:
    - Box: "shekeriev/centos-stream-9"
    - Host names: "jenkins.martin.bg"
    - Private network with dedicated IPs: "192.168.34.201"
    - Forwarded port - "guest:host": "8080:8080"
    - Provisioning via provided bash scripts: "setup-hosts.sh", "setup-firewall.sh", "setup-additional-packages.sh", "setup-docker.sh" and "setup-jenkins.sh"
    - Default settings for shared folder
    - Set virtual machine memory size: 3072
    - Create after trigger event to get initial jenkins administrator password
    - Create another after trigger event to open default browser to configure Jenkins at [http://localhost:8080](http://localhost:8080)
2. Creating Jenkinsfile pipeline to build the BGApp application which contains:
    - Environment variables used in pipeline code
    - Four stages for process automation:
        - Downloading the project from your remote repository
            - if not exists - creating "projects" folder in default workspace directory
            - give access rights to "projects directory" for jenkins user
            - if application name folder already exists pull github project files, otherwise clone the project repository
        - Building the images
            - trying to remove existing docker images for web and db application
            - creating new docker images based on provided docker files at application name folder
        - Creating a common network
            - creating a common network for communication of the containers based on the previous created docker images
        - Running the containers
            - trying to remove existing docker containers for web and db application
            - running docker containers
3. Additional Jenkins setup at [http://localhost:8080](http://localhost:8080)
    - Enter initial administration password
    - Install suggested plugins
    - Create new event of type pipeline
    - Set configure pipeline with the created Jenkinsfile
    - Build the project
4. The result can be seen on this address [http://192.168.34.201:8000](http://192.168.34.201:8000)
