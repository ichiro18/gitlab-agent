# GitLab agent Helm chart

The official Helm chart for the client-side component (agentk) of the [GitLab agent for
Kubernetes](https://gitlab.com/gitlab-org/cluster-integration/gitlab-agent/).

For the server-side component (KAS), see the official [GitLab Helm chart](https://gitlab.com/gitlab-org/charts/gitlab)

## Getting started

### Install the latest stable release

```shell
helm repo add gitlab https://charts.gitlab.io
helm repo update
helm install gitlab/gitlab-agent gitlab-agent \
    --set config.kasAddress='wss://kas.gitlab.example.com' \
    --set config.token='YOUR.AGENT.TOKEN'
```

### Upgrade an existing release

```shell
helm repo update
helm upgrade gitlab/agent gitlab-agent --reuse-values
```

### Customize

See [`values.yaml`](./values.yaml).

### Install from source

``` shell
git clone https://gitlab.com/gitlab-org/charts/gitlab-agent.git
cd gitlab-agent
helm upgrade --install . gitlab-agent \
    --set config.kasAddress='wss://kas.gitlab.example.com' \
    --set config.token='YOUR.AGENT.TOKEN'
```

## Third-party trademarks

[Kubernetes](https://kubernetes.io/) is a registered trademark of The Linux Foundation.
