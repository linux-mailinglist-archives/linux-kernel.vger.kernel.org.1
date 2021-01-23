Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8977C301476
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 11:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbhAWKJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 05:09:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11186 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbhAWKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 05:08:56 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DNBcN55h3zl7yC;
        Sat, 23 Jan 2021 18:06:44 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 18:08:05 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add support for BBML
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20201126034230.777-1-thunder.leizhen@huawei.com>
 <20210122125132.GB24102@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <aac11411-f6cd-f990-fe53-db0d8c07f3a0@huawei.com>
Date:   Sat, 23 Jan 2021 18:08:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210122125132.GB24102@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/22 20:51, Will Deacon wrote:
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
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
>>  drivers/iommu/io-pgtable-arm.c              | 46 ++++++++++++++++-----
>>  include/linux/io-pgtable.h                  |  1 +
>>  4 files changed, 40 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index e634bbe60573..14a1a11565fb 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1977,6 +1977,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>>  		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
>>  		.tlb		= &arm_smmu_flush_ops,
>>  		.iommu_dev	= smmu->dev,
>> +		.bbml		= smmu->bbml,
>>  	};
>>  
>>  	if (smmu_domain->non_strict)
>> @@ -3291,6 +3292,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>  
>>  	/* IDR3 */
>>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
>> +	smmu->bbml = FIELD_GET(IDR3_BBML, reg);
>>  	if (FIELD_GET(IDR3_RIL, reg))
>>  		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>>  
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index d4b7f40ccb02..aa7eb460fa09 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -51,6 +51,7 @@
>>  #define IDR1_SIDSIZE			GENMASK(5, 0)
>>  
>>  #define ARM_SMMU_IDR3			0xc
>> +#define IDR3_BBML			GENMASK(12, 11)
>>  #define IDR3_RIL			(1 << 10)
>>  
>>  #define ARM_SMMU_IDR5			0x14
>> @@ -617,6 +618,7 @@ struct arm_smmu_device {
>>  
>>  	int				gerr_irq;
>>  	int				combined_irq;
>> +	int				bbml;
>>  
>>  	unsigned long			ias; /* IPA */
>>  	unsigned long			oas; /* PA */
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index a7a9bc08dcd1..341581337ad0 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -72,6 +72,7 @@
>>  
>>  #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
>>  #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
>> +#define ARM_LPAE_PTE_nT			(((arm_lpae_iopte)1) << 16)
>>  #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
>>  #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
>>  #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
>> @@ -255,7 +256,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>  
>>  static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>  				phys_addr_t paddr, arm_lpae_iopte prot,
>> -				int lvl, arm_lpae_iopte *ptep)
>> +				int lvl, arm_lpae_iopte *ptep, arm_lpae_iopte nT)
>>  {
>>  	arm_lpae_iopte pte = prot;
>>  
>> @@ -265,37 +266,60 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>  		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
>>  
>>  	pte |= paddr_to_iopte(paddr, data);
>> +	pte |= nT;
>>  
>>  	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
>>  }
>>  
>> +static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
>> +				    arm_lpae_iopte *ptep);
>>  static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>  			     unsigned long iova, phys_addr_t paddr,
>>  			     arm_lpae_iopte prot, int lvl,
>>  			     arm_lpae_iopte *ptep)
>>  {
>>  	arm_lpae_iopte pte = *ptep;
>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>  
>>  	if (iopte_leaf(pte, lvl, data->iop.fmt)) {
>>  		/* We require an unmap first */
>>  		WARN_ON(!selftest_running);
>>  		return -EEXIST;
>>  	} else if (iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
>> -		/*
>> -		 * We need to unmap and free the old table before
>> -		 * overwriting it with a block entry.
>> -		 */
>>  		arm_lpae_iopte *tblp;
>> +		struct io_pgtable *iop = &data->iop;
>>  		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
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
> here. 

The old BBM is the use case of BBML=0. There's a very small window of time.
In arm_lpae_init_pte():
CPU side:                                                             SMMU side:
1) __arm_lpae_unmap()，unmap the table mapping and perform TLBI
                                                                      2) Some devices are accessing this memory, but the page table mapping is invalid. So triggers translation faults
3)__arm_lpae_init_pte(), create the block mapping

Above have been mentioned in SMMUv3 specification: 3.21.1.1 Translation tables update procedure
Note: The requirement for a break-before-make sequence can cause problems for unrelated I/O streams that might
use addresses overlapping a region of interest, because the I/O streams cannot always be conveniently stopped and
might not tolerate translation faults.

So the hardware introduces BBML=1 and BBML=2:
For BBML=1:
1) __arm_lpae_init_pte(data, paddr, prot, lvl, ptep, ARM_LPAE_PTE_nT);          //switch the mapping from table to block, but with bit nT=1
2) perform TLBI and free the table mapping memory
3) __arm_lpae_init_pte(data, paddr, prot, lvl, ptep, 0);			//clear nT bit.

Some devices may access the memory between 1) and 3), they correctly access the memory based on the nT=1 block mapping.
The nT=1 block mapping is not cached in theTLB, so after the table mapping has been invalidated, clear the nT bit.
After 3), the new memory access causes the block mapping to be cached in the TLB.

For BBML=2:
1) __arm_lpae_init_pte(data, paddr, prot, lvl, ptep, 0);
2) perform TLBI
3) free the table mapping memory

-----------------
| Page0 | Page1 |
-----------------
|     Block     |
-----------------
Assume that a device has accessed Page0 before 1）, so the TLB cached the 4K Page0 mapping. The a device accesses the Page1 after 1).
This time, the block mapping will be cached in the TLB. At this time, for 4K Page0, the TLB has two different mappings(4K and 2M).
A device accesses Page0 will trigger TLB conflict if BBML=2 is not supported. But now, the hardware choose either of the two mappings.
This is not a problem because the output addresses of both mapping translations are the same.

2) is added by me, clear the useless mappings in a timely manner, it's not required by BBML=2 specication.

> The dodgy case is when we unmap part of a block, and end up installing
> a table via arm_lpae_split_blk_unmap(). We can't use BBM there because there
> could be ongoing DMA to parts of the block mapping that we want to remain in
> place.
> 
> Are you seeing a problem in practice?
> 
> Will
> 
> .
> 

