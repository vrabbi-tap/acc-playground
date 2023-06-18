#!/bin/bash

TAP_VERSION=`yq e '.tapVersion' values.yaml`
TBS_DEPS_VERSION=`yq e '.imageTags.tbsDeps' values.yaml`
DIND_IMAGE_TAG=`yq e '.imageTags.dind' values.yaml`
TECHODCS_IMAGE_TAG=`yq e '.imageTags.techdocs' values.yaml`
PSQL_IMAGE_TAG=`yq e '.imageTags.postgresql' values.yaml`
BITNAMI_SHELL_IMAGE_TAG=`yq e '.imageTags.bitnamiShell' values.yaml`
PSQL_EXPORTER_IMAGE_TAG=`yq e '.imageTags.postgresExporter' values.yaml`

imgpkg copy registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:$TAP_VERSION --to-repo $1/$2/tap-packages
imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/full-tbs-deps-package-repo:$TBS_DEPS_VERSION --to-repo $1/$2/full-tbs-deps-package-repo

docker pull ghcr.io/vrabbi/docker:$DIND_IMAGE_TAG
docker tag ghcr.io/vrabbi/docker:$DIND_IMAGE_TAG $1/$2/docker:$DIND_IMAGE_TAG
docker push $1/$2/docker:$DIND_IMAGE_TAG

docker pull spotify/techdocs:$TECHODCS_IMAGE_TAG
docker tag spotify/techdocs:$TECHODCS_IMAGE_TAG $1/$2/techdocs:$TECHODCS_IMAGE_TAG
docker push $1/$2/techdocs:$TECHODCS_IMAGE_TAG

docker pull bitnami/postgresql:$PSQL_IMAGE_TAG
docker tag bitnami/postgresql:$PSQL_IMAGE_TAG $1/$2/postgresql:$PSQL_IMAGE_TAG
docker push $1/$2/postgresql:$PSQL_IMAGE_TAG

docker pull bitnami/bitnami-shell:$BITNAMI_SHELL_IMAGE_TAG
docker tag bitnami/bitnami-shell:$BITNAMI_SHELL_IMAGE_TAG $1/$2/bitnami-shell:$BITNAMI_SHELL_IMAGE_TAG
docker push $1/$2/bitnami-shell:$BITNAMI_SHELL_IMAGE_TAG

docker pull bitnami/postgres-exporter:$PSQL_EXPORTER_IMAGE_TAG
docker tag bitnami/postgres-exporter:$PSQL_EXPORTER_IMAGE_TAG $1/$2/postgres-exporter:$PSQL_EXPORTER_IMAGE_TAG
docker push $1/$2/postgres-exporter:$PSQL_EXPORTER_IMAGE_TAG