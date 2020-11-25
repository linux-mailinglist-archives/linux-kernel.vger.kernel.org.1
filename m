Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA32C4746
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbgKYSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:10:25 -0500
Received: from foss.arm.com ([217.140.110.172]:35886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731956AbgKYSKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:10:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2DEE31B;
        Wed, 25 Nov 2020 10:10:23 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABD533F23F;
        Wed, 25 Nov 2020 10:10:22 -0800 (PST)
Subject: Re: [PATCH] iommu: arm-smmu-impl: add NXP hook to preserve
 bootmappings
To:     laurentiu.tudor@nxp.com, will@kernel.org, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com
References: <20201125155009.18453-1-laurentiu.tudor@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <30296756-9b8d-4851-87f0-8c4bd41110e9@arm.com>
Date:   Wed, 25 Nov 2020 18:10:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125155009.18453-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-25 15:50, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Add a NXP specific hook to preserve SMMU mappings present at
> boot time (created by the boot loader). These are needed for
> MC firmware present on some NXP chips to continue working
> across kernel boot and SMMU initialization.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 33 ++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index 7fed89c9d18a..ca07d9d4be69 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -187,6 +187,36 @@ static const struct arm_smmu_impl mrvl_mmu500_impl = {
>   	.reset = arm_mmu500_reset,
>   };
>   
> +static int nxp_cfg_probe(struct arm_smmu_device *smmu)
> +{
> +	int i, cnt = 0;
> +	u32 smr;
> +
> +	for (i = 0; i < smmu->num_mapping_groups; i++) {
> +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +
> +		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {

I bet this is fun over kexec...

Note that the Qualcomm special case got a bit of a free pass since it 
involves working around a totally broken hypervisor, plus gets to play 
the "nobody sane will run an enterprise distro on their phone" card to 
an extent; I don't think the likes of Layerscape kit get it quite so easy ;)

> +			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> +			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> +			smmu->smrs[i].valid = true;
> +
> +			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> +			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> +			smmu->s2crs[i].cbndx = 0xff;
> +
> +			cnt++;
> +		}
> +	}
> +
> +	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> +		   cnt == 1 ? "" : "s");

That gets you around the initial SMMU reset, but what happens for the 
arbitrarily long period of time between the MC device getting attached 
to a default domain and the MC driver actually probing and (presumably) 
being able to map and reinitialise its firmware?

> +
> +	return 0;
> +}
> +
> +static const struct arm_smmu_impl nxp_impl = {
> +	.cfg_probe = nxp_cfg_probe,
> +};

I believe you're mostly using MMU-500, so you probably don't want to 
simply throw out the relevant errata workarounds.

>   struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   {
> @@ -226,5 +256,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
>   		smmu->impl = &mrvl_mmu500_impl;
>   
> +	if (of_property_read_bool(np, "nxp,keep-boot-mappings"))
> +		smmu->impl = &nxp_impl;

Normally you'd get a "what about ACPI?" here, but given the number of 
calls and email threads we've had specifically about trying to make ACPI 
support for these platforms work, that gets upgraded to at least a "WHAT 
ABOUT ACPI!?" :P

But seriously, the case of device firmware in memory being active before 
handover to Linux is *literally* the original reason behind IORT RMRs. 
We already know we need a way to specify the equivalent thing for DT 
systems, such that both can be handled commonly. I really don't want to 
have to support a vendor-specific mechanism for not-even-fully-solving a 
completely generic issue, sorry.

Robin.

> +
>   	return smmu;
>   }
> 
