# Multi Container Ruby App Helm Chart
## Introduction
This directory contains the necessary files required to install the MoJ Multi Container Ruby application via the Helm package manager. This application is intended to be used to demonstrate the ease of deployment on a MoJ Cloud Platform. 

Each component(API server, postgres database, worker, rails app) of this application is the subchart. 

For the local instance of the application you can run Postgres in an ephemeral docker container. Refer the postgres folder for installation instructions. 

When deploying to [cloud platform][cloudplatform] setup an RDS instance using the [terraform module] (https://github.com/ministryofjustice/cloud-platform-terraform-rds-instance) and set the $DATABASE_URL from the kubernetes secret created. 

## Installing the Chart
To install the chart:
```

multi-container-app/. --name multi-container-app --values multi-container-app/values.yaml --namespace starter-pack-2 --set global.postgresurl=
helm install multi-container-app/. \
  --name multi-container-app \
  --values values.yaml \
  --namespace <namespace-name> \
  --set global.postgresurl=$DATABASE_URL
```

The ```namespace-name``` here is the environment name (namespace) you've created in the [Creating a Cloud Platform Environment](https://ministryofjustice.github.io/cloud-platform-user-docs/cloud-platform/env-create/#creating-a-cloud-platform-environment) guide.

The ```DATABASE_URL``` can also be fetched from the [.env](https://github.com/ministryofjustice/cloud-platform-multi-container-demo-app/blob/master/.env) file.

There are a number of install switches available. Please visit the [Helm docs](https://docs.helm.sh/helm/#helm-install) for more information. 

## Deleting the Chart
To delete the installation from your cluster:
```
helm del --purge multi-container-app
```
## Configuration
| Parameter  | Description     | Default |
| ---------- | --------------- | ------- |
| `global.postgresurl` | Full database url as mentioned in .env file | `$DATABASE_URL` |

## Chart Structure
### Chart.yaml
The YAML for our chart. This contains our API version, chart description, name and version. 

### values.yaml
The default configuration values for this chart.

### charts/
A directory containing all subcharts upon which this chart depends.
