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
az aks get-credentials --resource-group rg-aulainfra --name teste-aks --overwrite-existing

# instalar Elastic Stack
kubectl apply -f elastic/01-namespace.yaml
kubectl apply -f elastic/02-elastic.yaml

sleep 180

kubectl apply -f elastic/03-kibana.yaml
kubectl apply -f elastic/04-filebeat.yaml

sleep 60

# subir configuração da aplicação
kubectl apply -f aks/1-config
kubectl apply -f aks/2-db
kubectl apply -f aks/3-app

# kubectl port-forward deployment/kibana 5601 -n kube-logging
# kubectl port-forward sts/elasticsearch-master 9200 -n kube-logging
# curl http://localhost:9200/_cat/indices?v
# curl http://springpetapp.westus.cloudapp.azure.com/