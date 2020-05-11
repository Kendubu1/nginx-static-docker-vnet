FROM nginx:1.17

# Set Env Variables for the ports
ENV PORT 80
ENV SSH_PORT 2222

# Install openssh-server
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    supervisor \
    openssh-server \
    && echo "root:Docker!" | chpasswd	
RUN rm -f /etc/ssh/sshd_config
COPY sshd_config /etc/ssh/
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
RUN chmod -R +x /tmp/ssh_setup.sh \
   && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null) \
   && rm -rf /tmp/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY sshd_config /etc/ssh/
COPY init_container.sh /bin/
RUN chmod +x /bin/init_container.sh
COPY index.html /home/site/wwwroot/index.html
COPY access.log /home/LogFiles/access.log
COPY error.log /home/LogFiles/error.log

EXPOSE 80 2222

CMD ["/bin/init_container.sh"]
