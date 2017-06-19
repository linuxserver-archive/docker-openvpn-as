[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://openvpn.net/index.php/access-server/overview.html
[hub]: https://hub.docker.com/r/linuxserver/openvpn-as/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/openvpn-as
[![](https://images.microbadger.com/badges/version/linuxserver/openvpn-as.svg)](https://microbadger.com/images/linuxserver/openvpn-as "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/openvpn-as.svg)](http://microbadger.com/images/linuxserver/openvpn-as "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/openvpn-as.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/openvpn-as.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-openvpn-as)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-openvpn-as/)

OpenVPN Access Server is a full featured secure network tunneling VPN software solution that integrates OpenVPN server capabilities, enterprise management capabilities, simplified OpenVPN Connect UI, and OpenVPN Client software packages that accommodate Windows, MAC, Linux, Android, and iOS environments. OpenVPN Access Server supports a wide range of configurations, including secure and granular remote access to internal network and/ or private cloud network resources and applications with fine-grained access control. [Openvpn-as](https://openvpn.net/index.php/access-server/overview.html)

[![openvpn-as](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/openvpn-as-banner.png)][appurl]

## Usage

```
docker create \
--name=openvpn-as \
-v <path to data>:/config \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-e INTERFACE=<interface> \
-e PASSWD=<adminpassword> \
--net=host --privileged \
linuxserver/openvpn-as
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-v /config` - where openvpn-as should store configuration files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for Timezone setting
* `-e INTERFACE` setting interface for openvpn-as *default is eth0*
* `-e PASSWD` optional variable to change the admin password
* `--net=host` IMPORTANT, for most users, needs to operate in host mode.
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

The admin interface is available at `https://<ip>:943/admin` with a default user/password of admin/password.  (unless changed with the PASSWD variable)

For user accounts to be persistent, switch the "Authentication" in the webui from "PAM" to "Local" and then set up the user accounts with their passwords through the gui.

## Info

* To monitor the logs of the container in realtime `docker logs -f openvpn-as`.


* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' openvpn-as`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/openvpn-as`

## Versions

+ **19.06.17:** Add ability to change admin password through optional variable
+ **31.10.16:** Pick up version 2.14b.
+ **14.10.16:** Add version layer information.
+ **13.09.16:** Rebuild due to push error to hub on last build.
+ **10.09.16:** Add layer badges to README.
+ **28.08.16:** Add badges to README.
+ **01.08.16:** Rebase to xenial.
+ **18.09.15:** Initial Release. 

