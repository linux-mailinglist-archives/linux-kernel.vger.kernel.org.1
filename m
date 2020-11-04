Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637FB2A6C10
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbgKDRqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:46:15 -0500
Received: from foss.arm.com ([217.140.110.172]:41026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731989AbgKDRqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:46:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B93A139F;
        Wed,  4 Nov 2020 09:46:12 -0800 (PST)
Received: from [10.37.12.41] (unknown [10.37.12.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A09DC3F718;
        Wed,  4 Nov 2020 09:46:09 -0800 (PST)
Subject: Re: [PATCH v5 02/40] arm64: mte: Add in-kernel MTE helpers
To:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1602535397.git.andreyknvl@google.com>
 <94dfda607f7f7a28a5df9ee68703922aa9a52a1e.1602535397.git.andreyknvl@google.com>
 <CACT4Y+YhWM0MhS8wVsAmFmpBf4A8yDTLuV-JXtFYr79FJ9GGrQ@mail.gmail.com>
 <CAAeHK+wCO+J7D1_T89DG+jJrPLk3X9RsGFKxJGd0ZcUFjQT-9Q@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <03d63c72-52fa-70e1-ecb9-657b2f300acd@arm.com>
Date:   Wed, 4 Nov 2020 17:49:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wCO+J7D1_T89DG+jJrPLk3X9RsGFKxJGd0ZcUFjQT-9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey/Dmitry,

sorry I missed this one.

On 10/29/20 4:50 PM, Andrey Konovalov wrote:
> On Wed, Oct 28, 2020 at 12:28 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
> 
> [...]
> 
>>> +void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>>> +{
>>> +       void *ptr = addr;
>>> +
>>> +       if ((!system_supports_mte()) || (size == 0))
>>> +               return addr;
>>> +
>>> +       /* Make sure that size is MTE granule aligned. */
>>> +       WARN_ON(size & (MTE_GRANULE_SIZE - 1));
>>> +
>>> +       /* Make sure that the address is MTE granule aligned. */
>>> +       WARN_ON((u64)addr & (MTE_GRANULE_SIZE - 1));
>>> +
>>> +       tag = 0xF0 | tag;
>>> +       ptr = (void *)__tag_set(ptr, tag);
>>> +
>>> +       mte_assign_mem_tag_range(ptr, size);
>>
>> This function will be called on production hot paths. I think it makes
>> sense to shave off some overheads here.
>>
>> The additional debug checks may be useful, so maybe we need an
>> additional debug mode (debug of MTE/KASAN itself)?
>>
>> Do we ever call this when !system_supports_mte()? I think we wanted to
>> have static_if's higher up the stack. Having additional checks
>> scattered across lower-level functions is overhead for every
>> malloc/free.
>>
>> Looking at how this is called from KASAN code.
>> KASAN code already ensures addr/size are properly aligned. I think we
>> should either remove the duplicate alignment checks, or do them only
>> in the additional debugging mode.
>> Does KASAN also ensure proper tag value (0xF0 mask)?
>>
>> KASAN wrapper is inlined in this patch:
>> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3699
>> but here we still have 2 non-inlined calls. The
>> mte_assign_mem_tag_range is kinda inherent since it's in .S. But then
>> I think this wrapper should be inlinable.
>>
>> Also, can we move mte_assign_mem_tag_range into inline asm in the
>> header? This would avoid register spills around the call in
>> malloc/free.
>>
>> The asm code seems to do the rounding of the size up at no additional
>> cost (checks remaining size > 0, right?). I think it makes sense to
>> document that as the contract and remove the additional round_up(size,
>> KASAN_GRANULE_SIZE) in KASAN code.
> 
> These are all valid concerns. It would be great to have inline asm
> mte_assign_mem_tag_range() implementation. We can also call it
> directly from KASAN code without all these additional checks.
> 
> Perhaps it makes sense to include this change into the other series
> that adds the production mode. And then squash if we decide to put
> both changes into a single one.
> 
> Vincenzo, could you write a patch that adds inline asm
> mte_assign_mem_tag_range() implementation?
> 

As Andrey said those are valid concerns, this function was originally thought
for the debugging version of kasan, but since we are planning to use it in
production the inline optimization sounds a good approach.

-- 
Regards,
Vincenzo
