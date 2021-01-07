Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15362ED58A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbhAGR0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:26:33 -0500
Received: from foss.arm.com ([217.140.110.172]:36504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbhAGR0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:26:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A85B31B;
        Thu,  7 Jan 2021 09:25:47 -0800 (PST)
Received: from [10.37.8.33] (unknown [10.37.8.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6166C3F719;
        Thu,  7 Jan 2021 09:25:44 -0800 (PST)
Subject: Re: [PATCH 2/4] arm64: mte: Add asynchronous mode support
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210106115519.32222-1-vincenzo.frascino@arm.com>
 <20210106115519.32222-3-vincenzo.frascino@arm.com>
 <CAAeHK+xuGRzkLdrfGZVo-RVfkH31qUrNdBaPd4k5ffMKHWGfTQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c4f04127-a682-d809-1dad-5ee1f51d3e0a@arm.com>
Date:   Thu, 7 Jan 2021 17:29:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xuGRzkLdrfGZVo-RVfkH31qUrNdBaPd4k5ffMKHWGfTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/7/21 4:29 PM, Andrey Konovalov wrote:
> On Wed, Jan 6, 2021 at 12:56 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> MTE provides an asynchronous mode for detecting tag exceptions. In
>> particular instead of triggering a fault the arm64 core updates a
>> register which is checked by the kernel at the first entry after the tag
>> exception has occurred.
>>
>> Add support for MTE asynchronous mode.
>>
>> The exception handling mechanism will be added with a future patch.
>>
>> Note: KASAN HW activates async mode via kasan.mode kernel parameter.
>> The default mode is set to synchronous.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/kernel/mte.c | 31 +++++++++++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 24a273d47df1..5d992e16b420 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -153,8 +153,35 @@ void mte_init_tags(u64 max_tag)
>>
>>  void mte_enable_kernel(enum kasan_arg_mode mode)
>>  {
>> -       /* Enable MTE Sync Mode for EL1. */
>> -       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>> +       const char *m;
>> +
>> +       /* Preset parameter values based on the mode. */
>> +       switch (mode) {
>> +       case KASAN_ARG_MODE_OFF:
>> +               return;
>> +       case KASAN_ARG_MODE_LIGHT:
>> +               /* Enable MTE Async Mode for EL1. */
>> +               sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_ASYNC);
>> +               m = "asynchronous";
>> +               break;
>> +       case KASAN_ARG_MODE_DEFAULT:
>> +       case KASAN_ARG_MODE_PROD:
>> +       case KASAN_ARG_MODE_FULL:
>> +               /* Enable MTE Sync Mode for EL1. */
>> +               sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>> +               m = "synchronous";
>> +               break;
>> +       default:
>> +               /*
>> +                * kasan mode should be always set hence we should
>> +                * not reach this condition.
>> +                */
>> +               WARN_ON_ONCE(1);
>> +               return;
>> +       }
>> +
>> +       pr_info_once("MTE: enabled in %s mode at EL1\n", m);
>> +
>>         isb();
>>  }
>>
>> --
>> 2.29.2
>>
> 
> Hi Vincenzo,
> 
> It would be cleaner to pass a bool to mte_enable_kernel() and have it
> indicate sync/async mode. This way you don't have to pull all these
> KASAN constants into the arm64 code.
>

Boolean arguments are generally bad for legibility, hence I tend to avoid them.
In this case exposing the constants does not seem a big issue especially because
the only user of this code is "KASAN_HW_TAGS" and definitely improves its
legibility hence I would prefer to keep it as is.
> Thanks!
> 

-- 
Regards,
Vincenzo
