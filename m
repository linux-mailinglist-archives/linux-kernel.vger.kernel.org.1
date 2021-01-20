Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F42FD6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbhATOt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:49:28 -0500
Received: from foss.arm.com ([217.140.110.172]:37802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390744AbhATOnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:43:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987AFD6E;
        Wed, 20 Jan 2021 06:42:56 -0800 (PST)
Received: from [10.37.8.30] (unknown [10.37.8.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F7583F66E;
        Wed, 20 Jan 2021 06:42:54 -0800 (PST)
Subject: Re: [PATCH v4 3/5] kasan: Add report for async mode
To:     Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-4-vincenzo.frascino@arm.com>
 <20210119130440.GC17369@gaia> <813f907f-0de8-6b96-c67a-af9aecf31a70@arm.com>
 <20210119144625.GB2338@C02TD0UTHF1T.local>
 <CAAeHK+wcWk_URtGROUc1VLR4PjVQChCUpSLFya9DNTytQP2mVg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d9ee1147-be64-4910-aca5-6b83f1c71895@arm.com>
Date:   Wed, 20 Jan 2021 14:46:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wcWk_URtGROUc1VLR4PjVQChCUpSLFya9DNTytQP2mVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/21 6:12 PM, Andrey Konovalov wrote:
> On Tue, Jan 19, 2021 at 3:46 PM Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> Given there's no information available, I think it's simpler and
>> preferable to handle the logging separately, as is done for
>> kasan_report_invalid_free(). For example, we could do something roughly
>> like:
>>
>> void kasan_report_async(void)
>> {
>>         unsigned long flags;
>>
>>         start_report(&flags);
>>         pr_err("BUG: KASAN: Tag mismatch detected asynchronously\n");
> 
> "BUG: KASAN: invalid-access"
>

Ok, I will do in v5. It looks more uniform with what we have for the sync exception.

> It also might make sense to pass the ip, even though it's not exactly
> related to the access:
> 

I would like to avoid to add a builtin for something that has not a real meaning
as you are correctly pointing out.

> pr_err("BUG: KASAN: invalid-access in %pS\n", (void *)ip);
> 
> Up to you.
> 
>>         pr_err("KASAN: no fault information available\n");
> 
> pr_err("Asynchronous mode enabled: no access details available\n");
> 
>>         dump_stack();
>>         end_report(&flags);
>> }
> 
> This approach with a dedicated function is better. Thanks, Mark!
> 
> Please put it next to kasan_report_invalid_free().
> 

Will do in v5.

Thanks!

-- 
Regards,
Vincenzo
