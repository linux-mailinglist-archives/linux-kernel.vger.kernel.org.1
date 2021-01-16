Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34152F8E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbhAPR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:58:17 -0500
Received: from foss.arm.com ([217.140.110.172]:55552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbhAPR6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:58:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3540101E;
        Sat, 16 Jan 2021 05:43:22 -0800 (PST)
Received: from [10.37.8.30] (unknown [10.37.8.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61EBC3F719;
        Sat, 16 Jan 2021 05:43:20 -0800 (PST)
Subject: Re: [PATCH v3 1/4] kasan, arm64: Add KASAN light mode
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-2-vincenzo.frascino@arm.com>
 <20210115150811.GA44111@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ba23ab9b-8f49-bdb7-87d8-3eb99ddf54b6@arm.com>
Date:   Sat, 16 Jan 2021 13:47:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115150811.GA44111@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 1/15/21 3:08 PM, Mark Rutland wrote:
> On Fri, Jan 15, 2021 at 12:00:40PM +0000, Vincenzo Frascino wrote:
>> Architectures supported by KASAN HW can provide a light mode of
>> execution. On an MTE enabled arm64 hw for example this can be identified
>> with the asynch mode of execution.
>> In this mode, if a tag check fault occurs, the TFSR_EL1 register is
>> updated asynchronously. The kernel checks the corresponding bits
>> periodically.
> 
> What's the expected usage of this relative to prod, given that this has
> to be chosen at boot time? When/where is this expected to be used
> relative to prod mode?
> 

IIUC the light mode is meant for low spec devices. I let Andrey comment a bit
more on this topic.

>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 18fce223b67b..3a7c5beb7096 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -231,7 +231,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>>  }
>>  
>>  #ifdef CONFIG_KASAN_HW_TAGS
>> -#define arch_enable_tagging()			mte_enable_kernel()
>> +#define arch_enable_tagging(mode)		mte_enable_kernel(mode)
> 
> Rather than passing a mode in, I think it'd be better to have:
> 
> * arch_enable_tagging_prod()
> * arch_enable_tagging_light()
> 
> ... that we can map in the arch code to separate:
> 
> * mte_enable_kernel_sync()
> * mte_enable_kernel_async()
> 
> ... as by construction that avoids calls with an unhandled mode, and we
> wouldn't need the mode enum kasan_hw_tags_mode...
> 
>> +static inline int hw_init_mode(enum kasan_arg_mode mode)
>> +{
>> +	switch (mode) {
>> +	case KASAN_ARG_MODE_LIGHT:
>> +		return KASAN_HW_TAGS_ASYNC;
>> +	default:
>> +		return KASAN_HW_TAGS_SYNC;
>> +	}
>> +}
> 
> ... and we can just have a wrapper like this to call either of the two functions directly, i.e.
> 
> static inline void hw_enable_tagging_mode(enum kasan_arg_mode mode)
> {
> 	if (mode == KASAN_ARG_MODE_LIGHT)
> 		arch_enable_tagging_mode_light();
> 	else
> 		arch_enable_tagging_mode_prod();
> }
>

Fine by me, this would remove the need of adding a new enumeration as well and
reflect on the arch code. I would keep "arch_enable_tagging_mode_sync" and
"arch_enable_tagging_mode_async" though to give a clear indication in the KASAN
code of the mode we are setting. I will adapt my code accordingly for v4.

> Thanks,
> Mark.
> 

-- 
Regards,
Vincenzo
