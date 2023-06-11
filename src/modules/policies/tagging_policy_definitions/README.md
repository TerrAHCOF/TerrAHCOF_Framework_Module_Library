<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tagging_policy_definitions"></a> [tagging\_policy\_definitions](#module\_tagging\_policy\_definitions) | ../../../resources/policies/tagging_policy_definitions | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_mandatory_tag_names"></a> [mandatory\_tag\_names](#input\_mandatory\_tag\_names) | List of mandatory tag names used by tagging policies | `list(string)` | n/a | yes |
| <a name="input_mandatory_tags_with_value_rules"></a> [mandatory\_tags\_with\_value\_rules](#input\_mandatory\_tags\_with\_value\_rules) | List of mandatory tags used that require value rules (e.g. not allowed values) | `list(string)` | n/a | yes |
| <a name="input_policy_definition_scope_id"></a> [policy\_definition\_scope\_id](#input\_policy\_definition\_scope\_id) | The Management Group ID that the policies are defined under. | `string` | n/a | yes |
| <a name="input_policy_files_directory_path"></a> [policy\_files\_directory\_path](#input\_policy\_files\_directory\_path) | Directory path for all of the policy json files. | `string` | `"policy_files"` | no |
| <a name="input_tag_values_not_allowed"></a> [tag\_values\_not\_allowed](#input\_tag\_values\_not\_allowed) | list of tag values that are not allowed | `list(string)` | <pre>[<br>  "",<br>  "NA",<br>  "N/A",<br>  "tbc",<br>  "'tbc'",<br>  "TBC",<br>  "to_be_confirmed",<br>  "to be confirmed"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_inheritTagValuesFromRG_policy_definition"></a> [inheritTagValuesFromRG\_policy\_definition](#output\_inheritTagValuesFromRG\_policy\_definition) | The policy definition defined for inheritTagValuesFromRG |
| <a name="output_inheritTagsFromRG_policy_definition"></a> [inheritTagsFromRG\_policy\_definition](#output\_inheritTagsFromRG\_policy\_definition) | The policy definition defined for inheritTagsFromRG |
| <a name="output_requireTagsOnRG_policy_definition"></a> [requireTagsOnRG\_policy\_definition](#output\_requireTagsOnRG\_policy\_definition) | The policy definition for requireTagsOnRG |
| <a name="output_tagsWithValueRules_policy_definition"></a> [tagsWithValueRules\_policy\_definition](#output\_tagsWithValueRules\_policy\_definition) | The policy definition defined for tagsWithValueRules |
<!-- END_TF_DOCS -->