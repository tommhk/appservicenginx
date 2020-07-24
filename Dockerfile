FROM nginx

# Install openssh-server to provide web ssh access from kudu, supervisor to run processor
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    supervisor \
    openssh-server \
    && echo "root:Docker!" | chpasswd	

RUN mkdir -p /home/site/wwwroot
RUN mkdir -p /home/LogFiles
	
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf	
COPY sshd_config /etc/ssh/
COPY init_container.sh /bin/

RUN ["chmod", "+x", "/bin/init_container.sh"]

EXPOSE 80 2222
CMD ["/bin/init_container.sh"]