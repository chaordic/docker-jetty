docker-jetty
============

Base image derived from phusion and extended with java and jetty. This image uses phusion's supervisor **runit** to run jetty

Example
==================

```
FROM chaordic/docker-jetty

MAINTAINER Chaordic Mail Team "scorsese-devs@chaordic.com.br"

ADD myapp.war /opt/jetty/webapps/clint/

EXPOSE 8080
```

You may want to expose a different port or just map to the port you want when running the container with the -p parameter:

```
docker run -p 80:8080 my_image
```

**Note**: By default phusion has SSH installed so you can log on to your container. If you don't need just add this to your Dockerfile:

```
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
```
