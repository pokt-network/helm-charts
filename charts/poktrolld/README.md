# Poktrolld Helm Chart

This Helm chart deploys a [Pocket Network](https://pokt.network/) full node (poktrolld) on Kubernetes.

## Quick Start

```yaml
# Minimal required configuration
config:
  network: "testnet-beta"  # REQUIRED: Specify which network to use
nodeKeysSecretName: "your-node-keys"  # Secret with node_key.json and priv_validator_key.json
```

## Introduction

This chart bootstraps a Pocket Network full node deployment on a Kubernetes cluster using the Helm package manager. The chart downloads the official network-specific configurations by default, requiring minimal setup to get started.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (for persistence)

## Installing the Chart

To install the chart with the release name `my-poktrolld`:

```bash
# Using a custom values file (recommended)
helm install my-poktrolld -f values.yaml .
```

Example values files can be found in the [examples](./examples) directory.

## REQUIRED Configuration

You must specify the network to use:

```yaml
config:
  network: "testnet-beta"  # Options: testnet-alpha, testnet-beta, mainnet
```

## Node Initialization Methods

This chart supports two methods for initializing a Pocket Network node:

1. **Genesis Sync**: The node will sync from block height 0. This is slower but verifies the entire chain history.

2. **Snapshot Sync** (recommended): The node will download and apply a recent snapshot, then sync from that height. This is much faster for getting a node operational.

### Using Snapshot Sync

To enable snapshot sync, add the following to your values file:

```yaml
snapshot:
  enabled: true
  # No need to specify network here, it uses config.network value
```

The chart uses torrent downloads and a Debian-based init container to fetch and apply the snapshot. This approach provides faster and more reliable downloads.

### Configuration Sources

The chart automatically downloads all necessary configuration files (genesis.json, app.toml, client.toml, config.toml) and seeds directly from the official Pocket Network genesis repository. This ensures your node uses the standard, tested configurations for each network.

If you need to use your own configurations (not recommended), you can disable the genesis repo download:

```yaml
genesisRepo:
  downloadConfigs: false
  
# Then provide your own ConfigMaps
externalConfigs:
  genesis:
    configMapName: "my-genesis-configmap"
  customConfigsConfigMap:
    enabled: true
    name: "my-configs-configmap"
```

See the [full-node-with-snapshot.yaml](./examples/full-node-with-snapshot.yaml) example for a complete configuration.

## Configuration

The following table lists the configurable parameters of the poktrolld chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.network` | **REQUIRED**: Network to use (testnet-alpha, testnet-beta, mainnet) | `""` |
| `config.p2p.seeds` | P2P seeds for node discovery | `""` |
| `config.chainID` | Chain ID for the node (auto-detected if empty) | `""` |
| `config.additionalArgs` | Additional command-line arguments | `[]` |
| `homeDirectory` | Home directory for poktrolld | `/root/.poktroll` |
| `nodeKeysSecretName` | Name of secret with node keys | `""` |
| `snapshot.enabled` | Enable snapshot syncing | `false` |
| `snapshot.baseUrl` | Base URL for snapshots | `https://snapshots.us-nj.poktroll.com` |
| `genesisRepo.downloadConfigs` | Download configs from genesis repo | `true` |
| `genesisRepo.branch` | Genesis repo branch | `master` |
| `genesisRepo.baseUrl` | Genesis repo base URL | `https://raw.githubusercontent.com/pokt-network/pocket-network-genesis` |
| `cosmovisor.enabled` | Enable Cosmovisor for auto-upgrades | `false` |
| `persistence.enabled` | Enable persistence | `true` |
| `persistence.size` | Size of persistent volume | `1Gi` |

For a full list of configuration options, please see [values.yaml](./values.yaml).

## Persistence

The chart mounts a Persistent Volume for storing blockchain data. This is required for running a full node.

## Required Resources

For a full node, we recommend:
- 4-8 CPU cores
- 16-32GB RAM
- 100GB+ disk space

## Examples

See the [examples](./examples) directory for deployment configurations:
- [full-node-with-snapshot.yaml](./examples/full-node-with-snapshot.yaml): Full node with snapshot sync enabled 