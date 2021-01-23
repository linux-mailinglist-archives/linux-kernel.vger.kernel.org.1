Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715E630169B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 17:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbhAWQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 11:05:37 -0500
Received: from foss.arm.com ([217.140.110.172]:47936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbhAWQF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 11:05:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EA4B11D4;
        Sat, 23 Jan 2021 08:04:40 -0800 (PST)
Received: from [10.57.40.145] (unknown [10.57.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60D263F68F;
        Sat, 23 Jan 2021 08:04:34 -0800 (PST)
Subject: Re: [PATCH v4 10/21] arm64: cpufeature: Use IDreg override in
 __read_sysreg_by_encoding()
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
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
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-11-maz@kernel.org> <20210122185344.GH8567@gaia>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <95659e7f-090e-0ff7-3e89-1ed17df68e6d@arm.com>
Date:   Sat, 23 Jan 2021 16:04:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122185344.GH8567@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 6:53 PM, Catalin Marinas wrote:
> On Mon, Jan 18, 2021 at 09:45:22AM +0000, Marc Zyngier wrote:
>> __read_sysreg_by_encoding() is used by a bunch of cpufeature helpers,
>> which should take the feature override into account. Let's do that.
>>
>> For a good measure (and because we are likely to need to further
>> down the line), make this helper available to the rest of the
>> non-modular kernel.
>>
>> Code that needs to know the *real* features of a CPU can still
>> use read_sysreg_s(), and find the bare, ugly truth.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>

>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index aaa075c6f029..48a011935d8c 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1149,14 +1149,17 @@ u64 read_sanitised_ftr_reg(u32 id)
>>   EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
>>   
>>   #define read_sysreg_case(r)	\
>> -	case r:		return read_sysreg_s(r)
>> +	case r:		val = read_sysreg_s(r); break;
>>   
>>   /*
>>    * __read_sysreg_by_encoding() - Used by a STARTING cpu before cpuinfo is populated.
>>    * Read the system register on the current CPU
>>    */
>> -static u64 __read_sysreg_by_encoding(u32 sys_id)
>> +u64 __read_sysreg_by_encoding(u32 sys_id)
>>   {
>> +	struct arm64_ftr_reg *regp;
>> +	u64 val;
>> +
>>   	switch (sys_id) {
>>   	read_sysreg_case(SYS_ID_PFR0_EL1);
>>   	read_sysreg_case(SYS_ID_PFR1_EL1);
>> @@ -1199,6 +1202,14 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
>>   		BUG();
>>   		return 0;
>>   	}
>> +
>> +	regp  = get_arm64_ftr_reg(sys_id);
>> +	if (regp && regp->override_mask && regp->override_val) {
>> +		val &= ~*regp->override_mask;
>> +		val |= (*regp->override_val & *regp->override_mask);
>> +	}
>> +
>> +	return val;
> 
> Ah, now the previous patch makes more sense. I don't particularly like
> this but I can't tell how to work around it. I was hoping that the
> overriding feature behaves more like a secondary CPU that limits all the
> overridden features. However, this approach would fail for FTR_EXACT
> cases (like PAC, though I wonder whether it fails already with your
> previous patch since the boot CPU value won't match the override, hence
> dropping to the safe one).
> 

Correct !For FTR_EXACT, we dont want to override a value that is not safe, e.g PAC.
This is handled correctly in the previous patch and thus we are covered.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

