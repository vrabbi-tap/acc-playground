

CLUSTER_NAME=`yq e '.clusterName' values.yaml`
REGISTRY=`yq e '.registryFqdn' values.yaml`
PROJECT=`yq e '.registryProject' values.yaml`
TECHDOCS_IMAGE_TAG=`yq e '.imageTags.techdocs' values.yaml`
DIND_IMAGE_TAG=`yq e '.imageTags.dind' values.yaml`
SOURCE_SCANNER=`yq e '.security.sourceScanner' values.yaml`
IMAGE_SCANNER=`yq e '.security.imageScanner' values.yaml`

# Create Overlay Directory
mkdir -p cluster-config/overlays

# Update Techdocs Overlay
cp overlays/techdocs-overlay.yaml cluster-config/overlays/techdocs-overlay.yaml
sed -i "s|TECHDOCS_IMAGE_PLACEHOLDER|$REGISTRY/$PROJECT/techdocs:$TECHDOCS_IMAGE_TAG|g" cluster-config/overlays/techdocs-overlay.yaml
sed -i "s|DIND_IMAGE_PLACEHOLDER|$REGISTRY/$PROJECT/docker:$DIND_IMAGE_TAG|g" cluster-config/overlays/techdocs-overlay.yaml

# Generate Files
ytt -f cluster-template.yaml --data-values-file values.yaml > cluster-config/tap-values.yaml
ytt -f tap-gui-db-values.yaml --data-values-file values.yaml > cluster-config/tap-gui-db-values.yaml
if [ "$SOURCE_SCANNER" == "prisma" ]; then
  ytt -f scanner/prisma-creds.yaml --data-values-file values.yaml > cluster-config/prisma-creds.yaml
  ytt -f scanner/prisma-pkgr.yaml --data-values-file values.yaml > cluster-config/prisma-pkgr.yaml
fi
if [ "$SOURCE_SCANNER" == "trivy" ]; then
  ytt -f scanner/trivy-pkgr.yaml --data-values-file values.yaml > cluster-config/trivy-pkgr.yaml
fi
if [ "$IMAGE_SCANNER" == "prisma" ]; then
  ytt -f scanner/prisma-creds.yaml --data-values-file values.yaml > cluster-config/prisma-creds.yaml
  ytt -f scanner/prisma-pkgr.yaml --data-values-file values.yaml > cluster-config/prisma-pkgr.yaml
fi
if [ "$IMAGE_SCANNER" == "trivy" ]; then
  ytt -f scanner/trivy-pkgr.yaml --data-values-file values.yaml > cluster-config/trivy-pkgr.yaml
fi
if [ "$IMAGE_SCANNER" == "snyk" ]; then
  ytt -f scanner/snyk-creds.yaml --data-values-file values.yaml > cluster-config/snyk-creds.yaml
fi
if [ "$IMAGE_SCANNER" == "cbc" ]; then
  ytt -f scanner/cbc-creds.yaml --data-values-file values.yaml > cluster-config/cbc-creds.yaml
fi