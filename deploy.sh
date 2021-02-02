az login

az ad sp create-for-rbac --skip-assignment

cd terraform

terraform init

terraform plan

terraform apply

az aks get-credentials --resource-group rg-aulainfra --name teste-aks

cd ..

docker build -t springapp .

docker tag springapp:latest aulainfraacr.azurecr.io/springapp:v1

docker tag springapp:latest aulainfraacr.azurecr.io/springapp:latest

az acr login --name aulainfraacr

docker push aulainfraacr.azurecr.io/springapp:v1

docker push aulainfraacr.azurecr.io/springapp:latest

kubectl apply -f aks/1-config

kubectl apply -f aks/2-db

kubectl apply -f aks/3-app

kubectl apply -f aks/4-ingress