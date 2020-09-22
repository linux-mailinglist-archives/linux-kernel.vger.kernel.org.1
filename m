Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762EB2745DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIVP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgIVP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600790328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZEZPjbCW+WDznyPzY3pnwtHOxYlin7U6kq/5+vfiZE=;
        b=cYTOJjtvjwY1fgV4xgzk5qrqvirJoMd9xgoFlGc2ju5f8uSeecJ25V72qGnA6x8j8kGRN8
        UkkwSeKxQVPBG4Cjgu8sHp9OTIi0fkY+R+iZDAJa3TTzs8uwnxt7b8bG7iT7unh7/cW469
        cfKp1ya2dQ5B/JIKYRcMmdg5SowsQ30=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-x7Z9FSYQMMunLZJyLx9VIA-1; Tue, 22 Sep 2020 11:58:46 -0400
X-MC-Unique: x7Z9FSYQMMunLZJyLx9VIA-1
Received: by mail-qt1-f198.google.com with SMTP id b39so16427265qta.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZEZPjbCW+WDznyPzY3pnwtHOxYlin7U6kq/5+vfiZE=;
        b=XhuA9LisvEvBuKz5pNri0GmEjYJmAZQ4W6jWPzq535HS6KDQLbqaFg6MbmYvQ9dc83
         UBFrpswpLfkl6BukNyILjyCd9IoLQfrTePxgiZMjOfuolJyiB1OT7lR4WqqafRiwDY1x
         aeeXqKmFFcDfwXfwLaA8RyE+vNtG/3x3NSZsFjUCpf1SqbUO/CsBcjeP9ez/NsraSqa0
         U7EAMMqTeBszVF6i2Auz5igMWzeSxp4mrf4wi2e4rN2VTTaAqPSvjjXV0zaCpBkmd8q1
         /TDfYTJYGaWaTtgqdPK0u1ZhbL+pMjBAMTSjAg4VWenAEu3x4RRDhKqUwhpQ05EaK2QG
         LVOA==
X-Gm-Message-State: AOAM533riyCOJgSvDEW+a5fNGLTpCclGkai6Alm25+tniV6WnWxJ/yUc
        Fm/dV6mGz9vokxuQt4StNsF93F8qcoBSbZ1InusiaX7ymec6ZjNwcW1OavrhJ4qjFbUV/3Xutq7
        9Sk+M5XMNoPG/h873kSdTB7r8
X-Received: by 2002:a37:c203:: with SMTP id i3mr5326159qkm.155.1600790325427;
        Tue, 22 Sep 2020 08:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3NRg7sKvd2vdXkXVqig5l4rY6SRi9Xchw1HLlRRiR3IT2ZLli2VcqqeYnwmwJakErDEjHag==
X-Received: by 2002:a37:c203:: with SMTP id i3mr5326127qkm.155.1600790325099;
        Tue, 22 Sep 2020 08:58:45 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id g8sm11777550qkl.28.2020.09.22.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:58:43 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:58:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
Message-ID: <20200922155842.GG19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <20200922114839.GC11679@redhat.com>
 <20200922124013.GD11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922124013.GD11679@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 02:40:14PM +0200, Oleg Nesterov wrote:
> On 09/22, Oleg Nesterov wrote:
> >
> > On 09/21, Peter Xu wrote:
> > >
> > > @@ -859,6 +989,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > >  			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
> > >  				break;
> > >  		}
> > > +
> > > +		if (unlikely(data.cow_new_page)) {
> > > +			/*
> > > +			 * If cow_new_page set, we must be at the 2nd round of
> > > +			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
> > > +			 * page now.  Note that in all cases page_break_cow()
> > > +			 * will properly release the objects in copy_mm_data.
> > > +			 */
> > > +			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
> > > +			if (pte_install_copied_page(dst_mm, new, src_pte,
> > > +						    dst_pte, addr, rss,
> > > +						    &data)) {
> > > +				/* We installed the pte successfully; move on */
> > > +				progress++;
> > > +				continue;
> >
> > I'm afraid I misread this patch too ;)
> >
> > But it seems to me in this case the main loop can really "leak"
> > COPY_MM_BREAK_COW. Suppose the the next 31 pte's are pte_none() and
> > need_resched() is true.
> >
> > No?

I still think it's a no...

Note that now we'll reset "progress" every time before the do loop, so we'll
never reach need_resched() (since progress<32) before pte_install_copied_page()
when needed.

I explicitly put the pte_install_copied_page() into the loop just...

> 
> If yes, perhaps we can simplify the copy_ret/cow_new_page logic and make
> it more explicit?
> 
> Something like below, on top of this patch...
> 
> Oleg.
> 
> 
> --- x/mm/memory.c
> +++ x/mm/memory.c
> @@ -704,17 +704,6 @@
>  	};
>  };
>  
> -static inline void page_release_cow(struct copy_mm_data *data)
> -{
> -	/* The old page should only be released in page_duplicate() */
> -	WARN_ON_ONCE(data->cow_old_page);
> -
> -	if (data->cow_new_page) {
> -		put_page(data->cow_new_page);
> -		data->cow_new_page = NULL;
> -	}
> -}

