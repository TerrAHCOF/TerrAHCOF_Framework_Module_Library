<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_groups"></a> [resource\_groups](#module\_resource\_groups) | ../../resources/resource_groups | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | (Required) A list of Azure Resource Groups with locations and tags | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_groups"></a> [resource\_groups](#output\_resource\_groups) | The resource groups created by module |
<!-- END_TF_DOCS -->