# Yet Another DST Server Runtime (x86_64)

[![Build Status](https://drone.fat4.cn/api/badges/maoxuner/yadst/status.svg?ref=refs/heads/main)](https://drone.fat4.cn/maoxuner/yadst)

As to `DoNotStarveTogether Dedicated Server`, I finally realized that `steamcmd` is only a game server files **downloader**. That is to say, what I need is just a game server **runtime**.

Modifying server settings by hand reduces the difficulty of runtime building and improves its compatibility.

Optimized for mutliple shards(>=3). Every shard run in a single container.

## Features

- Serve mutiple shards. (1 or more)
- Simple but powerful. (dedicated downloader and runtime)

## Guidings

1. Generate a cluster token and download base cluster config from next link<br>
   https://accounts.klei.com/account/game/servers?game=DontStarveTogether
2. Extract downloaded files to `data/DoNotStarveTogether/MyDediServer`
   ```
   server/data/DoNotStarveTogether
   └── MyDediServer
       ├── Caves
       │   ├── server.ini
       │   └── worldgenoverride.lua
       ├── cluster.ini
       ├── cluster_token.txt
       └── Master
           ├── server.ini
           └── worldgenoverride.lua
   ```
3. Download game files
   ```bash
   docker run --rm -v $PWD/server/game:/opt/dst/game steamcmd/steamcmd +force_install_dir /opt/dst/game +login anonymous +app_update 343050 validate +quit
   ```
4. Build runtime image (or use yadst image)
   ```bash
   docker compose build master-shard
   ```
5. After game files downloaded, start game servers
   ```bash
   docker compose up -d
   ```

## Thanks

These projects have done a great job. Some ideas or scripts come from them.

- [yeetzone/docker-dontstarvetogether](https://github.com/yeetzone/docker-dontstarvetogether)
- [Jamesits/docker-dst-server](https://github.com/Jamesits/docker-dst-server)

## References

- [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD)
- [steamcmd/steamcmd](https://hub.docker.com/r/steamcmd/steamcmd)
- [Dedicated Server Quick Setup Guide - Linux](https://forums.kleientertainment.com/forums/topic/64441-dedicated-server-quick-setup-guide-linux/)
- [Dedicated Server Command Line Options Guide](https://forums.kleientertainment.com/forums/topic/64743-dedicated-server-command-line-options-guide/)
- [Guides/Don’t Starve Together Dedicated Servers](https://dontstarve.fandom.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers)
- [饥荒联机独立服务器搭建教程（二）：Linux 篇](http://blog.ttionya.com/article-1233.html)
