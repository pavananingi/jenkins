pipeline {
    agent any
    options {
        skipDefaultCheckout(true)
    }
    stages {
        stage('Validate Branch') {
            when {
                branch 'main'
            }
            steps {
                checkout scm
                echo "Building only the main branch"
            }
        }

        stage('Build') {
            when {
                branch 'main'
            }
            steps {
                echo "This is the main branch - Building..."
                // your build steps here
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo "Deploying from main branch"
                // your deploy steps here
            }
        }
    }
}
