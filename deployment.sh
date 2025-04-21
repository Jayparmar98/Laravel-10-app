#!/bin/bash

# Deploy to Kubernetes
kubectl apply -f k8s/configmaps/mysql-init-configmap.yaml
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/redis-deployment.yaml
kubectl apply -f k8s/app1-deployment.yaml
#kubectl apply -f k8s/app2-deployment.yaml

exit




//     stage('Deploy to Kubernetes') {
    //         steps {
    //             script {
    //                 echo "🚀 Applying Kubernetes configurations..."
    //                 //withEnv(["KUBECONFIG=C:\\Users\\Piu\\.kube\\config"])
    //                 bat "kubectl apply -f k8s/app1-deployment.yaml --validate=false"
    //                 // bat 'kubectl apply -f k8s//app2-deployment.yaml'
    //                 // bat 'kubectl apply -f k8s//mysql-deployment.yaml'
    //                 // bat 'kubectl apply -f k8s//laravel-10-curd-deployment.yaml'
    //                 // bat 'kubectl apply -f k8s//configmaps//mysql-init-configmap.yaml'
    //             }
    //         }
    //     }
    // }