Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B963A270733
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIRUk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgIRUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600461655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3KTlzeMxbkN1J9iZRU481kw+vClX1N3yaY5uZmjOiU=;
        b=VI6e2eIx8fsiY9q4NMvZfe+vp0iBraEQHmhouo0KU6wzh9fWdUb5HgNvFCu1uKIkNn3FK9
        Y7wUyTiK22udjrftktLk/lLg33sNi75oZt8k9tAojvYHdeJChe39cTYLUlHqznwDeZqag6
        /1Fj2G232AcGRRtUJNOICSfCjtkO4cY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-N8kaIr3YNAmupcHgoV3U5w-1; Fri, 18 Sep 2020 16:40:51 -0400
X-MC-Unique: N8kaIr3YNAmupcHgoV3U5w-1
Received: by mail-qt1-f198.google.com with SMTP id a14so6164496qtp.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y3KTlzeMxbkN1J9iZRU481kw+vClX1N3yaY5uZmjOiU=;
        b=gAUz02dILm+n71mczr3pdjboCKsnK+vTtT+Dla0VXeksZRGqpVdMoZMJBClmgSRw6Z
         JiP0nnBQB0/rL3hjNZo4GTkvpmb58ASZsa3gBaoIwztyY+ICAOq3UcS4j1cLBvkg9oX8
         2i/kSqMFLskOPZYYiXGhq/BMqhPTgMmapNZgqOFp3UPldUQESlM8Y+pMfcQoGTq7T9hX
         ZIBmq0tbaDo/FgD/o+rH/qmaDQVqqbjc5zwMlx7ybQ+jx9eJIGpfvTvvZwY5W7KOWEDQ
         xGq776V2b/EqRnQlROKvHuP8QjbI1UhKycRN3bLi3b27i8uQQBuq4xDe03F4DmRystMb
         Uq/A==
X-Gm-Message-State: AOAM530n/O0oWR+cJeQzhsGTIBqGIFfOhAoVRa7CooI84cb2KQAaC9qG
        4BQt8hZu08y/dFDxKS83xt12/4aLsjlOnEIVsvGYpsCdPciX35a2Ax6HwPNYLUMEQFO8hWGzJ0M
        +/KBmyt240i5U+nqXSb6hQr/5
X-Received: by 2002:a05:6214:1873:: with SMTP id eh19mr675811qvb.16.1600461651231;
        Fri, 18 Sep 2020 13:40:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3iutpyLjf91kqStVUiq6iFQBBnNS8rPmqK2B51dRwo0/lAH8cLr6yiWJHX0b46FDiDeG1iw==
X-Received: by 2002:a05:6214:1873:: with SMTP id eh19mr675782qvb.16.1600461650816;
        Fri, 18 Sep 2020 13:40:50 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id 202sm2832821qkg.56.2020.09.18.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:40:50 -0700 (PDT)
Date:   Fri, 18 Sep 2020 16:40:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200918204048.GC5962@xz-x1>
References: <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200918173240.GY8409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918173240.GY8409@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 02:32:40PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 18, 2020 at 12:40:32PM -0400, Peter Xu wrote:
> 
> > Firstly in the draft patch mm->has_pinned is introduced and it's written to 1
> > as long as FOLL_GUP is called once.  It's never reset after set.
> 
> Worth thinking about also adding FOLL_LONGTERM here, at last as long
> as it is not a counter. That further limits the impact.

But theoritically we should also trigger COW here for pages even with PIN &&
!LONGTERM, am I right?  Assuming that FOLL_PIN is already a corner case.

> > One issue is when we charge for cgroup we probably can't do that onto the new
> > mm/task, since copy_namespaces() is called after copy_mm().  I don't know
> > enough about cgroup, I thought the child will inherit the parent's, but I'm not
> > sure.  Or, can we change that order of copy_namespaces() && copy_mm()?  I don't
> > see a problem so far but I'd like to ask first..
> 
> Know nothing about cgroups, but I would have guessed that the page
> table allocations would want to be in the cgroup too, is the struct
> page a different bucket?

Good question...  I feel like this kind of accountings were always done to
"current" via alloc_page().  But frankly speaking I don't know whether I
understand it right because afaict "current" is the parent during fork(), while
I feel like it will make more sense if it is accounted to the child process.  I
think I should have missed something important but I can't tell..

