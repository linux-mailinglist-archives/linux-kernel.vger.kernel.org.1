Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42E2B03C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgKLLWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:22:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:54042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgKLLWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:22:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605180164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X95cPMSStTZzNZ4CNsxGYNYPK8NnGZvfuwbtqitjKVA=;
        b=LWFNYjaAVRlaazrlO8jJtyv5stNspdTNsojXR33Q+m3Fi0Eymuku5jyFut52blH6j5Wlc7
        Recui6/EBM5gsMJg2SfkCv5aTVGs9Pj34HQoSk85GyDj76EyDRczkC0oKQSNd1ZtQqZM3B
        LrCYofJl/oI1vyYM23bK8tLGIOubqPc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E245AF16;
        Thu, 12 Nov 2020 11:22:44 +0000 (UTC)
Date:   Thu, 12 Nov 2020 12:22:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 2/2] mm,thp,shm: limit gfp mask to no more than specified
Message-ID: <20201112112242.GA12240@dhcp22.suse.cz>
References: <20201105191508.1961686-1-riel@surriel.com>
 <20201105191508.1961686-3-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105191508.1961686-3-riel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Chris for i915 and Andray]

On Thu 05-11-20 14:15:08, Rik van Riel wrote:
> Matthew Wilcox pointed out that the i915 driver opportunistically
> allocates tmpfs memory, but will happily reclaim some of its
> pool if no memory is available.

It would be good to explicitly mention the requested gfp flags for those
allocations. i915 uses __GFP_NORETRY | __GFP_NOWARN, or GFP_KERNEL. Is
__shmem_rw really meant to not allocate from highmeme/movable zones? Can
it be ever backed by THPs?

ttm might want __GFP_RETRY_MAYFAIL while shmem_read_mapping_page use
the mapping gfp mask which can be NOFS or something else. This is quite
messy already and I suspect that they are more targeting regular order-0
requests. E.g. have a look at cb5f1a52caf23.

I am worried that this games with gfp flags will lead to unmaintainable
code later on. There is a clear disconnect betwen the core THP
allocation strategy and what drivers are asking for and those
requirements might be really conflicting. Not to mention that flags
might be different between regular and THP pages.

> Make sure the gfp mask used to opportunistically allocate a THP
> is always at least as restrictive as the original gfp mask.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/shmem.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6c3cb192a88d..ee3cea10c2a4 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1531,6 +1531,26 @@ static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
>  	return page;
>  }
>  
> +/*
> + * Make sure huge_gfp is always more limited than limit_gfp.
> + * Some of the flags set permissions, while others set limitations.
> + */
> +static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
> +{
> +	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
> +	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
> +	gfp_t result = huge_gfp & ~allowflags;
> +
> +	/*
> +	 * Minimize the result gfp by taking the union with the deny flags,
> +	 * and the intersection of the allow flags.
> +	 */
> +	result |= (limit_gfp & denyflags);
> +	result |= (huge_gfp & limit_gfp) & allowflags;
> +
> +	return result;
> +}
> +
>  static struct page *shmem_alloc_hugepage(gfp_t gfp,
>  		struct shmem_inode_info *info, pgoff_t index)
>  {
> @@ -1889,6 +1909,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  
>  alloc_huge:
>  	huge_gfp = vma_thp_gfp_mask(vma);
> +	huge_gfp = limit_gfp_mask(huge_gfp, gfp);
>  	page = shmem_alloc_and_acct_page(huge_gfp, inode, index, true);
>  	if (IS_ERR(page)) {
>  alloc_nohuge:
> -- 
> 2.25.4

-- 
Michal Hocko
SUSE Labs
