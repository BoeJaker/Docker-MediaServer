# Docker Media Server
A complete media server with on-demand videos & games, a cloud file server and a backend for montitoring
</br>

# Components & Features

Listed below are the components and their features

</br>

## Twingate
Routes hosts to internal addresses.
Twingate requires an account and authentication keys to be set up. It takes 5 to 10 minutes and its free. With twingate you can access servoces over the internet with a url and optional port i.e. postgres.int:5432
[](twingate.com)

</br>

## Reverse Proxy
Routes URL requests to internal hosts & ports. allowing you to access services via urls i.e. www.dockernet.com/jackett

</br>

## Index
A simple web server that acts as a landing page, index of services and metrics monitor.

</br>

## Jackett

![](./resorces/jackett.jpg)

Torrent meta search.
Jackett works as a proxy server: it translates queries from apps (Sonarr, Radarr, SickRage, CouchPotato, Mylar3, Lidarr, DuckieTV, qBittorrent, Nefarious etc.) into tracker-site-specific http queries, parses the html or json response, and then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches.
[Jackett](https://github.com/Jackett/Jackett)

</br>

## Qbittorrent + Wireguard

![](./resorces/qbittorrent.jpg)

Torrent manager with web UI.
qBittorrent is a bittorrent client programmed in C++ / Qt that uses libtorrent (sometimes called libtorrent-rasterbar) by Arvid Norberg.
It aims to be a good alternative to all other bittorrent clients out there. qBittorrent is fast, stable and provides unicode support as well as many features.
[qbittorrentvpn - DyonR](https://github.com/DyonR/docker-qbittorrentvpn)

</br>

## Plex

![](./resorces/plex.jpg)

Media server, web UI and web based player.
Plex requires an account to be used, access the web interface and you will be guided through the process.   
It is advisable to setup remote connection to plex in the settings if you intend to access the server remotely.
[docker-plex - Linuxserver.io](https://github.com/linuxserver/docker-plex)

</br>

## Retroarch
![](./resorces/retroarch.jpg)
Web browser based video game emulation
[Retroarch Web - Inglebard](https://github.com/Inglebard/dockerfiles/tree/retroarch-web)

</br>

## Owncloud  
![](./resorces/owncloud.png)
A self hosted cloud and file management interface
[Owncloud docker server - Owncloud](https://github.com/owncloud-docker/server)

</br>

## ClamAv
Periodiccaly scans shared folders for known threats.

</br>

## Metrics

### cAdvisor
![](./resorces/cadvisor.png)

</br>

### Prometheus
![](./resorces/prometheus.png)

</br>

### Grafana
![](./resorces/grafana.png)

</br>

# Limitations & Gotchas

</br>

# Distributions
## Lite  

## Basic  

## Full  

</br>

# Usage

## Prerequisites 
Docker
Twingate account
VPN provider with support for p2p

## Building
Run the Docker Compose configuration:

Open a terminal or command prompt.
Navigate to the directory where the Docker Compose file is located using the `cd` command.

    cd /your_path_to/mediaserver_root

To start the services defined in the Docker Compose file, run the following command:

     docker-compose up
   
Docker Compose will read the configuration file and start the containers according to the specified services.
You will see the output and logs from the containers in the terminal or command prompt.
Monitor the logs to ensure that the services are starting correctly and to debug any issues.
Press `Ctrl+C` to stop the running services. This will gracefully stop and remove the containers.
   
Additional useful commands:

If you prefer to run the services in the background (detached mode), you can use the `-d` flag:
   
     docker-compose up -d
   
To stop the running services without removing the containers, you can use the following command:

     docker-compose stop

   
If you need to start the services again after they have been stopped, use the following command:
   
     docker-compose start

You can also specify a specific service for many of these commands by appending the name to the command. Take plex for an example:

    docker-compose up -d plex

## Scaling
### Docker swarm

### Redundancy
All containers can be built in multiples to create redundancy within the structure of the media server. Performance overhead is minmial, allowing for more robust connections to the containers. 

## Maintaining
