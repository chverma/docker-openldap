#!/usr/bin/env bash

if [ $# -lt 3 ]
then
	echo "usage: ./config.sh mydomain.com users myorganization_name"
        exit
fi
DOMAIN=$(echo $1 | cut -d. -f1)
DOMAIN_TLD=$(echo $1 | cut -d. -f2)
SUBDOMAIN_USERS_ADDRESS=$2
ORG_NAME=$3
# The sed here prevents a slash
PASSWORD=$(openssl rand -base64 32 | sed "s/\//#/g")

sed  -e "s/mydomain/$DOMAIN/g" -e "s/domtld/$DOMAIN_TLD/g" -e "s/subdomain/$SUBDOMAIN_USERS_ADDRESS/g" -e "s/MYORG/$ORG_NAME/g" -e "s/passToChange/$PASSWORD/g" docker-compose.yml
