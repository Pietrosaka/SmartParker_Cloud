#!/bin/bash

RESOURCE_GROUP="smartparker-rg"
VM_NAME="smartparker-vm"

echo "Deletando a máquina virtual $VM_NAME..."
az vm delete --resource-group $RESOURCE_GROUP --name $VM_NAME --yes

echo "Máquina virtual deletada."