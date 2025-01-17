FROM lolhens/baseimage-openjre
LABEL Jagadeesh
ADD target/springbootApp.jar springbootApp.jar
ENTRYPOINT ["java", "-jar", "springbootApp.jar"]
