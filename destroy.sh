#!/bin/bash

# excluir namespace no Kubernetes
kubectl delete ns aulainfra

cd terraform

# destruir ambiente
terraform destroy -auto-approve
