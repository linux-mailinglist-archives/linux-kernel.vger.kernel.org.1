Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BEB2A8D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgKFDAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKFDA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:00:29 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC098C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 19:00:29 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g19so27631otp.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 19:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pDC3BIxF8LqiptXxMB/QWrdFxJBaZP+N97tS2uc0Blw=;
        b=V6Z9H4HSUMzTaYpWN8D1LE8T/QRcYi50BtrWZI/PDbJLxO+V7we2MZamHvdvWEXP9c
         EmTRd+NOwnx7meEl2l0x/cNhvQhnqtgjodDvWVd40fwq5ZqhBG4Mi9Gmd14bnG5VelGQ
         8NexJnugQw+j1XoCn6OcJ98es62RwLrnkVGjZMkRGeeyvO+rFpxG2mlIpqQFNE+tI23z
         Xv/Lt9AIayIgKe1//5s2s96DWJWCqT6oSNVjbohtuNqVFGbWwI3AxG2cd0L82RkbDift
         Xo2DRHhkyfo+Fc+G5zW52DXHYGblMFSa6zefXq2e2qhTENqMszYGo74bN6HulAHv7Kf6
         Dztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pDC3BIxF8LqiptXxMB/QWrdFxJBaZP+N97tS2uc0Blw=;
        b=tAy+mcj+yrIbHMuE9/lxQAof9QeGahmWwYZqu1Fd0sbuGZfWzmv4zhjOtxupyBaorZ
         0vWFx4XzkOXGI0fZRuk+y2THPfO7VXQei0st2tuiJvlqr4NZ/pqFQcxsHJvM+tvjwKZ2
         5JbLoz+2Aqx4SRnDoRp1XNRlV3iWthLRi0c0P2gBsrGd6hPmF1+mPyDDDnI/vzGrjr1S
         6W7bexzAIf8+cYFS6LnvMj0txCxxFxRm844S2yx7lFa+c0hlMH3cXO//gYmYv93IAxiB
         8JjcuSh/EBXrm/7fGc2DE66B0adpcKkZggylnNKl9FnFZTuBRKywboZmByTLk/pmcERR
         sTUA==
X-Gm-Message-State: AOAM531Ity0WrkMq9cVTnxbscZ33urhsf8cDbbTdT3UjPC/Dy9RCGt0q
        9VLYfssUR9i78ZKVO8dob+cYUQ==
X-Google-Smtp-Source: ABdhPJzcltGwM+9WkaO4RcY/2h3MXZA09BC2CFLwp2UfsA2XUnHXC/bddQBulUbq1EZcjTgkNveqBw==
X-Received: by 2002:a9d:65d7:: with SMTP id z23mr3832905oth.131.1604631628792;
        Thu, 05 Nov 2020 19:00:28 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v17sm15426ote.40.2020.11.05.19.00.27
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 05 Nov 2020 19:00:27 -0800 (PST)
Date:   Thu, 5 Nov 2020 19:00:11 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Shakeel Butt <shakeelb@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: always do TTU_IGNORE_ACCESS
In-Reply-To: <20201104231928.1494083-1-shakeelb@google.com>
Message-ID: <alpine.LSU.2.11.2011051751130.4455@eggly.anvils>
References: <20201104231928.1494083-1-shakeelb@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know why this was addressed to me in particular (easy to imagine
I've made a mod at some time that bears on this, but I haven't found it);
but have spent longer considering the patch than I should have done -
apologies to everyone else I should be replying to.

On Wed, 4 Nov 2020, Shakeel Butt wrote:

