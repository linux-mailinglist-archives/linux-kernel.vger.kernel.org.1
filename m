Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACA2A8087
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgKEOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:14:03 -0500
Received: from foss.arm.com ([217.140.110.172]:33706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgKEOOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:14:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 894BA14BF;
        Thu,  5 Nov 2020 06:14:02 -0800 (PST)
Received: from [10.37.12.41] (unknown [10.37.12.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55673F719;
        Thu,  5 Nov 2020 06:13:59 -0800 (PST)
Subject: Re: [PATCH v8 30/43] arm64: kasan: Allow enabling in-kernel MTE
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1604531793.git.andreyknvl@google.com>
 <5e3c76cac4b161fe39e3fc8ace614400bc2fb5b1.1604531793.git.andreyknvl@google.com>
 <58aae616-f1be-d626-de16-af48cc2512b0@arm.com>
 <CAAeHK+yfQJbHLP0ja=_qnEugyrtQFMgRyw3Z1ZOeu=NVPNCFgg@mail.gmail.com>
 <1ef3f645-8b91-cfcf-811e-85123fea90fa@arm.com>
 <CAAeHK+zuJtMbUK75TEFSmLjpu8h-wTfkra1ZGV533shYKEYi6g@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <090ab218-8566-772b-648f-00001413fef2@arm.com>
Date:   Thu, 5 Nov 2020 14:17:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zuJtMbUK75TEFSmLjpu8h-wTfkra1ZGV533shYKEYi6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/20 12:14 PM, Andrey Konovalov wrote:
> On Thu, Nov 5, 2020 at 12:39 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> On 11/5/20 11:35 AM, Andrey Konovalov wrote:
>>> This will work. Any preference on the name of this function?
>>>
>>
>> I called it in my current iteration mte_enable(), and calling it from
>> cpu_enable_mte().
>>
>>> Alternatively we can rename mte_init_tags() to something else and let
>>> it handle both RRND and sync/async.
>>
>> This is an option but then you need to change the name of kasan_init_tags and
>> the init_tags indirection name as well. I would go for the simpler and just
>> splitting the function as per above.
>>
>> What do you think?
> 
> OK, let's split. mte_enable() as a name sounds good to me. Both
> functions will still be called one right after another from
> kasan_init_hw_tags (as it's now called) though. I think the name
> works, as it means initializing the hw_tags mode, not just the tags.
> 

I agree. When you finish with v9, could you please provide a tree with both the
sets on top similar to [1]? I would like to repeat the tests (ltp + kselftests)
and even to rebase my async code on top of it since we are aligning with the
development.

[1] https://github.com/xairy/linux/tree/up-boot-mte-v1

> Will do in v9.
> 

-- 
Regards,
Vincenzo
