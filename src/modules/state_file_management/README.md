<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_state_file_management"></a> [state\_file\_management](#module\_state\_file\_management) | ../../resources/state_file_management | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_business_function"></a> [business\_function](#input\_business\_function) | Top level business function | `string` | `"PCS"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the resource is deployed. | `string` | `"australiaeast"` | no |
| <a name="input_location_short_name"></a> [location\_short\_name](#input\_location\_short\_name) | Short name for the the Azure region where the resource is deployed. | `string` | `"ae"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_state_file_storage_accounts"></a> [state\_file\_storage\_accounts](#input\_state\_file\_storage\_accounts) | All the storage accounts to be created. | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_state_file_storage_accounts"></a> [state\_file\_storage\_accounts](#output\_state\_file\_storage\_accounts) | The storage accounts created to store state files. |
<!-- END_TF_DOCS -->