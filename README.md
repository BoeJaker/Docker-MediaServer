[](./resorces/jackett.jpg)
[](./resorces/plex.jpg)
[](./resorces/qbittorrent.jpg)
[](./resorces/retroarch.jpg)

# Features
## 
## Twingate
Routes hosts to internal addresses.
Twingate requires an account and authentication keys to be set up. It takes 5 to 10 minutes and its free.
[](twingate.com)
## Reverse Proxy
Routes URL requests to internal hosts & ports

## Index
Index of services on the network.

## Jackett
Torrent meta search.
Jackett works as a proxy server: it translates queries from apps (Sonarr, Radarr, SickRage, CouchPotato, Mylar3, Lidarr, DuckieTV, qBittorrent, Nefarious etc.) into tracker-site-specific http queries, parses the html or json response, and then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches.
[Jackett](https://github.com/Jackett/Jackett)

## Qbittorrent + Wireguard
Torrent manager with web UI.
qBittorrent is a bittorrent client programmed in C++ / Qt that uses libtorrent (sometimes called libtorrent-rasterbar) by Arvid Norberg.
It aims to be a good alternative to all other bittorrent clients out there. qBittorrent is fast, stable and provides unicode support as well as many features.
[qbittorrentvpn - DyonR](https://github.com/DyonR/docker-qbittorrentvpn)


## Plex
Media server, web UI and web based player.
Plex requires an account to be used, access the web interface and you will be guided through the process.   
It is advisable to setup remote connection to plex in the settings if you intend to access the server remotely.
[docker-plex - Linuxserver.io](https://github.com/linuxserver/docker-plex)

## Retroarch
Web browser based video game emulation
[Retroarch Web - Inglebard](https://github.com/Inglebard/dockerfiles/tree/retroarch-web)

## Owncloud  
A self hosted cloud and file management interface
[Owncloud docker server - Owncloud](https://github.com/owncloud-docker/server)
## ClamAv

## Metrics
### cAdvisor
### Prometheus
### Grafana

# Redundancy
All containers that handle networking have built in redundancies. Performance overhead is minmial, allowing for more robust connections to the container.

