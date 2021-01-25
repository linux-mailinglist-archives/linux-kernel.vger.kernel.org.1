Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA50302663
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbhAYOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:37:56 -0500
Received: from foss.arm.com ([217.140.110.172]:48162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbhAYOdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:33:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AD53139F;
        Mon, 25 Jan 2021 06:32:43 -0800 (PST)
Received: from [10.37.8.33] (unknown [10.37.8.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26BA03F66B;
        Mon, 25 Jan 2021 06:32:41 -0800 (PST)
Subject: Re: [PATCH v4 1/3] arm64: Improve kernel address detection of
 __is_lm_address()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20210122155642.23187-1-vincenzo.frascino@arm.com>
 <20210122155642.23187-2-vincenzo.frascino@arm.com>
 <20210125130204.GA4565@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ddc0f9e2-f63e-9c34-f0a4-067d1c5d63b8@arm.com>
Date:   Mon, 25 Jan 2021 14:36:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125130204.GA4565@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 1/25/21 1:02 PM, Mark Rutland wrote:
> Hi Vincenzo,
> 
> On Fri, Jan 22, 2021 at 03:56:40PM +0000, Vincenzo Frascino wrote:
>> Currently, the __is_lm_address() check just masks out the top 12 bits
>> of the address, but if they are 0, it still yields a true result.
>> This has as a side effect that virt_addr_valid() returns true even for
>> invalid virtual addresses (e.g. 0x0).
>>
>> Improve the detection checking that it's actually a kernel address
>> starting at PAGE_OFFSET.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Looking around, it seems that there are some existing uses of
> virt_addr_valid() that expect it to reject addresses outside of the
> TTBR1 range. For example, check_mem_type() in drivers/tee/optee/call.c.
> 
> Given that, I think we need something that's easy to backport to stable.
> 

I agree, I started looking at it this morning and I found cases even in the main
allocators (slub and page_alloc) either then the one you mentioned.

> This patch itself looks fine, but it's not going to backport very far,
> so I suspect we might need to write a preparatory patch that adds an
> explicit range check to virt_addr_valid() which can be trivially
> backported.
> 

I checked the old releases and I agree this is not back-portable as it stands.
I propose therefore to add a preparatory patch with the check below:

#define __is_ttrb1_address(addr)	((u64)(addr) >= PAGE_OFFSET && \
					(u64)(addr) < PAGE_END)

If it works for you I am happy to take care of it and post a new version of my
patches.

Thanks!

> For this patch:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks,
> Mark.
> 
>> ---
>>  arch/arm64/include/asm/memory.h | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 18fce223b67b..99d7e1494aaa 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -247,9 +247,11 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>>  
>>  
>>  /*
>> - * The linear kernel range starts at the bottom of the virtual address space.
>> + * Check whether an arbitrary address is within the linear map, which
>> + * lives in the [PAGE_OFFSET, PAGE_END) interval at the bottom of the
>> + * kernel's TTBR1 address range.
>>   */
>> -#define __is_lm_address(addr)	(((u64)(addr) & ~PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET))
>> +#define __is_lm_address(addr)	(((u64)(addr) ^ PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET))
>>  
>>  #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
>>  #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
>> -- 
>> 2.30.0
>>

-- 
Regards,
Vincenzo
