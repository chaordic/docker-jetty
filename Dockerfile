FROM phusion/baseimage
MAINTAINER Chaordic Mail Team "scorsese-devs@chaordic.com.br"

RUN echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    \
    echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java7-installer oracle-java7-set-default  && \
    \
    echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk7-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

ADD http://eclipse.org/downloads/download.php?file=/jetty/9.0.7.v20131107/dist/jetty-distribution-9.0.7.v20131107.tar.gz /opt/jetty.tar.gz

RUN tar -xvf /opt/jetty.tar.gz -C /opt/ && \
    rm /opt/jetty.tar.gz && \
    mv /opt/jetty-distribution-9.0.7.v20131107 /opt/jetty && \
    rm -rf /opt/jetty/webapps.demo /opt/jetty/start.d/*-demo.ini && \
    useradd jetty -U -s /bin/false && \
    chown -R jetty:jetty /opt/jetty

ADD start-jetty.sh /etc/service/jetty/run

EXPOSE 8080

