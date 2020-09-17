Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E530326E57B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgIQQP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:15:58 -0400
Received: from foss.arm.com ([217.140.110.172]:48608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbgIQQP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:15:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD34D11D4;
        Thu, 17 Sep 2020 09:14:36 -0700 (PDT)
Received: from [10.37.8.97] (unknown [10.37.8.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3BF3F68F;
        Thu, 17 Sep 2020 09:14:33 -0700 (PDT)
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
Message-ID: <9ef0a773-71f0-c1d6-b67e-ccf7d8bcbbe6@arm.com>
Date:   Thu, 17 Sep 2020 17:17:00 +0100
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
> This doesn't do what you think it does. LDG indeed reads the tag from
> memory but LDR loads the actual data at that address. Instead of the
> first LDR, you may want something like "mov %0, #0xf << 56" (and use
> some macros to avoid the hard-coded 56).
>

Seems I can't encode a shift of 56 neither in mov nor in orr. I propose to
replace both with an and of the address with itself.
This should not change anything.

Thoughts?

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
> What was the intention here? The first ADD doubles the pointer value and
> gets a tag out of it (possibly doubled as well, depends on the carry
> from bit 55). Better use something like "orr %0, %0, #0xf << 56".
> 

-- 
Regards,
Vincenzo
