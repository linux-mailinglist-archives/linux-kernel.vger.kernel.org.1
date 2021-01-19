Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1597A2FBFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391593AbhASTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:16:56 -0500
Received: from foss.arm.com ([217.140.110.172]:45962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbhASTEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:04:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F27ADD6E;
        Tue, 19 Jan 2021 11:03:52 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76AB83F719;
        Tue, 19 Jan 2021 11:03:51 -0800 (PST)
Subject: Re: [PATCH] kasan: Add explicit preconditions to kasan_report()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210119172607.18400-1-vincenzo.frascino@arm.com>
 <CAAeHK+zpB6GZcAbWnmvKu5mk_HuNEaXV2OwRuSNnVjddjBqZMQ@mail.gmail.com>
 <20210119185206.GA26948@gaia> <e3d67672-1825-894a-db68-5709b33b4991@arm.com>
 <20210119190219.GC26948@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6a5600c0-002a-3e80-0229-494d1c9648ac@arm.com>
Date:   Tue, 19 Jan 2021 19:07:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119190219.GC26948@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/21 7:02 PM, Catalin Marinas wrote:
> On Tue, Jan 19, 2021 at 07:00:57PM +0000, Vincenzo Frascino wrote:
>> On 1/19/21 6:52 PM, Catalin Marinas wrote:
>>> On Tue, Jan 19, 2021 at 07:27:43PM +0100, Andrey Konovalov wrote:
>>>> On Tue, Jan 19, 2021 at 6:26 PM Vincenzo Frascino
>>>> <vincenzo.frascino@arm.com> wrote:
>>>>>
>>>>> With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
>>>>> the address passed as a parameter.
>>>>>
>>>>> Add a comment to make sure that the preconditions to the function are
>>>>> explicitly clarified.
>>>>>
>>>>> Note: An invalid address (e.g. NULL pointer address) passed to the
>>>>> function when, KASAN_HW_TAGS is enabled, leads to a kernel panic.
>>>>>
>>>>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>>>> Cc: Alexander Potapenko <glider@google.com>
>>>>> Cc: Dmitry Vyukov <dvyukov@google.com>
>>>>> Cc: Leon Romanovsky <leonro@mellanox.com>
>>>>> Cc: Andrey Konovalov <andreyknvl@google.com>
>>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>>> ---
>>>>>  mm/kasan/report.c | 11 +++++++++++
>>>>>  1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>>>>> index c0fb21797550..2485b585004d 100644
>>>>> --- a/mm/kasan/report.c
>>>>> +++ b/mm/kasan/report.c
>>>>> @@ -403,6 +403,17 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>>>>>         end_report(&flags);
>>>>>  }
>>>>>
>>>>> +/**
>>>>> + * kasan_report - report kasan fault details
>>>>> + * @addr: valid address of the allocation where the tag fault was detected
>>>>> + * @size: size of the allocation where the tag fault was detected
>>>>> + * @is_write: the instruction that caused the fault was a read or write?
>>>>> + * @ip: pointer to the instruction that cause the fault
>>>>> + *
>>>>> + * Note: When CONFIG_KASAN_HW_TAGS is enabled kasan_report() dereferences
>>>>> + * the address to access the tags, hence it must be valid at this point in
>>>>> + * order to not cause a kernel panic.
>>>>> + */
>>>>
>>>> It doesn't dereference the address, it just checks the tags, right?
>>>>
>>>> Ideally, kasan_report() should survive that with HW_TAGS like with the
>>>> other modes. The reason it doesn't is probably because of a blank
>>>> addr_has_metadata() definition for HW_TAGS in mm/kasan/kasan.h. I
>>>> guess we should somehow check that the memory comes from page_alloc or
>>>> kmalloc. Or otherwise make sure that it has tags. Maybe there's an arm
>>>> instruction to check whether the memory has tags?
>>>
>>> There isn't an architected way to probe whether a memory location has a
>>> VA->PA mapping. The tags are addressed by PA but you can't reach them if
>>> you get a page fault on the VA. So we either document the kasan_report()
>>> preconditions or, as you suggest, update addr_has_metadata() for the
>>> HW_TAGS case. Something like:
>>>
>>>         return is_vmalloc_addr(virt) || virt_addr_valid(virt));
>>
>> Or we could have both ;)
> 
> True. Documentation doesn't hurt (well, only when it's wrong ;)).
> 

Testing the patch now, I will send it in half an hour.

-- 
Regards,
Vincenzo
