#!/usr/bin/env bash

set -e

# TODO: Set to URL of git repo.
PROJECT_GIT_URL='https://github.com/CHANGEME.git'

PROJECT_BASE_PATH='/usr/local/apps/profiles-rest-api'

##echo "Installing dependencies..."
##apt-get update
##apt-get install -y python3-dev python3-venv sqlite python-pip supervisor nginx git
##
### Create project directory
##mkdir -p $PROJECT_BASE_PATH
##git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH
##
## Create virtual environment
#mkdir -p $PROJECT_BASE_PATH/env
#python3 -m venv $PROJECT_BASE_PATH/env
#
## Install python packages
#/usr/local/apps/profiles-rest-api/env/bin/pip install -r /usr/local/apps/profiles-rest-api/requirements.txt
#/usr/local/apps/profiles-rest-api/env/bin/pip install uwsgi==2.0.18

# Run migrations and collectstatic
#cd /usr/local/apps/profiles-rest-api
#$PROJECT_BASE_PATH/env/bin/python manage.py migrate
#$PROJECT_BASE_PATH/env/bin/python manage.py collectstatic --noinput

# Configure supervisor
cp /usr/local/apps/profiles-rest-api/deploy_v2/supervisor_profiles_api.conf /etc/supervisor/conf.d/profiles_api.conf
supervisorctl reread
supervisorctl update
supervisorctl restart profiles_api

# Configure nginx
cp /usr/local/apps/profiles-rest-api/deploy_v2/nginx_profiles_api.conf /etc/nginx/sites-available/profiles_api.conf
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/profiles_api.conf /etc/nginx/sites-enabled/profiles_api.conf
systemctl restart nginx.service

echo "DONE! :)"