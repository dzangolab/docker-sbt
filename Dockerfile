FROM ubuntu:18.04
MAINTAINER dzangolab <info@dzangolab.com>

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
      apt-get -y install --fix-missing \
        openjdk-8-jre-headless \
        openjdk-8-jdk

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
      apt-get -y install --fix-missing \
        apt-transport-https \
        curl \
        gnupg

ENV SBT_VERSION 0.13.15

RUN curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb \
    && dpkg -i sbt-$SBT_VERSION.deb \
    && rm sbt-$SBT_VERSION.deb \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
      apt-get install  -y --fix-missing sbt \
    && sbt sbtVersion \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/
