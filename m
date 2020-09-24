Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBB277502
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgIXPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728273AbgIXPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600960587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEGtP1M885HpaQR6XfPDu4hVB77QGMGwZzHzi2KUVdc=;
        b=SfPlt8BAi4It2Ims8jkv3mYm3UjfePpi/tPz1bafqtXye58HlhdbxWiirIlkJyt/jJKT2O
        RaLXtLDZ6U0MIWwF85xnU89xtlWy786aJzcOmASG3/wUZUaTH0zqaOY7Uwis9uE20OeHIg
        v95oWvvyWkf9fVwlAJ0t9ttP0GkNB4U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-L3hMCPZUN9GV4Re_3BUJIg-1; Thu, 24 Sep 2020 11:16:23 -0400
X-MC-Unique: L3hMCPZUN9GV4Re_3BUJIg-1
Received: by mail-qk1-f200.google.com with SMTP id y17so2166647qky.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JEGtP1M885HpaQR6XfPDu4hVB77QGMGwZzHzi2KUVdc=;
        b=aBDrnlAKkDZAD2PwOByk+0E6EdRexI0FHfBLc7VbUC4v0LlXBGQ+6VpwcN7tmGMrrJ
         ccghuALHUe/pwiCuBJczZRozNUeliAcHlyBvgVVc7cAR3QBCHW/6U181/TgWO/JKiW7t
         Lcl8NuFF+v3arZZBxBvA8BrRcoin8vHVRuQ0J0XnFLJAFslAHCmAx8o2hZM99bQROdo8
         UoK37uXwgr8eP4wizHkzIOMEEsKr2Qxtze74bBFqPK45ZpavS4qKJRbHc8r7TA2Y3UKf
         FVx2f6K6E9BNbYfigHaPgDdKXBpGbY5JCnJTMzy9HTiJJOySvwMZeT9ES1E8q679vQpN
         3OiA==
X-Gm-Message-State: AOAM531i6gFonO3xkl7hWehUOdbbL1BnZXcAuqaMw8OZGdtSgJZ9+T0v
        6LInEaMTEcso3IzDc/YMELrqVgHIgJulCH9RIhpdVUlM+mtf2LVPxlXELv+JOJ0JrDCnIvns9AD
        RXDBdFBbwhDgAyrC2K1NS4eLH
X-Received: by 2002:a0c:8064:: with SMTP id 91mr5906420qva.32.1600960583349;
        Thu, 24 Sep 2020 08:16:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyld9DnbypPWR5nFPjnFyrJjYMGJ38UcvgnWhrOmiQba5Tp+8IV7jIKTMFFsrSTGbNwB/fIbQ==
X-Received: by 2002:a0c:8064:: with SMTP id 91mr5906391qva.32.1600960582988;
        Thu, 24 Sep 2020 08:16:22 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id z29sm2436288qtj.79.2020.09.24.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:16:22 -0700 (PDT)
Date:   Thu, 24 Sep 2020 11:16:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
Message-ID: <20200924151620.GF79898@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <2a590103-95dc-5aed-6e7a-5f8b58337dd0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a590103-95dc-5aed-6e7a-5f8b58337dd0@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:48:00PM +0300, Kirill Tkhai wrote:
> > +/*
> > + * Duplicate the page for this PTE.  Returns zero if page copied (so we need to
> > + * retry on the same PTE again to arm the copied page very soon), or negative
> > + * if error happened.  In all cases, the old page will be properly released.
> > + */
> > +static int page_duplicate(struct mm_struct *src_mm, struct vm_area_struct *vma,
> > +			  unsigned long address, struct copy_mm_data *data)
> > +{
> > +	struct page *new_page = NULL;
> > +	int ret;
> > +
> > +	/* This should have been set in change_one_pte() when reach here */
> > +	WARN_ON_ONCE(!data->cow_old_page);
> 
> Despite WARN() is preferred over BUG() in kernel, it looks a little strange that
> we catch WARN once here, but later avoid panic in put_page().

Do you mean "it'll panic in put_page()"?  I'll agree if so, seems this
WARN_ON_ONCE() won't help much.

> 
> > +	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
> > +	if (!new_page) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	copy_user_highpage(new_page, data->cow_old_page, address, vma);
> > +	ret = mem_cgroup_charge(new_page, src_mm, GFP_KERNEL);
> 
> All failing operations should go first, while copy_user_highpage() should go last.

Since I'll rebase to Linus's patch, I'll move this into the critical section
because the preallocated page can be used by any pte after that.  The spin
locks will need to be taken longer for that, but assuming that's not a problem
for an unlikely path.

> > @@ -859,6 +989,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >  			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
> >  				break;
> >  		}
> > +
> > +		if (unlikely(data.cow_new_page)) {
> > +			/*
> > +			 * If cow_new_page set, we must be at the 2nd round of
> > +			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
> > +			 * page now.  Note that in all cases page_break_cow()
> > +			 * will properly release the objects in copy_mm_data.
> > +			 */
> > +			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
> > +			if (pte_install_copied_page(dst_mm, new, src_pte,
> > +						    dst_pte, addr, rss,
> > +						    &data)) {
> 
> It looks a little confusing, that all helpers in this function return 0 in case of success,
> while pte_install_copied_page() returns true. Won't be better to return 0 and -EAGAIN instead
> from it?

IMHO it's fine as long as no real errno will be popped out of the new helper.
But no strong opinion either, I'll see what I can do after the rebase.

Thanks for reviewing the patch even if it's going away.

-- 
Peter Xu

