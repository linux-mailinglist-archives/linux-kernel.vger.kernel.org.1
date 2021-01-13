Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10902F47AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbhAMJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:34:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:52346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbhAMJeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:34:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610530412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=voqVdGYzYdHfnFqrEWaLDjLhPhxcuxwsSJVMqjuuK2s=;
        b=q2JTLMTVtUUEiE86kntcI1HHn5aDwM3ujMCEnSylIRxFVQDvDCK3odhZBxTONNXUX4sxRL
        IVOrxA2De1a/KIcO0dzRElYU4hTb5brVzgT8oSTQrC0pmO0kzww1ySIFtUpMlMSqOeXJ03
        QbiG7Monfh90YrRckli55/YSxGxHse8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 397C8AA6F;
        Wed, 13 Jan 2021 09:33:32 +0000 (UTC)
Date:   Wed, 13 Jan 2021 10:33:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm: hugetlb: retry dissolve page when hitting race
Message-ID: <20210113093331.GV22493@dhcp22.suse.cz>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113052209.75531-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-01-21 13:22:07, Muchun Song wrote:
> There is a race between dissolve_free_huge_page() and put_page().
> Theoretically, we should return -EBUSY when we encounter this race.
> In fact, we have a chance to successfully dissolve the page if we
> do a retry. Because the race window is quite small. If we seize
> this opportunity, it is an optimization for increasing the success
> rate of dissolving page.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4a9011e12175..898e4ea43e13 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1772,6 +1772,7 @@ int dissolve_free_huge_page(struct page *page)
>  {
>  	int rc = -EBUSY;
>  
> +retry:
>  	/* Not to disrupt normal path by vainly holding hugetlb_lock */
>  	if (!PageHuge(page))
>  		return 0;
> @@ -1793,8 +1794,23 @@ int dissolve_free_huge_page(struct page *page)
>  		 * We should make sure that the page is already on the free list
>  		 * when it is dissolved.
>  		 */
> -		if (unlikely(!PageHugeFreed(head)))
> -			goto out;
> +		if (unlikely(!PageHugeFreed(head))) {
> +			spin_unlock(&hugetlb_lock);
> +
> +			/*
> +			 * Theoretically, we should return -EBUSY when we
> +			 * encounter this race. In fact, we have a chance
> +			 * to successfully dissolve the page if we do a
> +			 * retry. Because the race window is quite small.
> +			 * If we seize this opportunity, it is an optimization
> +			 * for increasing the success rate of dissolving page.
> +			 */
> +			while (PageHeadHuge(head) && !PageHugeFreed(head)) {
> +				cond_resched();
> +				cpu_relax();
> +			}
> +			goto retry;

OK, so you have done the retry here. Please fold it into the previous
patch. Also do we need cpu_relax on top of cond_resched as well?

> +		}
>  
>  		/*
>  		 * Move PageHWPoison flag from head page to the raw error page,
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
