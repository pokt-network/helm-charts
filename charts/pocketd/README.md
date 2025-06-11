# pocketd

![Version: 0.1.5](https://img.shields.io/badge/Version-0.1.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.6](https://img.shields.io/badge/AppVersion-0.1.6-informational?style=flat-square)

A Helm chart for Kubernetes

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
```

2. Deploy or upgrade the chart:

```bash
helm upgrade --install pocketd ./charts/pocketd -f values.yaml
```

### How Snapshot Syncing Works

When snapshot syncing is enabled:

1. An init container checks if blockchain data already exists:
   - If data is found, the snapshot download is skipped (happens only once)
   - If no data exists, it installs necessary packages and downloads the snapshot

2. The snapshot init process:
   - Installs necessary packages (aria2c, zstd, etc.) at runtime
   - Fetches information about the latest snapshot for the selected network
   - Downloads the snapshot torrent using aria2c with optimized settings
   - Extracts the snapshot to the data directory
   - Records the version from the snapshot for cosmovisor to use

3. The cosmovisor init container will:
   - Check if cosmovisor is already initialized, and skip setup if it is
   - Check for the recorded snapshot version if needed
   - Download the binary matching that version if not present
   - Configure cosmovisor to use the correct binary version

4. When the node starts, it will continue syncing from the snapshot height instead of starting from genesis.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| chownDataDirTo | int | `1025` |  |
| config.p2p.externalAddress | string | `""` |  |
| config.p2p.persistentPeers | string | `""` |  |
| config.p2p.seedMode | bool | `false` |  |
| config.p2p.seeds | string | `""` |  |
| config.p2p.unconditionalPeerIds | string | `""` |  |
| config.unsafeSkipUpgrades | list | `[]` |  |
| containerSecurityContext.runAsGroup | int | `1025` |  |
| containerSecurityContext.runAsUser | int | `1025` |  |
| cosmovisor.allowDownloadBinaries | bool | `true` |  |
| cosmovisor.enabled | bool | `false` |  |
| cosmovisor.restartAfterUpgrade | bool | `true` |  |
| cosmovisor.unsafeSkipBackup | bool | `true` |  |
| customConfigsConfigMap.enabled | bool | `false` |  |
| customConfigsConfigMap.name | string | `""` |  |
| dnsConfig | object | `{}` |  |
| dnsPolicy | string | `"ClusterFirst"` |  |
| extraArgs | list | `[]` |  |
| extraEnvVars | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| genesis.configMapKey | string | `"genesis.json"` |  |
| genesis.configMapName | string | `""` |  |
| homeDirectory | string | `"/home/pocket/.pocket"` |  |
| hostNetwork | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/pokt-network/pocketd"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.api.annotations | object | `{}` |  |
| ingress.api.enabled | bool | `false` |  |
| ingress.api.hosts | list | `[]` |  |
| ingress.api.tls.secretName | string | `""` |  |
| ingress.grpc.annotations | object | `{}` |  |
| ingress.grpc.enabled | bool | `false` |  |
| ingress.grpc.hosts | list | `[]` |  |
| ingress.grpc.tls.secretName | string | `""` |  |
| ingress.rpc.annotations | object | `{}` |  |
| ingress.rpc.enabled | bool | `false` |  |
| ingress.rpc.hosts | list | `[]` |  |
| ingress.rpc.tls.secretName | string | `""` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | int | `26657` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `30` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| logs.format | string | `"plain"` |  |
| logs.level | string | `"info"` |  |
| nodeKeysSecretName | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.className | string | `""` |  |
| persistence.customName | string | `""` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.useCustomName | bool | `false` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podManagementPolicy | string | `"OrderedReady"` |  |
| podSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` |  |
| purpose | string | `"full-node"` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | int | `26657` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| removeUpgradeInfoOnStart | bool | `false` |  |
| resources | object | `{}` |  |
| service.ports.api | int | `1317` |  |
| service.ports.cometBFTMetrics | int | `26660` |  |
| service.ports.grpc | int | `9090` |  |
| service.ports.rpc | int | `26657` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceP2P.annotations | object | `{}` |  |
| serviceP2P.externalTrafficPolicy | string | `"Cluster"` |  |
| serviceP2P.internalTrafficPolicy | string | `"Cluster"` |  |
| serviceP2P.port | int | `26656` |  |
| serviceP2P.type | string | `"ClusterIP"` |  |
| snapshot.baseUrl | string | `"https://snapshots.us-nj.poktroll.com"` |  |
| snapshot.enabled | bool | `false` |  |
| snapshot.image.pullPolicy | string | `"IfNotPresent"` |  |
| snapshot.image.repository | string | `"ubuntu"` |  |
| snapshot.image.tag | string | `"22.04"` |  |
| snapshot.network | string | `"testnet-beta"` |  |
| startupProbe.enabled | bool | `true` |  |
| startupProbe.failureThreshold | int | `30` |  |
| startupProbe.httpGet.path | string | `"/"` |  |
| startupProbe.httpGet.port | int | `26657` |  |
| startupProbe.initialDelaySeconds | int | `0` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| terminationGracePeriodSeconds | int | `30` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| updateStrategy.type | string | `"RollingUpdate"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
