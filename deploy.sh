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
docker tag springapp:latest aulainfraacrk.azurecr.io/springapp:latest

# login no repositorio de imagem do Azure (privado)
az acr login --name aulainfraacrk

# subir imagem
docker push aulainfraacrk.azurecr.io/springapp:latest

# obter credenciais do AKS
az aks get-credentials --resource-group rg-aulainfra --name teste-aks  --overwrite-existing

# subir configuração da aplicação
kubectl apply -f aks/1-config

# subir configuração da aplicação
kubectl apply -f aks/2-db

# subir configuração da aplicação
kubectl apply -f aks/3-app

# instalar EFK
kubectl apply -f efk/01-namespace.yaml
kubectl apply -f efk/02-elastic-svc.yaml
kubectl apply -f efk/03-elastic-stateful.yaml
kubectl apply -f efk/04-fluentd-security.yaml
kubectl apply -f efk/05-fluentd-daemon.yaml
kubectl apply -f efk/06-kibana-svc.yaml
kubectl apply -f efk/07-kibana-deployment.yaml

# kubectl port-forward --namespace kube-logging svc/kibana 5601:5601
# curl http://springpetapp.eastus.cloudapp.azure.com/