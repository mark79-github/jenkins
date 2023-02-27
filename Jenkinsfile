pipeline
{
  agent any

  environment {
        APP_NAME = "bgapp"
        GITHUB_ACCOUNT = "mark79-github"
        GITHUB_REPOSITORY = "bgapp"
        MYSQL_ROOT_PASSWORD = "12345"
        WEB_CONTAINER = "web"
        DB_CONTAINER = "db"
        WEB_IMAGE = "${APP_NAME}-${WEB_CONTAINER}"
        DB_IMAGE = "${APP_NAME}-${DB_CONTAINER}"
        APP_NETWORK = "${APP_NAME}-net"
        EXPOSE_TO_PORT = "8000"
  }

  stages
  {
    stage('Downloading the project from your remote repository')
    {
      steps
      {
        sh '''
            if [ ! -d ${workspace}/projects ]; then
                sudo mkdir -p ${workspace}/projects
                sudo chown -R jenkins:jenkins ${workspace}/projects
            fi
            if [ -d ${workspace}/projects/${APP_NAME} ]; then
                cd ${workspace}/projects/${APP_NAME}
                git pull https://github.com/${GITHUB_ACCOUNT}/${GITHUB_REPOSITORY}.git
            else
                cd ${workspace}/projects
                git clone https://github.com/${GITHUB_ACCOUNT}/${GITHUB_REPOSITORY}.git ${APP_NAME}
            fi
          '''
      }
    }
    stage('Building the images')
    {
      steps
      {
        sh '''
            cd ${workspace}/projects/${APP_NAME}

            sudo docker image rm -f ${WEB_IMAGE} || true
            sudo docker image rm -f ${DB_IMAGE} || true

            sudo docker image build -t ${WEB_IMAGE} -f Dockerfile.${WEB_CONTAINER} .
            sudo docker image build -t ${DB_IMAGE} -f Dockerfile.${DB_CONTAINER} .
           '''
      }
    }
    stage('Creating a common network')
    {
      steps
      {
        sh 'sudo docker network ls | grep ${APP_NETWORK} || sudo docker network create ${APP_NETWORK}'
      }
    }
    stage('Running the containers')
    {
      steps
      {
        sh '''
        sudo docker container rm -f ${WEB_CONTAINER} || true
        sudo docker container rm -f ${DB_CONTAINER} || true

        sudo docker container run -d --name ${WEB_CONTAINER} --net ${APP_NETWORK} -p ${EXPOSE_TO_PORT}:80 -v ${workspace}/projects/${APP_NAME}/web:/var/www/html:ro ${WEB_IMAGE}
        sudo docker container run -d --name ${DB_CONTAINER} --net ${APP_NETWORK} -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} ${DB_IMAGE}
        '''
      }
    }
  }
}
