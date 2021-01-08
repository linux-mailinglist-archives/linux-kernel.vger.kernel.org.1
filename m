Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC42A2EEE97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbhAHI3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:29:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:42320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbhAHI3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:29:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610094540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TW2seE7Yr8ETbDMfXNyP6hWd1MDNZNgi6O+6g3Zsgts=;
        b=rCGsjCbN2QYRIBddt1yYK3iczn7gGP3z4B8QPPVfL6WJY/7XSEgMgfPBLeI5d+lcWOpQgw
        D8jh+LkPACoKqnGIAJJa3jhPaBx6pTGbwB3Aotb7fTIMwb46jl1EkdtQ7EnGrN+fjW8Kfw
        aqmZyC1D575AG9TiFZvQS+ENHUupf/A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F8A6ACC6;
        Fri,  8 Jan 2021 08:29:00 +0000 (UTC)
Date:   Fri, 8 Jan 2021 09:28:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm: hugetlb: fix a race between freeing and
 dissolving the page
Message-ID: <20210108082858.GV13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com>
 <20210106165632.GT13207@dhcp22.suse.cz>
 <a9c59b0e-9a9d-c568-5503-5df6fe8db908@oracle.com>
 <20210107084038.GC13207@dhcp22.suse.cz>
 <509ef752-cc2e-3edf-5871-87f971a7bc0f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <509ef752-cc2e-3edf-5871-87f971a7bc0f@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-01-21 16:52:19, Mike Kravetz wrote:
> On 1/7/21 12:40 AM, Michal Hocko wrote:
> > On Wed 06-01-21 12:58:29, Mike Kravetz wrote:
> >> On 1/6/21 8:56 AM, Michal Hocko wrote:
> >>> On Wed 06-01-21 16:47:36, Muchun Song wrote:
> >>>> There is a race condition between __free_huge_page()
> >>>> and dissolve_free_huge_page().
> >>>>
> >>>> CPU0:                         CPU1:
> >>>>
> >>>> // page_count(page) == 1
> >>>> put_page(page)
> >>>>   __free_huge_page(page)
> >>>>                               dissolve_free_huge_page(page)
> >>>>                                 spin_lock(&hugetlb_lock)
> >>>>                                 // PageHuge(page) && !page_count(page)
> >>>>                                 update_and_free_page(page)
> >>>>                                 // page is freed to the buddy
> >>>>                                 spin_unlock(&hugetlb_lock)
> >>>>     spin_lock(&hugetlb_lock)
> >>>>     clear_page_huge_active(page)
> >>>>     enqueue_huge_page(page)
> >>>>     // It is wrong, the page is already freed
> >>>>     spin_unlock(&hugetlb_lock)
> >>>>
> >>>> The race windows is between put_page() and spin_lock() which
> >>>> is in the __free_huge_page().
> >>>
> >>> The race window reall is between put_page and dissolve_free_huge_page.
> >>> And the result is that the put_page path would clobber an unrelated page
> >>> (either free or already reused page) which is quite serious.
> >>> Fortunatelly pages are dissolved very rarely. I believe that user would
> >>> require to be privileged to hit this by intention.
> >>>
> >>>> We should make sure that the page is already on the free list
> >>>> when it is dissolved.
> >>>
> >>> Another option would be to check for PageHuge in __free_huge_page. Have
> >>> you considered that rather than add yet another state? The scope of the
> >>> spinlock would have to be extended. If that sounds more tricky then can
> >>> we check the page->lru in the dissolve path? If the page is still
> >>> PageHuge and reference count 0 then there shouldn't be many options
> >>> where it can be queued, right?
> >>
> >> The tricky part with expanding lock scope will be the potential call to
> >> hugepage_subpool_put_pages as it may also try to acquire the hugetlb_lock.
> > 
> > Can we rearrange the code and move hugepage_subpool_put_pages after all
> > this is done? Or is there any strong reason for the particular ordering?
> 
> The reservation code is so fragile, I always get nervous when making
> any changes.  However, the straight forward patch below passes some
> simple testing.  The only difference I can see is that global counts
> are adjusted before sub-pool counts.  This should not be an issue as
> global and sub-pool counts are adjusted independently (not under the
> same lock).  Allocation code checks sub-pool counts before global
> counts.  So, there is a SMALL potential that a racing allocation which
> previously succeeded would now fail.  I do not think this is an issue
> in practice.
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3b38ea958e95..658593840212 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1395,6 +1395,11 @@ static void __free_huge_page(struct page *page)
>  		(struct hugepage_subpool *)page_private(page);
>  	bool restore_reserve;
>  
> +	spin_lock(&hugetlb_lock);
> +	/* check for race with dissolve_free_huge_page/update_and_free_page */
> +	if (!PageHuge(page))
> +		return;
> +

This really wants to unlock the lock, right? But this is indeed what
I've had in mind.
-- 
Michal Hocko
SUSE Labs
