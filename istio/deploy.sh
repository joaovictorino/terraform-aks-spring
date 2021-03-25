# install istio on cluster
istioctl install

istioctl verify-install

kubectl label namespace default istio-injection=enabled

istioctl dashboard [kiali grafana prometheus]