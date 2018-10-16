#!/bin/bash

#  Environment variables for proxy autoconfiguration

#  Domain name to be used for reverse proxy
export LE_DOMAINNAME='domain.tld'

#  Email address for Let's Encrypt
export LE_EMAIL='example@email.com'

#  Subdomain name for portainer service

export PORTAINER_HOSTNAME='docker'

#  Subdomain name for gitea service

export GITEA_HOSTNAME='gitea'

#  Subdomain for calibre-web service

export CALIBRE_WEB_HOSTNAME='calibre-web'
