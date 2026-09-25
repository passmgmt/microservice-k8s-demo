# Microservice K8s Demo Context Diagram

This diagram shows the application, delivery pipeline, Kubernetes runtime, and supporting platform components.

```mermaid
flowchart LR
    Client[Client / Postman / Browser]

    subgraph Development[Local Development]
        Source[Source Code Repository]
        Maven[Maven Build and Tests]
        Docker[Docker Engine]
        Scripts[Build, Deploy, and Port-Forward Scripts]
    end

    subgraph Delivery[CI/CD and GitOps]
        Actions[GitHub Actions CI/CD]
        Registry[Container Registry\nGHCR or another OCI registry]
        ArgoCD[ArgoCD\nOptional GitOps Sync]
    end

    subgraph Cluster[Kubernetes Cluster]
        Ingress[NGINX Ingress Controller]
        Service[Kubernetes Service\nClusterIP]
        Namespace[Namespace\nmicroservice-demo]
        Deployment[Helm-managed Deployment]
        Pods[Spring Boot Microservice Pods]
        HPA[Horizontal Pod Autoscaler]
        MetricsServer[Metrics Server]
    end

    subgraph Observability[Observability]
        Actuator[Spring Boot Actuator\nHealth and Prometheus Metrics]
        Monitoring[Prometheus / Grafana\nor Datadog]
    end

    Client -->|HTTP request| Ingress
    Ingress -->|Routes traffic| Service
    Service -->|Load balances| Pods
    Pods -->|Health checks and metrics| Actuator
    Actuator -->|Metrics and logs| Monitoring

    Source -->|Push or pull request| Actions
    Actions -->|Maven test| Maven
    Actions -->|Build and publish image| Registry
    Registry -->|Image pull| Pods

    Source -->|Helm chart and manifests| ArgoCD
    ArgoCD -->|Optional sync| Namespace
    ArgoCD -->|Deploy release| Deployment

    Maven -->|Build artifact| Docker
    Docker -->|Local image| Pods
    Scripts -->|Build and deploy| Docker
    Scripts -->|Helm install or upgrade| Deployment
    Scripts -->|Port forward for local access| Service

    Deployment -->|Creates| Pods
    Namespace -->|Contains| Ingress
    Namespace -->|Contains| Service
    Namespace -->|Contains| Deployment
    Namespace -->|Contains| HPA

    MetricsServer -->|CPU utilization| HPA
    HPA -->|Scale replicas| Deployment
```

## Component Responsibilities

| Component | Responsibility |
| --- | --- |
| Client | Sends requests to the REST API. |
| Spring Boot Microservice | Handles `/api/v1/greetings` requests and exposes Actuator endpoints. |
| Docker Engine | Builds and runs the application container locally. |
| GitHub Actions | Runs tests, builds the image, publishes it, and validates the Helm chart. |
| Container Registry | Stores images for Kubernetes to pull. |
| NGINX Ingress | Provides external HTTP routing into the cluster. |
| Kubernetes Service | Provides stable internal networking and load balancing for pods. |
| Helm Deployment | Defines the application pods, probes, resources, and image configuration. |
| HPA | Adjusts pod replicas based on CPU utilization. |
| Metrics Server | Supplies resource metrics used by the HPA. |
| Actuator | Provides health, readiness, liveness, and Prometheus metrics endpoints. |
| Prometheus/Grafana or Datadog | Collects and visualizes application and infrastructure telemetry. |
| ArgoCD | Optionally synchronizes Kubernetes resources from Git. |
