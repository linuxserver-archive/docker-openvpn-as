![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://www.linuxserver.io/) team brings you another quality container release featuring auto-update of dependencies on startup, easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io/index.php) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/openvpn-as

OpenVPN Access Server is a full featured secure network tunneling VPN software solution that integrates OpenVPN server capabilities, enterprise management capabilities, simplified OpenVPN Connect UI, and OpenVPN Client software packages that accommodate Windows, MAC, Linux, Android, and iOS environments. OpenVPN Access Server supports a wide range of configurations, including secure and granular remote access to internal network and/ or private cloud network resources and applications with fine-grained access control. [Openvpn-as](https://openvpn.net/index.php/access-server/overview.html)

## Usage

```
docker create --name=openvpn-as -v <path to data>:/config -e PGID=<gid> -e PUID=<uid> -e TZ=<timezone> -e INTERFACE=<interface> --net=host --privileged linuxserver/openvpn-as
```

**Parameters**



* `-v /config` - where openvpn-as should store configuration files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for Timezone setting
* `-e INTERFACE` setting interface for openvpn-as *default is eth0*
* `--net=host` IMPORTANT, will not operate unless in host mode.
* `--privileged` IMPORTANT, will not operate unless in privileged mode.

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it openvpn-as /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

The admin interface is available at https://<ip>:943 with a default user/password of admin/password.
To change the password (recommended) do
`docker exec -it openvpn-as passwd admin` 


## Updates

* Upgrade dependencies to the latest version simply `docker restart openvpn-as`.
* To monitor the logs of the container in realtime `docker logs -f openvpn-as`.



## Versions

+ **18.09.2015:** Initial Release. 

