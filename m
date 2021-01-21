Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F122FEEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbhAUP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:28:38 -0500
Received: from foss.arm.com ([217.140.110.172]:39370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732765AbhAUP1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:27:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD45C11D4;
        Thu, 21 Jan 2021 07:27:03 -0800 (PST)
Received: from [10.37.8.32] (unknown [10.37.8.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24B3B3F68F;
        Thu, 21 Jan 2021 07:27:01 -0800 (PST)
Subject: Re: [PATCH v2 1/2] arm64: Fix kernel address detection of
 __is_lm_address()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20210121131956.23246-1-vincenzo.frascino@arm.com>
 <20210121131956.23246-2-vincenzo.frascino@arm.com>
 <20210121151206.GI48431@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <95727b4c-4578-6eb5-b518-208482e8ba62@arm.com>
Date:   Thu, 21 Jan 2021 15:30:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121151206.GI48431@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 3:12 PM, Mark Rutland wrote:
> [adding Ard]
>

Thanks for this, it is related to his patch and I forgot to Cc: him directly.

> On Thu, Jan 21, 2021 at 01:19:55PM +0000, Vincenzo Frascino wrote:
>> Currently, the __is_lm_address() check just masks out the top 12 bits
>> of the address, but if they are 0, it still yields a true result.
>> This has as a side effect that virt_addr_valid() returns true even for
>> invalid virtual addresses (e.g. 0x0).
> 
> When it was added, __is_lm_address() was intended to distinguish valid
> kernel virtual addresses (i.e. those in the TTBR1 address range), and
> wasn't intended to do anything for addresses outside of this range. See
> commit:
> 
>   ec6d06efb0bac6cd ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> 
> ... where it simply tests a bit.
> 
> So I believe that it's working as intended (though this is poorly
> documented), but I think you're saying that usage isn't aligned with
> that intent. Given that, I'm not sure the fixes tag is right; I think it
> has never had the semantic you're after.
>

I did not do much thinking on the intended semantics. I based my interpretation
on what you are saying (the usage is not aligned with the intent). Based on what
you are are saying, I will change the patch description removing the "Fix" term.

> I had thought the same was true for virt_addr_valid(), and that wasn't
> expected to be called for VAs outside of the kernel VA range. Is it
> actually safe to call that with NULL on other architectures?
> 

I am not sure on this, did not do any testing outside of arm64.

> I wonder if it's worth virt_addr_valid() having an explicit check for
> the kernel VA range, instead.
> 

I have no strong opinion either way even if personally I feel that modifying
__is_lm_address() is more clear. Feel free to propose something.

>> Fix the detection checking that it's actually a kernel address starting
>> at PAGE_OFFSET.
>>
>> Fixes: f4693c2716b35 ("arm64: mm: extend linear region for 52-bit VA configurations")
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/include/asm/memory.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 18fce223b67b..e04ac898ffe4 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -249,7 +249,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>>  /*
>>   * The linear kernel range starts at the bottom of the virtual address space.
>>   */
>> -#define __is_lm_address(addr)	(((u64)(addr) & ~PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET))
>> +#define __is_lm_address(addr)	(((u64)(addr) ^ PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET))
> 
> If we're going to make this stronger, can we please expand the comment
> with the intended semantic? Otherwise we're liable to break this in
> future.
> 

Based on your reply on the above matter, if you agree, I am happy to extend the
comment.

> Thanks,
> Mark.
> 

-- 
Regards,
Vincenzo
