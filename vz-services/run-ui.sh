#!/bin/bash

docker run  -t vaultize/ui:15.x -v /opt/config:/opt/config -v /home/web:/root/vault-home
