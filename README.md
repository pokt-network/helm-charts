# Pocket Network Protocol helm-charts

Helm charts for deploying Pocket Network components on Kubernetes.

## Releasing a New Version

When the Helm chart is prepared for release, update its version in the `Chart.yaml` file. Adhere to [SemVer](https://semver.org/) guidelines for versioning. Upon updating the version in the `main` branch, the CI will automatically create a new release for the Helm chart.

Note on Multiple Updates: Updating several Helm chart versions simultaneously may cause CI failures, likely due to an issue with the [helm/chart-releaser-action](https://github.com/helm/chart-releaser-action) GitHub action. If this occurs, please report the issue for prompt troubleshooting and resolution.

