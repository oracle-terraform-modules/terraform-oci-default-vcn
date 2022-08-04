# Oracle Cloud Infrastructure Default VCN Terraform Module

## :warning: End of Life notice :warning:

**This module, default-vcn, will not be updated anymore and will be removed from the registry by end of February 2021** :point_right: :wastebasket:

The OCI networking modules are going through a major refactoring and will be soon gathered under one umbrella: the *network* module and its suite of sub-modules will cover more use cases and facilitate [module composition](https://www.terraform.io/docs/language/modules/develop/composition.html).

This new "umbrella" module will start early March.

In the meantime, please consider the following alternatives:

- [The Resource Manager "Default VCN" Template](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Reference/templates.htm) which produce an output similair to this module
- [The official VCN module](https://registry.terraform.io/modules/oracle-terraform-modules/vcn/oci/latest) from Terraform Registry
- [The VCN Wizard](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/quickstartnetworking.htm) directly from OCI console

---

The Oracle Cloud Infrastructure Default VCN Module creates a basic Oracle Cloud Infrastructure Virtual Cloud Network (VCN) setup that can be used to get started quickly with Oracle Cloud Infrastructure and Terraform. The VCN contains a public subnet in each availability domain, with routing to an internet gateway.

By default, each subnet uses the default security list for the VCN. That default security list has a set of default rules - see [Security Lists](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/securitylists.htm#default-list) for details. By default, TCP traffic on destination port 22 (SSH) will be open from any source port. This will enable you to easily launch a Linux instance and connect via SSH. However, please note that by default Remote Desktop Protocol, RDP, will not be accessible. If you are using a Windows image, you have to add a stateful ingress rule for TCP traffic on destination port 3389 from any source port. The rules in the default security list can be modified in Terraform by using the `oci_core_default_security_list` resource - see [Default Resources](https://www.terraform.io/docs/providers/oci/guides/managing_default_resources.html).

For more information about Oracle Cloud Infrastructure VCNs and networking, see [VCNs and Subnets](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Tasks/managingVCNs.htm).

## Prerequisites

See the [Oracle Cloud Infrastructure Terraform Provider docs](https://www.terraform.io/docs/providers/oci/index.html) for information about setting up and using the Oracle Cloud Infrastructure Terraform Provider.

## How to use this module

The [examples](https://github.com/oracle-terraform-modules/terraform-oci-default-vcn/tree/master/examples/vcn_default) folder contains an example of how to use this module.


To create one VCN using this module:

```hcl
module "vcn" {
  source           = "oracle-terraform-modules/default-vcn/oci"
  compartment_ocid = "${var.compartment_ocid}"
  vcn_display_name = "${var.vcn_display_name}"
  vcn_cidr         = "${var.vcn_cidr}"
}

```

Argument | Description
--- | ---
compartment_ocid | Unique identifier (OCID) of the compartment in which the VCN is created
vcn_display_name | Dispaly name of Virtual Cloud Network
vcn_cidr |  The CIDR IP address block of the VCN
vcn_dns_label | A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet
subnet_dns_label | A DNS label prefix for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet


## Contributing

This project is open source. Oracle appreciates any contributions that are made by the open source community.

## License

Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

Licensed under the Universal Permissive License 1.0 or Apache License 2.0.

See [LICENSE](https://github.com/oracle-terraform-modules/terraform-oci-default-vcn/blob/master/LICENSE.txt) for more details.
