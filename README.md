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

Subir configuração da aplicação
````sh
kubectl apply -f aks/1-config
kubectl apply -f aks/2-db
kubectl apply -f aks/3-app
````

Instalar ElasticSearch
````sh
kubectl apply -f efk/01-namespace.yaml
kubectl apply -f efk/02-elastic-svc.yaml
kubectl apply -f efk/03-elastic-stateful.yaml
````

Instalar Fluentd
````sh
kubectl apply -f efk/04-fluentd-security.yaml
kubectl apply -f efk/05-fluentd-daemon.yaml
````

Instalar Kibana
````sh
kubectl apply -f efk/06-kibana-svc.yaml
kubectl apply -f efk/07-kibana-deployment.yaml
````

Acessar Kibana
````sh
kubectl port-forward --namespace kube-logging svc/kibana 5601:5601
````

Acessar a aplicação
````sh
curl http://springpetapp.eastus.cloudapp.azure.com/
````
