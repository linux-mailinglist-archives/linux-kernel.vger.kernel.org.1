Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B6528D0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgJMO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbgJMO4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:56:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915062489E;
        Tue, 13 Oct 2020 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602600964;
        bh=oB9nt+Yg6rD9DUc9KcRhqw0n2cGgCHRUGQG2xrYn2zA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pa6v1yfT3aJj1I9dJcXB98YMB7bSUClRd9bCRFqrIc5H6MDF4e4lo4tnsqNOTgz7q
         gYbhAfcPi8Hb9QeaLkAH+WK6DlPihAIh0AisOdLnCN8vymguQTlm74kVmSUMOw70YA
         OoLSsoshU94u8cEF6Ko78eQGK4NFxdhIarErqLLc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kSLic-000r4R-Dv; Tue, 13 Oct 2020 15:56:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Oct 2020 15:56:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "limingwang (A)" <limingwang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Fanhenglong <fanhenglong@huawei.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        Tangnianyao <tangnianyao@huawei.com>,
        Jiangyifei <jiangyifei@huawei.com>,
        "dengkai (A)" <dengkai1@huawei.com>,
        Zhanghailiang <zhang.zhanghailiang@huawei.com>,
        "Zhangxiaofeng (F)" <victor.zhangxiaofeng@huawei.com>
Subject: Re: [PATCH] arm64: KVM: marking pages as XN in Stage-2 does not care
 about CTR_EL0.DIC
In-Reply-To: <d67816ef196c4375923c0672dd421be3@huawei.com>
References: <d67816ef196c4375923c0672dd421be3@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0bdf5768857381c082062af0b55750d8@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: limingwang@huawei.com, catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fanhenglong@huawei.com, wanghaibin.wang@huawei.com, tangnianyao@huawei.com, jiangyifei@huawei.com, dengkai1@huawei.com, zhang.zhanghailiang@huawei.com, victor.zhangxiaofeng@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-13 13:56, limingwang (A) wrote:
>> Hi Li,
>> 
>> On 2020-10-12 02:08, l00484210 wrote:
>>> From: MingWang Li <limingwang@huawei.com>
>>> 
>>> When testing the ARMv8.2-TTS2UXN feature, setting bits of XN is
>>> unavailable.
>>> Because the control bit CTR_EL0.DIC is set by default on system.
>>> 
>>> But when CTR_EL0.DIC is set, software does not need to flush icache
>>> actively, instead of clearing XN bits.The patch, the commit id of
>>> which is 6ae4b6e0578886eb36cedbf99f04031d93f9e315, has implemented 
>>> the
>>> function of CTR_EL0.DIC.
>>> 
>>> Signed-off-by: MingWang Li <limingwang@huawei.com>
>>> Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
>>> ---
>>>  arch/arm64/include/asm/pgtable-prot.h | 12 +-----------
>>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>> 
>>> diff --git a/arch/arm64/include/asm/pgtable-prot.h
>>> b/arch/arm64/include/asm/pgtable-prot.h
>>> index 4d867c6446c4..5feb94882bf7 100644
>>> --- a/arch/arm64/include/asm/pgtable-prot.h
>>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>>> @@ -79,17 +79,7 @@ extern bool arm64_use_ng_mappings;
>>>  		__val;							\
>>>  	 })
>>> 
>>> -#define PAGE_S2_XN							\
>>> -	({								\
>>> -		u64 __val;						\
>>> -		if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))		\
>>> -			__val = 0;					\
>>> -		else							\
>>> -			__val = PTE_S2_XN;				\
>>> -		__val;							\
>>> -	})
>>> -
>>> -#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) |
>>> PTE_S2_RDONLY | PAGE_S2_XN)
>>> +#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) |
>>> PTE_S2_RDONLY | PTE_S2_XN)
>>>  #define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT |
>>> PAGE_S2_MEMATTR(DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_S2_XN)
>>> 
>>>  #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) |
>>> PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>> 
>> I don't understand what you are trying to achieve here.
>> 
>> This whole point of not setting XN in the page tables when DIC is 
>> present is to avoid a pointless permission fault at run time. At you 
>> noticed above, no icache invalidation is necessary. So why would you 
>> ever want to take a fault on exec the first place?
>> 
>>         M.
>> --
>> Jazz is not dead. It just smells funny...
>> 
>> 
> Hi Marc,
> 
> According to ARMv8.2-TTS2UXN feature, which extends the stage 2
> translation table access
> permissions to provide control of whether memory is executable at EL0
> independent of whether
> it is executable at EL1.
> 
> Testing this feature in some security scenario, for example, if I want
> to grant execute permission
> to some memory only for EL0, but it will failed. Because KVM clears XN
> bits at first, this means that
> the memory can be executable in both EL0 and El1.

KVM currently offers no support for this, and the only use we have for
XN so far is to to ensure Data/Instruction coherency when the CPU
doesn't offer it in HW.

> So the execute permission is not granted when the page table is
> created for the first time, then
> grant the execute permission by setting xn, based on the actual 
> requirements.
> 
> And according to spec:
> DIC, bit [29]
> 	Instruction cache invalidation requirements for data to instruction 
> coherence.
> 	0b0 Instruction cache invalidation to the Point of Unification is
> required for data to instruction coherence.
> 	0b1 Instruction cache invalidation to the Point of Unification is not
> required for data to instruction coherence.
> So when DIC is set, if the memory is changed to executable, the
> hardware will flush icache.

No. The Icache *snoops* the Dcache at all times. Which is why we don't
need to trap on execution, and we can leave the guest run without
any intervention.

> If as you said, I feel that DIC conflicts with ARMv8.2-TTS2UXN feature.

There is no conflict. KVM doesn't make use of all the bells and whistle
in the architecture, which is probably a good thing. If you feel that 
there
is a need for S2UXN as a security feature, we can discuss how to expose 
this
to the guest (because it definitely needs to know about that).

But setting XN when DIC is present for no other reason than "it may be
useful one day" doesn't make sense, and results in a massive performance
drop on the platforms that have DIC (and I really wish they all had it).

        M.
-- 
Jazz is not dead. It just smells funny...
