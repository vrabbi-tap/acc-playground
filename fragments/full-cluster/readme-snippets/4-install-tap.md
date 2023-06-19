  
## Install TAP
```bash
VERSION=`yq e '.tapVersion' values.yaml`
tanzu package install tap -p tap.tanzu.vmware.com --version $VERSION --namespace tap-install --values-file cluster-config/tap-values.yaml
```  
  