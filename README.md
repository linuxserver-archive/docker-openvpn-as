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

# [linuxserver/openvpn-as](https://github.com/linuxserver/docker-openvpn-as)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/openvpn-as.svg)](https://microbadger.com/images/linuxserver/openvpn-as "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/openvpn-as.svg)](https://microbadger.com/images/linuxserver/openvpn-as "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/openvpn-as.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/openvpn-as.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-openvpn-as/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-openvpn-as/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/openvpn-as/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/openvpn-as/latest/index.html)

[Openvpn-as](https://openvpn.net/index.php/access-server/overview.html) is a full featured secure network tunneling VPN software solution that integrates OpenVPN server capabilities, enterprise management capabilities, simplified OpenVPN Connect UI, and OpenVPN Client software packages that accommodate Windows, MAC, Linux, Android, and iOS environments. OpenVPN Access Server supports a wide range of configurations, including secure and granular remote access to internal network and/ or private cloud network resources and applications with fine-grained access control.

[![openvpn-as](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/openvpn-as-banner.png)](https://openvpn.net/index.php/access-server/overview.html)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/openvpn-as` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=openvpn-as \
  --cap-add=NET_ADMIN \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e INTERFACE=eth0 `#optional` \
  -p 943:943 \
  -p 9443:9443 \
  -p 1194:1194/udp \
  -v <path to data>:/config \
  --restart unless-stopped \
  linuxserver/openvpn-as
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  openvpn-as:
    image: linuxserver/openvpn-as
    container_name: openvpn-as
    cap_add:
      - NET_ADMIN
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - INTERFACE=eth0 #optional
    volumes:
      - <path to data>:/config
    ports:
      - 943:943
      - 9443:9443
      - 1194:1194/udp
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 943` | Admin GUI port. |
| `-p 9443` | TCP port. |
| `-p 1194/udp` | UDP port. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e INTERFACE=eth0` | With bridge networking, leave it as eth0 (or don't include at all), if host or macvlan, set it to your host's network interface, found by running `ifconfig` |
| `-v /config` | Where openvpn-as should store configuration files. |

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

The admin interface is available at `https://<ip>:943/admin` with a default user/password of admin/password

During first login, make sure that the "Authentication" in the webui is set to "Local" instead of "PAM". Then set up the user accounts with their passwords (user accounts created under PAM do not survive container update or recreation).

The "admin" account is a system (PAM) account and after container update or recreation, its password reverts back to the default. It is highly recommended to block this user's access for security reasons:
1) Create another user and set as an admin,
2) Log in as the new user,
3) Delete the "admin" user in the gui,
4) Modify the `as.conf` file under config/etc and replace the line `boot_pam_users.0=admin` with `#boot_pam_users.0=admin` (this only has to be done once and will survive container recreation)



## Support Info

* Shell access whilst the container is running: `docker exec -it openvpn-as /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f openvpn-as`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' openvpn-as`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/openvpn-as`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/openvpn-as`
* Stop the running container: `docker stop openvpn-as`
* Delete the container: `docker rm openvpn-as`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start openvpn-as`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull openvpn-as`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d openvpn-as`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once openvpn-as
  ```
* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-openvpn-as.git
cd docker-openvpn-as
docker build \
  --no-cache \
  --pull \
  -t linuxserver/openvpn-as:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **07.04.19:** - Fix first time config.
* **03.04.19:** - Big rewrite of the install and update logic of openvpn-as to fix breaking changes (should fix updating from 2.6.1 to 2.7.3), added mysql-client for cluster support.
* **14.03.19:** - Update deb package URL.
* **21.02.19:** - Rebase to xenial due to incompatibility issues on some older host OSes.
* **12.02.19:** - Rename github repo to match the docker hub repo and container name.
* **07.02.19:** - Add pipeline logic and multi arch.
* **31.01.19:** - Add port mappings to docker create sample in readme.
* **26.01.19:** - Removed `privileged` and `host` networking requirements, added `cap-add=NET_ADMIN` requirement instead. `INTERFACE` no longer needs to be defined as in bridge mode, it will use the container's eth0 interface by default.
* **19.12.18:** - Bump to version 2.6.1.
* **10.07.18:** - Bump to version 2.5.2.
* **23.03.18:** - Bump to version 2.5.
* **14.12.17:** - Consolidate layers and fix continuation lines.
* **25.10.17:** - Bump to version 2.1.12.
* **18.08.17:** - Switch default authentication method to local, update readme on how to deactivate the admin user.
* **31.07.17:** - Fix updates of existing openvpn-as installs.
* **07.07.17:** - Bump to version 2.1.9.
* **31.10.16:** - Bump to version 2.1.4.
* **14.10.16:** - Add version layer information.
* **13.09.16:** - Rebuild due to push error to hub on last build.
* **10.09.16:** - Add layer badges to README.
* **28.08.16:** - Add badges to README.
* **01.08.16:** - Rebase to xenial.
* **18.09.15:** - Initial Release.
