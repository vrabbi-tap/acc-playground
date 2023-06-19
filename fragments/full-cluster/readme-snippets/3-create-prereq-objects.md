  
## Create Pre Requisite Objects
```bash
kubectl create ns tap-install
REGISTRY=`yq e '.registryFqdn' values.yaml`
PROJECT=`yq e '.registryProject' values.yaml`
VERSION=`yq e '.tapVersion' values.yaml`
tanzu package repository add tap-repository -n tap-install --url $REGISTRY/$PROJECT/tap-packages:$VERSION
kubectl apply -f overlays/ -n tap-install
kubectl create ns tap-gui-backend
helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade --install tap-gui-db bitnami/postgresql -n tap-gui-backend -f cluster-config/tap-gui-db-values.yaml
```
  