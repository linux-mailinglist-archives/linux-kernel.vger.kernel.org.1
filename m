Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF62C9539
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgLACbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:31:31 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2471 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLACbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:31:31 -0500
Received: from dggeme715-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ClR0872RLz4yWX;
        Tue,  1 Dec 2020 10:30:16 +0800 (CST)
Received: from [10.174.186.123] (10.174.186.123) by
 dggeme715-chm.china.huawei.com (10.1.199.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 1 Dec 2020 10:30:41 +0800
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into a
 block entry
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
 <20201130121847.91808-3-wangyanan55@huawei.com>
 <20201130133421.GB24837@willie-the-truck>
 <67e9e393-1836-eca7-4235-6f4a19fed652@huawei.com>
 <20201130160119.GA25051@willie-the-truck>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <868a4403-10d3-80f3-4ae1-a490813c55e2@huawei.com>
Date:   Tue, 1 Dec 2020 10:30:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130160119.GA25051@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.186.123]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme715-chm.china.huawei.com (10.1.199.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/12/1 0:01, Will Deacon wrote:
> Hi,
>
> Cheers for the quick reply. See below for more questions...
>
> On Mon, Nov 30, 2020 at 11:24:19PM +0800, wangyanan (Y) wrote:
>> On 2020/11/30 21:34, Will Deacon wrote:
>>> On Mon, Nov 30, 2020 at 08:18:46PM +0800, Yanan Wang wrote:
>>>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>>>> index 696b6aa83faf..fec8dc9f2baa 100644
>>>> --- a/arch/arm64/kvm/hyp/pgtable.c
>>>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>>>> @@ -500,6 +500,9 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>>>>    	return 0;
>>>>    }
>>>> +static void stage2_flush_dcache(void *addr, u64 size);
>>>> +static bool stage2_pte_cacheable(kvm_pte_t pte);
>>>> +
>>>>    static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>>>>    				struct stage2_map_data *data)
>>>>    {
>>>> @@ -507,9 +510,17 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>>>>    	struct page *page = virt_to_page(ptep);
>>>>    	if (data->anchor) {
>>>> -		if (kvm_pte_valid(pte))
>>>> +		if (kvm_pte_valid(pte)) {
>>>> +			kvm_set_invalid_pte(ptep);
>>>> +			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu,
>>>> +				     addr, level);
>>>>    			put_page(page);
>>> This doesn't make sense to me: the page-table pages we're walking when the
>>> anchor is set are not accessible to the hardware walker because we unhooked
>>> the entire sub-table in stage2_map_walk_table_pre(), which has the necessary
>>> TLB invalidation.
>>>
>>> Are you seeing a problem in practice here?
>> Yes, I indeed find a problem in practice.
>>
>> When the migration was cancelled, a TLB conflic abort  was found in guest.
>>
>> This problem is fixed before rework of the page table code, you can have a
>> look in the following two links:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c3736cd32bf5197aed1410ae826d2d254a5b277
>>
>> https://lists.cs.columbia.edu/pipermail/kvmarm/2019-March/035031.html
> Ok, let's go through this, because I still don't see the bug. Please correct
> me if you spot any mistakes:
>
>    1. We have a block mapping for X => Y
>    2. Dirty logging is enabled, so the block mapping is write-protected and
>       ends up being split into page mappings
>    3. Dirty logging is disabled due to a failed migration.
>
> --- At this point, I think we agree that the state of the MMU is alright ---
>
>    4. We take a stage-2 fault and want to reinstall the block mapping:
>
>       a. kvm_pgtable_stage2_map() is invoked to install the block mapping
>       b. stage2_map_walk_table_pre() finds a table where we would like to
>          install the block:
>
> 	i.   The anchor is set to point at this entry
> 	ii.  The entry is made invalid
> 	iii. We invalidate the TLB for the input address. This is
> 	     TLBI IPAS2SE1IS without level hint and then TLBI VMALLE1IS.
>
> 	*** At this point, the page-table pointed to by the old table entry
> 	    is not reachable to the hardware walker ***
>
>       c. stage2_map_walk_leaf() is called for each leaf entry in the
>          now-unreachable subtree, dropping page-references for each valid
> 	entry it finds.
>       d. stage2_map_walk_table_post() is eventually called for the entry
>          which we cleared back in b.ii, so we install the new block mapping.
>
> You are proposing to add additional TLB invalidation to (c), but I don't
> think that is necessary, thanks to the invalidation already performed in
> b.iii. What am I missing here?

The point is at b.iii where the TLBI is not enough. There are many page 
mappings that we need to merge into a block mapping.

We invalidate the TLB for the input address without level hint at b.iii, 
but this operation just flush TLB for one page mapping, there

are still some TLB entries for the other page mappings in the cache, the 
MMU hardware walker can still hit these entries next time.


Maybe we can imagine a concrete example here. If we now need to merge 
page mappings into a 1G block mapping, and the

fault_ipa to user_mem_abort() is 0x225043000, after ALIGNMENT to 1G, the 
input address will be 0x200000000, then the TLBI

operation at b.iii will invalidate the TLB entry for address 
0x200000000. But what about address 0x200001000 , 0x200002000 ... ?

After the installing of 1G block mapping is finished, when the fault_ipa 
is 0x200007000, MMU can still hit the TLB entry for page

mapping in the cache and can also access memory through the new block entry.


So adding TLBI operation in stage2_map_walk_leaf() aims to invalidate 
TLB entries for all the page mappings that will be merged.

In this way, after installing of block mapping, MMU can only access 
memory through the new block entry.

>>>> +			if (stage2_pte_cacheable(pte))
>>>> +				stage2_flush_dcache(kvm_pte_follow(pte),
>>>> +						    kvm_granule_size(level));
>>> I don't understand the need for the flush either, as we're just coalescing
>>> existing entries into a larger block mapping.
>> In my opinion, after unmapping, it is necessary to ensure the cache
>> coherency, because it is unknown whether the future mapping memory attribute
>> is changed or not (cacheable -> non_cacheable) theoretically.
> But in this case we're just changing the structure of the page-tables,
> not the pages which are mapped, are we?
>
> Will
> .

Yes, there is not a condition for now that cache attributes will be 
changed in this case.

Maybe this part of dcache flush can be cut.


Yanan

