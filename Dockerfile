FROM gocd/gocd-agent-debian-12:v25.3.0
LABEL MAINTAINER="Rasmus Munk <rasmus.munk@nbi.ku.dk>"

USER root

RUN apt-get update \
    && apt install -y \
    apt-transport-https \
    wget \
    python3-dev \
    make \
    && apt-get update

RUN apt-get update \
  && apt-get install -y \
  build-essential \
  g++ \
  gcc