(I'm not very sure on whether I should drop this helper.  I wanted to have more
 spots for checking everything is right and raise if something got wrong, and I
 also wanted to have the cow_new_page to never contain invalid page pointer too
 since after the put_page() it's invalid (otherwise we'll need to set NULL when
 we do put_page every time explicitly).  I'll still tend to keep this if no
 strong opinion.. or I can also drop it if there's another vote.)

> -
>  /*
>   * Duplicate the page for this PTE.  Returns zero if page copied (so we need to
>   * retry on the same PTE again to arm the copied page very soon), or negative
> @@ -925,7 +914,7 @@
>  
>  	if (!pte_same(*src_pte, data->cow_oldpte)) {
>  		/* PTE has changed under us.  Release the page and retry */
> -		page_release_cow(data);
> +		put_page(data->cow_new_page);
>  		return false;
>  	}
>  
> @@ -936,12 +925,6 @@
>  	set_pte_at(dst_mm, addr, dst_pte, entry);
>  	rss[mm_counter(new_page)]++;
>  
> -	/*
> -	 * Manually clear the new page pointer since we've moved ownership to
> -	 * the newly armed PTE.
> -	 */
> -	data->cow_new_page = NULL;
> -
>  	return true;
>  }
>  
> @@ -958,16 +941,12 @@
>  	struct copy_mm_data data;
>  
>  again:
> -	/* We don't reset this for COPY_MM_BREAK_COW */
> -	memset(&data, 0, sizeof(data));
> -
> -again_break_cow:
>  	init_rss_vec(rss);
>  
>  	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
>  	if (!dst_pte) {
> -		/* Guarantee that the new page is released if there is */
> -		page_release_cow(&data);
> +		if (unlikely(copy_ret == COPY_MM_BREAK_COW))
> +			put_page(data.cow_new_page);
>  		return -ENOMEM;
>  	}
>  	src_pte = pte_offset_map(src_pmd, addr);
> @@ -978,6 +957,22 @@
>  	arch_enter_lazy_mmu_mode();
>  
>  	progress = 0;
> +	if (unlikely(copy_ret == COPY_MM_BREAK_COW)) {
> +		/*
> +		 * Note that in all cases pte_install_copied_page()
> +		 * will properly release the objects in copy_mm_data.
> +		 */
> +		copy_ret = COPY_MM_DONE;
> +		if (pte_install_copied_page(dst_mm, new, src_pte,
> +					    dst_pte, addr, rss,
> +					    &data)) {
> +			/* We installed the pte successfully; move on */
> +			progress++;
> +			goto next;

... to avoid jumps like this because I think it's really tricky. :)

> +		}
> +		/* PTE changed.  Retry this pte (falls through) */
> +	}
> +
>  	do {
>  		/*
>  		 * We are holding two locks at this point - either of them
> @@ -990,24 +985,6 @@
>  				break;
>  		}
>  
> -		if (unlikely(data.cow_new_page)) {
> -			/*
> -			 * If cow_new_page set, we must be at the 2nd round of
> -			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
> -			 * page now.  Note that in all cases page_break_cow()
> -			 * will properly release the objects in copy_mm_data.
> -			 */
> -			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
> -			if (pte_install_copied_page(dst_mm, new, src_pte,
> -						    dst_pte, addr, rss,
> -						    &data)) {
> -				/* We installed the pte successfully; move on */
> -				progress++;
> -				continue;
> -			}
> -			/* PTE changed.  Retry this pte (falls through) */
> -		}
> -
>  		if (pte_none(*src_pte)) {
>  			progress++;
>  			continue;
> @@ -1017,6 +994,7 @@
>  		if (copy_ret != COPY_MM_DONE)
>  			break;
>  		progress += 8;
> +next:
>  	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
>  
>  	arch_leave_lazy_mmu_mode();
> @@ -1030,13 +1008,14 @@
>  	case COPY_MM_SWAP_CONT:
>  		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
>  			return -ENOMEM;
> -		break;
> +		copy_ret = COPY_MM_DONE;

Kind of a continuation of the discussion from previous patch - I think we'd
better reset copy_ret not only for this case, but move it after the switch
(just in case there'll be new ones).  The new BREAK_COW uses goto so it's quite
special.

> +		goto again;

I feel like this could go wrong without the "addr != end" check later, when
this is the last pte to check.

Thanks,

>  	case COPY_MM_BREAK_COW:
>  		/* Do accounting onto parent mm directly */
>  		ret = page_duplicate(src_mm, vma, addr, &data);
>  		if (ret)
>  			return ret;
> -		goto again_break_cow;
> +		goto again;
>  	case COPY_MM_DONE:
>  		/* This means we're all good. */
>  		break;
> 

-- 
Peter Xu

