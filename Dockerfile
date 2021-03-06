FROM node:6.3
MAINTAINER Harry Lee
LABEL version="0.0.4"

RUN apt-get update && apt-get install -y \
    expect \
    openssh-client \
    rsync \
    curl \
&& apt-get clean && rm -rf /var/lib/opt/lists

RUN useradd --create-home --shell /bin/bash node

COPY ./my-hubot/ /home/node/my-hubot/
WORKDIR /home/node/my-hubot/

RUN mkdir node_modules && \
    chown -R node:node node_modules && \
    chmod -R a+x scripts/bash

USER node
ENV HOME /home/node

RUN npm install

CMD bin/hubot
