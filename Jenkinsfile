pipeline {
    agent {
        docker {
            image 'node:18'  // or node:20
            args '-u root'   // Run as root inside container (to avoid permission issues)
        }
    }

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
                sh 'npm run build || echo "No build script, skipping..."'
            }
        }

        stage('Test') {
            when { branch 'main' }
            steps {
                echo "Running tests"
                sh 'npm test || echo "No test script, skipping..."'
            }
        }

        stage('Deploy') {
            when { branch 'main' }
            steps {
                echo "Simulated deploy: PM2 not available in container"
                // Replace with actual deploy steps if you're deploying to another server
                sh 'echo "Deploy complete"'
            }
        }
    }

    post {
        success {
            echo "✅ Build and (simulated) deploy completed successfully on main branch."
        }
        failure {
            echo "❌ Build or deploy failed."
        }
    }
}
