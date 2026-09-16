# DHIS2 Helm Chart

This repository contains the [dhis2](./charts/dhis2) Helm chart, which deploys DHIS 2 together with a CloudNativePG PostgreSQL cluster, an optional MinIO file store and an optional Doris analytics cluster.

The previous per-component `core` chart has been removed; its released versions remain available through the chart repository index for deployments pinned to them.

## Documentation

The documentation for the chart properties can be found [here](./charts/dhis2/README.md) and is generated using [helm-docs](https://github.com/norwoodj/helm-docs).

## Configuration

Ensure the `KUBECONFIG` environment variable is pointing to a valid Kubernetes configuration file.

If you don't have a cluster available, one can be created using [this](https://github.com/dhis2-sre/im-cluster) project.

The CloudNativePG operator must be installed on the cluster before the chart can deploy.

## Launch

```bash
skaffold dev
```

## Launch with MinIO

Set `storage.type: minio` and `minio.enabled: true` in [values/dhis2.yaml](./values/dhis2.yaml).

## Helm

The [dhis2 helm chart](./charts/dhis2) is published to
https://dhis2-sre.github.io/dhis2-core-chart

To install the chart you first need to add this chart repository

```sh
helm repo add dhis2 https://dhis2-sre.github.io/dhis2-core-chart
helm repo update
helm search repo dhis2/dhis2 --versions
```

The versions returned are gathered from [index.yaml](./index.yaml) which is
published to [this GitHub page](https://dhis2-sre.github.io/dhis2-core-chart/index.yaml).

### Release

Bump the version in [Chart.yaml](./charts/dhis2/Chart.yaml), commit and push.
**NOTE: do not create a tag yourself!**

Our release workflow will then using [Helm chart releaser action](https://github.com/helm/chart-releaser-action)

* create a tag `dhis2-<version>`
* create a [release](https://github.com/dhis2-sre/dhis2-core-chart/releases) associated with the new tag
* commit an updated index.yaml with the new release
* redeploy the GitHub pages to serve the new index.yaml

Note: there might be a slight delay between the release and the `index.yaml`
file being updated as GitHub pages have to be re-deployed.

## PostgreSQL image update in 1.1.0

The default database image keeps PostgreSQL major 17 and moves PostGIS from 3.5
to 3.6 on Debian Bookworm. Its pinned manifest includes Linux AMD64 and ARM64;
the system variant retains Barman Cloud tooling. The seed job and wait container
use the multiarchitecture `dhis2/postgresql-curl:17-legacy-r1` image.

Publish the seed image before releasing this chart. Existing installations
upgrading the operand image should follow CloudNativePG's minor-image update
procedure and update PostGIS extensions in each database as documented upstream;
the chart's bootstrap SQL only creates extensions for newly initialized clusters.
