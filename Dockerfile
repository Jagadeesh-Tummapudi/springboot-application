FROM lolhens/baseimage-openjre
LABEL Jagadeesh
ADD target/NodeJs.jar NodeJs.jar
ENTRYPOINT ["java", "-jar", "NodeJs.jar"]
