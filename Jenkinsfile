pipeline {
    agent any
    stages {
	stage('build') {
	    steps {
		echo 'this is the build job'
		sh 'mvn compile'
		sleep 4
	    }
	}

	stage('test') {
	    steps {
		echo 'this is the test job'
		sh 'mvn clean test'
		sleep 9
	    }
	}

	stage('package') {
	    steps {
		echo 'this is the package job'
		sh 'mvn package -DskipTests'
		sleep 7
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
		    sh '''
                    docker build -t abdvswmdr/soqonicart:latest .
                    echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin
                    docker push abdvswmdr/soqonicart:latest
                    '''
		}
	    }
	}

    }
    tools {
	maven 'Maven 3.6.3'
    }
    post {
	always {
	    echo 'this pipeline has completed...'
	}

    }
}
