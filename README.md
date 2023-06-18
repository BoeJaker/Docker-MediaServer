# Docker Media Server
A complete media server with on-demand videos & games, a cloud file server and a backend for montitoring

</br>

# Table of contents

- [Docker Media Server](#docker-media-server)
- [Components & Features](#components--features)
  - [Twingate](#twingate)
  - [Reverse Proxy](#reverse-proxy)
  - [Index](#index)
  - [Jackett](#jackett)
  - [Qbittorrent + Wireguard](#qbittorrent--wireguard)
  - [Plex](#plex)
  - [Retroarch](#retroarch)
  - [Owncloud](#owncloud)
  - [ClamAv](#clamav)
  - [Metrics](#metrics)
- [System Requirements](#system-requirements)
  - [Recomended](#recomended)
  - [Basic](#basic)
  - [Swarm](#swarm)
- [Limitations & Gotchas](#limitations--gotchas)
  - [Twingate](#twingate)
  - [Reverse Proxy](#reverse-proxy)
  - [File Permissions](#file-permissions)
  - [](#)
- [Distributions](#distributions)
  - [Lite](#lite)
  - [Basic](#basic)
  - [Full](#full)
- [Quickstart](#quickstart)
- [Usage Guide](#usage-guide)
  - [Prerequisites](#prerequisites)
  - [Configuration](#configuration)
  - [Building](#building)
- [Run the Docker Compose configuration:](#run-the-docker-compose-configuration)
  - [Scaling](#scaling)
  - [Maintainence & Monitoring](#maintainence--monitoring)

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

# System Requirements

## Recomended
## Basic
## Swarm

</br>

# Limitations & Gotchas

## Twingate
## Reverse Proxy
## File Permissions
##
</br>

# Distributions
## Lite  

## Basic  

## Full  

</br>




# Quickstart

If your familiar with docker here is a quickstart guide so you can test the features.

Open the .env.example file in the projects root directory, if your not using a vpn, set QBITTORRENTVPN to 'false' instead of 'true'. 

If you have an account with twingate, include your endpoint keys in the appropriate variables and if you have a VPN provider point to the location of the config with the VPN_CONFIG variable.

Amend the directories variable to match those of your systems media files

Note any passwords and usernames in the env file as they are the defaults and will be needed later to access services. 
Then save the file as .env

The server can now be brought up with the docker command

     docker-compose up plex qbittorrent jackett owncloud retroarch 

if you did setup twingate simply append 

    twingate twingate_redundant 

Which would be:

    docker-compose up plex qbittorrent jackett owncloud retroarch  twingate twingate_redundant 

Feel free to disclude services from this statement or add flags such as -d.

</br>

# Usage Guide

## Prerequisites 

</br>

### Docker - Required
Visit the Docker website (https://www.docker.com/) and follow the instructions to install Docker for your operating system.
Docker Compose typically comes bundled with Docker, so you don't need to install it separately.

</br>

### Twingate account - Optional
Visit the Twingate website:

Open a web browser and go to the Twingate website (https://www.twingate.com/).
Sign up for an account:

Click on the "Get Started" or "Sign Up" button on the Twingate homepage.
Follow the registration process and provide the necessary information, such as your email address, name, and organization details.

Set up your organization:

Upon logging in, you will be prompted to set up your organization.
Follow the on-screen instructions to configure your organization's name, domain, and other relevant details.

Access the Admin Dashboard:

After setting up your organization, you will be taken to the Twingate Admin Dashboard.
The Admin Dashboard is where you can manage your organization's settings, users, and resources.

Navigate to the Connectors section:

In the Admin Dashboard, look for the "Connectors" tab or section.
Click on it to access the Connectors configuration.

Add a new Connector:

To add a new Connector, click on the "Add Connector" or "New Connector" button.
Follow the prompts to configure the Connector's details, such as its name and connection type.
Twingate supports various types of Connectors, including Cloud Connectors, Network Connectors, and Identity Providers. Choose the appropriate type based on your requirements.

Retrieve Connector details:

Once you have added a Connector, you will be provided with specific details required for its configuration.
You will need the authentication tokens.
Note down or copy the necessary Connector details as you will need them to configure the Connector on your network or system.

Configure the Connector:

With the Connector details in hand, 

</br>

### VPN provider with support for p2p - Optional
Visit the Mullvad website:

Open a web browser and go to the Mullvad website (https://mullvad.net/).

Sign up for an account:

Click on the "Get started" or "Sign up" button on the Mullvad homepage.
Follow the registration process and provide the necessary information, such as your email address and desired account details.

Choose a payment method:

Mullvad offers various payment options, including credit cards, PayPal, cryptocurrencies, and more.
Select the payment method that suits you best and follow the instructions to complete the payment process.

Generate a WireGuard configuration file:

After logging in, navigate to the "Account" or "Settings" section of the Mullvad app.
Look for an option to generate a WireGuard configuration file.
Click on the "Generate" or "Download" button to create and download the WireGuard configuration file.
Save the WireGuard configuration file:

Choose a location on your device where you want to save the WireGuard configuration file.
It is typically a .conf file or a file with a .conf extension.
Make sure to remember the location where you save the file for later use.

Set up Qbittorrent using the configuration file:

</br>

## Configuration

Configuration is achieved through the .env file here you can set usernames, passwords, ports, directories and other key build info. To start configuration save a copy of .env.example as .env and open it for editing. 

Each value is well described in the .env file, so they wont be outlined here. Each relates to environment variables used in the docker compose or within the containers themselves.

To start the twingate service you must input your twingate apikeys into those fields. Otherwise it will raise an error if you try to start that container

Volumes must be set for your media locations.

Ports should be left in their default state unless you understand what you are doing.

</br>

## Building

</br>

# Run the Docker Compose configuration:

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

You can also specify a specific service, or services, for many of these commands by appending them to the command. Take qbittorrent and plex for an example:

    docker-compose up -d plex qbittorrent

</br>

## Scaling
The stack can be scaled in two ways. 
Single host redundancy where multiple mirrored containers start for each servoce on one host.
Multiple host redundancy with Docker Swarm where services and load can be distributed between multiple host machines. If you have a raspberry pi, you can make a swarm.

### Single-Host Redundancy
All containers can be built in multiples to create redundancy within the structure of the media server. Performance overhead is minmial, allowing for more robust connections to the containers. 

### Docker swarm
Use the docker_stack_deploy.py script to quickly deploy this stack to a swarm

## Maintainence & Monitoring
