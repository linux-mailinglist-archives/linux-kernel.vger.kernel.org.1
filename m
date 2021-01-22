Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18783003AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbhAVNBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:01:50 -0500
Received: from foss.arm.com ([217.140.110.172]:46582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbhAVNBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:01:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B3211B3;
        Fri, 22 Jan 2021 05:00:46 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 609D53F66E;
        Fri, 22 Jan 2021 05:00:45 -0800 (PST)
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add support for BBML
To:     Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20201126034230.777-1-thunder.leizhen@huawei.com>
 <20210122125132.GB24102@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <34a9c164-389d-30cd-11a3-8796eb7bca93@arm.com>
Date:   Fri, 22 Jan 2021 13:00:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122125132.GB24102@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-22 12:51, Will Deacon wrote:
> On Thu, Nov 26, 2020 at 11:42:30AM +0800, Zhen Lei wrote:
>> When changing from a set of pages/smaller blocks to a larger block for an
>> address, the software should follow the sequence of BBML processing.
>>
>> When changing from a block to a set of pages/smaller blocks for an
>> address, there's no need to use nT bit. If an address in the large block
>> is accessed before page table switching, the TLB caches the large block
>> mapping. After the page table is switched and before TLB invalidation
>> finished, new access requests are still based on large block mapping.
>> After the block or page is invalidated, the system reads the small block
>> or page mapping from the memory; If the address in the large block is not
>> accessed before page table switching, the TLB has no cache. After the
>> page table is switched, a new access is initiated to read the small block
>> or page mapping from the memory.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
>>   drivers/iommu/io-pgtable-arm.c              | 46 ++++++++++++++++-----
>>   include/linux/io-pgtable.h                  |  1 +
>>   4 files changed, 40 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index e634bbe60573..14a1a11565fb 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1977,6 +1977,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>>   		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
>>   		.tlb		= &arm_smmu_flush_ops,
>>   		.iommu_dev	= smmu->dev,
>> +		.bbml		= smmu->bbml,
>>   	};
>>   
>>   	if (smmu_domain->non_strict)
>> @@ -3291,6 +3292,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>   
>>   	/* IDR3 */
>>   	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
>> +	smmu->bbml = FIELD_GET(IDR3_BBML, reg);
>>   	if (FIELD_GET(IDR3_RIL, reg))
>>   		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>>   
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index d4b7f40ccb02..aa7eb460fa09 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -51,6 +51,7 @@
>>   #define IDR1_SIDSIZE			GENMASK(5, 0)
>>   
>>   #define ARM_SMMU_IDR3			0xc
>> +#define IDR3_BBML			GENMASK(12, 11)
>>   #define IDR3_RIL			(1 << 10)
>>   
>>   #define ARM_SMMU_IDR5			0x14
>> @@ -617,6 +618,7 @@ struct arm_smmu_device {
>>   
>>   	int				gerr_irq;
>>   	int				combined_irq;
>> +	int				bbml;
>>   
>>   	unsigned long			ias; /* IPA */
>>   	unsigned long			oas; /* PA */
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index a7a9bc08dcd1..341581337ad0 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -72,6 +72,7 @@
>>   
>>   #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
>>   #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
>> +#define ARM_LPAE_PTE_nT			(((arm_lpae_iopte)1) << 16)
>>   #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
>>   #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
>>   #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
>> @@ -255,7 +256,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>   
>>   static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>   				phys_addr_t paddr, arm_lpae_iopte prot,
>> -				int lvl, arm_lpae_iopte *ptep)
>> +				int lvl, arm_lpae_iopte *ptep, arm_lpae_iopte nT)
>>   {
>>   	arm_lpae_iopte pte = prot;
>>   
>> @@ -265,37 +266,60 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>   		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
>>   
>>   	pte |= paddr_to_iopte(paddr, data);
>> +	pte |= nT;
>>   
>>   	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
>>   }
>>   
>> +static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
>> +				    arm_lpae_iopte *ptep);
>>   static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>   			     unsigned long iova, phys_addr_t paddr,
>>   			     arm_lpae_iopte prot, int lvl,
>>   			     arm_lpae_iopte *ptep)
>>   {
>>   	arm_lpae_iopte pte = *ptep;
>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>   
>>   	if (iopte_leaf(pte, lvl, data->iop.fmt)) {
>>   		/* We require an unmap first */
>>   		WARN_ON(!selftest_running);
>>   		return -EEXIST;
>>   	} else if (iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
>> -		/*
>> -		 * We need to unmap and free the old table before
>> -		 * overwriting it with a block entry.
>> -		 */
>>   		arm_lpae_iopte *tblp;
>> +		struct io_pgtable *iop = &data->iop;
>>   		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>   
>> -		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>> -		if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
>> -			WARN_ON(1);
>> -			return -EINVAL;
>> +		switch (cfg->bbml) {
>> +		case 0:
>> +			/*
>> +			 * We need to unmap and free the old table before
>> +			 * overwriting it with a block entry.
>> +			 */
>> +			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>> +			if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
>> +				WARN_ON(1);
>> +				return -EINVAL;
>> +			}
>> +			break;
>> +		case 1:
>> +			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep, ARM_LPAE_PTE_nT);
>> +
>> +			io_pgtable_tlb_flush_walk(iop, iova, sz, ARM_LPAE_GRANULE(data));
>> +			tblp = iopte_deref(pte, data);
>> +			__arm_lpae_free_pgtable(data, lvl + 1, tblp);
>> +			break;
>> +		case 2:
>> +			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep, 0);
>> +
>> +			io_pgtable_tlb_flush_walk(iop, iova, sz, ARM_LPAE_GRANULE(data));
>> +			tblp = iopte_deref(pte, data);
>> +			__arm_lpae_free_pgtable(data, lvl + 1, tblp);
>> +			return 0;
> 
> Sorry, but I really don't understand what you're trying to do here. The old
> code uses BBM for the table -> block path so we don't need anything extra
> here. The dodgy case is when we unmap part of a block, and end up installing
> a table via arm_lpae_split_blk_unmap(). We can't use BBM there because there
> could be ongoing DMA to parts of the block mapping that we want to remain in
> place.
> 
> Are you seeing a problem in practice?

Right, I was under the assumption that we could ignore BBML because we 
should never have a legitimate reason to split blocks. I'm certainly not 
keen on piling any more complexity into split_blk_unmap, because the 
IOMMU API clearly doesn't have a well-defined behaviour for that case 
anyway - some other drivers will just unmap the entire block, and IIRC 
there was a hint somewhere in VFIO that it might actually expect that 
behaviour.

Robin.
