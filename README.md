# Cloud Monitoring Exporter

A [Prometheus Exporter](https://prometheus.io/docs/instrumenting/exporters/#exporters-and-integrations) for [Google Cloud Monitoring](https://cloud.google.com/monitoring/) metrics.

# Features

* Export metrics from Google Cloud Monitoring to Prometheus
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
