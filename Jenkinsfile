pipeline {
    agent any

    stages {

        stage('git BackEnd') {
            steps {
                script{
                     checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/achrefDAHMEN/Devops_BackEnd']]])
                }
            }
        }
    
        
	    stage('Build Back') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Test Back JUnit') {
            steps {
                sh 'mvn test'
                junit 'target/surefire-reports/*.xml'
            }
        }
       
        

        stage("Create SonarQube Project") {
            steps {
                script {
                    def sonarServerUrl = "http://192.168.23.128:9000" 

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

                            withCredentials([usernamePassword(credentialsId: 'sonarqube', usernameVariable: 'sonarUsername', passwordVariable: 'sonarPassword')]) {
                                
                                sh """
                                set +x
                            mvn sonar:sonar  -Dsonar.projectKey=sonar1 -Dsonar.login=admin -Dsonar.password=admin123
                                set -x
                                
                                """
                            }
                        
                            echo 'Static Analysis Completed' 
                        
                        }
                    
                    }
            
                }
            }

             /*
        stage("Uploading JAR to Nexus repository") {
            steps {
                    nexusArtifactUploader artifacts: 
                    [
                        [artifactId: 'DevOps_Project', 
                        classifier: '', 
                        file: 'target/DevOps_Project-1.0.jar', 
                        type: 'jar'
                        ]
                    ], 
                    credentialsId: 'nexus3', 
                    groupId: 'tn.esprit', 
                    nexusUrl: '192.168.23.128:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'nexuspipeline', 
                    version: '1.0'
 
                }
        }

        */
    
            stage("Build and Push Backend Docker Image") {
        
                steps {
                    script {
                        
                        echo "Connection to dockerhub"
                     
                        def dockerUsername ="ashzee" 
                        def dockerPassword = "keylOgger1"
                        

                        
                        sh " docker login -u ${dockerUsername} -p ${dockerPassword} " 
                        
                    
                        
                    
                        echo "Building Docker image..."
                        sh "docker build -t backend:latest ." 
                    

                        echo "Renaming the image"
                        sh "docker tag backend:latest ashzee/backend-app"
                        echo "Pushing Docker image to Docker Hub..."
                        sh "docker push ashzee/backend-app:latest"
                    
                        echo "Docker image successfully pushed to Docker Hub."
                    }
                
                }

        
            }
            stage("git FrontEnd"){
                steps{
                    script{
                        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url:"https://github.com/achrefDAHMEN/Devops_FrontEnd"]]])
                    }
                }
         
           
         
            }
            stage('Build Frontend') {
                
                steps {

                        sh 'npm install'  
                        sh 'npm run build' 
                }
            }
     
    
            stage("Build and Push FrontEnd Docker Image") {
                    
                    
                        steps {
                            script {
            
                        echo "Connection to dockerhub"
                     
                        def dockerUsername ="ashzee" 
                        def dockerPassword = "keylOgger1"
                        

                        
                        sh " docker login -u ${dockerUsername} -p ${dockerPassword} " 
                        
                    
                        
                    
                        echo "Building Docker image..."
                        sh "docker build --no-cache -t frontend:latest ." 
                    

                        echo "Renaming the docker image"
                        sh "docker tag frontend:latest ashzee/frontend-app"
                        echo "Pushing Docker image to Docker Hub..."
                        sh "docker push ashzee/frontend-app:latest"
                    
                        echo "Docker image successfully pushed to Docker Hub."
                            }
                        }
                            
                            
                        
                            
            }
    }
}
