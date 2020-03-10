// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

#################
# VCN
#################
resource "oci_core_vcn" "this" {
  dns_label      = var.vcn_dns_label
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_display_name
}

######################
# Internet Gateway
######################
resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
}

######################
# Default Route Table
######################
resource "oci_core_default_route_table" "this" {
  manage_default_resource_id = oci_core_vcn.this.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}

######################
# Availability Domains
######################
data "oci_identity_availability_domains" "this" {
  compartment_id = var.compartment_ocid
}

######################
# Subnet
######################
resource "oci_core_subnet" "this" {
  count               = length(data.oci_identity_availability_domains.this.availability_domains)
  availability_domain = lookup(data.oci_identity_availability_domains.this.availability_domains[count.index], "name")
  cidr_block          = cidrsubnet(var.vcn_cidr, ceil(log(length(data.oci_identity_availability_domains.this.availability_domains) * 2, 2)), count.index)
  display_name        = "Default Subnet ${lookup(data.oci_identity_availability_domains.this.availability_domains[count.index], "name")}"
  dns_label           = "${var.subnet_dns_label}${count.index + 1}"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.this.id
  security_list_ids   = [oci_core_vcn.this.default_security_list_id]
}
