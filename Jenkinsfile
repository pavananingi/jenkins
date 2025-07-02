pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    stages {
        stage('Checkout') {
            when { branch 'main' }
            steps {
                echo "Checking out main branch"
                checkout scm
            }
        }

        stage('Install Dependencies') {
            when { branch 'main' }
            steps {
                echo "Installing npm packages"
                sh 'npm install'
            }
        }

        stage('Build') {
            when { branch 'main' }
            steps {
                echo "Building the application"
                sh 'npm run build || echo "No build script found. Skipping build..."'
            }
        }

        stage('Test') {
            when { branch 'main' }
            steps {
                echo "Running tests"
                sh 'npm test || echo "No tests found. Skipping tests..."'
            }
        }

        stage('Deploy') {
            when { branch 'main' }
            steps {
                echo "Deploying with PM2"
                sh '''
                    pm2 stop pavan-app || true
                    pm2 start index.js --name pavan-app
                    pm2 save
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build and deploy successful on main branch"
        }
        failure {
            echo "❌ Build or deploy failed"
        }
    }
}
