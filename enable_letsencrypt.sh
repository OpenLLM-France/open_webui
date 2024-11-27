#!/bin/bash

# Description: Simplified script to obtain and install Let's Encrypt SSL certificates using Certbot.

DOMAIN="dne.linagora.com"
EMAIL="htagourti@linagora.com"
NGINX_CONF_PATH="/home/ubuntu/projects/webui/conf.d"  # Path to your Nginx configuration folder


# Install Certbot if not installed
if ! command -v certbot &> /dev/null; then
    echo "Certbot not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y certbot python3-certbot-nginx
fi

# Obtain SSL certificate
sudo certbot --nginx --nginx-server-root "$NGINX_CONF_PATH" -d "$DOMAIN" --non-interactive --agree-tos -m "$EMAIL"

# Copy SSL certificate to the project folder to mount to nginx docker
sudo cp /etc/letsencrypt/live/dne.linagora.com/fullchain.pem /home/ubuntu/projects/webui/certbot/
sudo cp /etc/letsencrypt/live/dne.linagora.com/privkey.pem /home/ubuntu/projects/webui/certbot/


echo "Let's Encrypt SSL certificate has been installed"