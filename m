Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D407730018A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbhAVL1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:27:45 -0500
Received: from foss.arm.com ([217.140.110.172]:42332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbhAVLWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:22:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C6B139F;
        Fri, 22 Jan 2021 03:22:00 -0800 (PST)
Received: from [10.37.8.28] (unknown [10.37.8.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2479F3F719;
        Fri, 22 Jan 2021 03:21:58 -0800 (PST)
Subject: Re: [PATCH v5 2/6] kasan: Add KASAN mode kernel parameter
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
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
 <20210121163943.9889-3-vincenzo.frascino@arm.com>
 <CAAeHK+z3QrZr3OWcvetyChk9GMPuBZVTBjWoqQB45ZSFBOJHwQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <770c1426-3e62-e320-9928-37f6ac580c79@arm.com>
Date:   Fri, 22 Jan 2021 11:25:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+z3QrZr3OWcvetyChk9GMPuBZVTBjWoqQB45ZSFBOJHwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 5:34 PM, Andrey Konovalov wrote:
>> +- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
>> +  synchronous or asynchronous mode of execution (default: ``sync``).
>> +  ``synchronous mode``: an exception is triggered if a tag check fault occurs.
> Synchronous mode: a bad access is detected immediately when a tag
> check fault occurs.
> 
> (No need for `` here, "synchronous mode" is not an inline snippet.)
> 

Ok will do in v5.

>> +  ``asynchronous mode``: if a tag check fault occurs, the information is stored
>> +  asynchronously in hardware (e.g. in the TFSR_EL1 register for arm64). The kernel
>> +  checks the hardware location and reports an error if the fault is detected.
> Asynchronous mode: a bad access detection is delayed. When a tag check
> fault occurs, the information is stored in hardware (in the TFSR_EL1
> register for arm64). The kernel periodically checks the hardware and
> only reports tag faults during these checks.
> 

Will do in v5.

>> +
>>  - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
>>    traces collection (default: ``on`` for ``CONFIG_DEBUG_KERNEL=y``, otherwise
>>    ``off``).
>> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
>> index d16ec9e66806..7285dcf9fcc1 100644
>> --- a/lib/test_kasan.c
>> +++ b/lib/test_kasan.c
>> @@ -97,7 +97,7 @@ static void kasan_test_exit(struct kunit *test)
>>                         READ_ONCE(fail_data.report_found));     \
>>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {                 \
>>                 if (READ_ONCE(fail_data.report_found))          \
>> -                       hw_enable_tagging();                    \
>> +                       hw_enable_tagging_sync();               \
>>                 migrate_enable();                               \
>>         }                                                       \
>>  } while (0)
>> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
>> index e529428e7a11..224a2187839c 100644
>> --- a/mm/kasan/hw_tags.c
>> +++ b/mm/kasan/hw_tags.c
>> @@ -25,6 +25,11 @@ enum kasan_arg {
>>         KASAN_ARG_ON,
>>  };
>>
>> +enum kasan_arg_mode {
>> +       KASAN_ARG_MODE_SYNC,
>> +       KASAN_ARG_MODE_ASYNC,
> For other modes I explicitly added a _DEFAULT option first. It makes
> sense to do this here as well for consistency.
> 

Will do in v5.

>> +};
>> +
>>  enum kasan_arg_stacktrace {
>>         KASAN_ARG_STACKTRACE_DEFAULT,
>>         KASAN_ARG_STACKTRACE_OFF,
>> @@ -38,6 +43,7 @@ enum kasan_arg_fault {
>>  };
>>
>>  static enum kasan_arg kasan_arg __ro_after_init;
>> +static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
>>  static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>>
>> @@ -68,6 +74,21 @@ static int __init early_kasan_flag(char *arg)
>>  }
>>  early_param("kasan", early_kasan_flag);
>>
>> +/* kasan.mode=sync/async */
>> +static int __init early_kasan_mode(char *arg)
>> +{
>> +       /* If arg is not set the default mode is sync */
>> +       if ((!arg) || !strcmp(arg, "sync"))
>> +               kasan_arg_mode = KASAN_ARG_MODE_SYNC;
>> +       else if (!strcmp(arg, "async"))
>> +               kasan_arg_mode = KASAN_ARG_MODE_ASYNC;
>> +       else
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +early_param("kasan.mode", early_kasan_mode);
>> +
>>  /* kasan.stacktrace=off/on */
>>  static int __init early_kasan_flag_stacktrace(char *arg)
>>  {
>> @@ -115,7 +136,11 @@ void kasan_init_hw_tags_cpu(void)
>>                 return;
>>
>>         hw_init_tags(KASAN_TAG_MAX);
>> -       hw_enable_tagging();
>> +
> Let's add a comment:
> 
> /* Enable async mode only when explicitly requested through the command line. */
> 

Will do in v5.

-- 
Regards,
Vincenzo
