Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815522C55FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbgKZNki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:40:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:56436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390022AbgKZNkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:40:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606398035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tpQ2yN+EcMyN7hnntqz+RkMEw6hXQibeFRMrMM5L2s=;
        b=ajTwHAYd5J0mqReqBekTnBlsHHrNFEO2eq6u4Ld8L6JTiJiyCw/6cPwlyL+/8n48mCToMO
        9Fj6YnH2i8ERYfahSgxPKMouUumvsl2wEMjOv8qwNncauWTW6QbzM4Kca7A+6xWQxltQbk
        ddaiT31gMg3MoDiILTaN+MtEExvEZgY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1D05AC6A;
        Thu, 26 Nov 2020 13:40:35 +0000 (UTC)
Date:   Thu, 26 Nov 2020 14:40:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Subject: Re: [PATCH 2/3] mm,thp,shm: limit gfp mask to no more than specified
Message-ID: <20201126134034.GI31550@dhcp22.suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
 <20201124194925.623931-3-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124194925.623931-3-riel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-11-20 14:49:24, Rik van Riel wrote:
> Matthew Wilcox pointed out that the i915 driver opportunistically
> allocates tmpfs memory, but will happily reclaim some of its
> pool if no memory is available.
> 
> Make sure the gfp mask used to opportunistically allocate a THP
> is always at least as restrictive as the original gfp mask.

I have brought this up in the previous version review and I feel my
feedback hasn't been addressed. Please describe the expected behavior by
those shmem users including GFP_KERNEL restriction which would make the
THP flags incompatible. Is this a problem? Is there any actual problem
if the THP uses its own set of flags?

I am also not happy how those two sets of flags are completely detached
and we can only expect surprises there. 

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
> 

-- 
Michal Hocko
SUSE Labs
