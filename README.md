[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/pydio
[![](https://images.microbadger.com/badges/version/linuxserver/pydio.svg)](https://microbadger.com/images/linuxserver/pydio "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/pydio.svg)](http://microbadger.com/images/linuxserver/pydio "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/pydio.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/pydio.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-pydio)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-pydio/)
[hub]: https://hub.docker.com/r/linuxserver/pydio/

Pydio (formerly AjaXplorer) is a mature open source software solution for file sharing and synchronization. With intuitive user interfaces (web / mobile / desktop), Pydio provides enterprise-grade features to gain back control and privacy of your data: user directory connectors, legacy filesystems drivers, comprehensive admin interface, and much more. [pydio][pydiourl]


[![pydio](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/pydio-banner.png)][pydiourl]
[pydiourl]: https://pydio.com/

## Usage

```
docker create \
--name=pydio \
-v /etc/localtime:/etc/localtime:ro \
-v <path to data>:/config \
-v <path to data>:/data \
-e PGID=<gid> -e PUID=<uid>  \
-e TZ=<timezone> \
-p 443:443 \
linuxserver/pydio
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 443` - the port(s)
* `-v /etc/localtime` for timesync - *optional*, *omit if using TZ variable*
* `-v /config` - where pydio should store it's configuration files
* `-v /data` - where pydio should store uploaded files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it pydio /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

You must create a user and database for pydio to use in a mysql/mariadb or postgresql server. You can use sqlite with no further config needed, but this should only be considered for testing purposes.
In the setup page for database, use the ip address rather than hostname...

Self-signed keys are generated the first time you run the container and can be found in /config/keys , if needed, you can replace them with your own.

For email settings edit the file /config/ssmtp.conf and restart the container.


## Info
* Upgrade to the latest version through the web interface
* To monitor the logs of the container in realtime `docker logs -f pydio`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' pydio`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/pydio`

## Versions

+ **14-10-16:** Add version layer information.
+ **10.09.16:** Add layer badges to README. 
+ **08.09.15:** Initial Release. 
