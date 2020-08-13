Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A94243995
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 14:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHMMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 08:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgHMMD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:03:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26F8BACE3;
        Thu, 13 Aug 2020 11:47:01 +0000 (UTC)
Date:   Thu, 13 Aug 2020 13:46:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
Message-ID: <20200813114638.GJ9477@dhcp22.suse.cz>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
 <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
 <20200811015148.GA10792@MiWiFi-R3L-srv>
 <20200811065406.GC4793@dhcp22.suse.cz>
 <eb9d1e13-7455-0c4e-1f94-0c859c36c0bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9d1e13-7455-0c4e-1f94-0c859c36c0bb@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-08-20 14:43:28, Mike Kravetz wrote:
> On 8/10/20 11:54 PM, Michal Hocko wrote:
> > 
> > I have managed to forgot all the juicy details since I have made that
> > change. All that remains is that the surplus pages accounting was quite
> > tricky and back then I didn't figure out a simpler method that would
> > achieve the consistent look at those counters. As mentioned above I
> > suspect this could lead to pre-mature allocation failures while the
> > migration is ongoing.
> 
> It is likely lost in the e-mail thread, but the suggested change was to
> alloc_surplus_huge_page().  The code which allocates the migration target
> (alloc_migrate_huge_page) will not be changed.  So, this should not be
> an issue.

OK, I've missed that obviously.

> >                       Sure quite unlikely to happen and the race window
> > is likely very small. Maybe this is even acceptable but I would strongly
> > recommend to have all this thinking documented in the changelog.
> 
> I wrote down a description of what happens in the two different approaches
> "temporary page" vs "surplus page".  It is at the very end of this e-mail.
> When looking at the details, I came up with what may be an even better
> approach.  Why not just call the low level routine to free the page instead
> of going through put_page/free_huge_page?  At the very least, it saves a
> lock roundtrip and there is no need to worry about the counters/accounting.
> 
> Here is a patch to do that.  However, we are optimizing a return path in
> a race condition that we are unlikely to ever hit.  I 'tested' it by allocating
> an 'extra' page and freeing it via this method in alloc_surplus_huge_page.
> 
> >From 864c5f8ef4900c95ca3f6f2363a85f3cb25e793e Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Tue, 11 Aug 2020 12:45:41 -0700
> Subject: [PATCH] hugetlb: optimize race error return in
>  alloc_surplus_huge_page
> 
> The routine alloc_surplus_huge_page() could race with with a pool
> size change.  If this happens, the allocated page may not be needed.
> To free the page, the current code will 'Abuse temporary page to
> workaround the nasty free_huge_page codeflow'.  Instead, directly
> call the low level routine that free_huge_page uses.  This works
> out well because the page is new, we hold the only reference and
> already hold the hugetlb_lock.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 590111ea6975..ac89b91fba86 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1923,14 +1923,17 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	/*
>  	 * We could have raced with the pool size change.
>  	 * Double check that and simply deallocate the new page
> -	 * if we would end up overcommiting the surpluses. Abuse
> -	 * temporary page to workaround the nasty free_huge_page
> -	 * codeflow
> +	 * if we would end up overcommiting the surpluses.
>  	 */
>  	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
> -		SetPageHugeTemporary(page);
> +		/*
> +		 * Since this page is new, we hold the only reference, and
> +		 * we already hold the hugetlb_lock call the low level free
> +		 * page routine.  This saves at least a lock roundtrip.
> +		 */
> +		(void)put_page_testzero(page); /* don't call destructor */
> +		update_and_free_page(h, page);
>  		spin_unlock(&hugetlb_lock);
> -		put_page(page);
>  		return NULL;
>  	} else {
>  		h->surplus_huge_pages++;

Yes this makes sense. I would have to think about this more to be
confident and give Acked-by but this looks sensible from a quick glance.

Thanks!
-- 
Michal Hocko
SUSE Labs
