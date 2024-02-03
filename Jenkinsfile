pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
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
                    sh '''
                    echo 'push to repo'
                    docker push avinashbasoorbs/welcome-app:${BUILD_NUMBER}
                    '''
                }
            }
        }
    }
}