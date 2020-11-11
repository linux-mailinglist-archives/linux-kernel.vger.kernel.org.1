Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE82AF52A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgKKPit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbgKKPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605109119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgCJFGoKSDXxCJD2v8OUJZtywEr7v4SOSJ3WPrTyINQ=;
        b=OZOju3ADdyaBsp+YeQarcpOxfxrDlAX9aOvZZmfWwIJiOey9sq5mW0tEgvzfiuZzfETr9a
        CFX65b5dze5a7yYRlAC1xh/QB6f302mXRPkc5vwyIX05slQfwtCx8Rzv1hcRWKULkoO8gj
        a18SO4TN22fgFqcqT3IpsytnRV047II=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-AvtbgEswNM2JkGPpk2XxFg-1; Wed, 11 Nov 2020 10:38:36 -0500
X-MC-Unique: AvtbgEswNM2JkGPpk2XxFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE2651085988;
        Wed, 11 Nov 2020 15:38:34 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D870F1007635;
        Wed, 11 Nov 2020 15:38:32 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <796d64ea-5b40-b8a3-fb36-f15708e60d94@redhat.com>
Date:   Wed, 11 Nov 2020 16:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201103152237.9853-3-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.20 16:22, Vlastimil Babka wrote:
> Commit 11c9c7edae06 ("mm/page_poison.c: replace bool variable with static key")
> changed page_poisoning_enabled() to a static key check. However, the function
> is not inlined, so each check still involves a function call with overhead not
> eliminated when page poisoning is disabled.
> 
> Analogically to how debug_pagealloc is handled, this patch converts
> page_poisoning_enabled() back to boolean check, and introduces
> page_poisoning_enabled_static() for fast paths. Both functions are inlined.
> 
> The function kernel_poison_pages() is also called unconditionally and does
> the static key check inside. Remove it from there and put it to callers. Also
> split it to two functions kernel_poison_pages() and kernel_unpoison_pages()
> instead of the confusing bool parameter.
> 
> Also optimize the check that enables page poisoning instead of debug_pagealloc
> for architectures without proper debug_pagealloc support. Move the check to
> init_mem_debugging_and_hardening() to enable a single static key instead of
> having two static branches in page_poisoning_enabled_static().

[...]

> + * For use in fast paths after init_mem_debugging() has run, or when a
> + * false negative result is not harmful when called too early.
> + */
> +static inline bool page_poisoning_enabled_static(void)
> +{
> +	return (static_branch_unlikely(&_page_poisoning_enabled));

As already mentioned IIRC:

return static_branch_unlikely(&_page_poisoning_enabled);

> +}
>   #else
>   static inline bool page_poisoning_enabled(void) { return false; }
> -static inline void kernel_poison_pages(struct page *page, int numpages,
> -					int enable) { }
> +static inline bool page_poisoning_enabled_static(void) { return false; }
> +static inline void kernel_poison_pages(struct page *page, int numpages) { }
> +static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
>   #endif
>   
>   DECLARE_STATIC_KEY_FALSE(init_on_alloc);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 44d596c9c764..fd7f9345adc0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -775,6 +775,17 @@ void init_mem_debugging_and_hardening(void)
>   			static_branch_enable(&init_on_free);
>   	}
>   
> +#ifdef CONFIG_PAGE_POISONING
> +	/*
> +	 * Page poisoning is debug page alloc for some arches. If
> +	 * either of those options are enabled, enable poisoning.
> +	 */
> +	if (page_poisoning_enabled() ||
> +	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
> +	      debug_pagealloc_enabled()))
> +		static_branch_enable(&_page_poisoning_enabled);
> +#endif
> +
>   #ifdef CONFIG_DEBUG_PAGEALLOC
>   	if (!debug_pagealloc_enabled())
>   		return;
> @@ -1260,7 +1271,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
>   	if (want_init_on_free())
>   		kernel_init_free_pages(page, 1 << order);
>   
> -	kernel_poison_pages(page, 1 << order, 0);
> +	if (page_poisoning_enabled_static())
> +		kernel_poison_pages(page, 1 << order);

This would look much better by having kernel_poison_pages() simply be 
implemented in a header, where the static check is performed.

Take a look at how it's handled in mm/shuffle.h

-- 
Thanks,

David / dhildenb

