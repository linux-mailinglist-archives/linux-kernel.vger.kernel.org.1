Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2952F2E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbhALMAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:00:21 -0500
Received: from foss.arm.com ([217.140.110.172]:44804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbhALMAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:00:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB8FF1042;
        Tue, 12 Jan 2021 03:59:34 -0800 (PST)
Received: from [10.57.39.145] (unknown [10.57.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815CA3F66E;
        Tue, 12 Jan 2021 03:59:31 -0800 (PST)
Subject: Re: [PATCH v3 09/21] arm64: cpufeature: Add global feature override
 facility
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        kernel-team@android.com
References: <20210111132811.2455113-1-maz@kernel.org>
 <20210111132811.2455113-10-maz@kernel.org> <20210111184154.GC17941@gaia>
 <129db8bd3913a90c96d4cfe4f55e27a0@kernel.org>
 <a122aa5c-4af9-e236-db82-db0ed885e0a5@arm.com>
 <d98aed718a26d0455d5549d53f97db06@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <168970f2-89d8-4e57-ab8d-59fa52bd830a@arm.com>
Date:   Tue, 12 Jan 2021 11:59:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d98aed718a26d0455d5549d53f97db06@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 11:50 AM, Marc Zyngier wrote:
> Hi Suzuki,
> 
> On 2021-01-12 09:17, Suzuki K Poulose wrote:
>> Hi Marc,
>>
>> On 1/11/21 7:48 PM, Marc Zyngier wrote:
> 
> [...]
> 
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 894af60b9669..00d99e593b65 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -774,6 +774,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>>>       u64 strict_mask = ~0x0ULL;
>>>       u64 user_mask = 0;
>>>       u64 valid_mask = 0;
>>> +    u64 override_val = 0, override_mask = 0;
>>>
>>>       const struct arm64_ftr_bits *ftrp;
>>>       struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
>>> @@ -781,9 +782,35 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>>>       if (!reg)
>>>           return;
>>>
>>> +    if (reg->override_mask && reg->override_val) {
>>> +        override_mask = *reg->override_mask;
>>> +        override_val = *reg->override_val;
>>> +    }
>>> +
>>>       for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>>>           u64 ftr_mask = arm64_ftr_mask(ftrp);
>>>           s64 ftr_new = arm64_ftr_value(ftrp, new);
>>> +        s64 ftr_ovr = arm64_ftr_value(ftrp, override_val);
>>> +
>>> +        if ((ftr_mask & override_mask) == ftr_mask) {
>>> +            if (ftr_ovr < ftr_new) {
>>
>> Here we assume that all the features are FTR_LOWER_SAFE. We could
>> probably use arm64_ftr_safe_value(ftrp, ftr_new, ftr_ovr) here ?
>> That would cover us for both HIGHER_SAFE and LOWER_SAFE features.
>> However that may be restrictive for FTR_EXACT, as we the safe
>> value would be set to "ftr->safe_val". I guess that may be better
>> than forcing to use an unsafe value for the boot CPU, which could
>> anyway conflict with the other CPUs and eventually trigger the
>> ftr alue to be safe_val.
> 
> I like the idea of using the helper, as it cleanups up the code a bit.
> However, not being to set a feature to a certain value could be restrictive,
> as in general, it means that we can only disable a feature and not adjust
> its level of support.
> 
> Take PMUVER for example: with the helper, I can't override it from v8.4 to
> v8.1. I can only go to v8.0.

My point is, we set this only for the "init" of cpu features. So, even if we
init to a custom , non-(default-safe) value, the secondary CPUs could scream,
and the system wide safe value could fall back to the "safe" value for EXACT features,
no matter what you did to init it.

Also, it will be dangerous for things like PAC, as the lower level value may
not be compatible with the "actual" cpu feature supported.

So simply setting to a lower value for EXACT features is generally not safe,
though I understand some are exceptions.

Suzuki



> 
> Is it something we care about?
> 
> Thanks,
> 
>          M.

