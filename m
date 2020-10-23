Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB66F2969E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375399AbgJWGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:47:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:45994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373100AbgJWGri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:47:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603435657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klhtciLu5zqObcp6VC8lGKNOReb4sC7Hz8VWst07W2Y=;
        b=PmVmHiDn0PfT0NcTU++Qm5ePPlICPwdf4uapEZrNAtmW9iT6XCEwlsn/uX/j6WVBFytBWa
        zm2smNYGEBBvL4tKz2LMtfc0zKufDqltW/rWvyATV0utmAyalM72iuW3m/18X2s7Qo/NJh
        7QNHpJqkx4CoBHfg2VOry0/ae8CFSmI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B4C6B0D1;
        Fri, 23 Oct 2020 06:47:37 +0000 (UTC)
Date:   Fri, 23 Oct 2020 08:47:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201023064736.GQ23790@dhcp22.suse.cz>
References: <20201021234846.5cc97e62@imladris.surriel.com>
 <20201022081532.GJ23790@dhcp22.suse.cz>
 <004062456494e9003b0f71b911f06f8c58a12797.camel@surriel.com>
 <20201022155022.GO23790@dhcp22.suse.cz>
 <1b2d262c30bd839ac433587532a27ad800df4771.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b2d262c30bd839ac433587532a27ad800df4771.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-10-20 12:06:01, Rik van Riel wrote:
> On Thu, 2020-10-22 at 17:50 +0200, Michal Hocko wrote:
> > On Thu 22-10-20 09:25:21, Rik van Riel wrote:
> > > On Thu, 2020-10-22 at 10:15 +0200, Michal Hocko wrote:
> > > > On Wed 21-10-20 23:48:46, Rik van Riel wrote:
> > > > > 
> > > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > > index 537c137698f8..d1290eb508e5 100644
> > > > > --- a/mm/shmem.c
> > > > > +++ b/mm/shmem.c
> > > > > @@ -1545,8 +1545,11 @@ static struct page
> > > > > *shmem_alloc_hugepage(gfp_t gfp,
> > > > >  		return NULL;
> > > > >  
> > > > >  	shmem_pseudo_vma_init(&pvma, info, hindex);
> > > > > -	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY
> > > > > |
> > > > > __GFP_NOWARN,
> > > > > -			HPAGE_PMD_ORDER, &pvma, 0,
> > > > > numa_node_id(),
> > > > > true);
> > > > > +	/* Limit the gfp mask according to THP configuration.
> > > > > */
> > > > > +	gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
> > > > 
> > > > What is the reason for these when alloc_hugepage_direct_gfpmask
> > > > provides
> > > > the full mask?
> > > 
> > > The mapping_gfp_mask for the shmem file might have additional
> > > restrictions above and beyond the gfp mask returned by
> > > alloc_hugepage_direct_gfpmask, and I am not sure we should just
> > > ignore the mapping_gfp_mask.
> > 
> > No, we shouldn't. But I do not see why you should be adding the above
> > set of flags on top.
> 
> Because THP allocations are higher order and optimistic,
> and we want them to:
> 1) be annotated as compound allocations
> 2) fail (and fall back to 4kB allocations) when they cannot
>    be easily satisfied, and
> 3) not create a spew of allocation failure backtraces on
>    the (serial) console when these THP allocations fail

This all is already returned from alloc_hugepage_direct_gfpmask.
-- 
Michal Hocko
SUSE Labs
