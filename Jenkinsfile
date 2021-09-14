pipeline {
    environment{
        imageName = "rupali04/helloworld"
        github_cred = "Git"
        dockerhub_credential = "dockerhub"
        portNo = 30115
    }
    agent any 
    stages {
        stage('SCM Checkout') { 
            steps {
                git url:'https://github.com/rups04/Jenkins_Pipeline.git', branch:'main' , credentialsId: github_cred
            }
        }
        stage('Build Image') { 
            steps {
                echo "build.."
                script {
                    dockerImage = docker.build imageName
               }
            }
        }
        stage('Push Image') { 
            steps {
                script {
                     echo "Push Image.." 
                    docker.withRegistry('https://registry.hub.docker.com', dockerhub_credential ) {            
                        dockerImage.push("${env.BUILD_NUMBER}")            
                        dockerImage.push("latest")        
                    }
                }
            }
        }
        stage('Test') { 
            steps {
                script {
                    echo "Testing.."
                    sh 'bash test.sh'
                }
                
            }
        }
        stage('Deploy') { 
            steps {
                sh '''
                    sed -i "s/nodePort: 30105/nodePort: ${portNo}/g" deployment.yml 
                    sed -i "s|image: rupali04/webserver:latest|image: \\"$imageName\\"|g" deployment.yml
                    cat deployment.yml
                    if sudo kubectl get service | grep -w myweb  || sudo kubectl get deployment | grep -w myweb
                    then
                        sudo kubectl delete service/myweb
                        sudo kubectl delete deployment/myweb
                    fi 
                    sudo kubectl create -f deployment.yml 
                    
                '''
                echo "Deployed.."
            }
        }
    }
}
