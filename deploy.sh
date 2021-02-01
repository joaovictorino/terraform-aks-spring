az login

az ad sp create-for-rbac --skip-assignment

cd terraform

terraform init

terraform apply

az aks get-credentials --resource-group rg-aulainfra --name teste-aks

docker tag springapp:latest aulainfra.azurecr.io/springapp:v1

az acr login --name aulainfra

docker push aulainfra.azurecr.io/springapp:v1

cd ..

kubectl apply -f aks