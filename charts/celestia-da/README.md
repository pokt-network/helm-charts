# Celestia-DA Helm Chart

This is a fork of official [Celestia's Helm Chart](https://github.com/celestiaorg/celestia-helm-charts/tree/main/charts/node), since the original source repo has been archived.

This Helm chart also utilizes [celestia-da](https://github.com/rollkit/celestia-da), which is a wrapper on top of [celestia-node](https://github.com/celestiaorg/celestia-node). This is necessary to run Rollkit rollups, such as [poktroll](https://github.com/pokt-network/poktroll).

This helm chart is being utilized as a dependency for Pocket Network `poktrolld` Helm Chart to run a light node. Other versions (such as brigde or full) are not guaranteed to run. PRs are welcome!

### Run different type of node

There are 3 different types of Celestia Node: bridge, light and full nodes. The chart has only been thoroughly tested with a `light` node, since this is what Rollkit Rollups require.
You can deploy anyone of them setting the variable below:

```yaml
celestiaNode:
  type: <bridge|light|full>
```

### Import Celkey

1. [Set up](https://docs.celestia.org/developers/celestia-node-key#using-the-cel-key-utility) and use `cel-key` utility to [create a new address](https://docs.celestia.org/developers/celestia-node-key#steps-for-generating-node-keys) or [import an existing one](https://docs.celestia.org/developers/celestia-node-key#steps-for-importing-node-keys). As a result, you should get new files created on your file system:
   ```bash
   tree $HOME/.celestia-light-mocha-4/keys/keyring-test
    /Users/YOUR_USER/.celestia-light-mocha-4/keys/keyring-test
    ├── aed66f43d2373ee4eca81b16c2e39253d497ea78.address
    └── super-address.info
    ```
   
2. Import the files into Kubernetes Secrets (note: K8S secrets are not always encrypted - please verify your infrastructure is secure to avoid lost of tokens):
   ```bash
   kubectl create secret generic celestia-super-address --from-file=$HOME/.celestia-light-mocha-4/keys/keyring-test/aed66f43d2373ee4eca81b16c2e39253d497ea78.address --from-file=$HOME/.celestia-light-mocha-4/keys/keyring-test/super-address.info
   ```
   
3. Configure celestia to use that address by changing the following values for helm:
  ```yaml
  celestia-node:
    celestiaNode:
      celKey:
        enabled: true
        address:
          secretName: "celestia-super-address"
          fileName: "aed66f43d2373ee4eca81b16c2e39253d497ea78.address"
        validatorInfo:
          secretName: "celestia-super-address"
          fileName: "super-address.info"
  ```
