pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'Dockerhub-jenkins' // Jenkins credentials ID
        IMAGE_TAG = 'latest' // Use 'latest', build number, or Git SHA
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'github', url: 'https://github.com/Jayparmar98/Laravel-10-app.git'
            }
        }

        stage('Build and Push Images') {
            matrix {
                axes {
                    axis {
                        name 'IMAGE_NAME'
                        values 'app1', 'app2', 'mysql', 'redis'
                    }
                }
                stages {
                    stage('Build Docker Image') {
                        steps {
                            script {
                                def fullImage = "jayparmar98/${IMAGE_NAME}:${IMAGE_TAG}"
                                echo "Building Docker image: ${fullImage}"
                                bat "docker build -t ${fullImage} ./docker/${IMAGE_NAME}"
                            }
                        }
                    }

                    stage('Push Docker Image') {
                        steps {
                            script {
                                def fullImage = "jayparmar98/${IMAGE_NAME}:${IMAGE_TAG}"
                                echo "Pushing image: ${fullImage}"
                                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                                    bat "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                                    bat "docker push ${fullImage}"
                                }
                            }
                        }
                    }
                }
            }
        }

    //     stage('Deploy to Kubernetes') {
    //         steps {
    //             script {
    //                 echo "Applying Kubernetes configurations..."
    //                 bat 'kubectl apply -f k8s/app1-deployment.yaml'
    //                 bat 'kubectl apply -f k8s/app2-deployment.yaml'
    //                 bat 'kubectl apply -f k8s/mysql-deployment.yaml'
    //                 bat 'kubectl apply -f k8s/laravel-10-curd-deployment.yaml'

    //                 // Optionally apply services/configmaps
    //                 bat 'kubectl apply -f k8s/services.yaml'
    //                 bat 'kubectl apply -f k8s/configmaps.yaml'
    //             }
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
