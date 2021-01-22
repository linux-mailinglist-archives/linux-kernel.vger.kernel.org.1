Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF530041A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhAVNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:25:16 -0500
Received: from foss.arm.com ([217.140.110.172]:47516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbhAVNYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:24:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4320711B3;
        Fri, 22 Jan 2021 05:23:27 -0800 (PST)
Received: from [10.37.8.28] (unknown [10.37.8.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7743F66E;
        Fri, 22 Jan 2021 05:23:24 -0800 (PST)
Subject: Re: [PATCH v5 3/6] kasan: Add report for async mode
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
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
 <20210121163943.9889-4-vincenzo.frascino@arm.com>
 <20210122131933.GD8567@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6ccde9db-98cd-5a56-b93d-0b79f4df56a7@arm.com>
Date:   Fri, 22 Jan 2021 13:27:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122131933.GD8567@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/21 1:19 PM, Catalin Marinas wrote:
> On Thu, Jan 21, 2021 at 04:39:40PM +0000, Vincenzo Frascino wrote:
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index bb862d1f0e15..b0a1d9dfa85c 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -351,6 +351,8 @@ static inline void *kasan_reset_tag(const void *addr)
>>  bool kasan_report(unsigned long addr, size_t size,
>>  		bool is_write, unsigned long ip);
>>  
>> +void kasan_report_async(void);
>> +
>>  #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>>  
>>  static inline void *kasan_reset_tag(const void *addr)
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 234f35a84f19..2fd6845a95e9 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -358,6 +358,17 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>>  	end_report(&flags);
>>  }
>>  
>> +void kasan_report_async(void)
>> +{
>> +	unsigned long flags;
>> +
>> +	start_report(&flags);
>> +	pr_err("BUG: KASAN: invalid-access\n");
>> +	pr_err("Asynchronous mode enabled: no access details available\n");
>> +	dump_stack();
>> +	end_report(&flags);
>> +}
> 
> I think the kernel test robot complains that with KASAN_SW_TAGS and
> HW_TAGS disabled, the kasan_report_async() prototype is no longer
> visible but you still have the non-static function definition here. So
> either move kasan_report_async() out of this #ifdef or add the #ifdef
> around the function definition.
>

I think adding #ifdef around the function would be the best way in this case,
for consistency with the header.

> It looks like the original kasan_report() prototype is declared in two
> places (second one in mm/kasan/kasan.h). I'd remove the latter and try
> to have a consistent approach for kasan_report() and
> kasan_report_async().
> 

Ok, I will remove it.

-- 
Regards,
Vincenzo
