Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7B2C980E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgLAHWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:22:18 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2323 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgLAHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:22:17 -0500
Received: from dggeme715-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ClYRF2cLqz13P90;
        Tue,  1 Dec 2020 15:20:41 +0800 (CST)
Received: from [10.174.186.123] (10.174.186.123) by
 dggeme715-chm.china.huawei.com (10.1.199.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 1 Dec 2020 15:21:24 +0800
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
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <ef8f51d6-365b-8b05-0a10-5b4a242f6aa3@huawei.com>
Date:   Tue, 1 Dec 2020 15:21:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130132133.GA24837@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.186.123]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggeme715-chm.china.huawei.com (10.1.199.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/11/30 21:21, Will Deacon wrote:
> On Mon, Nov 30, 2020 at 08:18:45PM +0800, Yanan Wang wrote:
>> When installing a new leaf pte onto an invalid ptep, we need to get_page(ptep).
>> When just updating a valid leaf ptep, we shouldn't get_page(ptep).
>> Incorrect page_count of translation tables might lead to memory leak,
>> when unmapping a stage 2 memory range.
> Did you find this by inspection, or did you hit this in practice? I'd be
> interested to see the backtrace for mapping over an existing mapping.

Actually this is found by inspection.

In the current code, get_page() will uniformly called at "out_get_page" 
in function stage2_map_walk_leaf(),

no matter the old ptep is valid or not.

When using stage2_unmap_walker() API to unmap a memory range, some 
page-table pages might not be

freed if page_count of the pages is not right.

>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   arch/arm64/kvm/hyp/pgtable.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index 0271b4a3b9fe..696b6aa83faf 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -186,6 +186,7 @@ static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
>>   		return old == pte;
>>   
>>   	smp_store_release(ptep, pte);
>> +	get_page(virt_to_page(ptep));
> This is also used for the hypervisor stage-1 page-table, so I'd prefer to
> leave this function as-is.
I agree at this point.
>>   	return true;
>>   }
>>   
>> @@ -476,6 +477,7 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>   	/* There's an existing valid leaf entry, so perform break-before-make */
>>   	kvm_set_invalid_pte(ptep);
>>   	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
>> +	put_page(virt_to_page(ptep));
>>   	kvm_set_valid_leaf_pte(ptep, phys, data->attr, level);
>>   out:
>>   	data->phys += granule;
> Isn't this hunk alone sufficient to solve the problem?
>
> Will
> .

Not sufficient enough. When the old ptep is valid and old pte equlas new 
pte, in this case, "True" is also returned by kvm_set_valid_leaf_pte()

and get_page() will still be called.


Yanan

