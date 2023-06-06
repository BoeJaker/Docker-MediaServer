import docker

def get_container_public_ip(container):
    network_settings = container.attrs.get('NetworkSettings')
    if network_settings:
        networks = network_settings.get('Networks')
        if networks:
            network = list(networks.values())[0]
            ip_address = network.get('IPAddress')
            if ip_address:
                return ip_address

    return None

def verify_container_public_ips():
    client = docker.from_env()
    containers = client.containers.list()

    for container in containers:
        container_name = container.name
        public_ip = get_container_public_ip(container)

        if public_ip:
            print(f"Container: {container_name} | Public IP: {public_ip}")
        else:
            print(f"Container: {container_name} | Public IP: Not Found")

if __name__ == '__main__':
    verify_container_public_ips()
