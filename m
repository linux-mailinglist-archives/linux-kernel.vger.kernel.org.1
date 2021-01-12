Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6053B2F2ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbhALMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:17:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:53926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732299AbhALMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:17:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610453805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Yax5WNLXRTSjvCXHc37CSKXaoJG1nBrAta+imtbsRI=;
        b=a5lBnBz4DinnwHGHPeJBBY7PyscE5k/wYljLZXw7zmIQ2DOpt6QvyqCpdE83sGGzFDTIE6
        wzoVPz9fUMnpTW0wl6vHk/25fSusfg7cymBbgPxR6Ps1V9UlrUuaTFZKFPinLBRDdXDh/K
        ynoO+frbGqdvAw5uV+W/9e6oDPxE9pI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 499BBB8EE;
        Tue, 12 Jan 2021 12:16:45 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:16:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
Message-ID: <20210112121643.GP22493@dhcp22.suse.cz>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
 <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
 <20210112112709.GO22493@dhcp22.suse.cz>
 <d00da0ca-8a2b-f144-b455-2887fd269ed7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00da0ca-8a2b-f144-b455-2887fd269ed7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-01-21 12:34:01, David Hildenbrand wrote:
> On 12.01.21 12:27, Michal Hocko wrote:
> > On Tue 12-01-21 12:11:21, David Hildenbrand wrote:
> >> On 12.01.21 12:00, David Hildenbrand wrote:
> >>> On 10.01.21 13:40, Muchun Song wrote:
> >>>> If the refcount is one when it is migrated, it means that the page
> >>>> was freed from under us. So we are done and do not need to migrate.
> >>>>
> >>>> This optimization is consistent with the regular pages, just like
> >>>> unmap_and_move() does.
> >>>>
> >>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>>> Acked-by: Yang Shi <shy828301@gmail.com>
> >>>> ---
> >>>>  mm/migrate.c | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>> index 4385f2fb5d18..a6631c4eb6a6 100644
> >>>> --- a/mm/migrate.c
> >>>> +++ b/mm/migrate.c
> >>>> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >>>>  		return -ENOSYS;
> >>>>  	}
> >>>>  
> >>>> +	if (page_count(hpage) == 1) {
> >>>> +		/* page was freed from under us. So we are done. */
> >>>> +		putback_active_hugepage(hpage);
> >>>> +		return MIGRATEPAGE_SUCCESS;
> >>>> +	}
> >>>> +
> >>>>  	new_hpage = get_new_page(hpage, private);
> >>>>  	if (!new_hpage)
> >>>>  		return -ENOMEM;
> >>>>
> >>>
> >>> Question: What if called via alloc_contig_range() where we even want to
> >>> "migrate" free pages, meaning, relocate it?
> >>>
> >>
> >> To be more precise:
> >>
> >> a) We don't have dissolve_free_huge_pages() calls on the
> >> alloc_contig_range() path. So we *need* migration IIUC.
> >>
> >> b) dissolve_free_huge_pages() will fail if going below the reservation.
> >> In that case we really want to migrate free pages. This even applies to
> >> memory offlining.
> >>
> >> Either I am missing something important or this patch is more dangerous
> >> than it looks like.
> > 
> > This is an interesting point. But do we try to migrate hugetlb pages in
> > alloc_contig_range? isolate_migratepages_block !PageLRU need to be
> 
> I didn't test it so far (especially in the context of virtio-mem or
> CMA), but have a TODO item on my long list of things to look at in the
> future.

I have looked around and it seems this would more work than just to
allow the migration in a-c-r. migrate_huge_page_move_mapping resp.
hugetlbfs_migrate_page would need to special case pool pages. Likely a
non trivial work and potentially another land mine territory.

> 
> > marked as PageMovable AFAICS. This would be quite easy to implement but
> > a more fundamental question is whether we really want to mess with
> > existing pools for alloc_contig_range.
> 
> Can these pages fall onto ZONE_MOVABLE or even MIGRATE_CMA? If yes, we
> really want to. And I think both is the case for "ordinary" huge pages
> allocated via the buddy.

Yes movable hugetlb pages can sit in movable zone and CMA as well (see
htlb_modify_alloc_mask).
 
> > Anyway you are quite right that this change has more side effects than
> > it is easy to see while it doesn't really bring any major advantage
> > other than the consistency.
> 
> Free hugetlbfs pages are special. E.g., they cannot simply be skipped
> when offlining. So I don't think consistency actually really applies.

Well, currently pool pages are not migrateable but you are right that
this is likely something that we will need to look into in the future
and this optimization would stand in the way.
-- 
Michal Hocko
SUSE Labs
