pipeline {
    agent any
    
    tools {
        maven "Maven3"
    }
    
    environment{
         DOCKER_CREDENTIALS = credentials('docker-credentials')
         DOCKER_REGISTRY = 'docker.io'
    }

    stages {
        stage('code') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/Jagadeesh-Tummapudi/springboot-application.git']])
            }
        }
        stage ('Build'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage ('image'){
            steps{
                sh 'docker build -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$Tagname /var/lib/jenkins/workspace/project-k'
            }
        }
        stage ('login & push'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId:'docker-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin $DOCKER_REGISTRY"
                        sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$Tagname"
                    }
                }
            }
        }
        stage ('deploy'){
            steps{
                withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s-credentials', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                    sh "kubectl apply -f eks-deploy-k8s.yaml"
                }
            }
        }
    }
}
