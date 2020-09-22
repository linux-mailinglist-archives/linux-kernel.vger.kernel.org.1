Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8066274833
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIVSes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbgIVSes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600799686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2e2tdhFMlrwW+fXumGUoJr4qesGrHM0WZlHkfuqDvsA=;
        b=PUop3uVf41N1PWssvJ8T8JJQqTeD5ToVjVSfGnllcmzlsq8GOhm8V+aytYIvRnubrQrieB
        jpKj0UV0VmP9eNejiCrXDY3NWshx6o+2l9fwaf4GyPEIw9bD9aR246EjhLjBBtKz5P6SOo
        +CfJoBocqPe7vrV9X4lxFx3GLKOOIMU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-kdpPVgISNEWV0uLjyyKJ_g-1; Tue, 22 Sep 2020 14:34:42 -0400
X-MC-Unique: kdpPVgISNEWV0uLjyyKJ_g-1
Received: by mail-qk1-f197.google.com with SMTP id a136so11499315qkb.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2e2tdhFMlrwW+fXumGUoJr4qesGrHM0WZlHkfuqDvsA=;
        b=Zn5znGwsUe7lkIURfzGL81OXTRafw7B57nm0yJJLy65XY72xVrqmKCtnuixFN5NJhH
         wSNZEI8Bkm51PFtCGM5zNvsyFzPOAH6vK27I5wRBXN3CXCTRVTRsE3HhmAZh3HEr9G+W
         PsU2BIqHRQXDD3sh3ksa51lAB/TrCDOrzx8FJVV2HuROSsBlV2fNfGL2PsM9B3NCjhZZ
         hD4gUvIV40R+C4ERUtNCI+v74b4pOlZpj/WNiHNKgZncZTOXALzbCWhGeD87/2GUyQGV
         YJUSZe6oaTKDpIsV4cJPQSjoeDTWpFc2ApJnqnvvjeBxHRu2Yj+FHYsqVVmAkeurauBL
         Np7Q==
X-Gm-Message-State: AOAM531Obh+xtYtOGiowhj66ADByFHYUu9IlwRBcNcFco/iD5cFeEkmC
        4eUQkmGLbXRpiFx904G1bWyqdj5ZqZyBTSiL3nlRC8gIFTonh/u5uGrPhyjpV+dNeEIMlYOkJik
        YBN6dQtgYxVxO1ABI/4dT1qIM
X-Received: by 2002:ac8:7003:: with SMTP id x3mr1340900qtm.206.1600799681492;
        Tue, 22 Sep 2020 11:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnAgffUvZjfrts3wLzysg5oFbP4RLUg3wVexTDXtde8ji2nEgCqs8IgonDSwF3ckMD2fRUHw==
X-Received: by 2002:ac8:7003:: with SMTP id x3mr1340868qtm.206.1600799681190;
        Tue, 22 Sep 2020 11:34:41 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id x126sm12083779qkb.101.2020.09.22.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:34:40 -0700 (PDT)
Date:   Tue, 22 Sep 2020 14:34:38 -0400
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
Message-ID: <20200922183438.GL19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <20200922114839.GC11679@redhat.com>
 <20200922124013.GD11679@redhat.com>
 <20200922155842.GG19098@xz-x1>
 <20200922165216.GF11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922165216.GF11679@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 06:52:17PM +0200, Oleg Nesterov wrote:
> On 09/22, Peter Xu wrote:
> >
> > On Tue, Sep 22, 2020 at 02:40:14PM +0200, Oleg Nesterov wrote:
> > > On 09/22, Oleg Nesterov wrote:
> > > >
> > > > On 09/21, Peter Xu wrote:
> > > > >
> > > > > @@ -859,6 +989,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > > >  			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
> > > > >  				break;
> > > > >  		}
> > > > > +
> > > > > +		if (unlikely(data.cow_new_page)) {
> > > > > +			/*
> > > > > +			 * If cow_new_page set, we must be at the 2nd round of
> > > > > +			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
> > > > > +			 * page now.  Note that in all cases page_break_cow()
> > > > > +			 * will properly release the objects in copy_mm_data.
> > > > > +			 */
> > > > > +			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
> > > > > +			if (pte_install_copied_page(dst_mm, new, src_pte,
> > > > > +						    dst_pte, addr, rss,
> > > > > +						    &data)) {
> > > > > +				/* We installed the pte successfully; move on */
> > > > > +				progress++;
> > > > > +				continue;
> > > >
> > > > I'm afraid I misread this patch too ;)
> > > >
> > > > But it seems to me in this case the main loop can really "leak"
> > > > COPY_MM_BREAK_COW. Suppose the the next 31 pte's are pte_none() and
> > > > need_resched() is true.
> > > >
> > > > No?
> >
> > I still think it's a no...
> >
> > Note that now we'll reset "progress" every time before the do loop, so we'll
> > never reach need_resched() (since progress<32) before pte_install_copied_page()
> > when needed.
> 
> Yes. But copy_ret is still COPY_MM_BREAK_COW after pte_install_copied_page().
> Now suppose that the next 31 pte's are pte_none(), progress will be incremented
> every time.

Yes, I think you're right - I'll need to reset that.

> 
> > I explicitly put the pte_install_copied_page() into the loop just...
> ...
> > >  	progress = 0;
> > > +	if (unlikely(copy_ret == COPY_MM_BREAK_COW)) {
> > > +		/*
> > > +		 * Note that in all cases pte_install_copied_page()
> > > +		 * will properly release the objects in copy_mm_data.
> > > +		 */
> > > +		copy_ret = COPY_MM_DONE;
> > > +		if (pte_install_copied_page(dst_mm, new, src_pte,
> > > +					    dst_pte, addr, rss,
> > > +					    &data)) {
> > > +			/* We installed the pte successfully; move on */
> > > +			progress++;
> > > +			goto next;
> >
> > ... to avoid jumps like this because I think it's really tricky. :)
> 
> To me it looks better before the main loop because we know that
> data.cow_new_page != NULL is only possible at the 1st iterattion after
> restart ;)
> 
> But I agree, this is subjective, please ignore.

Thanks.  For simplicity, I'll keep the code majorly as is.  But I'm still open
to change if e.g. someone else still perfers the other way.

> However, I still think
> it is better to rely on the copy_ret == COPY_MM_BREAK_COW check rather
> than data.cow_new_page != NULL.

Yes.  Logically we should check both, but now as I'm written it as:

        if (unlikely(data.cow_new_page)) {
                WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
                ...
        }

I think it's even safer because it's actually checking both, but also warn if
only cow_new_page is set, which should never happen anyways.

Or I can also do it in inverted order if you think better:

        if (unlikely(copy_ret == COPY_MM_BREAK_COW)) {
                WARN_ON_ONCE(!data.cow_new_page);
                ...
        }

> 
> > >  	case COPY_MM_SWAP_CONT:
> > >  		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
> > >  			return -ENOMEM;
> > > -		break;
> > > +		copy_ret = COPY_MM_DONE;
> >
> > Kind of a continuation of the discussion from previous patch - I think we'd
> > better reset copy_ret not only for this case, but move it after the switch
> > (just in case there'll be new ones).  The new BREAK_COW uses goto so it's quite
> > special.
> >
> > > +		goto again;
> >
> > I feel like this could go wrong without the "addr != end" check later, when
> > this is the last pte to check.
> 
> How? We know that copy_one_pte() failed and returned COPY_MM_SWAP_CONT
> before addr = end.

I think you're right, again. :)

Thanks,

-- 
Peter Xu

