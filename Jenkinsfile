pipeline {
    agent any
    environment {
        IMAGE = "abdvswmdr/soqonicart"
        TAG   = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
    }
    stages {
        stage('build') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('test') {
            steps {
                sh 'mvn clean test'
            }
        }

        stage('package') {
            steps {
                sh 'mvn package -DskipTests'
                archiveArtifacts '**/target/*.jar'
            }
        }

        stage('docker') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh """
                        docker build -t ${IMAGE}:${TAG} .
                        echo "\$DOCKERHUB_PASS" | docker login -u "\$DOCKERHUB_USER" --password-stdin
                        docker push ${IMAGE}:${TAG}
                    """
                    script {
                        if (env.BRANCH_NAME == 'main') {
                            sh """
                                docker tag ${IMAGE}:${TAG} ${IMAGE}:latest
                                docker push ${IMAGE}:latest
                            """
                        }
                    }
                }
            }
        }
    }
    tools {
        maven 'Maven 3.6.3'
    }
    post {
        always {
            echo "Pipeline complete — image: ${IMAGE}:${TAG}"
        }
    }
}
