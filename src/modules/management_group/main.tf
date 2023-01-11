module "management_group" {
    source            = "../../resources/management_group"
    root_id           = var.root_id
    root_parent_id    = var.root_parent_id
    management_groups = var.management_groups
    canary_required   = var.canary_required
}