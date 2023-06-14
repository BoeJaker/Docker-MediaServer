import docker
import re
import yaml
from flask import Flask, render_template, redirect
import os, time
from dotenv import load_dotenv

load_dotenv()

MY_ENV_VAR = os.getenv('MY_ENV_VAR')

app = Flask(__name__)

stack_name="mediaserver"

def get_services():
    with open('docker-compose.yml', 'r') as file:
        compose_data = yaml.safe_load(file)
        services = compose_data['services']
        return services

def get_container_status(container):
    return container.status

def get_container_port(service_config):
    ports = service_config.get('ports')
    print(ports)
    if ports:
        # Assuming only one port mapping for simplicity
        port_mapping = ports[0].split(':')
        host_port = os.getenv(re.sub("\$|\{|\}", "", port_mapping[0]))
        return f"http://192.168.3.135:{host_port}"
    return None

def fuzzy_search(container_names, service_name):
    for container_name in container_names:
        if service_name in container_name:
            return container_name

    return None
def get_container_stats(container):
    stats = container.stats(stream=False)
    cpu_percent = None
    memory_percent = None
    print(stats)
    if 'cpu_stats' in stats and 'cpu_usage' in stats['cpu_stats']:
        cpu_stats = stats['cpu_stats']
        cpu_usage = cpu_stats['cpu_usage']['total_usage']
        cpu_system = cpu_stats['system_cpu_usage']
        cpu_percent = "%.00f%%" % ((cpu_usage / cpu_system) * 100)

    if 'memory_stats' in stats:
        memory_stats = stats['memory_stats']
        memory_usage = memory_stats.get('usage')
        memory_limit = memory_stats.get('limit')

        if memory_usage is not None and memory_limit is not None:
             memory_percent = "%.00f%%" % ((memory_usage / memory_limit) * 100)

    return cpu_percent, memory_percent


@app.route('/')
def index():
    client = docker.from_env()
    services = get_services()
    container_names = [container.name for container in client.containers.list()]
    print(container_names)
    service_data = []

    for service, config in services.items():
        matched_name = fuzzy_search(container_names, service)
        if matched_name:
            repo=None
            print(matched_name)
            container = client.containers.get(matched_name)
            cpu_percent, memory_percent = get_container_stats(container)
            status = get_container_status(container)
            port = get_container_port(config)
            start = f"http://192.168.3.135:5000/start/{matched_name}"
            stop = f"http://192.168.3.135:5000/stop/{matched_name}"
            repo = config.get('client_repo')
            print(config)

            service_data.append({
                'service': service,
                'repo': repo,
                'status': status,
                'port': port,
                'cpu_percent': cpu_percent,
                'memory_percent': memory_percent,
                'start': start,
                'stop' : stop

            })
            print(service_data)
        else:
            print(f"no match for {service}")
            start = f"http://192.168.3.135:5000/start/{service}"
            stop = f"http://192.168.3.135:5000/stop/{service}"

            service_data.append({
                'service': service,
                'status': 'Not Found',
                'port': None,
                'cpu_percent': 0,
                'memory_percent': 0,
                'start': start,
                'stop' : stop
            })

    return render_template('index.html', services=service_data)

@app.route('/start/<service>')
def start_container(service):
    services = get_services()
    os.popen(f"docker-compose up {[s for s in services if service in s]}")
    return redirect('/')

@app.route('/stop/<service>')
def stop_container(service):
    client = docker.from_env()
    services = get_services()
    container_names = [container.name for container in client.containers.list()]

    matched_name = fuzzy_search(container_names, service)

    if matched_name:
        os.popen(f"docker-compose stop {matched_name}")

    return redirect('/')

@app.route('/stopall')
def stop_all():
    os.popen(f"docker-compose down")

    return redirect('/')




if __name__ == '__main__':
    app.run(host="0.0.0.0")
