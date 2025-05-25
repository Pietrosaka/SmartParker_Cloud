#!/bin/bash

RESOURCE_GROUP="smartparker-rg"
VM_NAME="smartparker-vm"
LOCATION="eastus" # Escolha uma região
IMAGE="UbuntuLTS"
SIZE="Standard_DS1_v2"
ADMIN_USERNAME="mottuadmin"
ADMIN_PASSWORD="Fiap@2tdsvms"

echo "Criando o grupo de recursos $RESOURCE_GROUP na região $LOCATION..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Criando a máquina virtual $VM_NAME..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image $IMAGE \
  --size $SIZE \
  --admin-username $ADMIN_USERNAME \
  --admin-password $ADMIN_PASSWORD

echo "VM criada com sucesso! Anote o IP público para acesso SSH."
az vm show --resource-group $RESOURCE_GROUP --name $VM_NAME --show-details --query publicIps -o tsv









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

