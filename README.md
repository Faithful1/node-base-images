Minimal active Node.js LTS Versions Docker Images
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

1. to create a base image of a specific LTS node version please edit the Env variables in the dockerfile and insert the node version you would like to create an image of.
e.g in /root/Dockerfile:

```
ENV VERSION v14.15.0 #where you specify the version you want to create
ENV NPM_VERSION 6.14.8
ENV YARN_VERSION v1.22.10
```

Each version goes with the following tag format 
(ie, `sda/alpine-node:<tag>`).

2. RUN `chmod u+x run-build.sh` to give our entry file execute permission

3. edit `/root/run-build.sh` file to tag the image you are about to create

Examples TO TAG THE IMAGE BY EDITING THE run-build.sh FILE
-----------------------------------------------------------
```run-build.sh
    for tag in 14.15 14.15.0 latest ; do
        docker build --pull -t sda/alpine-node:$tag .
    done

    #here you specified the tags you want in semver format
```

4. RUN `./run-build.sh` to create the image you have specified in the run-build.sh file.




Examples TO RUN A CONTAINER ON THE NEWLY CREATED IMAGE
-------------------------------------------------------

```console
$ docker run --rm sda/alpine-node:14.15.0 node --version
v14.15.0

$ docker run --rm sda/alpine-node:14.15.1 node --version
v14.15.1
```


Example Dockerfile for your own Node.js application to test the newly created image
-----------------------------------------------------------------------------------

You can use the example app found in root/exampleApp folder to run a quick nodejs app on that image just to test our newly created base image

```exampleApp/app-Dockerfile
FROM sda/alpine-node:14.15.0

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