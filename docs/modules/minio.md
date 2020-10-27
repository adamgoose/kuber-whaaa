## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.13 |
| helm | ~> 1.3 |
| kubernetes | ~> 1.13 |
| random | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hostname | Hostname to use for Minio | `string` | n/a | yes |
| namespace | Namespace in which to deploy Minio | `string` | `"minio"` | no |

## Outputs

| Name | Description |
|------|-------------|
| accessKey | n/a |
| secretKey | n/a |

