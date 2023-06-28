# Cloud Monitoring Exporter

A [Prometheus Exporter](https://prometheus.io/docs/instrumenting/exporters/#exporters-and-integrations) for [Google Cloud Monitoring](https://cloud.google.com/monitoring/) metrics.

# Features

* Export metrics from GCP Cloud Monitoring to Prometheus
* Simple configuration of metrics using metric type prefixes
* Auto discovery of resources via tags
* Adds any available dimension labels to metrics

# Configuration

## Authentication

The exporter is configured to use [Google Application Default Credentials](https://cloud.google.com/docs/authentication/production#automatically) to authenticate with Google Cloud Monitoring.

## Configuration

The exporter is configured using a YAML file. The following options are available:

### Required

| Option | Description |
|--------|-------------|
| `project_id` | The Google Cloud project ID to export metrics from. |
| `metric_type_prefixes` | A list of metric type prefixes to export. |

### Optional

| Option | Description |
|--------|-------------|
| `user_labels` | User-defined [labels](https://cloud.google.com/resource-manager/docs/creating-managing-labels) to filter on. |

### Example

```yaml
project_id: "massdriver"
metric_type_prefixes:
- "cloudsql.googleapis.com/database/cpu"
user_labels:
  environment: "prod"
```

# Scraping

By default, the exporter is exposed on port `9090`, path `/metrics`.

Metrics are queried at the time of scraping and are not cached.

To adhere to the [Prometheus data model](https://prometheus.io/docs/concepts/data_model/), metric names are converted to [snake case](https://en.wikipedia.org/wiki/Snake_case) and all non-alphanumeric characters are replaced with underscores.

For example, the metric `cloudsql.googleapis.com/database/cpu/utilization` will be exported as `cloudsql_googleapis_com_database_cpu_utilization`.

All metrics are exported as [gauges](https://prometheus.io/docs/concepts/metric_types/#gauge), and the #HELP comment is set to the metric's description as supplied by the [GCP Cloud Monitoring API](https://cloud.google.com/monitoring/api/v3).

# Deployment

Images for the exporter are available on [Docker Hub](https://hub.docker.com/r/massdrivercloud/cloud_monitoring_exporter).

An example [docker-compose](./docker-compose.yml) file is included in this repository. It requires a `config.yml` and GCP `credentials.json` in the directory.

After starting the exporter with `docker-compose up`, metrics will be available at `http://localhost:9090/metrics`.

The docker file can be used to deploy the exporter to any container runtime - we use [Kubernetes](https://kubernetes.io/).

# Missing Features

* Currently no support for Distributions.

# Questions?

If you have any questions or suggestions, please [open an issue](https://github.com/massdriver-cloud/cloud_monitoring_exporter/issues/new)! We'd love to hear from you.
