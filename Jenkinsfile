pipeline {
    agent {
        node {
            label  "maven"
        }
    }

    stages {
        stage('Build') {
            steps {
                sh '/opt/apache-maven-3.9.4/bin/mvn clean deploy'
            }
        }
    }
}

