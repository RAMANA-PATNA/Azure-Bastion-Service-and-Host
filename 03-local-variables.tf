## Local variables for vusiness devision
locals {
  owners = var.business_devision
  envirnoment = var.envirnoment
  resource_name_prefix  = "${var.business_devision}-${var.envirnoment}"
  # name = "${local.owners}-${local.envirnoment}"
  common_tags = {
    owners = local.owners
    envirnoment = local.envirnoment
  }
}