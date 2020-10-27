## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.13 |
| helm | ~> 1.3 |
| kubernetes | ~> 1.13 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hostname | Hostname to use for NodeRED | `string` | n/a | yes |
| namespace | Namespace in which to deploy NodeRED | `string` | `"node-red"` | no |

## Outputs

No output.

