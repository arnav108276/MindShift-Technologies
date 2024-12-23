pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/arnav108276/Mindshift-Technologies.git'
        BRANCH = 'main' 
        IMAGE_NAME = 'arnavgoel/netflix-frontend'
    }
    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning Git Repository...'
                git branch: "${BRANCH}", url: "${REPO_URL}"
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                script {
                    sh """
                    docker build -t ${IMAGE_NAME} .
                    """
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                echo 'Running Docker Container...'
                script {
                    sh """
                    docker run -d -p 8080:80 --name my-container ${IMAGE_NAME}
                    """
                }
            }
        }
        stage('Verify Deployment') {
            steps {
                echo 'Verifying Deployment...'
                script {
                    sh """
                    curl -s http://localhost:8080 || exit 1
                    """
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for more details.'
        }
    }
}
