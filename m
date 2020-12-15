Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF82DA925
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgLOI03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:26:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:41744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgLOI0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:26:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608020725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TNK/lVDl1GoAySvXZqTqRJer4+ab+0COZr0xkYRhJo=;
        b=Yfl8ZaOr/8CH3TmHkGxKWBL32jv4Ay/iX5yt1AX2Lnad+FQsBWC6P+dHPyHZKE3G+7eLyZ
        3MSYiZ6RahCBkG+al79V9luYQ+kF9cNtmJaavuZ6Cnfz6jZfr3b5Qmr6iBdAkFmYvQORfq
        HRt8iwyvv2lmg9+pJqG92OymMBYaRAY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88FD3AC7F;
        Tue, 15 Dec 2020 08:25:25 +0000 (UTC)
Date:   Tue, 15 Dec 2020 09:25:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] mm: apply per-task gfp constraints in fast path
Message-ID: <20201215082524.GK32193@dhcp22.suse.cz>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-4-pasha.tatashin@soleen.com>
 <20201214140912.GE32193@dhcp22.suse.cz>
 <CA+CK2bA9u_ZUosha0JvW6ezs-h95UBHZztoFojMyFbC791ximw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA9u_ZUosha0JvW6ezs-h95UBHZztoFojMyFbC791ximw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-12-20 00:20:39, Pavel Tatashin wrote:
> > Ack to this.
> 
> Thank you.
> 
> >
> > But I do not really understand this. All allocation contexts should have
> > a proper gfp mask so why do we have to call current_gfp_context here?
> > In fact moving the current_gfp_context in the allocator path should have
> > made all this games unnecessary. Memcg reclaim path might need some
> > careful check because gfp mask is used more creative there but the
> > general reclaim paths should be ok.
> >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >
> > Again, why do we need this when the gfp_mask
> > >       };
> > >
> --
> 
> Hi Michal,
> 
> Beside from __alloc_pages_nodemask(), the current_gfp_context() is
> called from the following six functions:
> 
> try_to_free_pages()
> try_to_free_mem_cgroup_pages()
> __node_reclaim()
> __need_fs_reclaim()
> alloc_contig_range()
> pcpu_alloc()
> 
> As I understand, the idea is that because the allocator now honors
> gfp_context values for all paths, the call can be removed from some of
> the above functions. I think you are correct. But, at least from a
> quick glance, this is not obvious, and is not the case for all of the
> above functions.
> 
> For example:
> 
> alloc_contig_range()
>   __alloc_contig_migrate_range
>    isolate_migratepages_range
>      isolate_migratepages_block
>         /*
>          * Only allow to migrate anonymous pages in GFP_NOFS context
>          * because those do not depend on fs locks.
>          */
>        if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
>           goto isolate_fail;
> 
> If we remove current_gfp_context() from alloc_contig_range(), the
> cc->gfp_mask will not be updated with proper __GFP_FS flag.

I do not think I was proposing to drop current_gfp_context from
alloc_contig_range. ACR needs some work to be properly scoped gfp mask
aware. This should be addressed but I do not think think the code
works properly now so I wouldn't lose sleep over it in this series. At
least __alloc_contig_migrate_range should follow the gfp mask given to
alloc_contig_range.

> I have studied some other paths, and they are also convoluted.
> Therefore, I am worried about performing this optimization in this
> series.

Dropping current_gfp_context from the reclaim context should be done in
a separate patch. I didn't mean to push for this here. All I meant was
to simply not touch gfp/zone_idx in the reclaim path. The changelog
should call out that the page allocator always provides proper gfp mask.

-- 
Michal Hocko
SUSE Labs
