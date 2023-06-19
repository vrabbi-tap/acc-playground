# Installing A Full Profile Cluster
This folder provides all the configuration for a full profile cluster installation.

## Preperation
1. Update values.yaml file with you environment details
2. render the needed files
```bash
./prepare-files.sh
```
3. Create Pre Requisite Objects
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
3. Install TAP
```bash
VERSION=`yq e '.tapVersion' values.yaml`
tanzu package install tap -p tap.tanzu.vmware.com --version $VERSION --namespace tap-install --values-file cluster-config/tap-values.yaml
```
# Additional Steps