#!/bin/bash

dock_img=("centos" "debian" "fedora")

for c_name in "${dock_img[@]}"; do
  res=$( docker container inspect -f '{{.State.Running}}' "$c_name" )
  echo Res is "$res"
  if [ "$( docker container inspect -f '{{.State.Running}}' "$c_name" )" = "true" ]; then
    echo "Container $c_name is found"
  else
    echo "Starting container $c_name"
    docker run -dt --name "$c_name" "$c_name"
  fi
done

ansible-playbook --ask-vault-pass -i inventory/prod.yml site.yml

docker stop $(docker ps -q)
docker rm $(docker ps -aq)