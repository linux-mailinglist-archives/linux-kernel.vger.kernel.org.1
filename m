Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8125B2F8E42
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbhAPRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:23:17 -0500
Received: from foss.arm.com ([217.140.110.172]:54142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbhAPRXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:23:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E1A9106F;
        Sat, 16 Jan 2021 05:45:29 -0800 (PST)
Received: from [10.37.8.30] (unknown [10.37.8.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D44A3F719;
        Sat, 16 Jan 2021 05:45:26 -0800 (PST)
Subject: Re: [PATCH v3 2/4] arm64: mte: Add asynchronous mode support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-3-vincenzo.frascino@arm.com>
 <20210115151327.GB44111@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <2fde5816-35a7-1e21-e42c-f6e413f30aec@arm.com>
Date:   Sat, 16 Jan 2021 13:49:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115151327.GB44111@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 3:13 PM, Mark Rutland wrote:
> On Fri, Jan 15, 2021 at 12:00:41PM +0000, Vincenzo Frascino wrote:
>> MTE provides an asynchronous mode for detecting tag exceptions. In
>> particular instead of triggering a fault the arm64 core updates a
>> register which is checked by the kernel after the asynchronous tag
>> check fault has occurred.
>>
>> Add support for MTE asynchronous mode.
>>
>> The exception handling mechanism will be added with a future patch.
>>
>> Note: KASAN HW activates async mode via kasan.mode kernel parameter.
>> The default mode is set to synchronous.
>> The code that verifies the status of TFSR_EL1 will be added with a
>> future patch.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/kernel/mte.c | 26 ++++++++++++++++++++++++--
>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 53a6d734e29b..df7a1ae26d7c 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -153,8 +153,30 @@ void mte_init_tags(u64 max_tag)
>>  
>>  void mte_enable_kernel(enum kasan_hw_tags_mode mode)
>>  {
>> -	/* Enable MTE Sync Mode for EL1. */
>> -	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>> +	const char *m;
>> +
>> +	/* Preset parameter values based on the mode. */
>> +	switch (mode) {
>> +	case KASAN_HW_TAGS_ASYNC:
>> +		/* Enable MTE Async Mode for EL1. */
>> +		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_ASYNC);
>> +		m = "asynchronous";
>> +		break;
>> +	case KASAN_HW_TAGS_SYNC:
>> +		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>> +		m = "synchronous";
>> +		break;
>> +	default:
>> +		/*
>> +		 * kasan mode should be always set hence we should
>> +		 * not reach this condition.
>> +		 */
>> +		WARN_ON_ONCE(1);
>> +		return;
>> +	}
>> +
>> +	pr_info_once("MTE: enabled in %s mode at EL1\n", m);
>> +
>>  	isb();
>>  }
> 
> For clarity, we should have that ISB before the pr_info_once().
>

Good point, I will fix it in v4.

> As with my comment on patch 1, I think with separate functions this
> would be much clearer and simpler:
> 
> static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
> {
> 	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, tcf);
> 	isb();
> 
> 	pr_info_once("MTE: enabled in %s mode at EL1\n", mode);
> }
> 
> void mte_enable_kernel_sync(void)
> {
> 	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
> }
> 
> void mte_enable_kernel_async(void)
> {
> 	__mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
> }
> 

Ok, seems cleaner like this, will adapt my code accordingly.

> Thanks,
> Mark.
> 

-- 
Regards,
Vincenzo
