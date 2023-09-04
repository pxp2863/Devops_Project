pipeline {
    agent {
        node {
            label  "maven"
        }
    }

    stages {
        stage('Hello') {
            steps {
                git branch: 'main', url: 'https://github.com/pxp2863/Devops_Project.git'
            }
        }
    }
}

