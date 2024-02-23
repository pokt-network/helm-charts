# Poktrolld / Pocket on Rollkit

<!-- Note on each Poktrolld sequencer / full node needing to have it's own celestia node (light is fine) -->

## (Optional) import a key with an address

This is only needed for those running a sequencer. Full node operators can skip this step.

In order to post blocks on Celestia network, an address with TIA tokens is required. To import a private key for that address, you need to perform the following steps:

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