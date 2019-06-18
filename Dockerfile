FROM debian:9-slim
MAINTAINER dzangolab <info@dzangolab.com>

RUN apt-get update \
    && apt-get install -y \
      apt-transport-https \
      curl \
      gnupg \
      openjdk-8-jdk

ENV SBT_VERSION 0.13.15

RUN curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb \
    && dpkg -i sbt-$SBT_VERSION.deb \
    && rm sbt-$SBT_VERSION.deb \
    && apt-get update \
    && apt-get install sbt \
    && sbt sbtVersion \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/
