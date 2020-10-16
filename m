Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534472902F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395452AbgJPKlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 06:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:50508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395431AbgJPKlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 06:41:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B892DAB5C;
        Fri, 16 Oct 2020 10:41:04 +0000 (UTC)
To:     Zhenhua Huang <zhenhuah@codeaurora.org>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1602839640-13125-1-git-send-email-zhenhuah@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix page_owner initializing issue for arm32
Message-ID: <1a1a80b8-2ce4-9346-f333-68f3bb8b25c0@suse.cz>
Date:   Fri, 16 Oct 2020 12:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <1602839640-13125-1-git-send-email-zhenhuah@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 11:14 AM, Zhenhua Huang wrote:
> Page owner of pages used by page owner itself used is missing on arm32 targets.
> The reason is dummy_handle and failure_handle is not initialized correctly.
> Buddy allocator is used to initialize these two handles. However, buddy
> allocator is not ready when page owner calls it. This change fixed that by
> initializing page owner after buddy initialization.
> 
> The working flow before and after this change are:
> original logic:
> 1. allocated memory for page_ext(using memblock).
> 2. invoke the init callback of page_ext_ops like
> page_owner(using buddy allocator).
> 3. initialize buddy.
> 
> after this change:
> 1. allocated memory for page_ext(using memblock).
> 2. initialize buddy.
> 3. invoke the init callback of page_ext_ops like
> page_owner(using buddy allocator).
> 
> with the change, failure/dummy_handle can get its correct value and
> page owner output for example has the one for page owner itself:
> Page allocated via order 2, mask 0x6202c0(GFP_USER|__GFP_NOWARN), pid 1006, ts
> 67278156558 ns
> PFN 543776 type Unmovable Block 531 type Unmovable Flags 0x0()
>   init_page_owner+0x28/0x2f8
>   invoke_init_callbacks_flatmem+0x24/0x34
>   start_kernel+0x33c/0x5d8
>     (null)

register_dummy_stack should also appear in the above. Either one too many is 
skipped in arm32 stack saving, or the noinline is not honoured. Could be 
investigated separately.

> 
> Signed-off-by: Zhenhua Huang <zhenhuah@codeaurora.org>

This should be safe, as the sparse variant page_ext_init() runs even later, so:

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> ---
>   include/linux/page_ext.h | 8 ++++++++
>   init/main.c              | 2 ++
>   mm/page_ext.c            | 8 +++++++-
>   3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index cfce186..aff81ba 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -44,8 +44,12 @@ static inline void page_ext_init_flatmem(void)
>   {
>   }
>   extern void page_ext_init(void);
> +static inline void page_ext_init_flatmem_late(void)
> +{
> +}
>   #else
>   extern void page_ext_init_flatmem(void);
> +extern void page_ext_init_flatmem_late(void);
>   static inline void page_ext_init(void)
>   {
>   }
> @@ -76,6 +80,10 @@ static inline void page_ext_init(void)
>   {
>   }
>   
> +static inline void page_ext_init_flatmem_late(void)
> +{
> +}
> +
>   static inline void page_ext_init_flatmem(void)
>   {
>   }
> diff --git a/init/main.c b/init/main.c
> index 130376e..b34c475 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -818,6 +818,8 @@ static void __init mm_init(void)
>   	init_debug_pagealloc();
>   	report_meminit();
>   	mem_init();
> +	/* page_owner must be initialized after buddy is ready */
> +	page_ext_init_flatmem_late();
>   	kmem_cache_init();
>   	kmemleak_init();
>   	pgtable_init();
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index a3616f7..373f7a1 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -99,6 +99,13 @@ static void __init invoke_init_callbacks(void)
>   	}
>   }
>   
> +#if !defined(CONFIG_SPARSEMEM)

#ifndef is more common if you don't need boolean ops on multiple configs

> +void __init page_ext_init_flatmem_late(void)
> +{
> +	invoke_init_callbacks();
> +}
> +#endif
> +
>   static inline struct page_ext *get_entry(void *base, unsigned long index)
>   {
>   	return base + page_ext_size * index;
> @@ -177,7 +184,6 @@ void __init page_ext_init_flatmem(void)
>   			goto fail;
>   	}
>   	pr_info("allocated %ld bytes of page_ext\n", total_usage);
> -	invoke_init_callbacks();
>   	return;
>   
>   fail:
> 

