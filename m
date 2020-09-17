Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A548E26DE37
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgIQO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:28:45 -0400
Received: from foss.arm.com ([217.140.110.172]:47528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbgIQOZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:25:20 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 10:25:19 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBC1730E;
        Thu, 17 Sep 2020 07:19:15 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95B3B3F718;
        Thu, 17 Sep 2020 07:19:13 -0700 (PDT)
Subject: Re: [PATCH v2 22/37] arm64: mte: Add in-kernel MTE helpers
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1600204505.git.andreyknvl@google.com>
 <4ac1ed624dd1b0851d8cf2861b4f4aac4d2dbc83.1600204505.git.andreyknvl@google.com>
 <20200917134653.GB10662@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7904f7c2-cf3b-315f-8885-e8709c232718@arm.com>
Date:   Thu, 17 Sep 2020 15:21:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917134653.GB10662@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/20 2:46 PM, Catalin Marinas wrote:
> On Tue, Sep 15, 2020 at 11:16:04PM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/include/asm/mte-helpers.h b/arch/arm64/include/asm/mte-helpers.h
>> new file mode 100644
>> index 000000000000..5dc2d443851b
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/mte-helpers.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020 ARM Ltd.
>> + */
>> +#ifndef __ASM_MTE_ASM_H
>> +#define __ASM_MTE_ASM_H
>> +
>> +#define __MTE_PREAMBLE		".arch armv8.5-a\n.arch_extension memtag\n"
> 
> Because of how the .arch overrides a previous .arch, we should follow
> the ARM64_ASM_PREAMBLE introduced in commit 1764c3edc668 ("arm64: use a
> common .arch preamble for inline assembly"). The above should be
> something like:
> 
> #define __MTE_PREAMBLE	ARM64_ASM_PREAMBLE ".arch_extension memtag"
> 
> with the ARM64_ASM_PREAMBLE adjusted to armv8.5-a if available.

Good idea, I was not aware of commit 1764c3edc668. I will fix it accordingly.

> 
>> +#define MTE_GRANULE_SIZE	UL(16)
>> +#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
>> +#define MTE_TAG_SHIFT		56
>> +#define MTE_TAG_SIZE		4
>> +#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
>> +#define MTE_TAG_MAX		(MTE_TAG_MASK >> MTE_TAG_SHIFT)
> 
> In v1 I suggested we keep those definitions in mte-def.h (or
> mte-hwdef.h) so that they can be included in cache.h. Anything else
> should go in mte.h, I don't see the point of two headers for various MTE
> function prototypes.
> 

This is what I did in my patches I shared with Andrey. I suppose that since in
this version he introduced some functions that are needed in this file, he
reverted to the old name (mte-helper.h).

>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/types.h>
>> +
>> +#ifdef CONFIG_ARM64_MTE
>> +
>> +#define mte_get_ptr_tag(ptr)	((u8)(((u64)(ptr)) >> MTE_TAG_SHIFT))
> 
> I wonder whether this could also be an inline function that takes a void
> *ptr.
> 
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 52a0638ed967..e238ffde2679 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -72,6 +74,52 @@ int memcmp_pages(struct page *page1, struct page *page2)
>>  	return ret;
>>  }
>>  
>> +u8 mte_get_mem_tag(void *addr)
>> +{
>> +	if (system_supports_mte())
>> +		asm volatile(ALTERNATIVE("ldr %0, [%0]",
>> +					 __MTE_PREAMBLE "ldg %0, [%0]",
>> +					 ARM64_MTE)
>> +			     : "+r" (addr));
> 
> This doesn't do what you think it does. LDG indeed reads the tag from
> memory but LDR loads the actual data at that address. Instead of the
> first LDR, you may want something like "mov %0, #0xf << 56" (and use
> some macros to avoid the hard-coded 56).
> 

The result of the load should never be used since it is meaningful only if
system_supports_mte(). It should be only required for compilation purposes.

Said that, I think I like more your solution hence I am going to adopt it.

>> +
>> +	return 0xF0 | mte_get_ptr_tag(addr);
>> +}
>> +
>> +u8 mte_get_random_tag(void)
>> +{
>> +	u8 tag = 0xF;
>> +	u64 addr = 0;
>> +
>> +	if (system_supports_mte()) {
>> +		asm volatile(ALTERNATIVE("add %0, %0, %0",
>> +					 __MTE_PREAMBLE "irg %0, %0",
>> +					 ARM64_MTE)
>> +			     : "+r" (addr));
> 
> What was the intention here? The first ADD doubles the pointer value and
> gets a tag out of it (possibly doubled as well, depends on the carry
> from bit 55). Better use something like "orr %0, %0, #0xf << 56".
>

Same as above but I will use the orr in the next version.

>> +
>> +		tag = mte_get_ptr_tag(addr);
>> +	}
>> +
>> +	return 0xF0 | tag;
> 
> This function return seems inconsistent with the previous one. I'd
> prefer the return line to be the same in both.
> 

The reason why it is different is that in this function extracting the tag from
the address makes sense only if irg is executed.

I can initialize addr to 0xf << 56 and make them the same.

>> +}
>> +
>> +void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>> +{
>> +	void *ptr = addr;
>> +
>> +	if ((!system_supports_mte()) || (size == 0))
>> +		return addr;
>> +
>> +	/* Make sure that size is aligned. */
>> +	WARN_ON(size & (MTE_GRANULE_SIZE - 1));
>> +
>> +	tag = 0xF0 | (tag & 0xF);
> 
> No point in tag & 0xf, the top nibble doesn't matter as you or 0xf0 in.
> 

Agree, will remove in the next version.

>> +	ptr = (void *)__tag_set(ptr, tag);
>> +
>> +	mte_assign_mem_tag_range(ptr, size);
>> +
>> +	return ptr;
>> +}
>> +
>>  static void update_sctlr_el1_tcf0(u64 tcf0)
>>  {
>>  	/* ISB required for the kernel uaccess routines */
>> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
>> index 03ca6d8b8670..cc2c3a378c00 100644
>> --- a/arch/arm64/lib/mte.S
>> +++ b/arch/arm64/lib/mte.S
>> @@ -149,3 +149,20 @@ SYM_FUNC_START(mte_restore_page_tags)
>>  
>>  	ret
>>  SYM_FUNC_END(mte_restore_page_tags)
>> +
>> +/*
>> + * Assign allocation tags for a region of memory based on the pointer tag
>> + *   x0 - source pointer
>> + *   x1 - size
>> + *
>> + * Note: size must be non-zero and MTE_GRANULE_SIZE aligned
>> + */
>> +SYM_FUNC_START(mte_assign_mem_tag_range)
>> +	/* if (src == NULL) return; */
>> +	cbz	x0, 2f
>> +1:	stg	x0, [x0]
>> +	add	x0, x0, #MTE_GRANULE_SIZE
>> +	sub	x1, x1, #MTE_GRANULE_SIZE
>> +	cbnz	x1, 1b
>> +2:	ret
>> +SYM_FUNC_END(mte_assign_mem_tag_range)
> 
> I thought Vincenzo agreed to my comments on the previous version w.r.t.
> the fist cbz and the last cbnz:
> 
> https://lore.kernel.org/linux-arm-kernel/921c4ed0-b5b5-bc01-5418-c52d80f1af59@arm.com/
> 

Ups, this is my fault, I just realized I missed to unstash this change. Will be
present in the next version.

-- 
Regards,
Vincenzo
