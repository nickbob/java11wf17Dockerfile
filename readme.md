# Dockerfile example

The following example describes create of docker image.
After building you will have Ubuntu Linux operating system Ubuntu 18.04.2 LTS, HotSpot java 11.0.2, AS wildfly 17.0.0.Final.
Additionally comprises -Xlog configuration of JVM as example.


## Getting Started

These instructions will get you build image and run it.

BUILD IT
```
cd <directory_project>
docker build -t java11wf17 .
```

RUN IT
```
docker run -d -it --rm -p 8080:8080 -p 9990:9990 java11wf17
```

CONNECT TO CONTAINER
```
docker exec -it $(docker ps -q) bash
```
