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

Acessar a aplicação
````sh
curl http://springapp.eastus.cloudapp.azure.com/
````
