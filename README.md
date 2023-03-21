# KubeCube

KubeCube is an open source enterprise-level container platform that provides enterprises with visualized management of Kubernetes resources and unified multi-cluster-multi-tenant management functions. KubeCube can simplify application deployment, manage application life cycles and provide rich monitoring and log auditing functions, helping companies quickly build a powerful and feature-rich container cloud platform.

## Prerequisites

- Kubernetes 1.16+
- helm v3+

## Get the Chart

To install the chart with the release name `kubecube` in namespace `kubecube-system`:

- download to local

Switch to the `root` directory of the repo.

```console
todo
```

- remote

First, add the kubecube chart repo to your local repository.

```console
$ helm repo add kubecube-chart https://raw.githubusercontent.com/kubecube-io/kubecube-chart/master
$ helm repo list
NAME            URL
kubecube-chart   https://raw.githubusercontent.com/karmada-io/kubecube/master/charts
```

With the repo added, available charts and versions can be viewed.

```console
helm search repo kubecube
```

Install the chart and specify the version to install with the --version argument. Replace <x.x.x> with your desired version.

```console
todo
```

> **Tip**: List all releases using `helm list`

## Install pivot cluster

Switch to the `root` directory of the repo. Then create `pivot-value.yaml` and set values as you wish.

```yaml
# pivot-value.yaml

global:
  # control-plane node IP which is used for exporting NodePort svc.
  nodeIP: x.x.x.x
  
  dependencesEnable:  
    ingressController: "false" # set "true" to deploy if ingress is not already in cluster.
    localPathStorage: "false"
    metricServer: "false"

  localKubeConfig: xx # local cluster kubeconfig base64
  pivotKubeConfig: xx # pivot cluster kubeconfig base64

warden:
  containers:
    warden:
      args:
        cluster: "pivot-cluster"  # set current cluster name
```

```console
helm install kubecube -n kubecube-system --create-namespace ./kubecube-chart -f ./pivot-value.yaml
```

## Install member cluster

Switch to the `root` directory of the repo. Then create `member-value.yaml` and set values as you wish.

```yaml
# member-value.yaml

global:
  # control-plane node IP which is used for exporting NodePort svc.
  nodeIP: x.x.x.x
  
  # set "true" to deploy if there were not already in cluster.
  dependencesEnable: 
    ingressController: "false"
    localPathStorage: "false"
    metricServer: "false"
    
  # modify values as bellow.
  componentsEnable:
    kubecube: "false"
    warden: "true"
    audit: "false"
    webconsole: "false"
    cloudshell: "false"
    frontend: "false"

  localKubeConfig: xx # local cluster kubeconfig base64
  pivotKubeConfig: xx # pivot cluster kubeconfig base64

warden:
  containers:
    warden:
      args:
        inMemberCluster: true
        cluster: "member-cluster"  # set current cluster name
```

```console
helm install kubecube -n kubecube-system --create-namespace ./kubecube-chart -f ./member-value.yaml
```

## Uninstalling the Chart
> **Note**: not found error can be ignored. 

Before helm uninstall
```console
kubectl delete validatingwebhookconfigurations kubecube-validating-webhook-configuration warden-validating-webhook-configuration kubecube-monitoring-admission
```

To uninstall/delete the `kubecube` helm release in namespace `kubecube-system`:

```console
helm uninstall kubecube -n kubecube-system
```

After helm uninstall: the command removes all the Kubernetes components associated with the chart and deletes the release.
> **Note**: There are some RBAC resources that are used by the `preJob` that can not be deleted by the `uninstall` command above. You might have to clean them manually with tools like `kubectl`.  You can clean them by commands:

```console
kubectl delete sa/kubecube-pre-job -n kubecube-system
kubectl delete clusterRole/kubecube-pre-job 
kubectl delete clusterRoleBinding/kubecube-pre-job
kubectl delete ns kubecube-system hnc-system kubecube-monitoring
```

### Configuration

# todo: complete params bellow.

### Global parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
|      |             |       |

### Common parameters

| Name | Description | Value |
| ---- | ----------- | ----- |
|      |             |       |