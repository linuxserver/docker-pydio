[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/pydio](https://github.com/linuxserver/docker-pydio)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/pydio.svg)](https://microbadger.com/images/linuxserver/pydio "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/pydio.svg)](https://microbadger.com/images/linuxserver/pydio "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/pydio.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/pydio.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-pydio/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-pydio/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/pydio/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/pydio/latest/index.html)

[Pydio](https://pydio.com/) (formerly AjaXplorer) is a mature open source software solution for file sharing and synchronization. With intuitive user interfaces (web / mobile / desktop), Pydio provides enterprise-grade features to gain back control and privacy of your data: user directory connectors, legacy filesystems drivers, comprehensive admin interface, and much more.

[![pydio](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/pydio-banner.png)](https://pydio.com/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/pydio` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=pydio \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 443:443 \
  -v <path to data>:/config \
  -v <path to data>:/data \
  --restart unless-stopped \
  linuxserver/pydio
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  pydio:
    image: linuxserver/pydio
    container_name: pydio
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
      - <path to data>:/data
    ports:
      - 443:443
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 443` | WebUI |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /config` | Where pydio should store it's configuration files. |
| `-v /data` | Where pydio should store uploaded files. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

You must create a user and database for pydio to use in a mysql/mariadb or postgresql server. You can use sqlite with no further config needed, but this should only be considered for testing purposes.
In the setup page for database, use the ip address rather than hostname...

Self-signed keys are generated the first time you run the container and can be found in /config/keys , if needed, you can replace them with your own.

For public link sharing to function correctly be sure to change the Detected Server Url to the URL of your pydio instance in the setup wizard.

For email settings edit the file /config/ssmtp.conf and restart the container.



## Support Info

* Shell access whilst the container is running: `docker exec -it pydio /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f pydio`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' pydio`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/pydio`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/pydio`
* Stop the running container: `docker stop pydio`
* Delete the container: `docker rm pydio`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start pydio`
* You can also remove the old dangling images: `docker image prune`

### Via Taisun auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one shot:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock taisun/updater \
  --oneshot pydio
  ```
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull pydio`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d pydio`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **11.02.19:** - Add pipeline logic and multi arch, rebase to alpine 3.8.
* **12.01.18:** - Rebase to alpine linux 3.7.
* **28.10.17:** - php7-ssh2 moved from testing to community repo.
* **25.05.17:** - Rebase to alpine linux 3.6.
* **17.05.17:** - Make default install pydio 8.
* **03.05.17:** - Use repo pinning to better solve dependencies, use repo version of php7-imagick.
* **28.02.17:** - Modify sed for data path.
* **18.02.17:** - Rebase to alpine linux 3.5.
* **05.11.16:** - Pinned at latest sourceforge download version, in lieu of a full rewrite.
* **14.10.16:** - Add version layer information.
* **10.09.16:** - Add layer badges to README.
* **08.09.15:** - Initial Release.
