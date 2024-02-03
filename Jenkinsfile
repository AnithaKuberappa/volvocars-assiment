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
    }
}