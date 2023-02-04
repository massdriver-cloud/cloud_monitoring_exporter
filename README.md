# AzureMetricsExporterProxy

A simple proxy that attaches a `subscription_id` to the request's query string before forwarding upstream.

We use this to proxy requests to the Azure Metrics Exporter without having to specify the subscription ID in the serviceMonitor's params.
