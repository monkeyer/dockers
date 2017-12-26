FROM openjdk:8-jre-alpine

COPY ./build/libs/blog-application-11001.jar /root/blog-application-11001.jar

WORKDIR /root

CMD ["java", "-server", "-Xms4g", "-Xmx4g", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "blog-application-11001.jar"]
