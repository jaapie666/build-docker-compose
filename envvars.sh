#!/bin/bash

#  Environment variables for proxy autoconfiguration

#  List of services to include when building the docker-compose.yml file
#  the nginx reverse proxy, automatic ssl, and portainer services are always
#  included

  INCLUDE_PROXY='true'

  INCLUDE_PORTAINER='true'

  INCLUDE_GITEA='true'

  INCLUDE_CALIBRE_WEB='true'

  INCLUDE_BOOKSTACK='false'


#  Domain name to be used for reverse proxy
  LE_DOMAINNAME='domain.tld'

#  Email address for Let's Encrypt
  LE_EMAIL='example@email.com'

#  Subdomain name for portainer service

  PORTAINER_HOSTNAME='docker'

#  Subdomain name for gitea service

  GITEA_HOSTNAME='gitea'

#  Subdomain for calibre-web service

  CALIBRE_WEB_HOSTNAME='calibre-web'

#  Subdomain for bookstack service

  BOOKSTACK_HOSTNAME='bookstack'
