<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_management_group"></a> [management\_group](#module\_management\_group) | ../../resources/management_group | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_canary_required"></a> [canary\_required](#input\_canary\_required) | Boolean value to toggle the canary environment. | `bool` | `true` | no |
| <a name="input_management_groups"></a> [management\_groups](#input\_management\_groups) | List of management group in map structure for all MG groups. | `map(any)` | n/a | yes |
| <a name="input_root_id"></a> [root\_id](#input\_root\_id) | This is the root level ID which is equivalent to level 1 of the mg and it is the root level. | `string` | n/a | yes |
| <a name="input_root_parent_id"></a> [root\_parent\_id](#input\_root\_parent\_id) | This is the tenancy MG root ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_level_1_management_group_id"></a> [level\_1\_management\_group\_id](#output\_level\_1\_management\_group\_id) | The ID of the Level 1 Management Group |
| <a name="output_level_2_management_group_ids"></a> [level\_2\_management\_group\_ids](#output\_level\_2\_management\_group\_ids) | The ID's of the Level 2 Management Group |
| <a name="output_level_3_management_group_ids"></a> [level\_3\_management\_group\_ids](#output\_level\_3\_management\_group\_ids) | The ID's of the Level 3 Management Group |
| <a name="output_level_4_management_group_ids"></a> [level\_4\_management\_group\_ids](#output\_level\_4\_management\_group\_ids) | The ID's of the Level 4 Management Group |
<!-- END_TF_DOCS -->