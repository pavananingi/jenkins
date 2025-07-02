pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    environment {
        COMPOSE_CMD = 'docker compose' // use 'docker-compose' if using older binary
    }

    stages {
        stage('Checkout') {
            when { branch 'main' }
            steps {
                echo "🔄 Checking out main branch"
                checkout scm
            }
        }

        stage('Install Dependencies') {
            when { branch 'main' }
            steps {
                echo "📦 Installing npm dependencies"
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            when { branch 'main' }
            steps {
                echo "🐳 Building Docker image via Compose"
                sh "${env.COMPOSE_CMD} build"
            }
        }

        stage('Deploy Application') {
            when { branch 'main' }
            steps {
                echo "🚀 Deploying with Docker Compose"
                sh '''
                    ${COMPOSE_CMD} down
                    ${COMPOSE_CMD} up -d --build
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment to production successful"
        }
        failure {
            echo "❌ Build or deploy failed"
        }
    }
}
