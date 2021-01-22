Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B488E300778
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbhAVPgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:36:23 -0500
Received: from foss.arm.com ([217.140.110.172]:51944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbhAVO56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:57:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 465D911D4;
        Fri, 22 Jan 2021 06:57:12 -0800 (PST)
Received: from [10.37.8.28] (unknown [10.37.8.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55A0A3F66E;
        Fri, 22 Jan 2021 06:57:10 -0800 (PST)
Subject: Re: [PATCH v7 3/4] kasan: Add report for async mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210122141125.36166-1-vincenzo.frascino@arm.com>
 <20210122141125.36166-4-vincenzo.frascino@arm.com>
 <CAAeHK+ydhzfrdrPbjok20rgMEYykpfmjcRASm_bTfhuTVXF_VA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <42b4d820-0a33-35a0-0dd0-0381dd693b9e@arm.com>
Date:   Fri, 22 Jan 2021 15:01:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+ydhzfrdrPbjok20rgMEYykpfmjcRASm_bTfhuTVXF_VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/21 2:42 PM, Andrey Konovalov wrote:
> On Fri, Jan 22, 2021 at 3:11 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> KASAN provides an asynchronous mode of execution.
>>
>> Add reporting functionality for this mode.
>>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Alexander Potapenko <glider@google.com>
>> Cc: Andrey Konovalov <andreyknvl@google.com>
>> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  include/linux/kasan.h |  2 ++
>>  mm/kasan/report.c     | 13 +++++++++++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index bb862d1f0e15..b0a1d9dfa85c 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -351,6 +351,8 @@ static inline void *kasan_reset_tag(const void *addr)
>>  bool kasan_report(unsigned long addr, size_t size,
>>                 bool is_write, unsigned long ip);
>>
>> +void kasan_report_async(void);
>> +
>>  #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>>
>>  static inline void *kasan_reset_tag(const void *addr)
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 234f35a84f19..1390da06a988 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -358,6 +358,19 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>>         end_report(&flags);
>>  }
>>
>> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> 
> This looks wrong, CONFIG_KASAN_SW_TAGS doesn't use MTE, so this
> function isn't needed for that mode.
>

It is true, I will fix in v8.

> Let's add an #ifdef CONFIG_KASAN_HW_TAGS section in
> include/linux/kasan.h after the HW/SW one with kasan_report(). And
> only leave CONFIG_KASAN_HW_TAGS in mm/kasan/report.c too.
> 
>> +void kasan_report_async(void)
>> +{
>> +       unsigned long flags;
>> +
>> +       start_report(&flags);
>> +       pr_err("BUG: KASAN: invalid-access\n");
>> +       pr_err("Asynchronous mode enabled: no access details available\n");
>> +       dump_stack();
>> +       end_report(&flags);
>> +}
>> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>> +
>>  static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>>                                 unsigned long ip)
>>  {
>> --
>> 2.30.0
>>

-- 
Regards,
Vincenzo
