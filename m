Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90EA2D46EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgLIQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:39:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:59240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgLIQjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:39:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C964EAB63;
        Wed,  9 Dec 2020 16:38:27 +0000 (UTC)
Subject: Re: [PATCH v2] mm/page_owner: Record timestamp and pid
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lmark@codeaurora.org
References: <20201209125153.10533-1-georgi.djakov@linaro.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <20f7fb50-5e21-3ad8-50cd-81b56c9e45b1@suse.cz>
Date:   Wed, 9 Dec 2020 17:38:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209125153.10533-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 1:51 PM, Georgi Djakov wrote:
> From: Liam Mark <lmark@codeaurora.org>
> 
> Collect the time for each allocation recorded in page owner so that
> allocation "surges" can be measured.
> 
> Record the pid for each allocation recorded in page owner so that
> the source of allocation "surges" can be better identified.
> 
> The above is very useful when doing memory analysis. On a crash for
> example, we can get this information from kdump (or ramdump) and parse
> it to figure out memory allocation problems.

Yes, I can imagine this to be useful.

> Please note that on x86_64 this increases the size of struct page_owner
> from 16 bytes to 32.

That's the tradeoff, but it's not a functionality intended for production, so
unless somebody says they need to enable page_owner for debugging and this
increase prevents them from fitting into available memory, let's not complicate
things with making this optional.

> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> 
> v2:
> - Improve the commit message (Andrew and Vlastimil)
> - Update page_owner.rst with more recent object size information (Andrew)
> - Use pid_t for the pid (Andrew)
> - Print the info also in __dump_page_owner() (Vlastimil)
> 
> v1: https://lore.kernel.org/r/20201112184106.733-1-georgi.djakov@linaro.org/
> 
> 
>  Documentation/vm/page_owner.rst | 12 ++++++------
>  mm/page_owner.c                 | 17 +++++++++++++----
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 02deac76673f..cf7c0c361621 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -41,17 +41,17 @@ size change due to this facility.
>  - Without page owner::
>  
>     text    data     bss     dec     hex filename
> -   40662   1493     644   42799    a72f mm/page_alloc.o
> +  48392    2333     644   51369    c8a9 mm/page_alloc.o
>  
>  - With page owner::
>  
>     text    data     bss     dec     hex filename
> -   40892   1493     644   43029    a815 mm/page_alloc.o
> -   1427      24       8    1459     5b3 mm/page_ext.o
> -   2722      50       0    2772     ad4 mm/page_owner.o
> +  48800    2445     644   51889    cab1 mm/page_alloc.o
> +   6574     108      29    6711    1a37 mm/page_owner.o
> +   1025       8       8    1041     411 mm/page_ext.o
>  
> -Although, roughly, 4 KB code is added in total, page_alloc.o increase by
> -230 bytes and only half of it is in hotpath. Building the kernel with
> +Although, roughly, 8 KB code is added in total, page_alloc.o increase by
> +520 bytes and less than half of it is in hotpath. Building the kernel with
>  page owner and turning it on if needed would be great option to debug
>  kernel memory problem.
>  
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index b735a8eafcdb..af464bb7fbe7 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -10,6 +10,7 @@
>  #include <linux/migrate.h>
>  #include <linux/stackdepot.h>
>  #include <linux/seq_file.h>
> +#include <linux/sched/clock.h>
>  
>  #include "internal.h"
>  
> @@ -25,6 +26,8 @@ struct page_owner {
>  	gfp_t gfp_mask;
>  	depot_stack_handle_t handle;
>  	depot_stack_handle_t free_handle;
> +	u64 ts_nsec;
> +	pid_t pid;
>  };
>  
>  static bool page_owner_enabled = false;
> @@ -172,6 +175,8 @@ static inline void __set_page_owner_handle(struct page *page,
>  		page_owner->order = order;
>  		page_owner->gfp_mask = gfp_mask;
>  		page_owner->last_migrate_reason = -1;
> +		page_owner->pid = current->pid;
> +		page_owner->ts_nsec = local_clock();
>  		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
>  		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>  
> @@ -236,6 +241,8 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
>  	new_page_owner->last_migrate_reason =
>  		old_page_owner->last_migrate_reason;
>  	new_page_owner->handle = old_page_owner->handle;
> +	new_page_owner->pid = old_page_owner->pid;
> +	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
>  
>  	/*
>  	 * We don't clear the bit on the oldpage as it's going to be freed
> @@ -349,9 +356,10 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		return -ENOMEM;
>  
>  	ret = snprintf(kbuf, count,
> -			"Page allocated via order %u, mask %#x(%pGg)\n",
> +			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns\n",
>  			page_owner->order, page_owner->gfp_mask,
> -			&page_owner->gfp_mask);
> +			&page_owner->gfp_mask, page_owner->pid,
> +			page_owner->ts_nsec);
>  
>  	if (ret >= count)
>  		goto err;
> @@ -427,8 +435,9 @@ void __dump_page_owner(struct page *page)
>  	else
>  		pr_alert("page_owner tracks the page as freed\n");
>  
> -	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg)\n",
> -		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask);
> +	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu\n",
> +		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
> +		 page_owner->pid, page_owner->ts_nsec);
>  
>  	handle = READ_ONCE(page_owner->handle);
>  	if (!handle) {
> 

