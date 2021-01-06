Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28FD2EC1D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbhAFRLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:11:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:48978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbhAFRLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:11:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609953048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cWYYM4wHsoqQNcniGqO0vexUGEXTnF+YOVKCWdq6TxQ=;
        b=DDaHdz4lIszPEqfj1mTAdQ9uawBb2j6rNVUbG2MR2mZcIzb/OZbLejquyf5IidXEeJWjLu
        JT7/IoiYMHDS5wxQmPF0ZSYO4ns75nnLf8t8WeZsQlwBnrqkxazXwsFuvWrgWcWsUcTy2y
        o6Ln0G8K+w8me5jPT6Celga5uHBEvPY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8EA3ACAF;
        Wed,  6 Jan 2021 17:10:48 +0000 (UTC)
Date:   Wed, 6 Jan 2021 18:10:48 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mm: hugetlb: fix a race between isolating and
 freeing page
Message-ID: <20210106171048.GV13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106084739.63318-6-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 16:47:38, Muchun Song wrote:
> There is a race between isolate_huge_page() and __free_huge_page().
> 
> CPU0:                                       CPU1:
> 
> if (PageHuge(page))
>                                             put_page(page)
>                                               __free_huge_page(page)
>                                                   spin_lock(&hugetlb_lock)
>                                                   update_and_free_page(page)
>                                                     set_compound_page_dtor(page,
>                                                       NULL_COMPOUND_DTOR)
>                                                   spin_unlock(&hugetlb_lock)
>   isolate_huge_page(page)
>     // trigger BUG_ON
>     VM_BUG_ON_PAGE(!PageHead(page), page)
>     spin_lock(&hugetlb_lock)
>     page_huge_active(page)
>       // trigger BUG_ON
>       VM_BUG_ON_PAGE(!PageHuge(page), page)
>     spin_unlock(&hugetlb_lock)
> 
> When we isolate a HugeTLB page on CPU0. Meanwhile, we free it to the
> buddy allocator on CPU1. Then, we can trigger a BUG_ON on CPU0. Because
> it is already freed to the buddy allocator.
> 
> Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bf02e81e3953..67200dd25b1d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5587,9 +5587,9 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>  {
>  	bool ret = true;
>  
> -	VM_BUG_ON_PAGE(!PageHead(page), page);
>  	spin_lock(&hugetlb_lock);
> -	if (!page_huge_active(page) || !get_page_unless_zero(page)) {
> +	if (!PageHeadHuge(page) || !page_huge_active(page) ||
> +	    !get_page_unless_zero(page)) {
>  		ret = false;
>  		goto unlock;
>  	}
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
