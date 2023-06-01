# Start from the base qBittorrent image
FROM linuxserver/qbittorrent:latest

# Install WireGuard dependencies
RUN apt-get update && apt-get install -y wireguard

# Copy WireGuard configuration files to the container
COPY ./vpn/config/wg0.conf /etc/wireguard
# peer1/peer1.config

# Copy qBittorrent configuration files to the container (if needed)
COPY ./qbittorrent-config /config

# Expose the necessary ports for qBittorrent
EXPOSE 6881 6881/udp

# Start the WireGuard VPN connection
CMD ["sh", "-c", "wg-quick up /etc/wireguard/wg0.conf && qbittorrent-nox"]