> 
> > The other thing is on how to fail.  E.g., when COW failed due to either
> > charging of cgroup or ENOMEM, ideally we should fail fork() too.  Though that
> > might need more changes - current patch silently kept the shared page for
> > simplicity.
> 
> I didn't notice anything tricky here.. Something a bit gross but
> simple seemed workable:
> 
> @@ -852,7 +852,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  			continue;
>  		}
>  		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
> -							vma, addr, rss);
> +							vma, addr, rss, &err);
>  		if (entry.val)
>  			break;
>  		progress += 8;
> @@ -865,6 +865,9 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	pte_unmap_unlock(orig_dst_pte, dst_ptl);
>  	cond_resched();
>  
> +	if (err)
> +		return err;
> +
>  	if (entry.val) {
>  		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
>  			return -ENOMEM;
> 
> It is not really any different from add_swap_count_continuation()
> failure, which already works..

Yes it's not pretty, but I do plan to use something like this to avoid touching
all the return path in coyp_one_pte(), and I think the answer to the last
question matters too, below.

> > diff --git a/mm/gup.c b/mm/gup.c
> > index e5739a1974d5..cab10cefefe4 100644
> > +++ b/mm/gup.c
> > @@ -1255,6 +1255,17 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
> >  		BUG_ON(*locked != 1);
> >  	}
> >  
> > +	/*
> > +	 * Mark the mm struct if there's any page pinning attempt.  We're
> > +	 * aggresive on this bit since even if the pinned pages were unpinned
> > +	 * later on, we'll still keep this bit set for this address space just
> > +	 * to make everything easy.
> > +	 *
> > +	 * TODO: Ideally we can use mm->pinned_vm but only until it's stable.
> > +	 */
> > +	if (flags & FOLL_PIN)
> > +		WRITE_ONCE(mm->has_pinned, 1);
> 
> This should probably be its own commit, here is a stab at a commit
> message:
> 
> Reduce the chance of false positive from page_maybe_dma_pinned() by
> keeping track if the mm_struct has ever been used with
> pin_user_pages(). mm_structs that have never been passed to
> pin_user_pages() cannot have a positive page_maybe_dma_pinned() by
> definition. This allows cases that might drive up the page ref_count
> to avoid any penalty from handling dma_pinned pages.
> 
> Due to complexities with unpining this trivial version is a permanent
> sticky bit, future work will be needed to make this a counter.

Thanks for writting this.  I'll keep the commit message once split until I need
to post a formal patch.  Before that hope it's fine I'll still use a single
patch for simplicity because I still want to keep the discussion within the
thread.

> 
> > +/*
> > + * Do early cow for the page and the pte. Return true if page duplicate
> > + * succeeded, false otherwise.
> > + */
> > +static bool duplicate_page(struct mm_struct *mm, struct vm_area_struct *vma,
> 
> Suggest calling 'vma' 'new' here for consistency

OK.

> 
> > +			   unsigned long address, struct page *page,
> > +			   pte_t *newpte)
> > +{
> > +       struct page *new_page;
> > +       pte_t entry;
> > +
> > +       new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
> > +       if (!new_page)
> > +               return false;
> > +
> > +       copy_user_highpage(new_page, page, address, vma);
> > +       if (mem_cgroup_charge(new_page, mm, GFP_KERNEL)) {
> > +	       put_page(new_page);
> > +	       return false;
> > +       }
> > +       cgroup_throttle_swaprate(new_page, GFP_KERNEL);
> > +       __SetPageUptodate(new_page);
> 
> It looks like these GFP flags can't be GFP_KERNEL, this is called
> inside the pte_alloc_map_lock() which is a spinlock
> 
> One thought is to lift this logic out to around
> add_swap_count_continuation()? Would need some serious rework to be
> able to store the dst_pte though.

What would be the result if we simply use GFP_ATOMIC?  Would there be too many
pages to allocate in bulk for ATOMIC?  IMHO slowness would be fine, but I don't
know the inside of page allocation, and not sure whether __GFP_KSWAPD_RECLAIM
means we might kick kswapd and whether we'll deadlock when the kswapd could
potentially try to take the spinlock again somewhere while we waiting for it?

It would be good to go this (easy) way considering this is a very rare to
trigger path, so we can still keep copy_one page simple.  Otherwise I seem to
have no choice to move the page copy logic out of copy_one_pte(), as you
suggested.

-- 
Peter Xu

