Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A05F2759C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIWOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:20:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:53916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIWOUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:20:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3CB7B23E;
        Wed, 23 Sep 2020 14:20:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3C2BC1E12E3; Wed, 23 Sep 2020 16:20:03 +0200 (CEST)
Date:   Wed, 23 Sep 2020 16:20:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200923142003.GB15875@quack2.suse.cz>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923131043.GA59978@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923131043.GA59978@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-09-20 09:10:43, Peter Xu wrote:
> On Tue, Sep 22, 2020 at 08:27:35PM -0400, Peter Xu wrote:
> > On Tue, Sep 22, 2020 at 04:11:16PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 22, 2020 at 01:54:15PM -0400, Peter Xu wrote:
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 8f3521be80ca..6591f3f33299 100644
> > > > +++ b/mm/memory.c
> > > > @@ -888,8 +888,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > >                  * Because we'll need to release the locks before doing cow,
> > > >                  * pass this work to upper layer.
> > > >                  */
> > > > -               if (READ_ONCE(src_mm->has_pinned) && wp &&
> > > > -                   page_maybe_dma_pinned(page)) {
> > > > +               if (wp && page_maybe_dma_pinned(page) &&
> > > > +                   READ_ONCE(src_mm->has_pinned)) {
> > > >                         /* We've got the page already; we're safe */
> > > >                         data->cow_old_page = page;
> > > >                         data->cow_oldpte = *src_pte;
> > > > 
> > > > I can also add some more comment to emphasize this.
> > > 
> > > It is not just that, but the ptep_set_wrprotect() has to be done
> > > earlier.
> > 
> > Now I understand your point, I think..  So I guess it's not only about
> > has_pinned, but it should be a race between the fast-gup and the fork() code,
> > even if has_pinned is always set.
> > 
> > > 
> > > Otherwise it races like:
> > > 
> > >    pin_user_pages_fast()                   fork()
> > >     atomic_set(has_pinned, 1);
> > >     [..]
> > >                                            atomic_read(page->_refcount) //false
> > >                                            // skipped atomic_read(has_pinned)
> > >     atomic_add(page->_refcount)
> > >     ordered check write protect()
> > >                                            ordered set write protect()
> > > 
> > > And now have a write protect on a DMA pinned page, which is the
> > > invarient we are trying to create.
> > > 
> > > The best algorithm I've thought of is something like:
> > > 
> > >  pte_map_lock()
> > >   if (page) {
> > >       if (wp) {
> > > 	  ptep_set_wrprotect()
> > > 	  /* Order with try_grab_compound_head(), either we see
> > > 	   * page_maybe_dma_pinned(), or they see the wrprotect */
> > > 	  get_page();
> > 
> > Is this get_page() a must to be after ptep_set_wrprotect() explicitly?  IIUC
> > what we need is to order ptep_set_wrprotect() and page_maybe_dma_pinned() here.
> > E.g., would a "mb()" work?
> > 
> > Another thing is, do we need similar thing for e.g. gup_pte_range(), so that
> > to guarantee ordering of try_grab_compound_head() and the pte change check?
> > 
> > > 
> > > 	  if (page_maybe_dma_pinned() && READ_ONCE(src_mm->has_pinned)) {
> > > 	       put_page();
> > > 	       ptep_clear_wrprotect()
> > > 
> > > 	       // do copy
> > > 	       return
> > > 	  }
> > >       } else {
> > > 	  get_page();
> > >       }
> > >       page_dup_rmap()
> > >  pte_unmap_lock()
> > > 
> > > Then the do_wp_page() path would have to detect that the page is not
> > > write protected under the pte lock inside the fault handler and just
> > > do nothing.
> > 
> > Yes, iiuc do_wp_page() should be able to handle spurious write page faults like
> > this already, as below:
> > 
> > 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
> > 	spin_lock(vmf->ptl);
> >         ...
> > 	if (vmf->flags & FAULT_FLAG_WRITE) {
> > 		if (!pte_write(entry))
> > 			return do_wp_page(vmf);
> > 		entry = pte_mkdirty(entry);
> > 	}
> > 
> > So when spin_lock() returns:
> > 
> >   - When it's a real cow (not pinned pages; we write-protected it and it keeps
> >     write-protected), we should do cow here as usual.
> > 
> >   - When it's a fake cow (pinned pages), the write bit should have been
> >     recovered before the page table lock released, and we'll skip do_wp_page()
> >     and retry the page fault immediately.
> > 
> > > Ie the set/clear could be visible to the CPU and trigger a
> > > spurious fault, but never trigger a COW.
> > > 
> > > Thus 'wp' becomes a 'lock' that prevents GUP from returning this page.
> > 
> > Another question is, how about read fast-gup for pinning?  Because we can't use
> > the write-protect mechanism to block a read gup.  I remember we've discussed
> > similar things and iirc your point is "pinned pages should always be with
> > WRITE".  However now I still doubt it...  Because I feel like read gup is still
> > legal (as I mentioned previously - when device purely writes to the page and
> > the processor only reads from it).
> > 
> > > 
> > > Very tricky, deserves a huge comment near the ptep_clear_wrprotect()
> > > 
> > > Consider the above algorithm beside the gup_fast() algorithm:
> > > 
> > > 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
> > > 			goto pte_unmap;
> > >                 [..]
> > > 		head = try_grab_compound_head(page, 1, flags);
> > > 		if (!head)
> > > 			goto pte_unmap;
> > > 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > > 			put_compound_head(head, 1, flags);
> > > 			goto pte_unmap;
> > > 
> > > That last *ptep will check that the WP is not set after making
> > > page_maybe_dma_pinned() true.
> > > 
> > > It still looks reasonable, the extra work is still just the additional
> > > atomic in page_maybe_dma_pinned(), just everything else has to be very
> > > carefully sequenced due to unlocked page table accessors.
> > 
> > Tricky!  I'm still thinking about some easier way but no much clue so far.
> > Hopefully we'll figure out something solid soon.
> 
> Hmm, how about something like below?  Would this be acceptable?
> 
> ------8<--------
> diff --git a/mm/gup.c b/mm/gup.c
> index 2d9019bf1773..698bc2b520ac 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2136,6 +2136,18 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>         struct dev_pagemap *pgmap = NULL;
>         int nr_start = *nr, ret = 0;
>         pte_t *ptep, *ptem;
> +       spinlock_t *ptl = NULL;
> +
> +       /*
> +        * More strict with FOLL_PIN, otherwise it could race with fork().  The
> +        * page table lock guarantees that fork() will capture all the pinned
> +        * pages when dup_mm() and do proper page copy on them.
> +        */
> +       if (flags & FOLL_PIN) {
> +               ptl = pte_lockptr(mm, pmd);
> +               if (!spin_trylock(ptl))
> +                       return 0;
> +       }

I'd hate to take spinlock in the GUP-fast path. Also I don't think this is
quite correct because GUP-fast-only can be called from interrupt context
and page table locks are not interrupt safe. That being said I don't see
what's wrong with the solution Jason proposed of first setting writeprotect 
and then checking page_may_be_dma_pinned() during fork(). That should work
just fine AFAICT... BTW note that GUP-fast code is (and this is deliberated
because e.g. DAX depends on this) first updating page->_refcount and then
rechecking PTE didn't change and the page->_refcount update is actually
done using atomic_add_unless() so that it cannot be reordered wrt the PTE
check. So the fork() code only needs to add barriers to pair with this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