> Since the commit 369ea8242c0f ("mm/rmap: update to new mmu_notifier
> semantic v2"), the code to check the secondary MMU's page table access
> bit is broken for !(TTU_IGNORE_ACCESS) because the page is unmapped from
> the secondary MMU's page table before the check. More specifically for
> those secondary MMUs which unmap the memory in
> mmu_notifier_invalidate_range_start() like kvm.

Well, "broken" seems a bit unfair to 369ea8242c0f. It put a warning
mmu_notifier_invalidate_range_start() at the beginning, and matching
mmu_notifier_invalidate_range_end() at the end of try_to_unmap_one();
with its mmu_notifier_invalidate_range() exactly where the
mmu_notifier_invalidate_page() was before (I think the story gets
more complicated later).  Yes, if notifiee takes invalidate_range_start()
as signal to invalidate all their own range, then that will sometimes
cause them unnecessary invalidations.

Not just for !TTU_IGNORE_ACCESS: there's also the !TTU_IGNORE_MLOCK
case meeting a VM_LOCKED vma and setting PageMlocked where that had
been missed earlier (and page_check_references() has intentionally but
confusingly marked this case as PAGEREF_RECLAIM, not to reclaim the page,
but to reach the try_to_unmap_one() which will recognize and fix it up -
historically easier to do there than in page_referenced_one()).

But I think mmu_notifier is a diversion from what needs thinking about.

> 
> However memory reclaim is the only user of !(TTU_IGNORE_ACCESS) or the
> absence of TTU_IGNORE_ACCESS and it explicitly performs the page table
> access check before trying to unmap the page. So, at worst the reclaim
> will miss accesses in a very short window if we remove page table access
> check in unmapping code.

I agree with you and Johannes that the short race window when the page
might be re-referenced is no issue at all: the functional issue is the
one in your next paragraph.  If that's agreed by memcg guys, great,
then this patch is a nice observation and a welcome cleanup.

> 
> There is an unintented consequence of !(TTU_IGNORE_ACCESS) for the memcg
> reclaim. From memcg reclaim the page_referenced() only account the
> accesses from the processes which are in the same memcg of the target
> page but the unmapping code is considering accesses from all the
> processes, so, decreasing the effectiveness of memcg reclaim.

Are you sure it was unintended?

Since the dawn of memcg reclaim, it has been the case that a recent
reference in a "foreign" vma has rescued that page from being reclaimed:
now you propose to change that.  I expect some workflows will benefit
and others be disadvantaged.  I have no objection myself to the change,
but I do think it needs to be better highlighted here, and explicitly
agreed by those more familiar with memcg reclaim.

Hugh

> 
> The simplest solution is to always assume TTU_IGNORE_ACCESS in unmapping
> code.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/rmap.h |  1 -
>  mm/huge_memory.c     |  2 +-
>  mm/memory-failure.c  |  2 +-
>  mm/memory_hotplug.c  |  2 +-
>  mm/migrate.c         |  8 +++-----
>  mm/rmap.c            |  9 ---------
>  mm/vmscan.c          | 14 +++++---------
>  7 files changed, 11 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 3a6adfa70fb0..70085ca1a3fc 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -91,7 +91,6 @@ enum ttu_flags {
>  
>  	TTU_SPLIT_HUGE_PMD	= 0x4,	/* split huge PMD if any */
>  	TTU_IGNORE_MLOCK	= 0x8,	/* ignore mlock */
> -	TTU_IGNORE_ACCESS	= 0x10,	/* don't age */
>  	TTU_IGNORE_HWPOISON	= 0x20,	/* corrupted page is recoverable */
>  	TTU_BATCH_FLUSH		= 0x40,	/* Batch TLB flushes where possible
>  					 * and caller guarantees they will
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 08a183f6c3ab..8b235b4abf73 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2324,7 +2324,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>  
>  static void unmap_page(struct page *page)
>  {
> -	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
> +	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
>  		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
>  	bool unmap_success;
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index c0bb186bba62..b6d6d5cdb435 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -989,7 +989,7 @@ static int get_hwpoison_page(struct page *page)
>  static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  				  int flags, struct page **hpagep)
>  {
> -	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
> +	enum ttu_flags ttu = TTU_IGNORE_MLOCK;
>  	struct address_space *mapping;
>  	LIST_HEAD(tokill);
>  	bool unmap_success = true;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8c1b7182bb08..968e6916d297 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1303,7 +1303,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			if (WARN_ON(PageLRU(page)))
>  				isolate_lru_page(page);
>  			if (page_mapped(page))
> -				try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS);
> +				try_to_unmap(page, TTU_IGNORE_MLOCK);
>  			continue;
>  		}
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c1585ec29827..e434d49fd428 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1122,8 +1122,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  		/* Establish migration ptes */
>  		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
>  				page);
> -		try_to_unmap(page,
> -			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
> +		try_to_unmap(page, TTU_MIGRATION|TTU_IGNORE_MLOCK);
>  		page_was_mapped = 1;
>  	}
>  
> @@ -1339,8 +1338,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  			goto unlock_put_anon;
>  
>  		try_to_unmap(hpage,
> -			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS|
> -			TTU_RMAP_LOCKED);
> +			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_RMAP_LOCKED);
>  		page_was_mapped = 1;
>  		/*
>  		 * Leave mapping locked until after subsequent call to
> @@ -2684,7 +2682,7 @@ static void migrate_vma_prepare(struct migrate_vma *migrate)
>   */
>  static void migrate_vma_unmap(struct migrate_vma *migrate)
>  {
> -	int flags = TTU_MIGRATION | TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
> +	int flags = TTU_MIGRATION | TTU_IGNORE_MLOCK;
>  	const unsigned long npages = migrate->npages;
>  	const unsigned long start = migrate->start;
>  	unsigned long addr, i, restore = 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1b84945d655c..6cd9d4512117 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1536,15 +1536,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  			goto discard;
>  		}
>  
> -		if (!(flags & TTU_IGNORE_ACCESS)) {
> -			if (ptep_clear_flush_young_notify(vma, address,
> -						pvmw.pte)) {
> -				ret = false;
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> -			}
> -		}
> -
>  		/* Nuke the page table entry. */
>  		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>  		if (should_defer_flush(mm, flags)) {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a8611dce7a95..e71b563cda7b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1072,7 +1072,6 @@ static void page_check_dirty_writeback(struct page *page,
>  static unsigned int shrink_page_list(struct list_head *page_list,
>  				     struct pglist_data *pgdat,
>  				     struct scan_control *sc,
> -				     enum ttu_flags ttu_flags,
>  				     struct reclaim_stat *stat,
>  				     bool ignore_references)
>  {
> @@ -1297,7 +1296,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  		 * processes. Try to unmap it here.
>  		 */
>  		if (page_mapped(page)) {
> -			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
> +			enum ttu_flags flags = TTU_BATCH_FLUSH;
>  			bool was_swapbacked = PageSwapBacked(page);
>  
>  			if (unlikely(PageTransHuge(page)))
> @@ -1514,7 +1513,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  	}
>  
>  	nr_reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
> -			TTU_IGNORE_ACCESS, &stat, true);
> +					&stat, true);
>  	list_splice(&clean_pages, page_list);
>  	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
>  			    -(long)nr_reclaimed);
> @@ -1958,8 +1957,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	if (nr_taken == 0)
>  		return 0;
>  
> -	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, 0,
> -				&stat, false);
> +	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, &stat, false);
>  
>  	spin_lock_irq(&pgdat->lru_lock);
>  
> @@ -2131,8 +2129,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
>  
>  		nr_reclaimed += shrink_page_list(&node_page_list,
>  						NODE_DATA(nid),
> -						&sc, 0,
> -						&dummy_stat, false);
> +						&sc, &dummy_stat, false);
>  		while (!list_empty(&node_page_list)) {
>  			page = lru_to_page(&node_page_list);
>  			list_del(&page->lru);
> @@ -2145,8 +2142,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
>  	if (!list_empty(&node_page_list)) {
>  		nr_reclaimed += shrink_page_list(&node_page_list,
>  						NODE_DATA(nid),
> -						&sc, 0,
> -						&dummy_stat, false);
> +						&sc, &dummy_stat, false);
>  		while (!list_empty(&node_page_list)) {
>  			page = lru_to_page(&node_page_list);
>  			list_del(&page->lru);
> -- 
> 2.29.1.341.ge80a0c044ae-goog
