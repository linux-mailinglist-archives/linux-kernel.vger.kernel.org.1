Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42F22D939A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 08:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438928AbgLNHVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 02:21:18 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2526 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgLNHVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 02:21:18 -0500
Received: from dggeme770-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CvXpV4lVbzQqQ8;
        Mon, 14 Dec 2020 15:20:02 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme770-chm.china.huawei.com (10.3.19.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 14 Dec 2020 15:20:34 +0800
Subject: Re: [RFC PATCH] KVM: arm64: Add prejudgement for relaxing permissions
 only case in stage2 translation fault handler
To:     Will Deacon <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <zhukeqian1@huawei.com>, <yuzenghui@huawei.com>,
        <jiangkunkun@huawei.com>, <wangjingyi11@huawei.com>,
        <lushenming@huawei.com>
References: <20201211080115.21460-1-wangyanan55@huawei.com>
 <20201211080115.21460-2-wangyanan55@huawei.com>
 <20201211095337.GA11280@willie-the-truck>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <57550e15-77cb-6abc-328c-69a824a48446@huawei.com>
Date:   Mon, 14 Dec 2020 15:20:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201211095337.GA11280@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme770-chm.china.huawei.com (10.3.19.116)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/11 17:53, Will Deacon wrote:
> Hi Yanan,
>
> On Fri, Dec 11, 2020 at 04:01:15PM +0800, Yanan Wang wrote:
>> In dirty-logging, or dirty-logging-stopped time, even normal running
>> time of a guest configed with huge mappings and numbers of vCPUs,
>> translation faults by different vCPUs on the same GPA could occur
>> successively almost at the same time. There are two reasons for it.
>>
>> (1) If there are some vCPUs accessing the same GPA at the same time
>> and the leaf PTE is not set yet, then they will all cause translation
>> faults and the first vCPU holding mmu_lock will set valid leaf PTE,
>> and the others will later choose to update the leaf PTE or not.
>>
>> (2) When changing a leaf entry or a table entry with break-before-make,
>> if there are some vCPUs accessing the same GPA just catch the moment
>> when the target PTE is set invalid in a BBM procedure coincidentally,
>> they will all cause translation faults and will later choose to update
>> the leaf PTE or not.
>>
>> The worst case can be like this: some vCPUs cause translation faults
>> on the same GPA with different prots, they will fight each other by
>> changing back access permissions of the PTE with break-before-make.
>> And the BBM-invalid moment might trigger more unnecessary translation
>> faults. As a result, some useless small loops will occur, which could
>> lead to vCPU stuck.
>>
>> To avoid unnecessary update and small loops, add prejudgement in the
>> translation fault handler: Skip updating the valid leaf PTE if we are
>> trying to recreate exactly the same mapping or to reduce access
>> permissions only(such as RW-->RO). And update the valid leaf PTE without
>> break-before-make if we are trying to add more permissions only.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   arch/arm64/kvm/hyp/pgtable.c | 73 +++++++++++++++++++++++++-----------
>>   1 file changed, 52 insertions(+), 21 deletions(-)
> Cheers for this. Given that this patch is solving a few different problems,
> do you think you could split it up please? That would certainly make it much
> easier to review, as there's quite a lot going on here. A chunk of the
> changes seem to be the diff I posted previously:
>
> https://lore.kernel.org/r/20201201141632.GC26973@willie-the-truck
>
> so maybe that could be its own patch?
Yeah, I will split the diff into two patches at next version, thanks.
>
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index 23a01dfcb27a..f8b3248cef1c 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -45,6 +45,8 @@
>>   
>>   #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
>>   
>> +#define KVM_PTE_LEAF_ATTR_PERMS	(GENMASK(7, 6) | BIT(54))
> You only use this on the S2 path, so how about:
>
> #define KVM_PTE_LEAF_ATTR_S2_PERMS	KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
> 					KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
> 					KVM_PTE_LEAF_ATTR_HI_S2_XN
>
> or something like that?
Yes, it's more reasonable.
>>   struct kvm_pgtable_walk_data {
>>   	struct kvm_pgtable		*pgt;
>>   	struct kvm_pgtable_walker	*walker;
>> @@ -170,10 +172,9 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp)
>>   	smp_store_release(ptep, pte);
>>   }
>>   
>> -static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
>> -				   u32 level)
>> +static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
>>   {
>> -	kvm_pte_t old = *ptep, pte = kvm_phys_to_pte(pa);
>> +	kvm_pte_t pte = kvm_phys_to_pte(pa);
>>   	u64 type = (level == KVM_PGTABLE_MAX_LEVELS - 1) ? KVM_PTE_TYPE_PAGE :
>>   							   KVM_PTE_TYPE_BLOCK;
>>   
>> @@ -181,12 +182,7 @@ static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
>>   	pte |= FIELD_PREP(KVM_PTE_TYPE, type);
>>   	pte |= KVM_PTE_VALID;
>>   
>> -	/* Tolerate KVM recreating the exact same mapping. */
>> -	if (kvm_pte_valid(old))
>> -		return old == pte;
>> -
>> -	smp_store_release(ptep, pte);
>> -	return true;
>> +	return pte;
>>   }
>>   
>>   static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, u64 addr,
>> @@ -341,12 +337,17 @@ static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
>>   static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>   				    kvm_pte_t *ptep, struct hyp_map_data *data)
>>   {
>> +	kvm_pte_t new, old = *ptep;
>>   	u64 granule = kvm_granule_size(level), phys = data->phys;
>>   
>>   	if (!kvm_block_mapping_supported(addr, end, phys, level))
>>   		return false;
>>   
>> -	WARN_ON(!kvm_set_valid_leaf_pte(ptep, phys, data->attr, level));
>> +	/* Tolerate KVM recreating the exact same mapping. */
>> +	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
>> +	if (old != new && !WARN_ON(kvm_pte_valid(old)))
>> +		smp_store_release(ptep, new);
>> +
>>   	data->phys += granule;
>>   	return true;
>>   }
>> @@ -461,25 +462,56 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
>>   	return 0;
>>   }
>>   
>> +static bool stage2_set_valid_leaf_pte_pre(u64 addr, u32 level,
>> +					  kvm_pte_t *ptep, kvm_pte_t new,
>> +					  struct stage2_map_data *data)
>> +{
>> +	kvm_pte_t old = *ptep, old_attr, new_attr;
>> +
>> +	if ((old ^ new) & (~KVM_PTE_LEAF_ATTR_PERMS))
>> +		return false;
>> +
>> +	/*
>> +	 * Skip updating if we are trying to recreate exactly the same mapping
>> +	 * or to reduce the access permissions only. And update the valid leaf
>> +	 * PTE without break-before-make if we are trying to add more access
>> +	 * permissions only.
>> +	 */
>> +	old_attr = (old & KVM_PTE_LEAF_ATTR_PERMS) ^ KVM_PTE_LEAF_ATTR_HI_S2_XN;
>> +	new_attr = (new & KVM_PTE_LEAF_ATTR_PERMS) ^ KVM_PTE_LEAF_ATTR_HI_S2_XN;
>> +	if (new_attr <= old_attr)
>> +		return true;
> I think this is a significant change in behaviour for
> kvm_pgtable_stage2_map() and I worry that it could catch somebody out in the
> future. Please can you update the kerneldoc in kvm_pgtable.h with a note
> about this?
>
> Will
> .
