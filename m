Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C38300672
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbhAVPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:02:41 -0500
Received: from foss.arm.com ([217.140.110.172]:51792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbhAVOzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:55:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE3ED11D4;
        Fri, 22 Jan 2021 06:54:23 -0800 (PST)
Received: from [10.37.8.28] (unknown [10.37.8.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEEBA3F66E;
        Fri, 22 Jan 2021 06:54:21 -0800 (PST)
Subject: Re: [PATCH v3 2/2] kasan: Add explicit preconditions to
 kasan_report()
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20210122143748.50089-1-vincenzo.frascino@arm.com>
 <20210122143748.50089-3-vincenzo.frascino@arm.com>
 <CAAeHK+yyJia6zOCMpy6ZJDX-Brvr_s88gZ6HwG2TxfLgtw=SSg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <be55dae5-e654-7673-fea6-7ee4055d2be2@arm.com>
Date:   Fri, 22 Jan 2021 14:58:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yyJia6zOCMpy6ZJDX-Brvr_s88gZ6HwG2TxfLgtw=SSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 2:46 PM, Andrey Konovalov wrote:
> On Fri, Jan 22, 2021 at 3:38 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
>> the address passed as a parameter.
> 
> It doesn't dereference the address, it accesses the metadata. And only
> when addr_has_metadata() succeeds.
>

Yes, this is correct. Seems I forgot again to unstash something. Will fix it in v4.

>>
>> Add a comment to make sure that the preconditions to the function are
>> explicitly clarified.
>>
>> Note: An invalid address (e.g. NULL) passed to the function when,
>> KASAN_HW_TAGS is enabled, leads to a kernel panic.
> 
> This is no longer true, right? Commit description needs to be updated.
> 
>>
>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Alexander Potapenko <glider@google.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Leon Romanovsky <leonro@mellanox.com>
>> Cc: Andrey Konovalov <andreyknvl@google.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  include/linux/kasan.h | 7 +++++++
>>  mm/kasan/kasan.h      | 2 +-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index fe1ae73ff8b5..0aea9e2a2a01 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -333,6 +333,13 @@ static inline void *kasan_reset_tag(const void *addr)
>>         return (void *)arch_kasan_reset_tag(addr);
>>  }
>>
>> +/**
>> + * kasan_report - print a report about a bad memory access detected by KASAN
>> + * @addr: address of the bad access
>> + * @size: size of the bad access
>> + * @is_write: whether the bad access is a write or a read
>> + * @ip: instruction pointer for the accessibility check or the bad access itself
>> + */
> 
> Looks good, thanks!
> 
>>  bool kasan_report(unsigned long addr, size_t size,
>>                 bool is_write, unsigned long ip);
>>
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index cc4d9e1d49b1..8c706e7652f2 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
>> @@ -209,7 +209,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>>
>>  static inline bool addr_has_metadata(const void *addr)
>>  {
>> -       return true;
>> +       return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
>>  }
> 
> Let's put this change into a separate patch.
>

Ok, it will be done in v4.

>>
>>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>> --
>> 2.30.0
>>

-- 
Regards,
Vincenzo
