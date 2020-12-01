Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2242CA976
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgLARVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:21:20 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2325 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgLARVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:21:20 -0500
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ClpkY6Q1lz13Nqq;
        Wed,  2 Dec 2020 01:19:49 +0800 (CST)
Received: from [10.174.186.123] (10.174.186.123) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Dec 2020 01:20:33 +0800
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into a
 block entry
To:     Marc Zyngier <maz@kernel.org>
CC:     Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
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
 <868a4403-10d3-80f3-4ae1-a490813c55e2@huawei.com>
 <20201201134606.GB26973@willie-the-truck>
 <2e92a511-496c-d446-95f4-6211ec8b4bb6@huawei.com>
 <e9f00d1af54cf61c7469c7d905bff3e0@kernel.org>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <0a36f859-2666-e5e7-856d-47fa306a6f53@huawei.com>
Date:   Wed, 2 Dec 2020 01:20:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e9f00d1af54cf61c7469c7d905bff3e0@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.186.123]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/1 22:35, Marc Zyngier wrote:

> Hi Yanan,
>
> On 2020-12-01 14:11, wangyanan (Y) wrote:
>> On 2020/12/1 21:46, Will Deacon wrote:
>>> On Tue, Dec 01, 2020 at 10:30:41AM +0800, wangyanan (Y) wrote:
>
> [...]
>
>>>> The point is at b.iii where the TLBI is not enough. There are many 
>>>> page
>>>> mappings that we need to merge into a block mapping.
>>>>
>>>> We invalidate the TLB for the input address without level hint at 
>>>> b.iii, but
>>>> this operation just flush TLB for one page mapping, there
>>>>
>>>> are still some TLB entries for the other page mappings in the 
>>>> cache, the MMU
>>>> hardware walker can still hit these entries next time.
>>> Ah, yes, I see. Thanks. I hadn't considered the case where there are 
>>> table
>>> entries beneath the anchor. So how about the diff below?
>>>
>>> Will
>>>
>>> --->8
>>
>> Hi, I think it's inappropriate to put the TLBI of all the leaf entries
>> in function stage2_map_walk_table_post(),
>>
>> because the *ptep must be an upper table entry when we enter
>> stage2_map_walk_table_post().
>>
>> We should make the TLBI for every leaf entry not table entry in the
>> last lookup level,  just as I am proposing
>>
>> to add the additional TLBI in function stage2_map_walk_leaf().
>
> Could you make your concerns explicit? As far as I can tell, this should
> address the bug you found, at least from a correctness perspective.
>
> Are you worried about the impact of the full S2 invalidation? Or do you
> see another correctness issue?


Hi Will, Marc,


After recheck of the diff, the full S2 invalidation in 
stage2_map_walk_table_post() should be well enough to solve this problem.

But I was wondering if we can add the full S2 invalidation in 
stage2_map_walk_table_pre(), where __kvm_tlb_flush_vmid() will be called 
for only one time.

If we add the full TLBI in stage2_map_walk_table_post(), 
__kvm_tlb_flush_vmid() might be called for many times in the loop and 
lots of (unnecessary) CPU instructions will be wasted.

What I'm saying is something like below, please let me know what do you 
think.

If this is OK, I can update the diff in v2 and send it with your SOB (is 
it appropriate?) after some tests.


diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b232bdd142a6..f11fb2996080 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -496,7 +496,7 @@ static int stage2_map_walk_table_pre(u64 addr, u64 
end, u32 level,
                 return 0;

         kvm_set_invalid_pte(ptep);
-       kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, 0);
+       kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
         data->anchor = ptep;
         return 0;
  }


Thanks,

Yanan

