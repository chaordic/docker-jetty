#!/bin/bash

export JETTY_HOME=/opt/jetty

cd $JETTY_HOME

java -Djetty.home=${JETTY_HOME} -jar /opt/jetty/start.jar

