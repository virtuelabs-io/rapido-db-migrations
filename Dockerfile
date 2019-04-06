FROM node:8-alpine

LABEL maintainer="Sangram Reddy <reddy.horcrux@gmail.com>"
LABEL application="rapido-db-migrations"

ENV HOST 3306

ADD ./package.json /home/app/
ADD ./node_modules /home/app/node_modules
ADD ./src /home/app/src

WORKDIR /home/app/

ENTRYPOINT [ "node", "./src/fargate/migrate.js" ]
