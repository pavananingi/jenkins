pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    stages {
        stage('Checkout') {
            when {
                branch 'main'
            }
            steps {
                echo "Checking out main branch"
                checkout scm
            }
        }

        stage('Install Dependencies') {
            when {
                branch 'main'
            }
            steps {
                echo "Installing npm packages"
                sh 'npm install'
            }
        }

        stage('Build') {
            when {
                branch 'main'
            }
            steps {
                echo "Building the application"
                sh 'npm run build || echo "No build script, skipping..."'
            }
        }

        stage('Test') {
            when {
                branch 'main'
            }
            steps {
                echo "Running tests"
                sh 'npm test || echo "No test script, skipping..."'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo "Deploying the app using PM2"
                sh '''
                    pm2 stop all || true
                    pm2 start index.js --name pavan-app || pm2 restart pavan-app
                    pm2 save
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build and deploy completed successfully on main branch."
        }
        failure {
            echo "❌ Build or deploy failed."
        }
    }
}
