Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18FA2FBB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbhASPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:46:49 -0500
Received: from foss.arm.com ([217.140.110.172]:36950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391647AbhASPp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:45:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42A7BD6E;
        Tue, 19 Jan 2021 07:45:10 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62A03F66E;
        Tue, 19 Jan 2021 07:45:07 -0800 (PST)
Subject: Re: [PATCH v4 5/5] arm64: mte: Inline mte_assign_mem_tag_range()
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
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-6-vincenzo.frascino@arm.com>
 <20210119144459.GE17369@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1bb4355f-4341-21a7-0a53-a4a27840adee@arm.com>
Date:   Tue, 19 Jan 2021 15:48:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119144459.GE17369@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 1/19/21 2:45 PM, Catalin Marinas wrote:
> On Mon, Jan 18, 2021 at 06:30:33PM +0000, Vincenzo Frascino wrote:
>> mte_assign_mem_tag_range() is called on production KASAN HW hot
>> paths. It makes sense to inline it in an attempt to reduce the
>> overhead.
>>
>> Inline mte_assign_mem_tag_range() based on the indications provided at
>> [1].
>>
>> [1] https://lore.kernel.org/r/CAAeHK+wCO+J7D1_T89DG+jJrPLk3X9RsGFKxJGd0ZcUFjQT-9Q@mail.gmail.com/
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/include/asm/mte.h | 26 +++++++++++++++++++++++++-
>>  arch/arm64/lib/mte.S         | 15 ---------------
>>  2 files changed, 25 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
>> index 237bb2f7309d..1a6fd53f82c3 100644
>> --- a/arch/arm64/include/asm/mte.h
>> +++ b/arch/arm64/include/asm/mte.h
>> @@ -49,7 +49,31 @@ long get_mte_ctrl(struct task_struct *task);
>>  int mte_ptrace_copy_tags(struct task_struct *child, long request,
>>  			 unsigned long addr, unsigned long data);
>>  
>> -void mte_assign_mem_tag_range(void *addr, size_t size);
>> +static inline void mte_assign_mem_tag_range(void *addr, size_t size)
>> +{
>> +	u64 _addr = (u64)addr;
>> +	u64 _end = _addr + size;
>> +
>> +	/*
>> +	 * This function must be invoked from an MTE enabled context.
>> +	 *
>> +	 * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
>> +	 * size must be non-zero and MTE_GRANULE_SIZE aligned.
>> +	 */
>> +	do {
>> +		/*
>> +		 * 'asm volatile' is required to prevent the compiler to move
>> +		 * the statement outside of the loop.
>> +		 */
>> +		asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
>> +			     :
>> +			     : "r" (_addr)
>> +			     : "memory");
>> +
>> +		_addr += MTE_GRANULE_SIZE;
>> +	} while (_addr != _end);
>> +}
> 
> While I'm ok with moving this function to C, I don't think it solves the
> inlining in the kasan code. The only interface we have to kasan is via
> mte_{set,get}_mem_tag_range(), so the above function doesn't need to
> live in a header.
> 
> If you do want inlining all the way to the kasan code, we should
> probably move the mte_{set,get}_mem_tag_range() functions to the header
> as well (and ideally backed by some numbers to show that it matters).
> 
> Moving it to mte.c also gives us more control on how it's called (we
> have the WARN_ONs in place in the callers).
> 

Based on the thread [1] this patch contains only an intermediate step to allow
KASAN to call directly mte_assign_mem_tag_range() in future. At that point I
think that mte_set_mem_tag_range() can be removed.

If you agree, I would live the things like this to give to Andrey a chance to
execute on the original plan with a separate series.

I agree though that this change alone does not bring huge benefits but
regressions neither.

If you want I can add something to the commit message in the next version to
make this more explicit.

Let me know how do you want me to proceed.

-- 
Regards,
Vincenzo
