pipeline{

    agent any

    // uncomment the following lines by removing /* and */ to enable
    tools{
	maven 'Maven 3.6.3' 
    }    

    stages{
        stage('build'){
            steps{
                echo 'this is the build job'
                sh 'mvn compile'
                sleep 4
            }
        }
        stage('test'){
            steps{
                echo 'this is the test job'
                sh 'mvn clean test'
                sleep 9
            }
        }
        stage('package'){
            steps{
                echo 'this is the package job'
                sh 'mvn package -DskipTests'
                sleep 7
            }
        }
    }
    
    post{
        always{
            echo 'this pipeline has completed...'
        }
        
    }
    
}

