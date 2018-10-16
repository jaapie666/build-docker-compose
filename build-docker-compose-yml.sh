# build-dc.sh
# builds a docker-compose.yml file from individual service files

#!/bin/bash

# Variables
  
  source envvars.sh
  
  DCY_COMMENT="# This docker-compose.yml file was generated using an automated script\n# documentation is available at https://github.com/jaapie666/build-docker-compose"


  OPTIND=1 

  SUBSTITUTE_VARIABLES='false'

  FILE_NAME='docker-compose.yml'


  DCY_HEADER="$DCY_COMMENT\n\nversion: '2'\n"

  PROXY_NETWORKS="  proxy-tier:\n"
  
  PROXY_VOLUMES="  certs:\n  vhost.d:\n  html:"
  
  CALIBRE_WEB_VOLUMES="  cw-books:\n  cw-app:\n  cw-kindlegen:\n  cw-config:"
  
  BOOKSTACK_VOLUMES="  bs-config:\n  bs-data:"

# Functions

  buildservices()
  {  
    OLDDIR=$(pwd)
    cd services

    echo -e "services:\n"

    if [ "$INCLUDE_PROXY" == 'true' ]
    then
      cat proxy.yml
    fi

    if [ "$INCLUDE_PORTAINER" == 'true' ]
    then
      cat portainer.yml
    fi

    if [ "$INCLUDE_GITEA" == 'true' ]
    then
      cat gitea.yml
    fi

    if [ "$INCLUDE_CALIBRE_WEB" == 'true' ]
    then
      cat calibre-web.yml
    fi
  
    if [ "$INCLUDE_BOOKSTACK" == 'true' ]
    then
      cat bookstack.yml
    fi

    echo

    cd $OLDDIR
  }

  buildvolumes()
  {
    echo -e "volumes:"
    
    if [ "$INCLUDE_PROXY" == 'true' ]
    then
      echo -e "$PROXY_VOLUMES"
    fi

  
    if [ "$INCLUDE_CALIBRE_WEB" == 'true' ]
    then
      echo -e "$CALIBRE_WEB_VOLUMES"
    fi

    if [ "$INCLUDE_BOOKSTACK" == 'true' ]
    then
      echo -e "$BOOKSTACK_VOLUMES"
    fi

    echo
  }

  buildnetworks()
  {
    echo networks:

    if [ "$INCLUDE_PROXY" == 'true' ]
    then
      echo -e "$PROXY_NETWORKS"
    fi
  }

  substituteVars()
  {
    LE_DOMAINNAME_STR='${LE_DOMAINNAME}'

    LE_EMAIL_STR='${LE_EMAIL}'

    PORTAINER_HOSTNAME_STR='${PORTAINER_HOSTNAME}'

    GITEA_HOSTNAME_STR='${GITEA_HOSTNAME}'
  
    CALIBRE_WEB_HOSTNAME_STR='${CALIBRE_WEB_HOSTNAME}'

    BOOKSTACK_HOSTNAME_STR='{$BOOKSTACK_HOSTNAME}'
    
    
    sed -e "s/$LE_DOMAINNAME_STR/$LE_DOMAINNAME/" | \
    sed -e "s/$LE_EMAIL_STR/$LE_EMAIL/" | \
    sed -e "s/$PORTAINER_HOSTNAME_STR/$PORTAINER_HOSTNAME/" | \
    sed -e "s/$GITEA_HOSTNAME_STR/$GITEA_HOSTNAME/" | \
    sed -e "s/$CALIBRE_WEB_HOSTNAME_STR/$CALIBRE_WEB_HOSTNAME/" | \
    sed -e "s/$BOOKSTACK_HOSTNAME_STR/$BOOKSTACK_HOSTNAME/"
  }


  buildYaml()
  {
    source envvars.sh
    echo -e $DCY_HEADER
    buildservices
    buildvolumes
    buildnetworks
  }
  
  generateOutput()
  {
    if [ "$SUBSTITUTE_VARIABLES" == 'true' ]
    then
      buildYaml | substituteVars
    else
      buildYaml
    fi
  }

  
# Actual script begins here

# Parse flags

while getopts ":to:" opt; do
  case $opt in
    t)
      SUBSTITUTE_VARIABLES='true'
      ;;
    o)
      CREATE_FILE='true'

      if [ "$OPTARG" == '-t' ] || [ "$OPTARG" == 't' ]
      then
        SUBSTITUTE_VARIABLES='true'
      else
        FILE_NAME="$OPTARG"
      fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      CREATE_FILE='true'
      ;;
  esac
done




  if [ "$SUBSTITUTE_VARIABLES" == 'true' ]
  then
    echo substituting variables
  fi

  if [ "$CREATE_FILE" == 'true' ]
  then
    echo creating $FILE_NAME
    generateOutput > $FILE_NAME
  else
  generateOutput
  fi


