#/bin/bash

  source envvars.sh

  LE_DOMAINNAME_STR='${LE_DOMAINNAME}'

  LE_EMAIL_STR='${LE_EMAIL}'

  PORTAINER_HOSTNAME_STR='${PORTAINER_HOSTNAME}'

  GITEA_HOSTNAME_STR='${GITEA_HOSTNAME}'

  sed -i -e "s/$LE_DOMAINNAME_STR/$LE_DOMAINNAME/" docker-compose.yml

  sed -i -e "s/$LE_EMAIL_STR/$LE_EMAIL/" docker-compose.yml

  sed -i -e "s/$PORTAINER_HOSTNAME_STR/$PORTAINER_HOSTNAME/" docker-compose.yml

  sed -i -e "s/$GITEA_HOSTNAME_STR/$GITEA_HOSTNAME/" docker-compose.yml



