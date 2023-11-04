pipeline {
    agent any

    stages {

        stage('git') {
            steps {
                script{
                     checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/achrefDAHMEN/Devops_BackEnd']]])
                }
            }
        }
    
        
	    stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
                junit 'target/surefire-reports/*.xml'
            }
        }


        stage("Create SonarQube Project") {
            steps {
                script {
                    def sonarServerUrl = "http://192.168.159.128:9000" 

                    def projectName = "sonar1" 
                    def projectKey = "sonar1" 
                    sh """
                        curl -X POST "${sonarServerUrl}/api/projects/create?name=${projectName}&project=${projectKey}"
                    """
                

                    }
                }
        }
     
        
        
        
        
        stage("Run SonarQube Analysis") {
         
            steps {
                    script {
                        withSonarQubeEnv('sonarqube') 
                        {

                            def sonarUsername = "admin"
                            def sonarPassword = "admin123"

                            withCredentials([usernamePassword(credentialsId: 'sonar', usernameVariable: 'sonarUsername', passwordVariable: 'sonarPassword')]) {
                                
                                sh """
                                set +x
                            mvn sonar:sonar  -Dsonar.projectKey=sonar1
                                set -x
                                
                                """
                            }
                        
                            echo 'Static Analysis Completed' 
                        
                        }
                    
                    }
            
                }
            }

        
    }
}
