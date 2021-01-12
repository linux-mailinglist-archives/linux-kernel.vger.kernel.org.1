Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687F92F2B12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392534AbhALJSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:18:18 -0500
Received: from foss.arm.com ([217.140.110.172]:42324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392481AbhALJSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:18:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 032B531B;
        Tue, 12 Jan 2021 01:17:30 -0800 (PST)
Received: from [10.57.39.145] (unknown [10.57.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA5F3F719;
        Tue, 12 Jan 2021 01:17:27 -0800 (PST)
Subject: Re: [PATCH v3 09/21] arm64: cpufeature: Add global feature override
 facility
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
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
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a122aa5c-4af9-e236-db82-db0ed885e0a5@arm.com>
Date:   Tue, 12 Jan 2021 09:17:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <129db8bd3913a90c96d4cfe4f55e27a0@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 1/11/21 7:48 PM, Marc Zyngier wrote:
> Hi Catalin,
> 
> On 2021-01-11 18:41, Catalin Marinas wrote:
>> Hi Marc,
>>
>> On Mon, Jan 11, 2021 at 01:27:59PM +0000, Marc Zyngier wrote:
>>> Add a facility to globally override a feature, no matter what
>>> the HW says. Yes, this is dangerous.
>>
>> Yeah, it's dangerous. We can make it less so if we only allow safe
>> values (e.g. lower if FTR_UNSIGNED).
> 
> My plan was also to allow non-safe values in order to trigger features
> that are not advertised by the HW. But I can understand if you are
> reluctant to allow such thing! :D
> 
>>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>>> index 9a555809b89c..465d2cb63bfc 100644
>>> --- a/arch/arm64/include/asm/cpufeature.h
>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>> @@ -75,6 +75,8 @@ struct arm64_ftr_reg {
>>>      u64                sys_val;
>>>      u64                user_val;
>>>      const struct arm64_ftr_bits    *ftr_bits;
>>> +    u64                *override_val;
>>> +    u64                *override_mask;
>>>  };
>>
>> At the arm64_ftr_reg level, we don't have any information about the safe
>> values for a feature. Could we instead move this to arm64_ftr_bits? We
>> probably only need a single field. When populating the feature values,
>> we can make sure it doesn't go above the hardware one.
>>
>> I attempted a feature modification for MTE here, though I dropped the
>> entire series in the meantime as we clarified the ARM ARM:
>>
>> https://lore.kernel.org/linux-arm-kernel/20200515171612.1020-24-catalin.marinas@arm.com/
>>
>> Srinivas copied it in his patch (but forgot to give credit ;)):
>>
>> https://lore.kernel.org/linux-arm-msm/1610152163-16554-3-git-send-email-sramana@codeaurora.org/
>>
>> The above adds a filter function but, instead, just use your mechanism in
>> this series for idreg.feature setting via cmdline. The arm64_ftr_value()
>> function extracts the hardware value and lowers it if a cmdline argument
>> was passed.
> 
> One thing is that it is not always possible to sanitise the value passed
> if it is required very early on, as I do with VHE. But in that case
> I actually check that we are VHE capable before starting to poke at
> VHE-specific state.
> 
> I came up with the following patch on top, which preserves the current
> global approach (no per arm64_ftr_bits state), but checks (and alters)
> the override as it iterates through the various fields.
> 
> For example, if I pass "arm64.nopauth kvm-arm.mode=nvhe id_aa64pfr1.bt=5"
> to the FVP, I get the following output:
> 
> [    0.000000] CPU features: SYS_ID_AA64ISAR1_EL1[31:28]: forced from 1 to 0
> [    0.000000] CPU features: SYS_ID_AA64ISAR1_EL1[11:8]: forced from 1 to 0
> [    0.000000] CPU features: SYS_ID_AA64MMFR1_EL1[11:8]: forced from 1 to 0
> [    0.000000] CPU features: SYS_ID_AA64PFR1_EL1[3:0]: not forcing 1 to 5
> [    0.000000] CPU features: detected: GIC system register CPU interface
> [    0.000000] CPU features: detected: Hardware dirty bit management
> [    0.000000] CPU features: detected: Spectre-v4
> [    0.000000] CPU features: detected: Branch Target Identification
> 
> showing that the PAC features have been downgraded, together with VHE,
> but that BTI is still detected as value 5 was obviously bogus.
> 
> Thoughts?
> 
>          M.
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 894af60b9669..00d99e593b65 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -774,6 +774,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>       u64 strict_mask = ~0x0ULL;
>       u64 user_mask = 0;
>       u64 valid_mask = 0;
> +    u64 override_val = 0, override_mask = 0;
> 
>       const struct arm64_ftr_bits *ftrp;
>       struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
> @@ -781,9 +782,35 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>       if (!reg)
>           return;
> 
> +    if (reg->override_mask && reg->override_val) {
> +        override_mask = *reg->override_mask;
> +        override_val = *reg->override_val;
> +    }
> +
>       for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>           u64 ftr_mask = arm64_ftr_mask(ftrp);
>           s64 ftr_new = arm64_ftr_value(ftrp, new);
> +        s64 ftr_ovr = arm64_ftr_value(ftrp, override_val);
> +
> +        if ((ftr_mask & override_mask) == ftr_mask) {
> +            if (ftr_ovr < ftr_new) {

Here we assume that all the features are FTR_LOWER_SAFE. We could
probably use arm64_ftr_safe_value(ftrp, ftr_new, ftr_ovr) here ?
That would cover us for both HIGHER_SAFE and LOWER_SAFE features.
However that may be restrictive for FTR_EXACT, as we the safe
value would be set to "ftr->safe_val". I guess that may be better
than forcing to use an unsafe value for the boot CPU, which could
anyway conflict with the other CPUs and eventually trigger the
ftr alue to be safe_val.

i.e,
	ftr_val = arm64_ftr_safe_value(ftrp, ftr_ovr, ftr_new);


Suzuki
