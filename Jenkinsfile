pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'Dockerhub-jenkins' // Jenkins credentials ID
        IMAGE_TAG = 'latest' // Use 'latest', build number, or Git SHA
        KUBECONFIG = "C:\\Users\\Piu\\.kube\\config"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Jayparmar98/Laravel-10-app.git'
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
                                def imageMap = [
                                    app1 : "jayparmar98/app1",
                                    app2 : "jayparmar98/app2",
                                    mysql: "jayparmar98/mysql",
                                    redis: "jayparmar98/redis"
                                ]

                                def dockerContextPath = IMAGE_NAME in ['mysql', 'redis'] 
                                    ? "./${IMAGE_NAME}" 
                                    : "./${IMAGE_NAME}"

                                def fullImage = "${imageMap[IMAGE_NAME]}:${IMAGE_TAG}"

                                echo "Building Docker image: ${fullImage}"
                                bat "docker build -t ${fullImage} ${dockerContextPath}"
                            }
                        }
                    }

                    stage('Push Docker Image') {
                        steps {
                            script {
                                def imageMap = [
                                    app1 : "jayparmar98/app1",
                                    app2 : "jayparmar98/app2",
                                    mysql: "jayparmar98/mysql",
                                    redis: "jayparmar98/redis"
                                ]

                                def fullImage = "${imageMap[IMAGE_NAME]}:${IMAGE_TAG}"

                                withCredentials([usernamePassword(credentialsId: env.DOCKERHUB_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                                    echo " Logging in to Docker Hub..."
                                    bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"

                                    echo "Pushing image: ${fullImage}"
                                    bat "docker push ${fullImage}"
                                }
                            }
                        }
                    }
                }
            }
        }

                    stage('Kubernetes Info') {
                         steps {
                        powershell 'kubectl get nodes'
                     }
                }

                    stage('Deploy to Kubernetes') {
                        steps {
                                powershell '''
                                Write-Host "Checking Kubernetes Context..."
                                kubectl config current-context
                                Write-Host "Applying Deployment..."
                                
                                kubectl apply -f k8s\\configmaps\\mysql-init-configmap.yaml
                                kubectl apply -f k8s\\mysql-deployment.yaml --validate=false
                                kubectl apply -f k8s\\redis-deployment.yaml --validate=false
                                kubectl apply -f k8s\\app1-deployment.yaml --validate=false
                                kubectl apply -f k8s\\app2-deployment.yaml --validate=false

                                Write-Host "Deployment completed."
                                '''
                     }
                }
            }
       }

    post {
        success {
            echo '✅ Deployment succeeded!'
        }
        failure {
            echo '❌ Deployment failed.'
        }
}