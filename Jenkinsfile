pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
        NPM_CONFIG_CACHE = 'C:\\tmp\\.npm'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 60, unit: 'MINUTES')
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo "📦 Checking out source code..."
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "📥 Installing npm dependencies..."
                bat '''
                npm ci --cache %NPM_CONFIG_CACHE% --no-optional --registry=https://registry.npmjs.org/
                '''
            }
        }

        stage('Run Tests') {
            steps {
                echo "🧪 Running tests..."
                bat 'npm test -- --passWithNoTests'
            }
        }

        stage('Build Application') {
            steps {
                echo "🏗️ Building application..."
                bat 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image..."
                bat 'docker build -t my-web-app:latest .'
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo "🚀 Deploying application..."
                bat '''
                docker-compose down
                docker-compose up -d --build
                '''
            }
        }

        stage('Health Check') {
            steps {
                echo "💓 Performing health check..."
                bat 'curl -s -o NUL http://localhost:3000 || exit 1'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed! Check logs for details."
        }
        always {
            echo "🧹 Cleaning up workspace..."
            deleteDir() // menggantikan cleanWs()
        }
    }
}
