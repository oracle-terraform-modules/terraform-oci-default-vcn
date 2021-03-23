// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

output "vcn_id" {
  description = "ocid of created VCN. "
  value       = module.vcn.vcn_id
}

output "default_security_list_id" {
  description = "ocid of default security list. "
  value       = module.vcn.default_security_list_id
}

output "default_dhcp_options_id" {
  description = "ocid of default DHCP options. "
  value       = module.vcn.default_dhcp_options_id
}

output "default_route_table_id" {
  description = "ocid of default route table. "
  value       = module.vcn.default_route_table_id
}

output "internet_gateway_id" {
  description = "ocid of internet gateway. "
  value       = module.vcn.internet_gateway_id
}

output "subnet_ids" {
  description = "ocid of subnet ids. "
  value       = module.vcn.subnet_ids
}
