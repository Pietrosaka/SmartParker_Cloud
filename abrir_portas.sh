#!/bin/bash

RESOURCE_GROUP="smartparker-rg"
VM_NAME="smartparker-vm"
HTTP_PORT=80
HTTPS_PORT=443
APP_PORT=8080 # Ajuste se sua aplicação usa outra porta

echo "Abrindo a porta $HTTP_PORT para HTTP..."
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --priority 1002 --port $HTTP_PORT

echo "Abrindo a porta $HTTPS_PORT para HTTPS..."
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --priority 1003 --port $HTTPS_PORT

echo "Abrindo a porta $APP_PORT para a aplicação..."
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --priority 1004 --port $APP_PORT

