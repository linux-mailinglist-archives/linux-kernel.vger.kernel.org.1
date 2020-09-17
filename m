Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F070726E363
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIQSTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgIQSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600366562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IF4zecc5wQDOc5a4udeGDriTmJ5wV4OM9czOL0eJzpw=;
        b=L1f4dyT+vzEkk+wN33KVEv0zsZKEOlrsb7qvfFJKGGRmwNqh4pLW05z7aQuCtOjVEeRczv
        B3R075UATzjlwC6f5oGqXPLC+dXtawpQoe1IgcqAoqFOIMdVaYQpcNwViqfhyYdJVtbi2f
        8vDXnknggX/+5vVPgQCYkVW5VHdhFgE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-xw1q3ReIPS2SRm6cOBwC0g-1; Thu, 17 Sep 2020 14:14:15 -0400
X-MC-Unique: xw1q3ReIPS2SRm6cOBwC0g-1
Received: by mail-qt1-f198.google.com with SMTP id b39so2472537qta.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IF4zecc5wQDOc5a4udeGDriTmJ5wV4OM9czOL0eJzpw=;
        b=by8qcNLJB0VphRxGsvJKc0KVY0iW354Y6ZWsX7IAPoAKKnk22aznYL+j4iJtJD14ef
         D9hvg783POmsfKCIpQog8/Kf5CVyYzmsmR44kEb0cR+LUYe2Oa5TdppDBqBJC0Wx/eUB
         ECxuXS/glcygex0FOejbENIdx4mFpKLuy0Fe5egNe2Kj4x8yYSUJd1jF4V2vJ87D8DV6
         mTJYBMdgzKZ9X5pngLqFTqhXc4h1EQnHUf15mG6xa4TQmwMkeKmTjRlG2AShYqPX+ocS
         fLHWS2sCq8rEZNarlOuLPWYhEezZouTumlAKaJgv5VZALnOGDGytai0YaeqzpyvVZ/ER
         zCXw==
X-Gm-Message-State: AOAM531+GWxcTpEowma3xfmsL/5+PChN58d3KlZkdA87p4qHMIMI+UUC
        1W2DekHeYKpblJTcW340Z3pcGsR4IyDcPG69Oifujjlu1vVMTDWT702297ZZrCuVjam0uTmov5w
        Mn2n6L0h+suYaC1njfki3maCl
X-Received: by 2002:a37:c09:: with SMTP id 9mr29971953qkm.471.1600366454422;
        Thu, 17 Sep 2020 11:14:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv+J6l0noy++KbjYYrO9rRxKBnRnBapSN5CJf/NTEn4xMRix6ZnaYZiOgo9+y0BQm/lnN4XA==
X-Received: by 2002:a37:c09:: with SMTP id 9mr29971913qkm.471.1600366454043;
        Thu, 17 Sep 2020 11:14:14 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id m6sm362823qkh.106.2020.09.17.11.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:14:13 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:14:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200917181411.GA133226@xz-x1>
References: <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917112538.GD8409@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:25:38AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 16, 2020 at 02:46:19PM -0400, Peter Xu wrote:
> 
> > My understanding is this may only work for the case when the fork()ed child
> > quitted before we reach here (so we still have mapcount==1 for the
> > page).  
> 
> Yes
> 
> > What if not?  Then mapcount will be greater than 1, and cow will
> > still trigger.  Is that what we want?
> 
> That doesn't work today anyhow, so it is fine continuing to be broken.
> 
> > Another problem is that, aiui, one of the major change previous patch proposed
> > is to avoid using lock_page() so that we never block in this path.
> 
> I saw you mention this before, but it looks like the change was to
> lift some of the atomc_reads out of the lock and avoid the lock if
> they indicate failure, checking also for page_maybe_dma_pinned()
> outside the lock just means the rare case of FOLL_PIN we will take the
> lock again.

Sorry to be unclear.  What I meant was that iiuc if we want to guarantee the
pinned page will be reused, then try_lock_page() could be too weak, and we may
still need lock_page().  E.g., an race on another thread who locked the page
accidentally which fails the try_lock_page() can trigger unexpected cow for the
pinned pages.

> 
> > Maybe even more complicated, because "correctness" should be even harder
> > than "best effort reuse" since it can cause data corruption if we didn't do it
> > right...
> 
> The only correct way is for the application to avoid write protect on
> FOLL_PIN pages. The purpose here is to allow applications that hadn't
> hit "bad luck" and failed to keep working.
> 
> Another thought is to insert a warning print here as well that the
> program is working improperly? At least it would give a transition
> period to evaluate the extent of the problem.
> 
> We are thinking it is going to be a notable regression.
> 
> I botched the last version of the patch, here is something a bit
> better.
> 
> Does it seem like it could be OK? I know very little about this part
> of the kernel

In my humble opinion, the real solution is still to use MADV_DONTFORK properly
so we should never share the DMA pages with others when we know the fact.

The apps may work with the old kernels, but IMHO they just work by accident
because the DMA pages were luckily not shared due to any other reason when the
write-protect page fault happens. E.g., the parent did waitpid() on the childs
so it is guaranteed that there will only be one user of the page then it'll be
reused as long as we check the mapcounts. But that's kind of a "workaround" at
least to me, since I'd say the sharing should not happen at all at the first
place, right after we know it's a DMA page.

It would be good if Linus or Andrea could share their thoughts, or anyone who
knows better (I'd bet a plenty of.. :).

Thanks,

> 
> Thanks,
> Jason
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 469af373ae76e1..332de777854f8b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2889,6 +2889,24 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +static bool cow_needed(struct vm_fault *vmf)
> +{
> +	int total_map_swapcount;
> +
> +	if (!reuse_swap_page(vmf->page, &total_map_swapcount))
> +		return true;
> +
> +	if (total_map_swapcount == 1) {
> +		/*
> +		 * The page is all ours. Move it to our anon_vma so the rmap
> +		 * code will not search our parent or siblings.  Protected
> +		 * against the rmap code by the page lock.
> +		 */
> +		page_move_anon_rmap(vmf->page, vmf->vma);
> +	}
> +	return false;
> +}
> +
>  /*
>   * This routine handles present pages, when users try to write
>   * to a shared page. It is done by copying the page to a new address
> @@ -2942,13 +2960,27 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		struct page *page = vmf->page;
>  
>  		/* PageKsm() doesn't necessarily raise the page refcount */
> -		if (PageKsm(page) || page_count(page) != 1)
> +		if (PageKsm(page))
>  			goto copy;
> +		if (page_count(page) != 1) {
> +			/*
> +			 * If the page is DMA pinned we can't rely on the
> +			 * above to know if there are other CPU references as
> +			 * page_count() will be elevated by the
> +			 * pin. Needlessly copying the page will cause the DMA
> +			 * pin to break, try harder to avoid that.
> +			 */
> +			if (!page_maybe_dma_pinned(page))
> +				goto copy;
> +		}
> +
>  		if (!trylock_page(page))
>  			goto copy;
>  		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> -			unlock_page(page);
> -			goto copy;
> +			if (cow_needed(vmf)) {
> +				unlock_page(page);
> +				goto copy;
> +			}
>  		}
>  		/*
>  		 * Ok, we've got the only map reference, and the only
> 

-- 
Peter Xu

