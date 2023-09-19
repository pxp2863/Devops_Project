FROM openjdk:11-jre-slim
COPY /home/ubuntu/jenkins/workspace/MultiBranch_Project_main/target/demo-workshop-2.1.2.jar /usr/local/lib/demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]