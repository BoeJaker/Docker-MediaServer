import os
import shutil
import subprocess

def read_env_file(env_file):
    env_vars = {}
    with open(env_file, "r") as file:
        lines = file.readlines()
        for line in lines:
            line = line.strip()
            if line and not line.startswith("#"):
                key, value = line.split("=", 1)
                env_vars[key.strip()] = value.strip().replace("\"","")
    return env_vars

def insert_env_variables(compose_file, env_vars):
    with open(compose_file, "r") as file:
        content = file.read()

    for key, value in env_vars.items():
        placeholder = f"${{{key}}}"
        content = content.replace(placeholder, value)

    return content

def save_compose_file(content, output_file):
    with open(output_file, "w") as file:
        file.write(content)

def deploy_stack(compose_file):
    subprocess.run(["docker", "stack", "deploy", "-c", compose_file, "stack_name"])

if __name__ == "__main__":
    env_file = ".env"
    compose_file = "docker-compose.yml"
    output_file = "docker-compose-swarm.yml"

    env_vars = read_env_file(env_file)
    new_compose_content = insert_env_variables(compose_file, env_vars)
    save_compose_file(new_compose_content, output_file)
    deploy_stack(output_file)
