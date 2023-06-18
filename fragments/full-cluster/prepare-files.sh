
# Update Techdocs Overlay
CLUSTER_NAME=`yq e '.clusterName' values.yaml`
REGISTRY=`yq e '.registryFqdn' values.yaml`
PROJECT=`yq e '.registryProject' values.yaml`
TECHDOCS_IMAGE_TAG=`yq e '.imageTags.techdocs' values.yaml`
DIND_IMAGE_TAG=`yq e '.imageTags.dind' values.yaml`
mkdir -p cluster-config/overlays
cp overlays/techdocs-overlay.yaml cluster-config/overlays/techdocs-overlay.yaml
sed -i "s|TECHDOCS_IMAGE_PLACEHOLDER|$REGISTRY/$PROJECT/techdocs:$TECHDOCS_IMAGE_TAG|g" cluster-config/overlays/techdocs-overlay.yaml
sed -i "s|DIND_IMAGE_PLACEHOLDER|$REGISTRY/$PROJECT/docker:$DIND_IMAGE_TAG|g" cluster-config/overlays/techdocs-overlay.yaml

ytt -f cluster-template.yaml --data-values-file values.yaml > cluster-config/tap-values.yaml
ytt -f tap-gui-db-values.yaml --data-values-file values.yaml > cluster-config/tap-gui-db-values.yaml
