## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.13 |
| digitalocean | ~> 2.0 |
| local | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubernetes\_version | Digitalocean Kubernetes Version of the cluster | `string` | `"1.17.5-do.0"` | no |
| name | Name of the cluster | `string` | n/a | yes |
| node\_count | Number of nodes in the default node pool | `number` | `2` | no |
| node\_size | Size of the nodes in the default node pool | `string` | `"s-2vcpu-2gb"` | no |
| region | Digitalocean Region of the cluster | `string` | `"nyc1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
| kube\_config | n/a |

