# Relocating TAP Images
1. Create a project in harbor for TAP system images
2. Run the script relocate-images.sh to copy all TAP images to the local harbor instance
```bash
docker login <HARBOR_FQDN>
./scripts/relocate-all-images.sh <HARBOR_FQDN> <HARBOR_PROJECT_NAME>
```
