pipeline {
    agent any

    environment {
        IMAGE_NAME = 'kreaviq_web'
        CONTAINER_NAME = 'kreaviq_web'
        PORT = '8081'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📦 Mengambil source code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '⚙️  Membuat image Docker...'
                script {
                    bat "docker build -t %IMAGE_NAME%:latest ."
                }
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                echo '🧹 Menghapus container lama (jika ada)...'
                script {
                    bat """
                    docker ps -q -f name=%CONTAINER_NAME% > tmp.txt
                    for /f %%i in (tmp.txt) do docker stop %%i
                    for /f %%i in (tmp.txt) do docker rm %%i
                    del tmp.txt
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Menjalankan container baru...'
                script {
                    bat "docker run -d --name %CONTAINER_NAME% -p %PORT%:80 %IMAGE_NAME%:latest"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment berhasil! Akses di: http://localhost:%PORT%"
        }
        failure {
            echo "❌ Build gagal. Cek log error di atas."
        }
    }
}
