![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://www.linuxserver.io/) team brings you another quality container release featuring auto-update of dependencies on startup, easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io/index.php) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/openvpn-as

<Provide a short, concise description of the application. No more than two SHORT paragraphs. Link to sources where possible and include an image illustrating your point if necessary. Point users to the original applications website, as that's the best place to get support - not here.>

## Usage

```
docker create --name=openvpnas -v <path to data>:/config -e PGID=<gid> -e PUID=<uid> -e TZ=<timezone> -e INTERFACE=<interface> --net=host --privileged linuxserver/openvpn-as
```

**Parameters**



* `-v /config` - where openvpn-as should store configuration files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for Timezone setting
* `-e INTERFACE` setting interface for openvpn-as *default is eth0*

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it openvpnas /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

<Insert a basic user guide here to get a n00b up and running with the software inside the container.> DELETE ME


## Updates

* Upgrade dependencies to the latest version simply `docker restart openvpnas`.
* To monitor the logs of the container in realtime `docker logs -f openvpnas`.



## Versions

+ **18.09.2015:** Initial Release. 
