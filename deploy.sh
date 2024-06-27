#!/bin/bash

cd terraform

# iniciar terraform (primeira execução)
terraform init

# alterar ambiente
terraform apply -auto-approve

cd ..

# compilar imagem
docker build -t springapp .

# taggear a imagem com latest
docker tag springapp:latest springinfraacrk.azurecr.io/springapp:latest

# login no repositorio de imagem do Azure (privado)
az acr login --name springinfraacrk

# subir imagem
docker push springinfraacrk.azurecr.io/springapp:latest

# obter credenciais do AKS
az aks get-credentials --resource-group rg-springinfra --name teste-aks --overwrite-existing

# subir configuração da aplicação
kubectl apply -f aks/1-config
kubectl apply -f aks/2-db
kubectl apply -f aks/3-app

# curl http://springpetapp.eastus.cloudapp.azure.com/
