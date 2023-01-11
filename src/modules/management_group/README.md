<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name                                                                                | Source                           | Version |
| ----------------------------------------------------------------------------------- | -------------------------------- | ------- |
| <a name="module_management_group"></a> [management_group](#module_management_group) | ../../resources/management_group | n/a     |

## Resources

No resources.

## Inputs

| Name                                                                                 | Description                                                                                  | Type       | Default | Required |
| ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- | ---------- | ------- | :------: |
| <a name="input_canary_required"></a> [canary_required](#input_canary_required)       | Boolean value to toggle the canary environment.                                              | `bool`     | `true`  |    no    |
| <a name="input_management_groups"></a> [management_groups](#input_management_groups) | List of management group in map structure for all MG groups.                                 | `map(any)` | n/a     |   yes    |
| <a name="input_root_id"></a> [root_id](#input_root_id)                               | This is the root level ID which is equivalent to level 1 of the mg and it is the root level. | `string`   | n/a     |   yes    |
| <a name="input_root_parent_id"></a> [root_parent_id](#input_root_parent_id)          | This is the tenancy MG root ID.                                                              | `string`   | n/a     |   yes    |

## Outputs

| Name                                                                                                                    | Description                              |
| ----------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| <a name="output_level_1_management_group_id"></a> [level_1_management_group_id](#output_level_1_management_group_id)    | The ID of the Level 1 Management Group   |
| <a name="output_level_2_management_group_ids"></a> [level_2_management_group_ids](#output_level_2_management_group_ids) | The ID's of the Level 2 Management Group |
| <a name="output_level_3_management_group_ids"></a> [level_3_management_group_ids](#output_level_3_management_group_ids) | The ID's of the Level 3 Management Group |
| <a name="output_level_4_management_group_ids"></a> [level_4_management_group_ids](#output_level_4_management_group_ids) | The ID's of the Level 4 Management Group |

<!-- END_TF_DOCS -->
