Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6E2F5DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbhANJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:40:17 -0500
Received: from foss.arm.com ([217.140.110.172]:46660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbhANJkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:40:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE12A1FB;
        Thu, 14 Jan 2021 01:39:35 -0800 (PST)
Received: from [10.0.0.31] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EC303F70D;
        Thu, 14 Jan 2021 01:39:32 -0800 (PST)
Subject: Re: [PATCH v2 2/4] arm64: mte: Add asynchronous mode support
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
 <20210107172908.42686-3-vincenzo.frascino@arm.com>
 <20210113172228.GE27045@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <16a57293-37fa-4526-e6cd-61f80b93e12a@arm.com>
Date:   Thu, 14 Jan 2021 09:43:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113172228.GE27045@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/21 5:22 PM, Catalin Marinas wrote:
> On Thu, Jan 07, 2021 at 05:29:06PM +0000, Vincenzo Frascino wrote:
>> MTE provides an asynchronous mode for detecting tag exceptions. In
>> particular instead of triggering a fault the arm64 core updates a
>> register which is checked by the kernel at the first entry after the tag
>> exception has occurred.
> 
> Just rephrase the "tag exception" here as there's no exception taken.
> Also we don't check this only when the kernel is first entered after a
> tag check fault, as per patch 3.
>

Ok, I will clarify it in v3.

>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -153,8 +153,35 @@ void mte_init_tags(u64 max_tag)
>>  
>>  void mte_enable_kernel(enum kasan_arg_mode mode)
>>  {
>> -	/* Enable MTE Sync Mode for EL1. */
>> -	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>> +	const char *m;
>> +
>> +	/* Preset parameter values based on the mode. */
>> +	switch (mode) {
>> +	case KASAN_ARG_MODE_OFF:
>> +		return;
>> +	case KASAN_ARG_MODE_LIGHT:
>> +		/* Enable MTE Async Mode for EL1. */
>> +		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_ASYNC);
>> +		m = "asynchronous";
>> +		break;
>> +	case KASAN_ARG_MODE_DEFAULT:
>> +	case KASAN_ARG_MODE_PROD:
>> +	case KASAN_ARG_MODE_FULL:
>> +		/* Enable MTE Sync Mode for EL1. */
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
> 
> I guess the switch statement here will be re-written as we want kasan to
> drive the actual sync/async modes as it sees fit rather than MTE
> guessing what PROD/FULL/LIGHT means.
> 

Yes, this is correct, it will present only sync/async mode.

-- 
Regards,
Vincenzo
