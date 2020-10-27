## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.13 |
| digitalocean | ~> 2.0 |
| helm | ~> 1.3 |
| kubernetes | ~> 1.13 |
| kustomization | ~> 0.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| do\_token | Digital Ocean API Token | `string` | n/a | yes |
| domain | Domain at which to deploy your magic | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| minio | Get the generated Minio credentials |

