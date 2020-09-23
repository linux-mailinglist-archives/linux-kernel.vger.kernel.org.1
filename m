Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA2274DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgIWA1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727015AbgIWA1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600820861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xGDE1yzKyE5kc6EXF+iSj4DX9Dvcn5/HEjhUC9MrZfM=;
        b=h58EZDElFe7qnWryC8PHE6b2qY4w5YhXm91Rei2PC5ZZLWAYGBkAgZGJzT84ojzsOv4/hN
        LxXPP2nw8X1vp00IeJqXlyWqrBNV8lyCZuarImVEKRCF8CFhVgZ+/d6TZ94v8hK97qcPF3
        kAnJ05ZxDnt2aL/pbyga4B82b226mQM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-n7LcfIV0NG6jKIyAY-lrUA-1; Tue, 22 Sep 2020 20:27:39 -0400
X-MC-Unique: n7LcfIV0NG6jKIyAY-lrUA-1
Received: by mail-qk1-f198.google.com with SMTP id m23so15268802qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 17:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xGDE1yzKyE5kc6EXF+iSj4DX9Dvcn5/HEjhUC9MrZfM=;
        b=soBsPTdkh6NIrMA7ZUCnUey1Ln3bLo4v8Fg5aiJhMP0jVmLZTpMGeACHXAbIFm75My
         KkgW4pmWfk7+iq0rCaD0YIZkTi73ycb0GegmOXTqm1cWl/M4xwJoRwpCYPcjBKhS6MPc
         CSiEnq1Wny5kRZWOaDSoTsqkikwaLmnfQd9Zxj4cfzKdUiPErFFCZUfw5QUCpsrzblnY
         pBbcU+ofNRYGCeQNROXHDhr+ckTIEMiFNJP0e0b1KAJZ22BV9E9P2a8Z9uV/6HK8EROH
         bKBzSlv7i7I/2mMmeo8NB1hA/KWKSsNZDwF/Em601TmRKoTnf1HnpVuIlRzF5oJ8rK7k
         13ww==
X-Gm-Message-State: AOAM532to3CvwkDTwJH2rspF49g/GPYgK3N4rNO5Zs2NcB6yS2eoXozW
        OtnUJPkDcX3jEkFaATqcTQzW1NNxkaK69nkXDC3M9mQSqZxj5p7rVoYVDKQ/Ii15yz7qu/qGMmv
        9/Zy1u+Qk2CHpbpZLKDu6er8n
X-Received: by 2002:a0c:dd8d:: with SMTP id v13mr8635441qvk.22.1600820858771;
        Tue, 22 Sep 2020 17:27:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaaRTxMotr0e7loft5rDR9S4uZO8D2viy77VWKYGRYo7u6uovWqlsy/QULgXLw0bLZzvNoYQ==
X-Received: by 2002:a0c:dd8d:: with SMTP id v13mr8635411qvk.22.1600820858450;
        Tue, 22 Sep 2020 17:27:38 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t11sm13498143qtp.32.2020.09.22.17.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 17:27:37 -0700 (PDT)
