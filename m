Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA12209CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgGOKUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 06:20:42 -0400
Received: from foss.arm.com ([217.140.110.172]:35072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbgGOKUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:20:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 320B930E;
        Wed, 15 Jul 2020 03:20:41 -0700 (PDT)
Received: from [10.57.32.45] (unknown [10.57.32.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A073F718;
        Wed, 15 Jul 2020 03:20:39 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] iommu/arm-smmu: Call configuration impl hook
 before consuming features
To:     Tomasz Nowicki <tn@semihalf.com>, will@kernel.org, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
References: <20200715070649.18733-1-tn@semihalf.com>
 <20200715070649.18733-2-tn@semihalf.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <def8aa82-bcca-b209-a6b4-81725fc4fbdb@arm.com>
Date:   Wed, 15 Jul 2020 11:20:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715070649.18733-2-tn@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-15 08:06, Tomasz Nowicki wrote:
> 'cfg_probe' hook is called at the very end of configuration probing
> procedure and therefore features override and workaround may become
> complex like for ID register fixups. In preparation for adding Marvell
> errata move 'cfg_probe' a bit earlier to have chance to adjust
> the detected features before we start consuming them.
> 
> Since the Cavium quirk (the only user) does not alter features
> it is safe to do so.

Sorry for the confusion of failing to match my own intent in the first 
place ;)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>   drivers/iommu/arm-smmu.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 243bc4cb2705..19f906de6420 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1728,7 +1728,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   	unsigned int size;
>   	u32 id;
>   	bool cttw_reg, cttw_fw = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
> -	int i;
> +	int i, ret;
>   
>   	dev_notice(smmu->dev, "probing hardware configuration...\n");
>   	dev_notice(smmu->dev, "SMMUv%d with:\n",
> @@ -1891,6 +1891,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
>   	}
>   
> +	if (smmu->impl && smmu->impl->cfg_probe) {
> +		ret = smmu->impl->cfg_probe(smmu);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	/* Now we've corralled the various formats, what'll it do? */
>   	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH32_S)
>   		smmu->pgsize_bitmap |= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
> @@ -1918,9 +1924,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
>   			   smmu->ipa_size, smmu->pa_size);
>   
> -	if (smmu->impl && smmu->impl->cfg_probe)
> -		return smmu->impl->cfg_probe(smmu);
> -
>   	return 0;
>   }
>   
> 
