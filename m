Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8332F2E64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbhALLu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbhALLu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:50:58 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C6F23104;
        Tue, 12 Jan 2021 11:50:17 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kzIBi-006wqv-RB; Tue, 12 Jan 2021 11:50:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 12 Jan 2021 11:50:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
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
Subject: Re: [PATCH v3 09/21] arm64: cpufeature: Add global feature override
 facility
In-Reply-To: <a122aa5c-4af9-e236-db82-db0ed885e0a5@arm.com>
References: <20210111132811.2455113-1-maz@kernel.org>
 <20210111132811.2455113-10-maz@kernel.org> <20210111184154.GC17941@gaia>
 <129db8bd3913a90c96d4cfe4f55e27a0@kernel.org>
 <a122aa5c-4af9-e236-db82-db0ed885e0a5@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d98aed718a26d0455d5549d53f97db06@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2021-01-12 09:17, Suzuki K Poulose wrote:
> Hi Marc,
> 
> On 1/11/21 7:48 PM, Marc Zyngier wrote:

[...]

>> diff --git a/arch/arm64/kernel/cpufeature.c 
>> b/arch/arm64/kernel/cpufeature.c
>> index 894af60b9669..00d99e593b65 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -774,6 +774,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, 
>> u64 new)
>>       u64 strict_mask = ~0x0ULL;
>>       u64 user_mask = 0;
>>       u64 valid_mask = 0;
>> +    u64 override_val = 0, override_mask = 0;
>> 
>>       const struct arm64_ftr_bits *ftrp;
>>       struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
>> @@ -781,9 +782,35 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, 
>> u64 new)
>>       if (!reg)
>>           return;
>> 
>> +    if (reg->override_mask && reg->override_val) {
>> +        override_mask = *reg->override_mask;
>> +        override_val = *reg->override_val;
>> +    }
>> +
>>       for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>>           u64 ftr_mask = arm64_ftr_mask(ftrp);
>>           s64 ftr_new = arm64_ftr_value(ftrp, new);
>> +        s64 ftr_ovr = arm64_ftr_value(ftrp, override_val);
>> +
>> +        if ((ftr_mask & override_mask) == ftr_mask) {
>> +            if (ftr_ovr < ftr_new) {
> 
> Here we assume that all the features are FTR_LOWER_SAFE. We could
> probably use arm64_ftr_safe_value(ftrp, ftr_new, ftr_ovr) here ?
> That would cover us for both HIGHER_SAFE and LOWER_SAFE features.
> However that may be restrictive for FTR_EXACT, as we the safe
> value would be set to "ftr->safe_val". I guess that may be better
> than forcing to use an unsafe value for the boot CPU, which could
> anyway conflict with the other CPUs and eventually trigger the
> ftr alue to be safe_val.

I like the idea of using the helper, as it cleanups up the code a bit.
However, not being to set a feature to a certain value could be 
restrictive,
as in general, it means that we can only disable a feature and not 
adjust
its level of support.

Take PMUVER for example: with the helper, I can't override it from v8.4 
to
v8.1. I can only go to v8.0.

Is it something we care about?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
