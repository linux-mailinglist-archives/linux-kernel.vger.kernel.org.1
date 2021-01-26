Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37D303CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392429AbhAZMLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:11:22 -0500
Received: from foss.arm.com ([217.140.110.172]:36500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392305AbhAZMKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:10:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C2B101E;
        Tue, 26 Jan 2021 04:10:06 -0800 (PST)
Received: from [10.37.12.25] (unknown [10.37.12.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90C53F66B;
        Tue, 26 Jan 2021 04:10:03 -0800 (PST)
Subject: Re: [PATCH v4 1/3] arm64: Improve kernel address detection of
 __is_lm_address()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20210122155642.23187-1-vincenzo.frascino@arm.com>
 <20210122155642.23187-2-vincenzo.frascino@arm.com>
 <20210125130204.GA4565@C02TD0UTHF1T.local>
 <ddc0f9e2-f63e-9c34-f0a4-067d1c5d63b8@arm.com> <20210125145911.GG25360@gaia>
 <4bd1c01b-613c-787f-4363-c55a071f14ae@arm.com> <20210125175630.GK25360@gaia>
 <62348cb4-0b2e-e17a-d930-8d41dc4200d3@arm.com> <20210126120754.GB20158@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e368874c-667e-0989-5a5c-f74f107cc03c@arm.com>
Date:   Tue, 26 Jan 2021 12:13:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126120754.GB20158@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/21 12:07 PM, Catalin Marinas wrote:
> On Tue, Jan 26, 2021 at 11:58:13AM +0000, Vincenzo Frascino wrote:
>> On 1/25/21 5:56 PM, Catalin Marinas wrote:
>>> On Mon, Jan 25, 2021 at 04:09:57PM +0000, Vincenzo Frascino wrote:
>>>> On 1/25/21 2:59 PM, Catalin Marinas wrote:
>>>>> On Mon, Jan 25, 2021 at 02:36:34PM +0000, Vincenzo Frascino wrote:
>>>>>> On 1/25/21 1:02 PM, Mark Rutland wrote:
>>>>>>> On Fri, Jan 22, 2021 at 03:56:40PM +0000, Vincenzo Frascino wrote:
>>>>>>>> Currently, the __is_lm_address() check just masks out the top 12 bits
>>>>>>>> of the address, but if they are 0, it still yields a true result.
>>>>>>>> This has as a side effect that virt_addr_valid() returns true even for
>>>>>>>> invalid virtual addresses (e.g. 0x0).
>>>>>>>>
>>>>>>>> Improve the detection checking that it's actually a kernel address
>>>>>>>> starting at PAGE_OFFSET.
>>>>>>>>
>>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>>>>>
>>>>>>> Looking around, it seems that there are some existing uses of
>>>>>>> virt_addr_valid() that expect it to reject addresses outside of the
>>>>>>> TTBR1 range. For example, check_mem_type() in drivers/tee/optee/call.c.
>>>>>>>
>>>>>>> Given that, I think we need something that's easy to backport to stable.
>>>>>>>
>>>>>>
>>>>>> I agree, I started looking at it this morning and I found cases even in the main
>>>>>> allocators (slub and page_alloc) either then the one you mentioned.
>>>>>>
>>>>>>> This patch itself looks fine, but it's not going to backport very far,
>>>>>>> so I suspect we might need to write a preparatory patch that adds an
>>>>>>> explicit range check to virt_addr_valid() which can be trivially
>>>>>>> backported.
>>>>>>>
>>>>>>
>>>>>> I checked the old releases and I agree this is not back-portable as it stands.
>>>>>> I propose therefore to add a preparatory patch with the check below:
>>>>>>
>>>>>> #define __is_ttrb1_address(addr)	((u64)(addr) >= PAGE_OFFSET && \
>>>>>> 					(u64)(addr) < PAGE_END)
>>>>>>
>>>>>> If it works for you I am happy to take care of it and post a new version of my
>>>>>> patches.
>>>>>
>>>>> I'm not entirely sure we need a preparatory patch. IIUC (it needs
>>>>> checking), virt_addr_valid() was fine until 5.4, broken by commit
>>>>> 14c127c957c1 ("arm64: mm: Flip kernel VA space"). Will addressed the
>>>>> flip case in 68dd8ef32162 ("arm64: memory: Fix virt_addr_valid() using
>>>>> __is_lm_address()") but this broke the <PAGE_OFFSET case. So in 5.4 a
>>>>> NULL address is considered valid.
>>>>>
>>>>> Ard's commit f4693c2716b3 ("arm64: mm: extend linear region for 52-bit
>>>>> VA configurations") changed the test to no longer rely on va_bits but
>>>>> did not change the broken semantics.
>>>>>
>>>>> If Ard's change plus the fix proposed in this test works on 5.4, I'd say
>>>>> we just merge this patch with the corresponding Cc stable and Fixes tags
>>>>> and tweak it slightly when doing the backports as it wouldn't apply
>>>>> cleanly. IOW, I wouldn't add another check to virt_addr_valid() as we
>>>>> did not need one prior to 5.4.
>>>>
>>>> Thank you for the detailed analysis. I checked on 5.4 and it seems that Ard
>>>> patch (not a clean backport) plus my proposed fix works correctly and solves the
>>>> issue.
>>>
>>> I didn't mean the backport of the whole commit f4693c2716b3 as it
>>> probably has other dependencies, just the __is_lm_address() change in
>>> that patch.
>>
>> Then call it preparatory patch ;)
> 
> It's preparatory only for the stable backports, not for current
> mainline. But I'd rather change the upstream patch when backporting to
> apply cleanly, no need for a preparatory stable patch.
> 

Thanks for the clarification.

-- 
Regards,
Vincenzo
