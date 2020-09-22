Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B12273FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIVKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:33:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgIVKdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B32F2B226;
        Tue, 22 Sep 2020 10:33:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A8F771E12E3; Tue, 22 Sep 2020 12:33:15 +0200 (CEST)
Date:   Tue, 22 Sep 2020 12:33:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
Message-ID: <20200922103315.GD15112@quack2.suse.cz>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-09-20 23:41:16, John Hubbard wrote:
> On 9/21/20 2:20 PM, Peter Xu wrote:
> ...
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 7ff29cc3d55c..c40aac0ad87e 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1074,6 +1074,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >   	src_page = pmd_page(pmd);
> >   	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
> > +
> > +	/*
> > +	 * If this page is a potentially pinned page, split and retry the fault
> > +	 * with smaller page size.  Normally this should not happen because the
> > +	 * userspace should use MADV_DONTFORK upon pinned regions.  This is a
> > +	 * best effort that the pinned pages won't be replaced by another
> > +	 * random page during the coming copy-on-write.
> > +	 */
> > +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > +		     page_maybe_dma_pinned(src_page))) {
> 
> This condition would make a good static inline function. It's used in 3
> places, and the condition is quite special and worth documenting, and
> having a separate function helps with that, because the function name
> adds to the story. I'd suggest approximately:
> 
>     page_likely_dma_pinned()
> 
> for the name.

Well, but we should also capture that this really only works for anonymous
pages. For file pages mm->has_pinned does not work because the page may be
still pinned by completely unrelated process as Jann already properly
pointed out earlier in the thread. So maybe anon_page_likely_pinned()?
Possibly also assert PageAnon(page) in it if we want to be paranoid...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
