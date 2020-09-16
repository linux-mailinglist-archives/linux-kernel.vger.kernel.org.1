Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACF26C857
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgIPSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:46:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728191AbgIPSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600281985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puIJGOJT+MwnnD6TZO9vIKCPtXLQsx8Gz/5DaTlQPWM=;
        b=TAdIjz6KQVZTDiJcn5kHKmy27tizWOFGKSCfty4m1hpuFGQnIC1+mNNfJJJ12tMPq+rexG
        dQ0kK/lIpBmFcl96dKB70FUm2X5HV0jNC/ich5MuHnBFArxhZwiCeB+TMCD+smu8Qml7gi
        aU2L8uzw5dPf5h+54j8C+9ev9kT6vd4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-tO998b-EPWiQxW0o4tIzmA-1; Wed, 16 Sep 2020 14:46:24 -0400
X-MC-Unique: tO998b-EPWiQxW0o4tIzmA-1
Received: by mail-qt1-f197.google.com with SMTP id c5so6826363qtd.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=puIJGOJT+MwnnD6TZO9vIKCPtXLQsx8Gz/5DaTlQPWM=;
        b=GTgnHZlcqNUUYHxSRdgs57QGg9+z8bnAf4vakCOXLaXIx/G57mcWAHA2jhoC3pLyzk
         qm8LQH+rRLu0aLf0bPc0zmWUmsXEO5GsoXERj3hs68qXFKiG/BjoN/GCxtSSdZcL66pw
         0EcSqSpiO3Fc8PtdnDnPw3z2jRYphwUnzmsE+nVea8dOw797BFQCitOxpdg/81M5EMDn
         7hs3/0jdVJOUalxtw66g82tF+js8k3+E8XNM8vtX0lbCyJCSXGNucPRlOcx9x0MxwbCA
         nsBnEMUeksI0U8isdxcc39+b/cAZzxUiDcu5Esy/R/RXjiGjtz3JxFjOxGafBGHRZPGh
         ep8w==
X-Gm-Message-State: AOAM532UHOxsEKNkalUSr7/RbIkHHVyloYkHGxIhpysiGVx5o0PvcxId
        wXaVe9K693yZpEcoacoQ4PCFXZJ83Tn07xSrvaE36P29OQDdDli/RArYLGqm87nX5GugeHJRuBh
        7YKT8xfPG5lUxAI2IkqdOgTf7
X-Received: by 2002:ad4:4b61:: with SMTP id m1mr25199594qvx.11.1600281982357;
        Wed, 16 Sep 2020 11:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo98nfkY+hGwK/tn74LUrnsECrW254lBUhMHvRV6bFVTzuK7i0gQXeUYoi4ivt4+pB84qrSw==
X-Received: by 2002:ad4:4b61:: with SMTP id m1mr25199556qvx.11.1600281982062;
        Wed, 16 Sep 2020 11:46:22 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id v2sm6833117qkv.26.2020.09.16.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:46:21 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:46:19 -0400
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
Message-ID: <20200916184619.GB40154@xz-x1>
References: <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200916174804.GC8409@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:48:04PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 06:50:46PM -0700, John Hubbard wrote:
> > > 
> > > It seems very strange that a physical page exclusively owned by a
> > > process can become copied if pin_user_pages() is active and the
> > > process did fork() at some point.
> > > 
> > > Could the new pin_user_pages() logic help here? eg the
> > > GUP_PIN_COUNTING_BIAS stuff?
> > > 
> > > Could the COW code consider a refcount of GUP_PIN_COUNTING_BIAS + 1 as
> > > being owned by the current mm and not needing COW? The DMA pin would
> > > be 'invisible' for COW purposes?
> > 
> > 
> > Please do be careful to use the API, rather than the implementation. The
> > FOLL_PIN refcounting system results in being able to get a "maybe
> > DMA-pinned", or a "definitely not DMA-pinned", via this API call:
> 
> So, what I'm thinking is something like (untested):
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 469af373ae76e1..77f63183667e52 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2889,6 +2889,26 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +static bool cow_needed(struct vm_fault *vmf)
> +{
> +	int total_map_swapcount;
> +
> +	if (!reuse_swap_page(vmf->page, &total_map_swapcount)) {
> +		unlock_page(vmf->page);
> +		return true;
> +	}
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
> @@ -2947,8 +2967,21 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		if (!trylock_page(page))
>  			goto copy;
>  		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +			bool cow = true;
> +
> +			/*
> +			 * If the page is DMA pinned we can't rely on the
> +			 * above to know if there are other CPU references as
> +			 * page_count() will be elevated by the
> +			 * pin. Needlessly copying the page will cause the DMA
> +			 * pin to break, try harder to avoid that.
> +			 */
> +			if (page_maybe_dma_pinned(page))
> +				cow = cow_needed(vmf);
> +
>  			unlock_page(page);
> -			goto copy;
> +			if (cow)
> +				goto copy;
>  		}
>  		/*
>  		 * Ok, we've got the only map reference, and the only
> 
> What do you think Peter? Is this remotely close?

My understanding is this may only work for the case when the fork()ed child
quitted before we reach here (so we still have mapcount==1 for the page).  What
if not?  Then mapcount will be greater than 1, and cow will still trigger.  Is
that what we want?

Another problem is that, aiui, one of the major change previous patch proposed
is to avoid using lock_page() so that we never block in this path.  However if
we need the page reuse logic to guarantee pinning pages, then it becomes a
correctness issue, so I'm afraid we'll start to make all things complicated
again. Maybe even more complicated, because "correctness" should be even harder
than "best effort reuse" since it can cause data corruption if we didn't do it
right...

-- 
Peter Xu

