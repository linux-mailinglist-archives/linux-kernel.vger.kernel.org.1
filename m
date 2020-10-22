Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1982961E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368801AbgJVPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:50:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368790AbgJVPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:50:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603381826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anpArebmwIS/om0L4RIV1Dunrd+yvDw/T8+yAe/vk1A=;
        b=o76rdIEDw74SbwxJ9nZ9ecoqf/hj9Uxz8v2Ia2L51b0gHHg/NMi8MrU9X2O7X0UZ6sq4uX
        ec/BDbu6EH/gI6NftTaCU1Mwg6N8feAcbp9xYv1lKro65pcrgQG8f8dC0iLax20p395D81
        mOdXsmR/zbcZo5D04EGdVkWWel17CS0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C78CAC48;
        Thu, 22 Oct 2020 15:50:26 +0000 (UTC)
Date:   Thu, 22 Oct 2020 17:50:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201022155022.GO23790@dhcp22.suse.cz>
References: <20201021234846.5cc97e62@imladris.surriel.com>
 <20201022081532.GJ23790@dhcp22.suse.cz>
 <004062456494e9003b0f71b911f06f8c58a12797.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004062456494e9003b0f71b911f06f8c58a12797.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-10-20 09:25:21, Rik van Riel wrote:
> On Thu, 2020-10-22 at 10:15 +0200, Michal Hocko wrote:
> > On Wed 21-10-20 23:48:46, Rik van Riel wrote:
> > > The allocation flags of anonymous transparent huge pages can be
> > > controlled
> > > through the files in /sys/kernel/mm/transparent_hugepage/defrag,
> > > which can
> > > help the system from getting bogged down in the page reclaim and
> > > compaction
> > > code when many THPs are getting allocated simultaneously.
> > > 
> > > However, the gfp_mask for shmem THP allocations were not limited by
> > > those
> > > configuration settings, and some workloads ended up with all CPUs
> > > stuck
> > > on the LRU lock in the page reclaim code, trying to allocate dozens
> > > of
> > > THPs simultaneously.
> > > 
> > > This patch applies the same configurated limitation of THPs to
> > > shmem
> > > hugepage allocations, to prevent that from happening.
> > > 
> > > This way a THP defrag setting of "never" or "defer+madvise" will
> > > result
> > > in quick allocation failures without direct reclaim when no 2MB
> > > free
> > > pages are available.
> > 
> > I remmeber I wanted to unify this in the past as well. The patch got
> > reverted in the end. It was a long story and I do not have time to
> > read
> > through lengthy discussions again. I do remember though that there
> > were
> > some objections pointing out that shmem has its own behavior which is
> > controlled by the mount option - at least for the explicitly mounted
> > shmems. I might misremember.
> 
> That is not entirely true, though.
> 
> THP has two main sysfs knobs: "enabled" and "defrag"
> 
> The mount options
> control the shmem equivalent options
> for "enabled", but they do not do anything for the "defrag"
> equivalent options.

Yeah, the situation is quite messy :/

> This patch applies the "defrag" THP options to
> shmem.

I am not really objecting I just do remember some pushback. My previous
attempt was to unify everything inside alloc_pages_vma IIRC.

> > [...]
> > 
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 537c137698f8..d1290eb508e5 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1545,8 +1545,11 @@ static struct page
> > > *shmem_alloc_hugepage(gfp_t gfp,
> > >  		return NULL;
> > >  
> > >  	shmem_pseudo_vma_init(&pvma, info, hindex);
> > > -	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY |
> > > __GFP_NOWARN,
> > > -			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
> > > true);
> > > +	/* Limit the gfp mask according to THP configuration. */
> > > +	gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
> > 
> > What is the reason for these when alloc_hugepage_direct_gfpmask
> > provides
> > the full mask?
> 
> The mapping_gfp_mask for the shmem file might have additional
> restrictions above and beyond the gfp mask returned by
> alloc_hugepage_direct_gfpmask, and I am not sure we should just
> ignore the mapping_gfp_mask.

No, we shouldn't. But I do not see why you should be adding the above
set of flags on top.

> That is why this patch takes the union of both gfp masks.
> 
> However, digging into things more, it looks like shmem inodes
> always have the mapping gfp mask set to GFP_HIGHUSER_MOVABLE,
> and it is never changed, so simply using the output from
> alloc_hugepage_direct_gfpmask should be fine.
> 
> I can do the patch either way. Just let me know what you prefer.

I would just and the given gfp with alloc_hugepage_direct_gfpmask

-- 
Michal Hocko
SUSE Labs
