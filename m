Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5024529B9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1803503AbgJ0PxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:53:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760131AbgJ0P3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:29:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A00FADD9;
        Tue, 27 Oct 2020 15:29:05 +0000 (UTC)
Date:   Tue, 27 Oct 2020 16:29:02 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
Message-ID: <20201027152858.GA11135@linux>
References: <20201007161736.ACC6E387@viggo.jf.intel.com>
 <20201007161745.26B1D789@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007161745.26B1D789@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:17:45AM -0700, Dave Hansen wrote:
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>

I am still going through all the details, but just my thoughts on things
that caught my eye:

> --- a/include/linux/migrate.h~demote-with-migrate_pages	2020-10-07 09:15:31.028642442 -0700
> +++ b/include/linux/migrate.h	2020-10-07 09:15:31.034642442 -0700
> @@ -27,6 +27,7 @@ enum migrate_reason {
>  	MR_MEMPOLICY_MBIND,
>  	MR_NUMA_MISPLACED,
>  	MR_CONTIG_RANGE,
> +	MR_DEMOTION,
>  	MR_TYPES

I think you also need to add it under include/trace/events/migrate.h, so
mm_migrate_pages event can know about it.

> +bool migrate_demote_page_ok(struct page *page, struct scan_control *sc)

Make it static?
Also, scan_control seems to be unused here.

> +{
> +	int next_nid = next_demotion_node(page_to_nid(page));
> +
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);

Right after the call to migrate_demote_page_ok, we call unlock_page
which already has this check in place.
I know that this is only to be on the safe side and we do not loss anything,
but just my thoughts.

> +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +{
> +	/*
> +	 * Try to fail quickly if memory on the target node is not
> +	 * available.  Leaving out __GFP_IO and __GFP_FS helps with
> +	 * this.  If the desintation node is full, we want kswapd to
> +	 * run there so that its pages will get reclaimed and future
> +	 * migration attempts may succeed.
> +	 */
> +	gfp_t flags = (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_NORETRY |
> +		       __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE |
> +		       __GFP_KSWAPD_RECLAIM);

I think it would be nicer to have this as a real GFP_ thingy defined.
e.g: GFP_DEMOTION

> +	/* HugeTLB pages should not be on the LRU */
> +	WARN_ON_ONCE(PageHuge(page));

I am not sure about this one.
This could only happen if the page, which now it is in another list, ends up in
the buddy system. That is quite unlikely bth.
And nevertheless, this is only a warning, which means that if this scenario gets
to happen, we will be allocating a single page to satisfy a higher-order page, and
I am not sure about the situation we will end up with.

> +
> +	if (PageTransHuge(page)) {
> +		struct page *thp;
> +
> +		flags |= __GFP_COMP;
> +
> +		thp = alloc_pages_node(node, flags, HPAGE_PMD_ORDER);
> +		if (!thp)
> +			return NULL;
> +		prep_transhuge_page(thp);
> +		return thp;
> +	}
> +
> +	return __alloc_pages_node(node, flags, 0);

Would make sense to transform this in some sort of new_demotion_page,
which actually calls alloc_migration_target with the right stuff in place?
And then pass a struct migration_target_control so alloc_migration_target
does the right thing.
alloc_migration_target also takes care of calling prep_transhuge_page
when needed.
e.g:

static struct page *new_demotion_node(struct page *page, unsigned long private)
{
        struct migration_target_control mtc = {
                .nid = private,
                .gfp_mask = GFP_DEMOTION,
        };

        if (PageTransHuge(page))
                mtc.gfp_mask |= __GFP_COMP;

        return alloc_migration_target(page, (unsigned long)&mtc);
}

The only thing I see is that alloc_migration_target seems to "override"
the gfp_mask and does ORs GFP_TRANSHUGE for THP pages, which includes
__GFP_DIRECT_RECLAIM (not appreciated in this case).
But maybe this can be worked around by checking if gfp_mask == GFP_DEMOTION,
and if so, just keep the mask as it is.

> +
> +	if (list_empty(demote_pages))
> +		return 0;
> +
> +	/* Demotion ignores all cpuset and mempolicy settings */
> +	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
> +			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> +			    &nr_succeeded);

As I said, instead of alloc_demote_page, use a new_demote_page and make
alloc_migration_target handle the allocations and prep thp pages.


-- 
Oscar Salvador
SUSE L3
