# login azure (primeira execução)
az login

# criar chaves de acesso ao Azure para o terraform (primeira execução)
az ad sp create-for-rbac --skip-assignment

cd terraform

# iniciar terraform (primeira execução)
terraform init

# planejar alterações
terraform plan

# alterar ambiente
terraform apply

# obter credenciais do AKS
az aks get-credentials --resource-group rg-aulainfra --name teste-aks

# compilar imagem
docker build -t springapp .

# taggear a imagem com latest
docker tag springapp:latest aulainfraacr.azurecr.io/springapp:latest

# login no repositorio de imagem do Azure (privado)
az acr login --name aulainfraacr

# subir imagem
docker push aulainfraacr.azurecr.io/springapp:latest

# subir configuração da aplicação
kubectl apply -f aks/1-config

# subir configuração da aplicação
kubectl apply -f aks/2-db

# subir configuração da aplicação
kubectl apply -f aks/3-app