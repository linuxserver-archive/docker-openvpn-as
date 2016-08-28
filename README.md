![https://linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](https://forum.linuxserver.io)
* [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`
* [Podcast](https://www.linuxserver.io/index.php/category/podcast/) covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/openvpn-as
[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/openvpn-as.svg)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/linuxserver/openvpn-as.svg)][hub]
[![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-openvpn-as)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-openvpn-as/)
[hub]: https://hub.docker.com/r/linuxserver/openvpn-as/

OpenVPN Access Server is a full featured secure network tunneling VPN software solution that integrates OpenVPN server capabilities, enterprise management capabilities, simplified OpenVPN Connect UI, and OpenVPN Client software packages that accommodate Windows, MAC, Linux, Android, and iOS environments. OpenVPN Access Server supports a wide range of configurations, including secure and granular remote access to internal network and/ or private cloud network resources and applications with fine-grained access control. [Openvpn-as](https://openvpn.net/index.php/access-server/overview.html)

[![openvpn-as](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/openvpn-as-banner.png)][openvpnurl]
[openvpnurl]: https://openvpn.net/index.php/access-server/overview.html
## Usage

```
docker create \
--name=openvpn-as \
-v <path to data>:/config \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-e INTERFACE=<interface> \
--net=host --privileged \
linuxserver/openvpn-as
```

**Parameters**


* `-v /config` - where openvpn-as should store configuration files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for Timezone setting
* `-e INTERFACE` setting interface for openvpn-as *default is eth0*
* `--net=host` IMPORTANT, will not operate unless in host mode.
* `--privileged` IMPORTANT, will not operate unless in privileged mode.

It is based on ubuntu xenial with S6 overlay, for shell access whilst the container is running do `docker exec -it openvpn-as /bin/bash`.


### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


## Setting up the application 

The admin interface is available at `https://<ip>:943/admin` with a default user/password of admin/password.
To change the password (recommended) do
`docker exec -it openvpn-as passwd admin`  (You will have to repeat this step if you update or reinstall this container)

For user accounts to be persistent, switch the "Authentication" in the webui from "PAM" to "Local" and then set up the user accounts with their passwords.

## Info

* To monitor the logs of the container in realtime `docker logs -f openvpn-as`.



## Versions

+ **28.08.16:** Add badges to README.
+ **01.08.16:** Rebase to xenial.
+ **18.09.15:** Initial Release. 

