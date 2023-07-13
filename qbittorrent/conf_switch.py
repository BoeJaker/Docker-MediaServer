"""
Switches VPN connection by rotating the wireguard config files after a threshold of data-use or latency is met. It also checks configs for expiration.
"""
import psutil
import subprocess
import time
import datetime

# Define your threshold values
BANDWIDTH_THRESHOLD = 50*1000000  # 100 Mbps
LATENCY_THRESHOLD = 50  # 50 ms

# Define the path to your WireGuard configuration files
CONFIG_PATH = "/etc/wireguard/"

# Define the names of your WireGuard configurations
CONFIGS = ["wg0.conf", "wg1.conf", "wg2.conf"]  # Add more configurations if needed

def get_bandwidth_usage():
    network_stats = psutil.net_io_counters(pernic=True)
    # Assuming the WireGuard interface is named "wg0"
    if "wg0" in network_stats:
        return network_stats["wg0"].bytes_sent + network_stats["wg0"].bytes_recv
    return 0

def get_latency():
    # Implement a method to measure latency to your servers
    # This can vary depending on your specific setup and requirements
    # You can use tools like Ping or custom scripts to measure latency
    # and return the average latency value.

    # Placeholder implementation, replace with your logic
    return 20  # ms

def switch_configuration(new_config):
    subprocess.run(["wg-quick", "down", "wg0"])
    subprocess.run(["cp", f"{CONFIG_PATH}/{new_config}", f"{CONFIG_PATH}/wg0.conf"])
    subprocess.run(["wg-quick", "up", "wg0"])
    
#  has_expired() function that reads the configuration file and checks if it has an expiration field in the form of # Expiration: YYYY-MM-DD.
def has_expired(config_file):
    with open(f"{CONFIG_PATH}/{config_file}", "r") as file:
        for line in file:
            if line.startswith("# Expiration:"):
                expiration_date = line.split(":")[1].strip()
                expiration_date = datetime.datetime.strptime(expiration_date, "%Y-%m-%d").date()
                return expiration_date < datetime.date.today()
    return False

def main():
    current_config = 0
    while True:
        bandwidth = get_bandwidth_usage()
        latency = get_latency()

        if bandwidth > BANDWIDTH_THRESHOLD or latency > LATENCY_THRESHOLD or has_expired(CONFIGS[current_config]):
            current_config = (current_config + 1) % len(CONFIGS)
            switch_configuration(CONFIGS[current_config])

        time.sleep(10)  # Check metrics every 10 seconds

if __name__ == "__main__":
    main()
