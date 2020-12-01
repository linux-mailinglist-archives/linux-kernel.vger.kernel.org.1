Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77A2CAD0A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404436AbgLAUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:09:26 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2080 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404423AbgLAUJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:09:25 -0500
Received: from dggeme720-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CltSb0XVfzVjpl;
        Wed,  2 Dec 2020 04:07:59 +0800 (CST)
Received: from [10.174.186.123] (10.174.186.123) by
 dggeme720-chm.china.huawei.com (10.1.199.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Dec 2020 04:08:42 +0800
Subject: Re: [RFC PATCH 1/3] KVM: arm64: Fix possible memory leak in kvm
 stage2
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
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-2-wangyanan55@huawei.com>
 <20201130132133.GA24837@willie-the-truck>
 <ef8f51d6-365b-8b05-0a10-5b4a242f6aa3@huawei.com>
 <20201201141632.GC26973@willie-the-truck>
 <1dbb71f2-a794-86ab-e1cc-ceb9c1e3dd37@huawei.com>
 <20201201181510.GA27955@willie-the-truck>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <775d2d78-1a59-f317-6eb4-045163240ae0@huawei.com>
Date:   Wed, 2 Dec 2020 04:08:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201181510.GA27955@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.186.123]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme720-chm.china.huawei.com (10.1.199.116)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/2 2:15, Will Deacon wrote:
> On Wed, Dec 02, 2020 at 01:19:35AM +0800, wangyanan (Y) wrote:
>> On 2020/12/1 22:16, Will Deacon wrote:
>>> On Tue, Dec 01, 2020 at 03:21:23PM +0800, wangyanan (Y) wrote:
>>>> On 2020/11/30 21:21, Will Deacon wrote:
>>>>> On Mon, Nov 30, 2020 at 08:18:45PM +0800, Yanan Wang wrote:
>>>>>> @@ -476,6 +477,7 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>>>>>     	/* There's an existing valid leaf entry, so perform break-before-make */
>>>>>>     	kvm_set_invalid_pte(ptep);
>>>>>>     	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
>>>>>> +	put_page(virt_to_page(ptep));
>>>>>>     	kvm_set_valid_leaf_pte(ptep, phys, data->attr, level);
>>>>>>     out:
>>>>>>     	data->phys += granule;
>>>>> Isn't this hunk alone sufficient to solve the problem?
>>>>>
>>>> Not sufficient enough. When the old ptep is valid and old pte equlas new
>>>> pte, in this case, "True" is also returned by kvm_set_valid_leaf_pte()
>>>>
>>>> and get_page() will still be called.
>>> I had a go at fixing this without introducing refcounting to the hyp stage-1
>>> case, and ended up with the diff below. What do you think?
>> Functionally this diff looks fine to me. A small comment inline, please see
>> below.
>>
>> I had made an alternative fix (after sending v1) and it looks much more
>> concise.
>>
>> If you're ok with it, I can send it as v2 (together with patch#2 and #3)
>> after some tests.
> Thanks.
>
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index 0271b4a3b9fe..b232bdd142a6 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -470,6 +470,9 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64
>> end, u32 level,
>>          if (!kvm_block_mapping_supported(addr, end, phys, level))
>>                  return false;
>>
>> +       if (kvm_pte_valid(*ptep))
>> +               put_page(virt_to_page(ptep));
>> +
>>          if (kvm_set_valid_leaf_pte(ptep, phys, data->attr, level))
>>                  goto out;
> This is certainly smaller, but see below.
>
>>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>>> index 0271b4a3b9fe..78e2c0dc47ae 100644
>>> --- a/arch/arm64/kvm/hyp/pgtable.c
>>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>>> @@ -170,23 +170,16 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp)
>>>    	smp_store_release(ptep, pte);
>>>    }
>>> -static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
>>> -				   u32 level)
>>> +static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
>>>    {
>>> -	kvm_pte_t old = *ptep, pte = kvm_phys_to_pte(pa);
>>> +	kvm_pte_t pte = kvm_phys_to_pte(pa);
>>>    	u64 type = (level == KVM_PGTABLE_MAX_LEVELS - 1) ? KVM_PTE_TYPE_PAGE :
>>>    							   KVM_PTE_TYPE_BLOCK;
>>>    	pte |= attr & (KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI);
>>>    	pte |= FIELD_PREP(KVM_PTE_TYPE, type);
>>>    	pte |= KVM_PTE_VALID;
>>> -
>>> -	/* Tolerate KVM recreating the exact same mapping. */
>>> -	if (kvm_pte_valid(old))
>>> -		return old == pte;
>>> -
>>> -	smp_store_release(ptep, pte);
>>> -	return true;
>>> +	return pte;
>>>    }
>>>    static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, u64 addr,
>>> @@ -341,12 +334,17 @@ static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
>>>    static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>>    				    kvm_pte_t *ptep, struct hyp_map_data *data)
>>>    {
>>> +	kvm_pte_t new, old = *ptep;
>>>    	u64 granule = kvm_granule_size(level), phys = data->phys;
>>>    	if (!kvm_block_mapping_supported(addr, end, phys, level))
>>>    		return false;
>>> -	WARN_ON(!kvm_set_valid_leaf_pte(ptep, phys, data->attr, level));
>>> +	/* Tolerate KVM recreating the exact same mapping. */
>>> +	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
>>> +	if (old != new && !WARN_ON(kvm_pte_valid(old)))
>>> +		smp_store_release(ptep, new);
>>> +
>>>    	data->phys += granule;
>>>    	return true;
>>>    }
>>> @@ -465,19 +463,24 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>>    				       kvm_pte_t *ptep,
>>>    				       struct stage2_map_data *data)
>>>    {
>>> +	kvm_pte_t new, old = *ptep;
>>>    	u64 granule = kvm_granule_size(level), phys = data->phys;
>>>    	if (!kvm_block_mapping_supported(addr, end, phys, level))
>>>    		return false;
>>> -	if (kvm_set_valid_leaf_pte(ptep, phys, data->attr, level))
>>> -		goto out;
>>> +	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
>>> +	if (kvm_pte_valid(old)) {
>>> +		/*
>>> +		 * There's an existing valid leaf entry, so perform
>>> +		 * break-before-make.
>>> +		 */
>>> +		kvm_set_invalid_pte(ptep);
>>> +		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
>>> +		put_page(virt_to_page(ptep));
>> When old PTE is valid and equals to the new one, we will also perform
>> break-before-make and the new PTE installation. But they're actually not
>> necessary in this case.
> Agreed, but I don't think that case should happen for stage-2 mappings.
> That's why I prefer my diff here, as it makes that 'old == new' logic
> specific to the hyp mappings.
>
> But I'll leave it all up to you (these diffs are only intended to be
> helpful).
>
> Will
> .

Hi Will,

In my opinion, the 'old == new' case might happen too in stage-2 
translation,  especially in the condition of concurrent access of 
multiple vCPUs.

For example, when merging tables into a block, we will perform 
break-before-make for a valid old PTE in function stage2_map_walk_pre().

If the other vCPUs are trying to access the same GPA range, so the MMUs 
will target at the same PTE as above, and they might just catch the moment

when the target PTE is set invalid in BBM by the vCPU holding the 
mmu_lock, but the old PTE will be updated to valid later.

As a result, translation fault will be triggered in these vCPUs, then 
they will wait for the mmu_lock to map exactly the *same* mapping (old 
== new).


Thanks,

Yanan

