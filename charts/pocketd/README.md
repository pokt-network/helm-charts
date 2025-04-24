# Pocketd Helm Chart

This Helm chart deploys a Pocket Network node.

## Snapshot Support

This chart supports syncing from snapshots to speed up node initialization, similar to the functionality provided in the `full-node.sh` script.

### Using Snapshots with the Helm Chart

To enable snapshot syncing:

1. Set `snapshot.enabled` to `true` in your values file:

```yaml
snapshot:
  enabled: true
  network: "testnet-beta"  # Options: "testnet-alpha", "testnet-beta", "mainnet"
  baseUrl: "https://snapshots.us-nj.poktroll.com"
  image:
    repository: "ubuntu"  # Standard Ubuntu image (packages installed at runtime)
    tag: "22.04"
    pullPolicy: "IfNotPresent"
```

2. Deploy or upgrade the chart:

```bash
helm upgrade --install pocketd ./charts/pocketd -f values.yaml
```

### How Snapshot Syncing Works

When snapshot syncing is enabled:

1. An init container is added that:
   - Installs necessary packages (aria2c, zstd, etc.) at runtime
   - Fetches information about the latest snapshot for the selected network
   - Downloads the snapshot torrent using aria2c
   - Extracts the snapshot to the data directory
   - Records the version from the snapshot for cosmovisor to use

2. The cosmovisor init container will:
   - Check for the recorded snapshot version
   - Download the binary matching that version
   - Configure cosmovisor to use the correct binary version

3. When the node starts, it will continue syncing from the snapshot height instead of starting from genesis.

### Alternative: Using a Pre-built Image

While the default implementation installs required packages at runtime, you can also build a custom image with all necessary tools pre-installed:

```bash
cd charts/pocketd/snapshot
docker build -t yourrepo/pocketd-snapshot-tools:latest .
```

Then specify this image in your values file:

```yaml
snapshot:
  image:
    repository: "yourrepo/pocketd-snapshot-tools"
    tag: "latest"
```

This approach can reduce pod startup time by avoiding package installation at runtime.

## Additional Configuration

Refer to the values.yaml file for all available configuration options. 