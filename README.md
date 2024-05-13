# Yet Another DST Server Runtime (x86_64)

As to `DoNotStarveTogether Dedicated Server`, I finally realized that `steamcmd` is only a game server files **downloader**. That is to say, what I need is just a game server **runtime**.

Modifying server settings by hand reduces the difficulty of runtime building and improves its compatibility.

Optimized for mutliple shards(>=3). Every shard run in a single container.

## Features

- Serve mutiple shards. (1 or more)
- Simple but powerful. (dedicated downloader and runtime)

## Guidings

1. Clone the project and change your working directory
   ```bash
   git clone https://gitee.com/maoxuner/yadst.git
   cd yadst
   ```
2. Generate a cluster token and download base cluster config from next link<br>
   https://accounts.klei.com/account/game/servers?game=DontStarveTogether
3. Extract downloaded files to `root-path-of-yadst/server/data/DoNotStarveTogether/MyDediServer`
   ```
   root-path-of-yadst/server
   ├── data
   │   └── DoNotStarveTogether
   │       └── MyDediServer
   │           ├── Caves
   │           │   ├── server.ini
   │           │   └── worldgenoverride.lua
   │           ├── Master
   │           │   ├── server.ini
   │           │   └── worldgenoverride.lua
   │           ├── cluster.ini
   │           └── cluster_token.txt
   └── game
   ```
4. Edit world and mods settings [manually]
5. Build runtime image (or use yadst)
   ```bash
   docker build -t yadst-runtime .
   ```
5. Download game and mods files
   ```bash
   # download game
   docker run --rm -v $PWD/server/game:/opt/dst/game steamcmd/steamcmd +force_install_dir /opt/dst/game +login anonymous +app_update 343050 validate +quit
   # download mods
   docker run --rm -v $PWD/server/game:/opt/dst/game -v $PWD/server/data:/opt/dst/data -w /opt/dst/game/bin64 yadst-runtime ./dontstarve_dedicated_server_nullrenderer_x64 -ugc_directory /opt/dst/game/ugc_mods -persistent_storage_root /opt/dst/data -conf_dir DoNotStarveTogether -cluster MyDediServer -shard Master -only_update_server_mods
   ```
6. After game files downloaded, start game servers
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
