Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0A2C42C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgKYPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:20:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:33066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbgKYPUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:20:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89670AC22;
        Wed, 25 Nov 2020 15:20:17 +0000 (UTC)
Subject: Re: [PATCH] [RFC] init/main: fix broken buffer_init when
 DEFERRED_STRUCT_PAGE_INIT set
To:     Lin Feng <linf@wangsu.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net
References: <20201123110500.103523-1-linf@wangsu.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <06a3d903-1f27-16c5-b45b-92ec56a47e96@suse.cz>
Date:   Wed, 25 Nov 2020 16:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123110500.103523-1-linf@wangsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 12:05 PM, Lin Feng wrote:
> In the booting phase if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set,
> we have following callchain:
> 
> start_kernel
> ...
>    mm_init
>      mem_init
>       memblock_free_all
>         reset_all_zones_managed_pages
>         free_low_memory_core_early
> ...
>    buffer_init
>      nr_free_buffer_pages
>        zone->managed_pages
> ...
>    rest_init
>      kernel_init
>        kernel_init_freeable
>          page_alloc_init_late
>            kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
>            wait_for_completion(&pgdat_init_all_done_comp);
>            ...
>            files_maxfiles_init
> 
> It's clear that buffer_init depends on zone->managed_pages, but it's reset
> in reset_all_zones_managed_pages after that pages are readded into
>   zone->managed_pages, but when buffer_init runs this process is half done
>   and most of them will finally be added till deferred_init_memmap done.
> In large memory couting of nr_free_buffer_pages drifts too much, also
> drifting from kernels to kernels on same hardware.
> 
> Fix is simple, it delays buffer_init run till deferred_init_memmap all done.

Hmm nobody should need bh_cachep to allocate buffer heads until then, right.

> But as corrected by this patch, max_buffer_heads becomes very large,
> the value is roughly as many as 4 times of totalram_pages, formula:
> max_buffer_heads = nrpages * (10%) * (PAGE_SIZE / sizeof(struct buffer_head));
> 
> Say in a 64GB memory box we have 16777216 pages, then max_buffer_heads
> turns out to be roughly 67,108,864.
> In common cases, should a buffer_head be mapped to one page/block(4KB)?
> So max_buffer_heads never exceeds totalram_pages.
> IMO it's likely to make buffer_heads_over_limit bool value alwasy false,
> then make codes 'if (buffer_heads_over_limit)' test in vmscan unnecessary.
> Correct me if it's not true.

Maybe we could compile that out with CONFIG_HIGHMEM then?

> So this patch will change the original behavior related to
> buffer_heads_over_limit in vmscan since we used a half done value
> of zone->managed_pages before, or should we use a smaller factor(<10%) in
> previous formula.
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   init/main.c     | 2 --
>   mm/page_alloc.c | 3 +++
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 20baced721ad..a3f7c3416286 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -58,7 +58,6 @@
>   #include <linux/rmap.h>
>   #include <linux/mempolicy.h>
>   #include <linux/key.h>
> -#include <linux/buffer_head.h>
>   #include <linux/page_ext.h>
>   #include <linux/debug_locks.h>
>   #include <linux/debugobjects.h>
> @@ -1034,7 +1033,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>   	fork_init();
>   	proc_caches_init();
>   	uts_ns_init();
> -	buffer_init();
>   	key_init();
>   	security_init();
>   	dbg_late_init();
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eaa227a479e4..2931d706fb52 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -70,6 +70,7 @@
>   #include <linux/psi.h>
>   #include <linux/padata.h>
>   #include <linux/khugepaged.h>
> +#include <linux/buffer_head.h>
>   
>   #include <asm/sections.h>
>   #include <asm/tlbflush.h>
> @@ -2103,6 +2104,8 @@ void __init page_alloc_init_late(void)
>   	files_maxfiles_init();
>   #endif
>   
> +	buffer_init();
> +
>   	/* Discard memblock private memory */
>   	memblock_discard();
>   
> 

