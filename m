Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870482B0248
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKLJwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:52:05 -0500
Received: from foss.arm.com ([217.140.110.172]:45634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgKLJwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:52:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54D9E139F;
        Thu, 12 Nov 2020 01:52:04 -0800 (PST)
Received: from [10.37.12.33] (unknown [10.37.12.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47B643F73C;
        Thu, 12 Nov 2020 01:52:01 -0800 (PST)
Subject: Re: [PATCH v9 32/44] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1605046192.git.andreyknvl@google.com>
 <25401c15dc19c7b672771f5b49a208d6e77bfeb5.1605046192.git.andreyknvl@google.com>
 <20201112093908.GE29613@gaia> <db6e3a5d-290f-d1b5-f130-503d7219b76b@arm.com>
 <20201112094553.GG29613@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6aec6a77-f9b0-cf73-6bf3-4f8df8f8cd13@arm.com>
Date:   Thu, 12 Nov 2020 09:55:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112094553.GG29613@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/20 9:45 AM, Catalin Marinas wrote:
> On Thu, Nov 12, 2020 at 09:45:45AM +0000, Vincenzo Frascino wrote:
>> On 11/12/20 9:39 AM, Catalin Marinas wrote:
>>> On Tue, Nov 10, 2020 at 11:10:29PM +0100, Andrey Konovalov wrote:
>>>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>>>> index 664c968dc43c..dbda6598c19d 100644
>>>> --- a/arch/arm64/kernel/mte.c
>>>> +++ b/arch/arm64/kernel/mte.c
>>>> @@ -129,6 +131,26 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>>>>  	return ptr;
>>>>  }
>>>>  
>>>> +void mte_init_tags(u64 max_tag)
>>>> +{
>>>> +	static bool gcr_kernel_excl_initialized = false;
>>>> +
>>>> +	if (!gcr_kernel_excl_initialized) {
>>>> +		/*
>>>> +		 * The format of the tags in KASAN is 0xFF and in MTE is 0xF.
>>>> +		 * This conversion extracts an MTE tag from a KASAN tag.
>>>> +		 */
>>>> +		u64 incl = GENMASK(FIELD_GET(MTE_TAG_MASK >> MTE_TAG_SHIFT,
>>>> +					     max_tag), 0);
>>>> +
>>>> +		gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
>>>> +		gcr_kernel_excl_initialized = true;
>>>> +	}
>>>> +
>>>> +	/* Enable the kernel exclude mask for random tags generation. */
>>>> +	write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
>>>> +}
>>>
>>> I don't think this function belongs to this patch. There is an earlier
>>> patch that talks about mte_init_tags() but no trace of it until this
>>> patch.
>>
>> Could you please point out to which patch are you referring to?
> 
> I replied to it already (or you can search ;)). But this patch is about
> switching GCR_EL1 on exception entry/exit rather than setting up the
> initial kernel GCR_EL1 value.
> 

Temporally after I asked ;) (I give you the benefit of delay of the mail server
;) ). I think that during the development the logic changed a bit, but I agree
that the comments are outdated. I am fine to move the code.

-- 
Regards,
Vincenzo
