Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FC32F6387
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbhANOyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:54:07 -0500
Received: from foss.arm.com ([217.140.110.172]:51026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbhANOyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:54:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C49ED1;
        Thu, 14 Jan 2021 06:53:20 -0800 (PST)
Received: from [10.37.12.3] (unknown [10.37.12.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40A493F70D;
        Thu, 14 Jan 2021 06:53:18 -0800 (PST)
Subject: Re: [PATCH v2 3/4] arm64: mte: Enable async tag check fault
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210107172908.42686-1-vincenzo.frascino@arm.com>
 <20210107172908.42686-4-vincenzo.frascino@arm.com>
 <20210113181121.GF27045@gaia> <efbb0722-eb4e-7be2-b929-77ec91cc0ae0@arm.com>
 <20210114142512.GB16561@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <80492795-4ebf-0d77-3f07-37593845a733@arm.com>
Date:   Thu, 14 Jan 2021 14:57:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114142512.GB16561@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/21 2:25 PM, Catalin Marinas wrote:
> On Thu, Jan 14, 2021 at 10:24:25AM +0000, Vincenzo Frascino wrote:
>> On 1/13/21 6:11 PM, Catalin Marinas wrote:
>>> On Thu, Jan 07, 2021 at 05:29:07PM +0000, Vincenzo Frascino wrote:
>>>>  static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
>>>>  {
>>>>  }
>>>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>>>> index 5346953e4382..74b020ce72d7 100644
>>>> --- a/arch/arm64/kernel/entry-common.c
>>>> +++ b/arch/arm64/kernel/entry-common.c
>>>> @@ -37,6 +37,8 @@ static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
>>>>  	lockdep_hardirqs_off(CALLER_ADDR0);
>>>>  	rcu_irq_enter_check_tick();
>>>>  	trace_hardirqs_off_finish();
>>>> +
>>>> +	mte_check_tfsr_el1();
>>>>  }
>>>>  
>>>>  /*
>>>> @@ -47,6 +49,8 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
>>>>  {
>>>>  	lockdep_assert_irqs_disabled();
>>>>  
>>>> +	mte_check_tfsr_el1();
>>>> +
>>>>  	if (interrupts_enabled(regs)) {
>>>>  		if (regs->exit_rcu) {
>>>>  			trace_hardirqs_on_prepare();
>>>> @@ -243,6 +247,8 @@ asmlinkage void noinstr enter_from_user_mode(void)
>>>>  
>>>>  asmlinkage void noinstr exit_to_user_mode(void)
>>>>  {
>>>> +	mte_check_tfsr_el1();
>>>
>>> While for kernel entry the asynchronous faults are sync'ed automatically
>>> with TFSR_EL1, we don't have this for exit, so we'd need an explicit
>>> DSB. But rather than placing it here, it's better if we add a bool sync
>>> argument to mte_check_tfsr_el1() which issues a dsb() before checking
>>> the register. I think that's the only place where such argument would be
>>> true (for now).
>>
>> Good point, I will add the dsb() in mte_check_tfsr_el1() but instead of a bool
>> parameter I will add something more explicit.
> 
> Or rename the function to mte_check_tfsr_el1_no_sync() and have a static
> inline mte_check_tfsr_el1() which issues a dsb() before calling the
> *no_sync variant.
> 
> Adding an enum instead here is not worth it (if that's what you meant by
> not using a bool).
> 

I like this option more, thanks for pointing it out.

-- 
Regards,
Vincenzo
