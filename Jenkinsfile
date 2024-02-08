pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        registryCredenial = 'Docker_hub_cred'
    }

    stages {
        stage('Checkout'){
            steps {
                git credentialsId: 'githubcred', 
                url: 'https://github.com/avinashbasoor12/volvocars-assiment.git'

            }
        }
        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Build Docker Image'
                    docker build -t avinashbasoorbs/welcome-app:${BUILD_NUMBER} .
                    '''
                }
            }
        }
        stage('Push the artifacts'){
            steps{
                script{
                    echo 'push to repo'
                    withDockerRegistry(credentialsId: registryCredenial){
                        sh "docker push avinashbasoorbs/welcome-app:${BUILD_NUMBER}"
                    }
                    
                }
            }
        }
        stage('Deploying App to Kubernetes'){
            steps{
                script{
                   kubernetesDeploy(configs: "deploymentservice.yml", kubeconfigId: "kubernetes")
                }
            }
        }
    }
}