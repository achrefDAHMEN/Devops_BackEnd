pipeline {
    agent any

    stages {

        stage('git') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Checkout Backend code') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/achrefDAHMEN/Devops_BackEnd']]])
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
                junit 'target/surefire-reports/*.xml'
            }
        }
	    stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        
    }
}