Date:   Tue, 22 Sep 2020 20:27:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20200923002735.GN19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922191116.GK8409@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 04:11:16PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 01:54:15PM -0400, Peter Xu wrote:
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 8f3521be80ca..6591f3f33299 100644
> > +++ b/mm/memory.c
> > @@ -888,8 +888,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >                  * Because we'll need to release the locks before doing cow,
> >                  * pass this work to upper layer.
> >                  */
> > -               if (READ_ONCE(src_mm->has_pinned) && wp &&
> > -                   page_maybe_dma_pinned(page)) {
> > +               if (wp && page_maybe_dma_pinned(page) &&
> > +                   READ_ONCE(src_mm->has_pinned)) {
> >                         /* We've got the page already; we're safe */
> >                         data->cow_old_page = page;
> >                         data->cow_oldpte = *src_pte;
> > 
> > I can also add some more comment to emphasize this.
> 
> It is not just that, but the ptep_set_wrprotect() has to be done
> earlier.

Now I understand your point, I think..  So I guess it's not only about
has_pinned, but it should be a race between the fast-gup and the fork() code,
even if has_pinned is always set.

> 
> Otherwise it races like:
> 
>    pin_user_pages_fast()                   fork()
>     atomic_set(has_pinned, 1);
>     [..]
>                                            atomic_read(page->_refcount) //false
>                                            // skipped atomic_read(has_pinned)
>     atomic_add(page->_refcount)
>     ordered check write protect()
>                                            ordered set write protect()
> 
> And now have a write protect on a DMA pinned page, which is the
> invarient we are trying to create.
> 
> The best algorithm I've thought of is something like:
> 
>  pte_map_lock()
>   if (page) {
>       if (wp) {
> 	  ptep_set_wrprotect()
> 	  /* Order with try_grab_compound_head(), either we see
> 	   * page_maybe_dma_pinned(), or they see the wrprotect */
> 	  get_page();

Is this get_page() a must to be after ptep_set_wrprotect() explicitly?  IIUC
what we need is to order ptep_set_wrprotect() and page_maybe_dma_pinned() here.
E.g., would a "mb()" work?

Another thing is, do we need similar thing for e.g. gup_pte_range(), so that
to guarantee ordering of try_grab_compound_head() and the pte change check?

> 
> 	  if (page_maybe_dma_pinned() && READ_ONCE(src_mm->has_pinned)) {
> 	       put_page();
> 	       ptep_clear_wrprotect()
> 
> 	       // do copy
> 	       return
> 	  }
>       } else {
> 	  get_page();
>       }
>       page_dup_rmap()
>  pte_unmap_lock()
> 
> Then the do_wp_page() path would have to detect that the page is not
> write protected under the pte lock inside the fault handler and just
> do nothing.

Yes, iiuc do_wp_page() should be able to handle spurious write page faults like
this already, as below:

	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
	spin_lock(vmf->ptl);
        ...
	if (vmf->flags & FAULT_FLAG_WRITE) {
		if (!pte_write(entry))
			return do_wp_page(vmf);
		entry = pte_mkdirty(entry);
	}

So when spin_lock() returns:

  - When it's a real cow (not pinned pages; we write-protected it and it keeps
    write-protected), we should do cow here as usual.

  - When it's a fake cow (pinned pages), the write bit should have been
    recovered before the page table lock released, and we'll skip do_wp_page()
    and retry the page fault immediately.

> Ie the set/clear could be visible to the CPU and trigger a
> spurious fault, but never trigger a COW.
> 
> Thus 'wp' becomes a 'lock' that prevents GUP from returning this page.

Another question is, how about read fast-gup for pinning?  Because we can't use
the write-protect mechanism to block a read gup.  I remember we've discussed
similar things and iirc your point is "pinned pages should always be with
WRITE".  However now I still doubt it...  Because I feel like read gup is still
legal (as I mentioned previously - when device purely writes to the page and
the processor only reads from it).

> 
> Very tricky, deserves a huge comment near the ptep_clear_wrprotect()
> 
> Consider the above algorithm beside the gup_fast() algorithm:
> 
> 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
> 			goto pte_unmap;
>                 [..]
> 		head = try_grab_compound_head(page, 1, flags);
> 		if (!head)
> 			goto pte_unmap;
> 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> 			put_compound_head(head, 1, flags);
> 			goto pte_unmap;
> 
> That last *ptep will check that the WP is not set after making
> page_maybe_dma_pinned() true.
> 
> It still looks reasonable, the extra work is still just the additional
> atomic in page_maybe_dma_pinned(), just everything else has to be very
> carefully sequenced due to unlocked page table accessors.

Tricky!  I'm still thinking about some easier way but no much clue so far.
Hopefully we'll figure out something solid soon.

Thanks,

-- 
Peter Xu

