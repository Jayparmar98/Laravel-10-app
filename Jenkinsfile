pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'Dockerhub-jenkins' // Jenkins credentials ID
        DOCKERHUB_REPO = 'jayparmar98/laravel-10-curd'
        IMAGE_TAG = 'latest' // You can replace this with a Git SHA or build number if needed
        FULL_IMAGE = "${DOCKERHUB_REPO}:${IMAGE_TAG}"
        //IMAGE = "laravel-10-App"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'github', url: 'https://github.com/Jayparmar98/Laravel-10-Curd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${FULL_IMAGE}"
                    bat "docker build -t ${FULL_IMAGE} ."
                }
            }
        }

          stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Logging into Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                    }

                    echo "Pushing image to Docker Hub..."
                    bat "docker push ${FULL_IMAGE}"
                }
            }
        }

          stage('Deploy with Docker Compose') {
             steps {
                 script {
                     echo "Pulling updated Docker image..."
                     bat "docker pull ${FULL_IMAGE}"

                     echo "Stopping any existing containers..."
                     bat "docker-compose down"

                     echo "Starting containers with updated image..."
                     bat "docker-compose up -d"
                 }
             }
         }

    //     stage('Deploy to Kubernetes') {
    //         steps {
    //             bat 'kubectl apply -f k8s\\deployment.yaml'
    //             bat 'kubectl apply -f k8s\\service.yaml'
    //             bat 'kubectl apply -f k8s\\configmap.yaml'
    //         }
    //     }
    // }

    // post {
    //     success {
    //         echo '✅ Deployment succeeded!'
    //     }
    //     failure {
    //         echo '❌ Deployment failed.'
    //     }
    }
}