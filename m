Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6179B2C87F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgK3PZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:25:20 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2514 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgK3PZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:25:20 -0500
Received: from dggeme714-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Cl8Cc3cd9zQmCs;
        Mon, 30 Nov 2020 23:24:12 +0800 (CST)
Received: from [10.174.186.123] (10.174.186.123) by
 dggeme714-chm.china.huawei.com (10.1.199.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 30 Nov 2020 23:24:33 +0800
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
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <67e9e393-1836-eca7-4235-6f4a19fed652@huawei.com>
Date:   Mon, 30 Nov 2020 23:24:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130133421.GB24837@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.186.123]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggeme714-chm.china.huawei.com (10.1.199.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/30 21:34, Will Deacon wrote:
> On Mon, Nov 30, 2020 at 08:18:46PM +0800, Yanan Wang wrote:
>> In dirty logging case(logging_active == True), we need to collapse a block
>> entry into a table if necessary. After dirty logging is canceled, when merging
>> tables back into a block entry, we should not only free the non-huge page
>> tables but also unmap the non-huge mapping for the block. Without the unmap,
>> inconsistent TLB entries for the pages in the the block will be created.
>>
>> We could also use unmap_stage2_range API to unmap the non-huge mapping,
>> but this could potentially free the upper level page-table page which
>> will be useful later.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   arch/arm64/kvm/hyp/pgtable.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index 696b6aa83faf..fec8dc9f2baa 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -500,6 +500,9 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>>   	return 0;
>>   }
>>   
>> +static void stage2_flush_dcache(void *addr, u64 size);
>> +static bool stage2_pte_cacheable(kvm_pte_t pte);
>> +
>>   static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>>   				struct stage2_map_data *data)
>>   {
>> @@ -507,9 +510,17 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>>   	struct page *page = virt_to_page(ptep);
>>   
>>   	if (data->anchor) {
>> -		if (kvm_pte_valid(pte))
>> +		if (kvm_pte_valid(pte)) {
>> +			kvm_set_invalid_pte(ptep);
>> +			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu,
>> +				     addr, level);
>>   			put_page(page);
> This doesn't make sense to me: the page-table pages we're walking when the
> anchor is set are not accessible to the hardware walker because we unhooked
> the entire sub-table in stage2_map_walk_table_pre(), which has the necessary
> TLB invalidation.
>
> Are you seeing a problem in practice here?

Yes, I indeed find a problem in practice.

When the migration was cancelled, a TLB conflic abort  was found in guest.

This problem is fixed before rework of the page table code, you can have 
a look in the following two links:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c3736cd32bf5197aed1410ae826d2d254a5b277

https://lists.cs.columbia.edu/pipermail/kvmarm/2019-March/035031.html

>> +			if (stage2_pte_cacheable(pte))
>> +				stage2_flush_dcache(kvm_pte_follow(pte),
>> +						    kvm_granule_size(level));
> I don't understand the need for the flush either, as we're just coalescing
> existing entries into a larger block mapping.

In my opinion, after unmapping, it is necessary to ensure the cache 
coherency, because it is unknown whether the future mapping memory 
attribute is changed or not (cacheable -> non_cacheable) theoretically.

> Will
> .
