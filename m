Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF61A2F5D67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbhANJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:28:58 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4136 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbhANJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:28:56 -0500
Received: from dggeme763-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DGf8y6R29zXyj9;
        Thu, 14 Jan 2021 17:27:14 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 14 Jan 2021 17:28:09 +0800
Subject: Re: [PATCH v2 2/3] KVM: arm64: Add prejudgement for relaxing
 permissions only case in stage2 translation fault handler
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
        <zhukeqian1@huawei.com>, <yuzenghui@huawei.com>
References: <20201216122844.25092-1-wangyanan55@huawei.com>
 <20201216122844.25092-3-wangyanan55@huawei.com>
 <20210113154414.GA11892@willie-the-truck>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <d494ead2-73c9-e9e0-0082-0036efca35c7@huawei.com>
Date:   Thu, 14 Jan 2021 17:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210113154414.GA11892@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/13 23:44, Will Deacon wrote:
> On Wed, Dec 16, 2020 at 08:28:43PM +0800, Yanan Wang wrote:
>> In dirty-logging, or dirty-logging-stopped time, even normal running
>> time of a guest configed with huge mappings and numbers of vCPUs,
>> translation faults by different vCPUs on the same GPA could occur
>> successively almost at the same time. There are two reasons for it.
>>
>> (1) If there are some vCPUs accessing the same GPA at the same time and
>> the leaf PTE is not set yet, then they will all cause translation faults
>> and the first vCPU holding mmu_lock will set valid leaf PTE, and the
>> others will later update the old PTE with a new one if they are different.
>>
>> (2) When changing a leaf entry or a table entry with break-before-make,
>> if there are some vCPUs accessing the same GPA just catch the moment when
>> the target PTE is set invalid in a BBM procedure coincidentally, they will
>> all cause translation faults and will later update the old PTE with a new
>> one if they are different.
>>
>> The worst case can be like this: vCPU A causes a translation fault with RW
>> prot and sets the leaf PTE with RW permissions, and then the next vCPU B
>> with RO prot updates the PTE back to RO permissions with break-before-make.
>> And the BBM-invalid moment may trigger more unnecessary translation faults,
>> then some useless small loops might occur which could lead to vCPU stuck.
>>
>> To avoid unnecessary update and small loops, add prejudgement in the
>> translation fault handler: Skip updating the PTE with break-before-make
>> if we are trying to recreate the exact same mapping or only change the
>> access permissions. Actually, change of permissions will be handled
>> through the relax_perms path next time if necessary.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   arch/arm64/kvm/hyp/pgtable.c | 28 +++++++++++++++++++---------
>>   1 file changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index 350f9f810930..8225ced49bad 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -45,6 +45,10 @@
>>   
>>   #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
>>   
>> +#define KVM_PTE_LEAF_ATTR_S2_PERMS	(KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
>> +					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
>> +					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
>> +
>>   struct kvm_pgtable_walk_data {
>>   	struct kvm_pgtable		*pgt;
>>   	struct kvm_pgtable_walker	*walker;
>> @@ -460,7 +464,7 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
>>   	return 0;
>>   }
>>   
>> -static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>> +static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>   				       kvm_pte_t *ptep,
>>   				       struct stage2_map_data *data)
>>   {
>> @@ -469,13 +473,18 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>   	struct page *page = virt_to_page(ptep);
>>   
>>   	if (!kvm_block_mapping_supported(addr, end, phys, level))
>> -		return false;
>> +		return 1;
> It would probably be cleaner to return another error code here, as we
> have failed to install a mapping (e.g. E2BIG or perhaps more perversely,
> ENOTBLK). Then the caller can decide to install a trable.
>
Ok, I will make some adjustment for this and post the v3 soon after.

Thanks,

Yanan.

