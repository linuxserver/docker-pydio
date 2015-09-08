![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://www.linuxserver.io/) team brings you another quality container release featuring update of dependencies on startup, easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io/index.php) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/pydio

Pydio (formerly AjaXplorer) is a mature open source software solution for file sharing and synchronization. With intuitive user interfaces (web / mobile / desktop), Pydio provides enterprise-grade features to gain back control and privacy of your data: user directory connectors, legacy filesystems drivers, comprehensive admin interface, and much more. [pydio](https://pyd.io/)

## Usage

```
docker create --name=pydio -v /etc/localtime:/etc/localtime:ro -v <path to data>:/config -v <path to data>:/data -e PGID=<gid> -e PUID=<uid>  -e TZ=<timezone> -p 443:443 linuxserver/pydio
```

**Parameters**

* `-p 443` - the port(s)
* `-v /etc/localhost` for timesync - *optional*, *omit if using TZ variable*
* `-v /config` - where pydio should store it's configuration files
* `-v /data` - where pydio should store uploaded files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it pydio /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

You must create a user and database for pydio to use in a mysql/mariadb or postgresql server. You can use sqlite with no further config needed, but this should only be considered for testing purposes.
In the setup page for database, use the ip address rather than hostname...

For email settings edit the file /config/ssmtp.conf and restart the container.


## Updates
* Upgrade the dependencies simply by `docker restart pydio`.
* Upgrade to the latest version through the web interface
* To monitor the logs of the container in realtime `docker logs -f pydio`.



## Versions

+ **08.09.2015:** Initial Release. 
