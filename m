Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9792B097F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgKLQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728233AbgKLQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605197231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzIecgZVE7wohi6AM6G+DH66BTu4wHaS8qfp+7laKBc=;
        b=NiaIY10gip2ad4EoNo8ura3mefGsUBdmt2xo5q15xm+tX3GY6x1v4FHfRROfDFSEowxzqO
        PZARqawGhpppZZXe425ZjRuNpLjvBceMrVUdjIlOrJRojdkhoRyNRee5ztrbLNzM3fVuHf
        4bEtfA8HALqdy13KUkJXgEUpsGG2Nhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-vOE-XfZeODqK7s9xrtSg7w-1; Thu, 12 Nov 2020 11:07:04 -0500
X-MC-Unique: vOE-XfZeODqK7s9xrtSg7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB581040C5A;
        Thu, 12 Nov 2020 16:06:41 +0000 (UTC)
Received: from [10.36.115.61] (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E1A35D9E8;
        Thu, 12 Nov 2020 16:06:39 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] mm, page_poison: use static key more efficiently
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>
References: <20201103152237.9853-1-vbabka@suse.cz>
 <20201103152237.9853-3-vbabka@suse.cz>
 <796d64ea-5b40-b8a3-fb36-f15708e60d94@redhat.com>
 <c4eb5301-0435-d296-5d32-a76ac58787b2@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4dea1223-a2bf-89ec-afe7-72a3218e61a9@redhat.com>
Date:   Thu, 12 Nov 2020 17:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c4eb5301-0435-d296-5d32-a76ac58787b2@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.20 15:37, Vlastimil Babka wrote:
> On 11/11/20 4:38 PM, David Hildenbrand wrote:
>> On 03.11.20 16:22, Vlastimil Babka wrote:
>>> Commit 11c9c7edae06 ("mm/page_poison.c: replace bool variable with static key")
>>> changed page_poisoning_enabled() to a static key check. However, the function
>>> is not inlined, so each check still involves a function call with overhead not
>>> eliminated when page poisoning is disabled.
>>>
>>> Analogically to how debug_pagealloc is handled, this patch converts
>>> page_poisoning_enabled() back to boolean check, and introduces
>>> page_poisoning_enabled_static() for fast paths. Both functions are inlined.
>>>
>>> The function kernel_poison_pages() is also called unconditionally and does
>>> the static key check inside. Remove it from there and put it to callers. Also
>>> split it to two functions kernel_poison_pages() and kernel_unpoison_pages()
>>> instead of the confusing bool parameter.
>>>
>>> Also optimize the check that enables page poisoning instead of debug_pagealloc
>>> for architectures without proper debug_pagealloc support. Move the check to
>>> init_mem_debugging_and_hardening() to enable a single static key instead of
>>> having two static branches in page_poisoning_enabled_static().
>>
>> [...]
>>
>>> + * For use in fast paths after init_mem_debugging() has run, or when a
>>> + * false negative result is not harmful when called too early.
>>> + */
>>> +static inline bool page_poisoning_enabled_static(void)
>>> +{
>>> +	return (static_branch_unlikely(&_page_poisoning_enabled));
>>
>> As already mentioned IIRC:
> 
> Yes, it was, and I thought I fixed it. Guess not.
> 
>> return static_branch_unlikely(&_page_poisoning_enabled);
>>
>>> +}
> 
>>> @@ -1260,7 +1271,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
>>>    	if (want_init_on_free())
>>>    		kernel_init_free_pages(page, 1 << order);
>>>    
>>> -	kernel_poison_pages(page, 1 << order, 0);
>>> +	if (page_poisoning_enabled_static())
>>> +		kernel_poison_pages(page, 1 << order);
>>
>> This would look much better by having kernel_poison_pages() simply be
>> implemented in a header, where the static check is performed.
>>
>> Take a look at how it's handled in mm/shuffle.h
>    
> Ok. Fixup below.
> 
> ----8<----
> 
>   From 7ce26ba61296f583f0f9089e7887f07424f25d2c Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 12 Nov 2020 15:20:58 +0100
> Subject: [PATCH] mm, page_poison: use static key more efficiently-fix
> 
> Non-functional cleanups, per David Hildenbrand.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>    include/linux/mm.h | 16 +++++++++++++---
>    mm/page_alloc.c    |  7 +++----
>    mm/page_poison.c   |  4 ++--
>    3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4d6dd9f44571..861b9392b5dc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2867,8 +2867,8 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
>    
>    extern void init_mem_debugging_and_hardening(void);
>    #ifdef CONFIG_PAGE_POISONING
> -extern void kernel_poison_pages(struct page *page, int numpages);
> -extern void kernel_unpoison_pages(struct page *page, int numpages);
> +extern void __kernel_poison_pages(struct page *page, int numpages);
> +extern void __kernel_unpoison_pages(struct page *page, int numpages);
>    extern bool _page_poisoning_enabled_early;
>    DECLARE_STATIC_KEY_FALSE(_page_poisoning_enabled);
>    static inline bool page_poisoning_enabled(void)
> @@ -2881,7 +2881,17 @@ static inline bool page_poisoning_enabled(void)
>     */
>    static inline bool page_poisoning_enabled_static(void)
>    {
> -	return (static_branch_unlikely(&_page_poisoning_enabled));
> +	return static_branch_unlikely(&_page_poisoning_enabled);
> +}
> +static inline void kernel_poison_pages(struct page *page, int numpages)
> +{
> +	if (page_poisoning_enabled_static())
> +		__kernel_poison_pages(page, numpages);
> +}
> +static inline void kernel_unpoison_pages(struct page *page, int numpages)
> +{
> +	if (page_poisoning_enabled_static())
> +		__kernel_unpoison_pages(page, numpages);
>    }
>    #else
>    static inline bool page_poisoning_enabled(void) { return false; }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fd7f9345adc0..1388b5939551 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1271,8 +1271,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
>    	if (want_init_on_free())
>    		kernel_init_free_pages(page, 1 << order);
>    
> -	if (page_poisoning_enabled_static())
> -		kernel_poison_pages(page, 1 << order);
> +	kernel_poison_pages(page, 1 << order);
> +
>    	/*
>    	 * arch_free_page() can make the page's contents inaccessible.  s390
>    	 * does this.  So nothing which can access the page's contents should
> @@ -2281,8 +2281,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>    	if (debug_pagealloc_enabled_static())
>    		kernel_map_pages(page, 1 << order, 1);
>    	kasan_alloc_pages(page, order);
> -	if (page_poisoning_enabled_static())
> -		kernel_unpoison_pages(page, 1 << order);
> +	kernel_unpoison_pages(page, 1 << order);
>    	set_page_owner(page, order, gfp_flags);
>    }
>    
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index dd7aeada036f..4d75fc9ccc7a 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -30,7 +30,7 @@ static void poison_page(struct page *page)
>    	kunmap_atomic(addr);
>    }
>    
> -void kernel_poison_pages(struct page *page, int n)
> +void __kernel_poison_pages(struct page *page, int n)
>    {
>    	int i;
>    
> @@ -89,7 +89,7 @@ static void unpoison_page(struct page *page)
>    	kunmap_atomic(addr);
>    }
>    
> -void kernel_unpoison_pages(struct page *page, int n)
> +void __kernel_unpoison_pages(struct page *page, int n)
>    {
>    	int i;
>    
> 

LGTM.

-- 
Thanks,

David / dhildenb

