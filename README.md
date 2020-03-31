# Nginx Docker Image for Azure Web Apps for Containers

Nginx Docker example, pre-configured for vnet integration. This simple repo is serving a static HTML page but can be used with single page application using Web Apps for Containers. 
- VNET Integration
- SSH Support
- Lightweight!

### Repository Keypoints  

| Files             |  Content                                   |
|----------------------|--------------------------------------------|
| `Dockerfile`           | Nginx base image with the openssh-server installed & the ENV variables of PORT & SSH_PORT set to account for dynamic port changes during vnet integration within Azure.          |
| `sshd_config`       | OpenSSH SSH daemon configuration file with env var SSH_PORT reference instead of 2222                     |
| `nginx.conf`       | Listening on the variable "PORT" instead of 80                  |
| `init_container.sh`               | Initalization script to start the services, pass the enviroment variables within the SSH session &  find/replace the varibles with our allocated ports within the nginx.conf & sshd_config during container startup. |


SSH Reference: https://docs.microsoft.com/bs-latn-ba/Azure/app-service/containers/configure-custom-container#enable-ssh
VNET Integration Reference: https://docs.microsoft.com/en-us/azure/app-service/web-sites-integrate-with-vnet#web-or-function-app-for-containers
