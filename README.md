Minimal active LTS Versions of Node.js Docker Images
-----------------------------------------------------

versions
- ENV VERSION v14.15.0 NPM_VERSION 6.14.8 YARN_VERSION v1.22.10
- ENV VERSION v14.15.1 NPM_VERSION 6.14.8 YARN_VERSION v1.22.10
- ENV VERSION v14.17.2 NPM_VERSION 6.14.9 YARN_VERSION v1.22.10
- ENV VERSION v14.15.3 NPM_VERSION 6.14.9 YARN_VERSION v1.22.10
- ENV VERSION v14.15.4 NPM_VERSION 6.14.10 YARN_VERSION v1.22.10
- ENV VERSION v14.16.5 NPM_VERSION 6.14.11 YARN_VERSION v1.22.10
- ENV VERSION v14.16.0 NPM_VERSION 6.14.11 YARN_VERSION v1.22.10
- ENV VERSION v14.17.1 NPM_VERSION 6.14.12 YARN_VERSION v1.22.10
- ENV VERSION v14.17.0 NPM_VERSION 6.14.13 YARN_VERSION v1.22.10
- ENV VERSION v14.17.1 NPM_VERSION 6.14.13 YARN_VERSION v1.22.10
- ENV VERSION v14.17.2 NPM_VERSION 6.14.13 YARN_VERSION v1.22.10
- ENV VERSION v14.17.3 NPM_VERSION 6.14.13 YARN_VERSION v1.22.10
- ENV VERSION v14.17.4 NPM_VERSION 6.14.14 YARN_VERSION v1.22.10
- ENV VERSION v14.17.5 NPM_VERSION 6.14.14 YARN_VERSION v1.22.10

built on [Alpine Linux](https://alpinelinux.org/)

1. to create a base image of a specific LTS version please edit the Env variables in the dockerfile and insert the node version you would like to create an image of.
e.g in root/Dockerfile:

```
ENV VERSION v14.15.0 #where you specify the version you want to create
ENV NPM_VERSION 6.14.8
ENV YARN_VERSION v1.22.10
```

Each version goes with the following tag format 
(ie, `sda/alpine-node:<tag>`).

2. RUN `chmod u+x run-docker.sh` to give our entry file execute permission

3. RUN ./run-docker.sh to install the specified version you have created.

Examples TO RUN A CONTAINER ON THE NEWLY CREATED IMAGE
-------------------------------------------------------

```console
$ docker run --rm sda/alpine-node:14.17.3 node --version
v14.17.3

$ docker run --rm sda/alpine-node:14.15.0 node --version
```

Example Dockerfile for your own Node.js project
-----------------------------------------------

```Dockerfile
FROM sda/alpine-node:14.15.1

# we add a user to a group because we dont want containers to run as root
RUN addgroup -S node && adduser -S node -G node

RUN npm --version

RUN node --version

RUN yarn --version

# create base app folder
RUN mkdir /code

WORKDIR /code

# make sure to use least priviledged users and not root
COPY --chown=node:node package.json package-lock.json ./

RUN npm install

COPY --chown=node:node . .

EXPOSE 3001

USER node

CMD ["node", "index.js"]
```