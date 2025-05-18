import json
import os
import sys

# File paths
DAEMON_JSON_PATH = "/etc/docker/daemon.json"
DOCKERFILE_PATH = "Dockerfile"
DOCKER_COMPOSE_PATH = "docker-compose.yml"

# Default hardening settings for the Docker daemon
HARDENING_FLAGS = {
    "security-opts": ["seccomp=unconfined", "no-new-privileges"],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "10m",
        "max-file": "3"
    }
}

# Security additions to Dockerfile
DOCKERFILE_SECURITY = """
# Use a non-root user
USER appuser

# Add a HEALTHCHECK directive to ensure the app is running properly
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD curl --fail http://localhost:5000/ || exit 1

# Resource limits: set memory limit and CPU limit
# Note: Docker will enforce these limits when containers are run
# For example: docker run --memory="512m" --cpus="1" mywebapp
"""

# Security settings to add to docker-compose.yml
DOCKER_COMPOSE_SECURITY = """
  mem_limit: 512m
  pids_limit: 100
  security_opt:
    - no-new-privileges
  read_only: true
"""

# Update daemon.json with hardening flags
def update_daemon_json():
    if os.path.exists(DAEMON_JSON_PATH):
        with open(DAEMON_JSON_PATH, "r") as file:
            config = json.load(file)
    else:
        config = {}

    # Update or add the security flags
    config.update(HARDENING_FLAGS)

    with open(DAEMON_JSON_PATH, "w") as file:
        json.dump(config, file, indent=4)
    
    print(f"Updated {DAEMON_JSON_PATH} with hardening flags.")

# Update Dockerfile with security settings
def update_dockerfile():
    if not os.path.exists(DOCKERFILE_PATH):
        print(f"{DOCKERFILE_PATH} not found.")
        return
    
    with open(DOCKERFILE_PATH, "a") as file:
        file.write(DOCKERFILE_SECURITY)
    
    print(f"Added user, healthcheck, and resource limits to {DOCKERFILE_PATH}.")

# Update docker-compose.yml with security settings
def update_docker_compose():
    if not os.path.exists(DOCKER_COMPOSE_PATH):
        print(f"{DOCKER_COMPOSE_PATH} not found.")
        return
    
    with open(DOCKER_COMPOSE_PATH, "a") as file:
        file.write(DOCKER_COMPOSE_SECURITY)
    
    print(f"Added resource limits and security options to {DOCKER_COMPOSE_PATH}.")

def main():
    # Run the update functions
    try:
        print("Starting Docker security hardening script...")
        
        update_daemon_json()
        update_dockerfile()
        update_docker_compose()

        print("Docker security hardening complete.")
    
    except Exception as e:
        print(f"Error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
