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
[![](https://images.microbadger.com/badges/version/linuxserver/openvpn-as.svg)](https://microbadger.com/images/linuxserver/openvpn-as "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/openvpn-as.svg)](https://microbadger.com/images/linuxserver/openvpn-as "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/openvpn-as.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/openvpn-as.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-openvpn-as)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-openvpn-as/)

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

The admin interface is available at `https://<ip>:943/admin` with a default user/password of admin/password

During first login, make sure that the "Authentication" in the webui is set to "Local" instead of "PAM". Then set up the user accounts with their passwords (user accounts created under PAM do not survive container update or recreation).

The "admin" account is a system (PAM) account and after container update or recreation, its password reverts back to the default. It is highly recommended to block this user's access for security reasons:
1) Set another user as an admin,
2) Delete the "admin" user in the gui,
3) Modify the `as.conf` file under config/etc and replace the line `boot_pam_users.0=admin` with `#boot_pam_users.0=admin` (this only has to be done once and will survive container recreation)

## Info

* To monitor the logs of the container in realtime `docker logs -f openvpn-as`.


* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' openvpn-as`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/openvpn-as`

## Versions

+ **19.12.18:** Bump to version 2.6.1.
+ **10.07.18:** Bump to version 2.5.2.
+ **23.03.18:** Bump to version 2.5.
+ **14.12.17:** Consolidate layers and fix continuation lines.
+ **25.10.17:** Bump to version 2.1.12.
+ **18.08.17:** Switch default authentication method to local, update readme on how to deactivate the admin user
+ **31.07.17:** Fix updates of existing openvpn-as installs.
+ **07.07.17:** Bump to version 2.1.9.
+ **31.10.16:** Bump to version 2.1.4.
+ **14.10.16:** Add version layer information.
+ **13.09.16:** Rebuild due to push error to hub on last build.
+ **10.09.16:** Add layer badges to README.
+ **28.08.16:** Add badges to README.
+ **01.08.16:** Rebase to xenial.
+ **18.09.15:** Initial Release.
