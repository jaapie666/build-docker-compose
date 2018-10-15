# build-docker-compose-yml.sh
# builds a docker-compose.yml file from individual service files

#!/bin/bash


buildservices()
{
    echo -e "services:\n\n$(cat ./services/{proxy.yml,portainer.yml})"
}

buildvolumes()
{
    echo -e "volumes:\n  certs:\n  vhost.d:\n  html:"
}

buildnetworks()
{
    echo -e "networks:\n  proxy-tier:"
}


echo -e "#  Copied from https://blog.ssdnodes.com/blog/self-hosting-handbook-a-docker-compose-tutorial/
#  Slightly modified to allow for automatic configuration with environment variables\n\nversion: '2'\n\n$(buildservices)\n\n$(buildvolumes)\n\n$(buildnetworks)" > docker-compose.yml
