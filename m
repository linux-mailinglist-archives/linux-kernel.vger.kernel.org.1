Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8449E29DF59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgJ1WR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731479AbgJ1WRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:24 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98FC92463B;
        Wed, 28 Oct 2020 08:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603873879;
        bh=J6g0AqbAEP/c0mRSw7PxqwkYCWWynYDfVJIoiPicu+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABbTL6LyP3eDO/pmiB1lhfafE1cqAuUhHi6uUzJu6dIBhNl9DJbXR4myF5ARx/OiX
         /B9uLJRWycZNcbmMeWV8ULFDZXTw7Kxw6LArRDE49Cdf5CfGI/roGnnpgTiPnheE8N
         5QA1dQD6d87rn1aHO9MUWiwm1vksPKmunlJk4l4I=
Date:   Wed, 28 Oct 2020 10:31:12 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>
Subject: Re: [PATCH 1/3] mm, page_alloc: do not rely on the order of
 page_poison and init_on_alloc/free parameters
Message-ID: <20201028083112.GA1428094@kernel.org>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026173358.14704-2-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:33:56PM +0100, Vlastimil Babka wrote:
> Enabling page_poison=1 together with init_on_alloc=1 or init_on_free=1 produces
> a warning in dmesg that page_poison takes precendence. However, as these

                                          ^ precedence

> warnings are printed in early_param handlers for init_on_alloc/free, they are
> not printed if page_poison is enabled later on the command line (handlers are
> called in the order of their parameters), or when init_on_alloc/free is always
> enabled by the respective config option - before the page_poison early param
> handler is called, it is not considered to be enabled. This is inconsistent.
> 
> We can remove the dependency on order by making the init_on_* parameters only
> set a boolean variable, and postponing the evaluation after all early params
> have been processed. Introduce a new init_mem_debugging() function for that,
> and move the related debug_pagealloc processing there as well.
> 
> As a result init_mem_debugging() knows always accurately if init_on_* and/or
> page_poison options were enabled. Thus we can also optimize want_init_on_alloc()
> and want_init_on_free(). We don't need to check page_poisoning_enabled() there,
> we can instead not enable the init_on_* tracepoint at all, if page poisoning is
> enabled. This results in a simpler and more effective code.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

With two more nits below fixed

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mm.h | 20 ++--------
>  init/main.c        |  2 +-
>  mm/page_alloc.c    | 94 +++++++++++++++++++++++-----------------------
>  3 files changed, 50 insertions(+), 66 deletions(-)
> 

...

> @@ -792,6 +752,44 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>  				unsigned int order, int migratetype) {}
>  #endif
>  
> +/*
> + * Enable static keys related to various memory debugging and hardening options.
> + * Some override others, and depend on early params that are evaluated in the
> + * order of appearance. So we need to first gather the full picture of what was
> + * enabled, and then make decisions.
> + */
> +void init_mem_debugging()

Shouldn't it be init_mem_debug(void)?
Or whatever a new name would be :)

> +{
> +	if (_init_on_alloc_enabled_early) {
> +		if (page_poisoning_enabled()) {
> +			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> +				"will take precedence over init_on_alloc\n");
> +		} else {
> +			static_branch_enable(&init_on_alloc);
> +		}
> +	}
> +	if (_init_on_free_enabled_early) {
> +		if (page_poisoning_enabled()) {
> +			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> +				"will take precedence over init_on_free\n");
> +		} else {
> +			static_branch_enable(&init_on_free);
> +		}
> +	}

I think the braces for the inner ifs are not required.

> +
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +	if (!debug_pagealloc_enabled())
> +		return;
> +
> +	static_branch_enable(&_debug_pagealloc_enabled);
> +
> +	if (!debug_guardpage_minorder())
> +		return;
> +
> +	static_branch_enable(&_debug_guardpage_enabled);
> +#endif
> +}
> +
>  static inline void set_buddy_order(struct page *page, unsigned int order)
>  {
>  	set_page_private(page, order);
> -- 
> 2.29.0
> 
> 

-- 
Sincerely yours,
Mike.
