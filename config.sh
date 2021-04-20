#!/usr/bin/env bash

if [ $# -lt 4 ]
then
	echo "usage: ./config.sh mydomain.com users myorganization_name ldap_password"
        exit
fi
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ ! -f $SCRIPT_DIR/docker-compose.yml.bak ]
then
 cp $SCRIPT_DIR/docker-compose.yml $SCRIPT_DIR/docker-compose.yml.bak
fi


DOMAIN=$(echo $1 | cut -d. -f1)
DOMAIN_TLD=$(echo $1 | cut -d. -f2)
SUBDOMAIN_USERS_ADDRESS=$2
ORG_NAME=$3
LDAP_PASSWORD=$4

# The sed here prevents a slash
#PASSWORD=$(openssl rand -base64 32 | sed "s/\//#/g")

sed  -i -e "s/mydomain/$DOMAIN/g" -e "s/domtld/$DOMAIN_TLD/g" -e "s/subdomain/$SUBDOMAIN_USERS_ADDRESS/g" -e "s/MYORG/$ORG_NAME/g" -e "s/passToChange/$LDAP_PASSWORD/g" $SCRIPT_DIR/docker-compose.yml
