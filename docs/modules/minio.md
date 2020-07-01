## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubernetes | n/a |
| random | n/a |

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

