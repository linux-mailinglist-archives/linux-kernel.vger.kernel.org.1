Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC22959F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894745AbgJVIPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:15:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443493AbgJVIPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:15:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603354533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBy6UP5t6Wl5y2nB0PcKMFAyqskTOmW6bMTiFToXfPQ=;
        b=u4+/bAIdO3ZACffTeN4vN1PGN8C8vG9AE7IzoXz+z0DB/7eaETz+DXvRgXBVWUpP/eWloB
        pfN0tF4c7EUQLOELgpoD9hQ3xhEr61WNSShCYquOCjrzqMH0IJ0+quXEwryC++5horgzHe
        2sm7WBdzGxEFGnD92o3fcqet4hWJWg4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D182FAECE;
        Thu, 22 Oct 2020 08:15:33 +0000 (UTC)
Date:   Thu, 22 Oct 2020 10:15:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201022081532.GJ23790@dhcp22.suse.cz>
References: <20201021234846.5cc97e62@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021234846.5cc97e62@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-10-20 23:48:46, Rik van Riel wrote:
> The allocation flags of anonymous transparent huge pages can be controlled
> through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
> help the system from getting bogged down in the page reclaim and compaction
> code when many THPs are getting allocated simultaneously.
> 
> However, the gfp_mask for shmem THP allocations were not limited by those
> configuration settings, and some workloads ended up with all CPUs stuck
> on the LRU lock in the page reclaim code, trying to allocate dozens of
> THPs simultaneously.
> 
> This patch applies the same configurated limitation of THPs to shmem
> hugepage allocations, to prevent that from happening.
> 
> This way a THP defrag setting of "never" or "defer+madvise" will result
> in quick allocation failures without direct reclaim when no 2MB free
> pages are available.

I remmeber I wanted to unify this in the past as well. The patch got
reverted in the end. It was a long story and I do not have time to read
through lengthy discussions again. I do remember though that there were
some objections pointing out that shmem has its own behavior which is
controlled by the mount option - at least for the explicitly mounted
shmems. I might misremember.

[...]

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 537c137698f8..d1290eb508e5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1545,8 +1545,11 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
>  		return NULL;
>  
>  	shmem_pseudo_vma_init(&pvma, info, hindex);
> -	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
> -			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
> +	/* Limit the gfp mask according to THP configuration. */
> +	gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;

What is the reason for these when alloc_hugepage_direct_gfpmask provides
the full mask?

> +	gfp &= alloc_hugepage_direct_gfpmask(&pvma);
> +	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
> +			       true);
>  	shmem_pseudo_vma_destroy(&pvma);
>  	if (page)
>  		prep_transhuge_page(page);
> 
> -- 
> All rights reversed.

-- 
Michal Hocko
SUSE Labs
