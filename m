Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602282C65B1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgK0MXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:23:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:35652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgK0MXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606479828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ng2/Ugmp8ecll2pI050So3NqNDeLyF5Nm/J+RZ681Bg=;
        b=svm+PTe2w4AfSBW10on4vxezJqJHdQK9XoRgPm8jQRc2qos71ordZVtGD5fnZWktZ+Jy4R
        B4bsNXOWTF8GPKV1L0bQtvYyZTd9C8bCDPC8OjuQ0TF/0fpCH9kj8LUfCauxkyQ4uVZBnS
        pDOTg/ThAJDNwLL6mkAjFxPd7tYVEZw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F363ABD7;
        Fri, 27 Nov 2020 12:23:48 +0000 (UTC)
Date:   Fri, 27 Nov 2020 13:23:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] mm/page_alloc: clear all pages in post_alloc_hook()
 with init_on_alloc=1
Message-ID: <20201127122347.GR31550@dhcp22.suse.cz>
References: <20201120180452.19071-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120180452.19071-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-11-20 19:04:52, David Hildenbrand wrote:
> commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
> init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
> leaving the buddy via alloc_pages() and friends to be
> initialized/cleared/zeroed on allocation.
> 
> However, the same logic is currently not applied to
> alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
> with init_on_alloc=1 and init_on_free=0. Let's also properly clear
> pages on that allocation path.
> 
> To achieve that, let's move clearing into post_alloc_hook(). This will not
> only affect alloc_contig_pages() allocations but also any pages used as
> migration target in compaction code via compaction_alloc().
> 
> While this sounds sub-optimal, it's the very same handling as when
> allocating migration targets via alloc_migration_target() - pages will
> get properly cleared with init_on_free=1. In case we ever want to optimize
> migration in that regard, we should tackle all such migration users - if we
> believe migration code can be fully trusted.
> 
> With this change, we will see double clearing of pages in some
> cases. One example are gigantic pages (either allocated via CMA, or
> allocated dynamically via alloc_contig_pages()) - which is the right
> thing to do (and to be optimized outside of the buddy in the callers) as
> discussed in:
>   https://lkml.kernel.org/r/20201019182853.7467-1-gpiccoli@canonical.com
> 
> This change implies that with init_on_alloc=1
> - All CMA allocations will be cleared
> - Gigantic pages allocated via alloc_contig_pages() will be cleared
> - virtio-mem memory to be unplugged will be cleared. While this is
>   suboptimal, it's similar to memory balloon drivers handling, where
>   all pages to be inflated will get cleared as well.
> - Pages isolated for compaction will be cleared

Yes, this looks much better than the previous version. Thanks for
looking into it deeper!

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Btw. I think we would benefit from a documentation which would explain
what is the purpose of the two parts of the initialization. What does
belong to prep_new_page resp. post_alloc_hook.

Thanks!
> ---
> 
> This is the follow-up of:
>   "[PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages() with
>   init_on_alloc=1 or __GFP_ZERO"
> 
> v1 -> v2:
> - Let's clear anything that leaves the buddy, also affecting compaction.
> - Don't implement __GFP_ZERO support for now
> 
> ---
>  mm/page_alloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eaa227a479e4..108b81c0dfa8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2275,6 +2275,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	kasan_alloc_pages(page, order);
>  	kernel_poison_pages(page, 1 << order, 1);
>  	set_page_owner(page, order, gfp_flags);
> +
> +	if (!free_pages_prezeroed() && want_init_on_alloc(gfp_flags))
> +		kernel_init_free_pages(page, 1 << order);
>  }
>  
>  static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
> @@ -2282,9 +2285,6 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
>  {
>  	post_alloc_hook(page, order, gfp_flags);
>  
> -	if (!free_pages_prezeroed() && want_init_on_alloc(gfp_flags))
> -		kernel_init_free_pages(page, 1 << order);
> -
>  	if (order && (gfp_flags & __GFP_COMP))
>  		prep_compound_page(page, order);
>  
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
