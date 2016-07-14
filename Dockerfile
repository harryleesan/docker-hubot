FROM node:6.3
MAINTAINER Harry Lee
LABEL version="0.0.1"

RUN apt-get update && apt-get install -y \
    expect \
    openssh-client \
&& apt-get clean && rm -rf /var/lib/opt/lists

RUN useradd --create-home --shell /bin/bash node

COPY ./my-hubot/ /home/node/my-hubot/
WORKDIR /home/node/my-hubot/

RUN mkdir node_modules && \
    chown -R node:node node_modules

USER node
ENV HOME /home/node

RUN npm install

CMD bin/hubot
