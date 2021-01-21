Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCEF2FDE52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 02:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390654AbhAUA7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:59:12 -0500
Received: from foss.arm.com ([217.140.110.172]:34432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392596AbhAUAMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:12:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C383314FF;
        Wed, 20 Jan 2021 16:11:31 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD643F719;
        Wed, 20 Jan 2021 16:11:31 -0800 (PST)
Subject: Re: [PATCH v2] arm64: PCI: Enable SMC conduit
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        bhelgaas@google.com, robh@kernel.org, vidyas@nvidia.com,
        linux-kernel@vger.kernel.org
References: <20210113224054.1769514-1-jeremy.linton@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <9384ae26-1203-ab9d-c87b-b98028e6bd20@arm.com>
Date:   Wed, 20 Jan 2021 18:11:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113224054.1769514-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/13/21 4:40 PM, Jeremy Linton wrote:
> Given that most arm64 platforms' PCI implementations need quirks
> to deal with problematic config accesses, this is a good place
> to apply a firmware abstraction. The ARM PCI Configuration Space
> Access Firmware Interface specification details a standard SMC
> conduit designed to provide a simple PCI config accessor. This
> specification enhances the existing ACPI/PCI abstraction and
> expects power, config, etc., is handled by the platform. It also
> is very explicit that the resulting config space registers must
> behave as is specified by the PCI specification.
> 
> Hook the ACPI/PCI config path, and when missing MCFG data is
> detected, attempt to probe the SMC conduit. If the conduit
> exists and responds to the requested segment,  provided by the
> ACPI namespace, attach a custom pci_ecam_ops which redirects
> all config read/write requests to the firmware.
> 
> The Arm PCI Configuration Space Access Firmware Interface:
> https://developer.arm.com/documentation/den0115/latest
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/pci.c   | 109 ++++++++++++++++++++++++++++++++++++++
>   include/linux/arm-smccc.h |  29 ++++++++++
>   2 files changed, 138 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..bcbca70ef219 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> @@ -107,6 +108,112 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>   	return status;
>   }
>   
> +static int smccc_pcie_has_conduit(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
> +		return -EOPNOTSUPP;
> +
> +	arm_smccc_smc(SMCCC_PCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);

Its been pointed out to me that there is a better choice here than 
arm_smccc_smc() given the spec calls out HVC too.

So i'm retesting this with arm_smccc_1_1_invoke() replacing all the 
arm_smccc_smc() call sites.

Reposting in the near future.

Thanks,


> +	if ((int)res.a0 < 0)
> +		return -EOPNOTSUPP;
> +
> +	arm_smccc_smc(SMCCC_PCI_FEATURES,
> +		      SMCCC_PCI_WRITE, 0, 0, 0, 0, 0, 0, &res);
> +	if ((int)res.a0 < 0)
> +		return -EOPNOTSUPP;
> +
> +	arm_smccc_smc(SMCCC_PCI_FEATURES,
> +		      SMCCC_PCI_READ, 0, 0, 0, 0, 0, 0, &res);
> +	if ((int)res.a0 < 0)
> +		return -EOPNOTSUPP;
> +
> +	arm_smccc_smc(SMCCC_PCI_FEATURES,
> +		      SMCCC_PCI_SEG_INFO, 0, 0, 0, 0, 0, 0, &res);
> +	if ((int)res.a0 < 0)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int smccc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				  int where, int size, u32 *val)
> +{
> +	struct arm_smccc_res res;
> +
> +	devfn |= bus->number << 8;
> +	devfn |= bus->domain_nr << 16;
> +
> +	arm_smccc_smc(SMCCC_PCI_READ, devfn, where, size, 0, 0, 0, 0, &res);
> +	if (res.a0) {
> +		*val = ~0;
> +		return -PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	*val = res.a1;
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int smccc_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +				   int where, int size, u32 val)
> +{
> +	struct arm_smccc_res res;
> +
> +	devfn |= bus->number << 8;
> +	devfn |= bus->domain_nr << 16;
> +
> +	arm_smccc_smc(SMCCC_PCI_WRITE, devfn, where, size, val, 0, 0, 0, &res);
> +	if (res.a0)
> +		return -PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static const struct pci_ecam_ops smccc_pcie_ops = {
> +	.pci_ops	= {
> +		.read		= smccc_pcie_config_read,
> +		.write		= smccc_pcie_config_write,
> +	}
> +};
> +
> +static struct pci_config_window *
> +pci_acpi_setup_smccc_mapping(struct acpi_pci_root *root)
> +{
> +	struct device *dev = &root->device->dev;
> +	struct arm_smccc_res res;
> +	struct resource *bus_res = &root->secondary;
> +	struct pci_config_window *cfg;
> +	u16 seg = root->segment;
> +
> +	arm_smccc_smc(SMCCC_PCI_SEG_INFO, seg, 0, 0, 0, 0, 0, 0, &res);
> +	if ((int)res.a0 < 0) {
> +		pr_warn("PCI: SMC segment %d doesn't exist\n", seg);
> +		return NULL;
> +	}
> +
> +	if (FIELD_GET(SMCCC_PCI_SEG_INFO_START_BUS, res.a1) != bus_res->start ||
> +	    FIELD_GET(SMCCC_PCI_SEG_INFO_END_BUS, res.a1) != bus_res->end) {
> +		pr_warn("PCI: SMC segment %d doesn't match ACPI description\n", seg);
> +		return NULL;
> +	}
> +
> +	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return NULL;
> +
> +	cfg->parent = dev;
> +	cfg->ops = &smccc_pcie_ops;
> +	cfg->busr.start = bus_res->start;
> +	cfg->busr.end = bus_res->end;
> +	cfg->busr.flags = IORESOURCE_BUS;
> +	cfg->res.name = "PCI SMCCC";
> +
> +	pr_info("PCI: SMC conduit attached to segment %d\n", seg);
> +
> +	return cfg;
> +}
> +
>   /*
>    * Lookup the bus range for the domain in MCFG, and set up config space
>    * mapping.
> @@ -125,6 +232,8 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>   
>   	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
>   	if (ret) {
> +		if (!smccc_pcie_has_conduit())
> +			return pci_acpi_setup_smccc_mapping(root);
>   		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
>   		return NULL;
>   	}
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index f860645f6512..a1a8fe0ea5aa 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -89,6 +89,35 @@
>   
>   #define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
>   
> +/* PCI ECAM conduit (defined by ARM DEN0115A) */
> +#define SMCCC_PCI_VERSION						\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_STANDARD, 0x0130)
> +
> +#define SMCCC_PCI_FEATURES						\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_STANDARD, 0x0131)
> +
> +#define SMCCC_PCI_READ							\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_STANDARD, 0x0132)
> +
> +#define SMCCC_PCI_WRITE							\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_STANDARD, 0x0133)
> +
> +#define SMCCC_PCI_SEG_INFO						\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_STANDARD, 0x0134)
> +
> +#define SMCCC_PCI_SEG_INFO_START_BUS  GENMASK(7, 0)
> +#define SMCCC_PCI_SEG_INFO_END_BUS    GENMASK(15, 8)
> +
>   /* Paravirtualised time calls (defined by ARM DEN0057A) */
>   #define ARM_SMCCC_HV_PV_TIME_FEATURES				\
>   	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> 

