# Terraform e Ansible criando Azure Kubernetes Service (AKS)

Pré-requisitos
- Az-cli instalado
- Terraform instalado

Logar no Azure via az-cli, o navegador será aberto para que o login seja feito
````sh
az login
````

Inicializar o Terraform
````sh
terraform init
````

Executar o Terraform
````sh
terraform apply -auto-approve
````

Compilar imagem
````sh
docker build -t springapp .
````

Taggear a imagem com latest
````sh
docker tag springapp:latest aulainfraacrk.azurecr.io/springapp:latest
````

Login no repositorio de imagem do Azure (privado)
````sh
az acr login --name aulainfraacrk
````

Subir imagem
````sh
docker push aulainfraacrk.azurecr.io/springapp:latest
````

Obter credenciais do AKS
````sh
az aks get-credentials --resource-group rg-aulainfra --name teste-aks
````

Instalar ElasticSearch
````sh
kubectl apply -f efk/01-namespace.yaml
kubectl apply -f efk/02-elastic.yaml
````

Instalar Kibana
````sh
kubectl apply -f efk/03-kibana.yaml
````

Instalar FileBeat
````sh
kubectl apply -f efk/04-filebeat.yaml
````

Subir configuração da aplicação
````sh
kubectl apply -f aks/1-config
kubectl apply -f aks/2-db
kubectl apply -f aks/3-app
````

Acessar Kibana e Elastic
````sh
kubectl port-forward deployment/kibana 5601 -n kube-logging
kubectl port-forward sts/elasticsearch-master 9200 -n kube-logging
curl http://localhost:9200/_cat/indices?v
````

Acessar a aplicação
````sh
curl http://springpetapp.eastus.cloudapp.azure.com/
````
