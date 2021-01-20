Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B912FD315
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390700AbhATOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:43:25 -0500
Received: from foss.arm.com ([217.140.110.172]:37734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390788AbhATOmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:42:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C01D0D6E;
        Wed, 20 Jan 2021 06:41:17 -0800 (PST)
Received: from [10.37.8.30] (unknown [10.37.8.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE3F33F66E;
        Wed, 20 Jan 2021 06:41:15 -0800 (PST)
Subject: Re: [PATCH v4 2/5] kasan: Add KASAN mode kernel parameter
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
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-3-vincenzo.frascino@arm.com>
 <CAAeHK+xCkkqzwYW+Q7zUOjbhrDE0fFV2dH9sRAqrFcCP6Df0iQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <555f43d2-2753-b8b8-5ca9-53bc580c9def@arm.com>
Date:   Wed, 20 Jan 2021 14:45:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xCkkqzwYW+Q7zUOjbhrDE0fFV2dH9sRAqrFcCP6Df0iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/19/21 6:10 PM, Andrey Konovalov wrote:
> On Mon, Jan 18, 2021 at 7:30 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> --- a/Documentation/dev-tools/kasan.rst
>> +++ b/Documentation/dev-tools/kasan.rst
>> @@ -162,6 +162,9 @@ particular KASAN features.
>>
>>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>>
>> +- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
>> +  synchronous or asynchronous mode of execution (default: ``sync``).
> This needs to be expanded with a short explanation of the difference.
> 

Ok, I will extend it in v5.

>> +static inline void hw_enable_tagging_mode(void)
>> +{
>> +       if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
>> +               hw_enable_tagging_async();
>> +       else
>> +               hw_enable_tagging_sync();
>> +}
> It's OK to open-code this in kasan_init_hw_tags_cpu(), no need for an
> additional function.
> 

I added the new function to keep the code cleaner, but I do not have strong
opinion hence it is fine by me to have open-code here.

-- 
Regards,
Vincenzo
