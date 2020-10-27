Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE329A74F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509590AbgJ0JHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408749AbgJ0JHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603789656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfnTJiAmD6eL990WPNghr/NJ26oGL+XhgGB5yIi2I6Y=;
        b=YaZ/ncPewqk4KCP4W6BpGL6XAjH2lPnOsr5SDn7pA2dC+2p6IrSMLISLfzXeJ2VVMtfUV2
        v9+bpv3xbKe+TNMYw5VxbnGR+j56pQGU0N58omCByMzzMDcE0WewOoefQ41883xMsZuotu
        wCUdvMVQJHqgSBLVvfW3uVbTqEFvhKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-74QlMOsKMKCNEHE_ukwAEg-1; Tue, 27 Oct 2020 05:07:32 -0400
X-MC-Unique: 74QlMOsKMKCNEHE_ukwAEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 234BD186842C;
        Tue, 27 Oct 2020 09:07:31 +0000 (UTC)
Received: from [10.36.113.185] (ovpn-113-185.ams2.redhat.com [10.36.113.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A31C12C31E;
        Tue, 27 Oct 2020 09:07:29 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm, page_poison: use static key more efficiently
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-3-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4e35c52a-800a-4a60-2ef5-dd70a4f774c6@redhat.com>
Date:   Tue, 27 Oct 2020 10:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201026173358.14704-3-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.20 18:33, Vlastimil Babka wrote:
> Commit 11c9c7edae06 ("mm/page_poison.c: replace bool variable with static key")
> changed page_poisoning_enabled() to a static key check. However, the function
> is not inlined, so each check still involves a function call with overhead not
> eliminated when page poisoning is disabled.
> 
> Analogically to how debug_pagealloc is handled, this patch converts
> page_poisoning_enabled() back to boolean check, and introduces
> page_poisoning_enabled_static() for fast paths. Both functions are inlined.
> 
> Also optimize the check that enables page poisoning instead of debug_pagealloc
> for architectures without proper debug_pagealloc support. Move the check to
> init_mem_debugging() to enable a single static key instead of having two
> static branches in page_poisoning_enabled_static().
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

[...]

> +/*
> + * For use in fast paths after init_mem_debugging() has run, or when a
> + * false negative result is not harmful when called too early.
> + */
> +static inline bool page_poisoning_enabled_static(void)
> +{
> +	return (static_branch_unlikely(&_page_poisoning_enabled));


return static_branch_unlikely(&_page_poisoning_enabled);

> +}
>   #else
>   static inline bool page_poisoning_enabled(void) { return false; }
> +static inline bool page_poisoning_enabled_static(void) { return false; }
>   static inline void kernel_poison_pages(struct page *page, int numpages,
>   					int enable) { }
>   #endif
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b168c58ef337..2a1be197649d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -777,6 +777,17 @@ void init_mem_debugging()
>   		}
>   	}
>   
> +#ifdef CONFIG_PAGE_POISONING
> +	/*
> +	 * Page poisoning is debug page alloc for some arches. If
> +	 * either of those options are enabled, enable poisoning.
> +	 */
> +	if (page_poisoning_enabled() ||
> +			(!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
> +			debug_pagealloc_enabled()))

Weird indentation

if (page_poisoning_enabled() ||
     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
      debug_pagealloc_enabled()))


> +		static_branch_enable(&_page_poisoning_enabled);
> +#endif
> +
>   #ifdef CONFIG_DEBUG_PAGEALLOC
>   	if (!debug_pagealloc_enabled())
>   		return;
> @@ -2208,7 +2219,7 @@ static inline int check_new_page(struct page *page)
>   static inline bool free_pages_prezeroed(void)
>   {
>   	return (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) &&
> -		page_poisoning_enabled()) || want_init_on_free();
> +		page_poisoning_enabled_static()) || want_init_on_free();
>   }

Apart from that LGTM.

-- 
Thanks,

David / dhildenb

