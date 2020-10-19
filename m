Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63AB2922B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgJSG7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:59:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:55750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgJSG7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:59:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603090754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWTtNyRQpspwMkK1R2rGtDqE4M7Gn98Si984Ule9Ss0=;
        b=cqeUAM00YSlx6flc2JUsczFqRhNqcAHUth3ItSDuz5RcBKns5y+UKj2SW04npGOzplO9YM
        /DT91Bj0wyvPOyrLrw46mVjU+B12frH9ptun+N2UOsv+OH9mbOggNw76bVK0FqY9/zWm78
        7bxFH5SZVDMwDg8OtCuas7X2YC2oOf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FE19ABD5;
        Mon, 19 Oct 2020 06:59:14 +0000 (UTC)
Date:   Mon, 19 Oct 2020 08:59:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, osalvador@suse.de,
        linmiaohe@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH V2] mm: fix potential pte_unmap_unlock pte error
Message-ID: <20201019065912.GA27114@dhcp22.suse.cz>
References: <20201017021151.28104-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017021151.28104-1-luoshijie1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-10-20 22:11:51, Shijie Luo wrote:
> When flags don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL bits, code breaks
>  and passing origin pte - 1 to pte_unmap_unlock seems like not a good idea.

This would really benefit from some improvements. It is preferable to
provide a user visibile effect of the patch. I would propose this, feel
free to reuse parts as you find fit.
"
queue_pages_pte_range can run in MPOL_MF_MOVE_ALL mode which doesn't
migrate misplaced pages but returns with EIO when encountering such a
page. Since a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when
MPOL_MF_STRICT is specified") and early break on the first pte in the
range results in pte_unmap_unlock on an underflow pte. This can lead to
lockups later on when somebody tries to lock the pte resp.
page_table_lock again..

Fixes: a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when
MPOL_MF_STRICT is specified")
"

> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

No need to add my s-o-b.

> ---
>  mm/mempolicy.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 3fde772ef5ef..3ca4898f3f24 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -525,7 +525,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  	unsigned long flags = qp->flags;
>  	int ret;
>  	bool has_unmovable = false;
> -	pte_t *pte;
> +	pte_t *pte, *mapped_pte;
>  	spinlock_t *ptl;
>  
>  	ptl = pmd_trans_huge_lock(pmd, vma);
> @@ -539,7 +539,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  	if (pmd_trans_unstable(pmd))
>  		return 0;
>  
> -	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>  	for (; addr != end; pte++, addr += PAGE_SIZE) {
>  		if (!pte_present(*pte))
>  			continue;
> @@ -571,7 +571,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  		} else
>  			break;
>  	}
> -	pte_unmap_unlock(pte - 1, ptl);
> +	pte_unmap_unlock(mapped_pte, ptl);
>  	cond_resched();
>  
>  	if (has_unmovable)
> -- 
> 2.19.1
> 

-- 
Michal Hocko
SUSE Labs
