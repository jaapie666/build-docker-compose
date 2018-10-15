# build-docker-compose-yml.sh
# builds a docker-compose.yml file from individual service files

#!/bin/bash


buildservices()
{
    echo -e "services:\n\n$(cat ./services/{proxy.yml,portainer.yml,gitea.yml})"
}

buildvolumes()
{
    echo -e "volumes:\n  certs:\n  vhost.d:\n  html:"
}

buildnetworks()
{
    echo -e "networks:\n  proxy-tier:"
}


echo -e "version: '2'\n\n$(buildservices)\n\n$(buildvolumes)\n\n$(buildnetworks)" > docker-compose.yml
