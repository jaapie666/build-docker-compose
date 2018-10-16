# build-docker-compose-yml.sh
# builds a docker-compose.yml file from individual service files

#!/bin/bash

echo Generating docker-compose.yml
buildservices()
{
    echo -e "services:\n\n$(cat ./services/calibre-web.yml)"
}

buildvolumes()
{
    echo -e "volumes:\n  certs:\n  vhost.d:\n  html:"
}

buildnetworks()
{
    echo -e "networks:\n"
}


echo -e "#  Copied from https://blog.ssdnodes.com/blog/self-hosting-handbook-a-docker-compose-tutorial/
#  Slightly modified to allow for automatic configuration with environment variables\n\nversion: '2'\n\n$(buildservices)\n\n$(buildvolumes)\n\n$(buildnetworks)" > docker-compose.yml


if [ "$1" == '-t' ]
then
  echo Substituting environment variables
  ./vartest.sh
fi
