Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426932A9593
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgKFLnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:43:22 -0500
Received: from foss.arm.com ([217.140.110.172]:36148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFLnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:43:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9E07147A;
        Fri,  6 Nov 2020 03:43:16 -0800 (PST)
Received: from [10.37.12.46] (unknown [10.37.12.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 565C13F719;
        Fri,  6 Nov 2020 03:43:14 -0800 (PST)
Subject: Re: [PATCH v8 28/43] arm64: mte: Reset the page tag in page->flags
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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
References: <cover.1604531793.git.andreyknvl@google.com>
 <fc9e96c022a147120b67056525362abb43b2a0ce.1604531793.git.andreyknvl@google.com>
 <20201105155859.GA30030@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <01a55e00-0d82-7e62-cc40-c282149dbb08@arm.com>
Date:   Fri, 6 Nov 2020 11:46:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105155859.GA30030@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 11/5/20 3:59 PM, Catalin Marinas wrote:
> On Thu, Nov 05, 2020 at 12:18:43AM +0100, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 8f99c65837fd..06ba6c923ab7 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -34,6 +34,7 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>>  			return;
>>  	}
>>  
>> +	page_kasan_tag_reset(page);
>>  	mte_clear_page_tags(page_address(page));
> 
> I think we need an smp_wmb() between setting the flags and clearing the
> actual tags. If another threads reads page->flags and builds a tagged
> address out of it (see page_to_virt) there's an address dependency to
> the actual memory access. However, on the current thread, we don't
> guarantee that the new page->flags are visible before the tags were
> updated.
> 

Indeed, and I will add a comment as well to explain why.

>>  }
>>  
>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>> index 70a71f38b6a9..348f4627da08 100644
>> --- a/arch/arm64/mm/copypage.c
>> +++ b/arch/arm64/mm/copypage.c
>> @@ -22,6 +22,7 @@ void copy_highpage(struct page *to, struct page *from)
>>  	copy_page(kto, kfrom);
>>  
>>  	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
>> +		page_kasan_tag_reset(to);
>>  		set_bit(PG_mte_tagged, &to->flags);
>>  		mte_copy_page_tags(kto, kfrom);
> 
> Nitpick: move page_kasan_tag_reset() just above mte_copy_page_tags() for
> consistency with the other places where PG_mte_tagged is set before or
> after the actual tag setting.
> 

Fine, I will add it to the next iteration.

>>  	}
>> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
>> index c52c1847079c..0e7eccbe598a 100644
>> --- a/arch/arm64/mm/mteswap.c
>> +++ b/arch/arm64/mm/mteswap.c
>> @@ -53,6 +53,7 @@ bool mte_restore_tags(swp_entry_t entry, struct page *page)
>>  	if (!tags)
>>  		return false;
>>  
>> +	page_kasan_tag_reset(page);
>>  	mte_restore_page_tags(page_address(page), tags);

I just realized based on your comment above that we need smp_wmb() here as well.
I will add it with a comment as well.

> 
> There is another mte_restore_page_tags() caller in hibernate.c. That one
> doesn't need page_kasan_tag_reset() since the page->flags would have
> been already restored but please add a comment in that file why its not
> needed.
> 

Yes I will do, I agree on the reasoning, I will report it in the comments.

-- 
Regards,
Vincenzo
