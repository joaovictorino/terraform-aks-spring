# Terraform criando Azure Kubernetes Service (AKS)

Pré-requisitos

- Az-cli instalado
- Terraform instalado

Logar no Azure via az-cli, o navegador será aberto para que o login seja feito

```sh
az login
```

Criar RBAC para acesso do AKS no Registry Docker, colocar no arquivo tfvars na primeira execução

```sh
az ad sp create-for-rbac
```

Inicializar o Terraform

```sh
terraform init
```

Executar o Terraform

```sh
terraform apply -auto-approve
```

Compilar imagem

```sh
docker build -t springapp .
```

Taggear a imagem com latest

```sh
docker tag springapp:latest springinfraacrk.azurecr.io/springapp:latest
```

Login no repositorio de imagem do Azure (privado)

```sh
az acr login --name springinfraacrk
```

Subir imagem

```sh
docker push springinfraacrk.azurecr.io/springapp:latest
```

Obter credenciais do AKS

```sh
az aks get-credentials --resource-group rg-springinfra --name teste-aks
```

Subir configuração da aplicação

```sh
kubectl apply -f aks/1-config
kubectl apply -f aks/2-db
kubectl apply -f aks/3-app
```

Acessar a aplicação

```sh
curl http://springpetapp.eastus.cloudapp.azure.com/
```
