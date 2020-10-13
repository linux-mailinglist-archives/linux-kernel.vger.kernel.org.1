Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FB28CEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgJMNMm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Oct 2020 09:12:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728490AbgJMNMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:12:41 -0400
X-Greylist: delayed 956 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 09:12:40 EDT
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 44F726526C6156BC6D5C;
        Tue, 13 Oct 2020 20:56:41 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 13 Oct 2020 20:56:40 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Tue, 13 Oct 2020 20:56:40 +0800
From:   "limingwang (A)" <limingwang@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fanhenglong <fanhenglong@huawei.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        Tangnianyao <tangnianyao@huawei.com>,
        Jiangyifei <jiangyifei@huawei.com>,
        "dengkai (A)" <dengkai1@huawei.com>,
        Zhanghailiang <zhang.zhanghailiang@huawei.com>,
        "Zhangxiaofeng (F)" <victor.zhangxiaofeng@huawei.com>
Subject: Re: [PATCH] arm64: KVM: marking pages as XN in Stage-2 does not care
 about CTR_EL0.DIC
Thread-Topic: [PATCH] arm64: KVM: marking pages as XN in Stage-2 does not care
 about CTR_EL0.DIC
Thread-Index: AdahWDzbwr1mcA3JQmSKPn8ti8Jsbg==
Date:   Tue, 13 Oct 2020 12:56:40 +0000
Message-ID: <d67816ef196c4375923c0672dd421be3@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.17]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Li,
>
>On 2020-10-12 02:08, l00484210 wrote:
>> From: MingWang Li <limingwang@huawei.com>
>> 
>> When testing the ARMv8.2-TTS2UXN feature, setting bits of XN is 
>> unavailable.
>> Because the control bit CTR_EL0.DIC is set by default on system.
>> 
>> But when CTR_EL0.DIC is set, software does not need to flush icache 
>> actively, instead of clearing XN bits.The patch, the commit id of 
>> which is 6ae4b6e0578886eb36cedbf99f04031d93f9e315, has implemented the 
>> function of CTR_EL0.DIC.
>> 
>> Signed-off-by: MingWang Li <limingwang@huawei.com>
>> Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
>> ---
>>  arch/arm64/include/asm/pgtable-prot.h | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h
>> b/arch/arm64/include/asm/pgtable-prot.h
>> index 4d867c6446c4..5feb94882bf7 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -79,17 +79,7 @@ extern bool arm64_use_ng_mappings;
>>  		__val;							\
>>  	 })
>> 
>> -#define PAGE_S2_XN							\
>> -	({								\
>> -		u64 __val;						\
>> -		if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))		\
>> -			__val = 0;					\
>> -		else							\
>> -			__val = PTE_S2_XN;				\
>> -		__val;							\
>> -	})
>> -
>> -#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) |
>> PTE_S2_RDONLY | PAGE_S2_XN)
>> +#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) |
>> PTE_S2_RDONLY | PTE_S2_XN)
>>  #define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT |
>> PAGE_S2_MEMATTR(DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_S2_XN)
>> 
>>  #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) |
>> PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>
>I don't understand what you are trying to achieve here.
>
>This whole point of not setting XN in the page tables when DIC is present is to avoid a pointless permission fault at run time. At you noticed above, no icache invalidation is necessary. So why would you ever want to take a fault on exec the first place?
>
>         M.
>--
>Jazz is not dead. It just smells funny...
>
>
Hi Marc,

According to ARMv8.2-TTS2UXN feature, which extends the stage 2 translation table access
permissions to provide control of whether memory is executable at EL0 independent of whether
it is executable at EL1. 

Testing this feature in some security scenario, for example, if I want to grant execute permission
to some memory only for EL0, but it will failed. Because KVM clears XN bits at first, this means that
the memory can be executable in both EL0 and El1. 

So the execute permission is not granted when the page table is created for the first time, then
grant the execute permission by setting xn, based on the actual requirements.

And according to spec:
DIC, bit [29]
	Instruction cache invalidation requirements for data to instruction coherence.
	0b0 Instruction cache invalidation to the Point of Unification is required for data to instruction coherence.
	0b1 Instruction cache invalidation to the Point of Unification is not required for data to instruction coherence.
So when DIC is set, if the memory is changed to executable, the hardware will flush icache.

If as you said, I feel that DIC conflicts with ARMv8.2-TTS2UXN feature.

Regards,
Mingwang
