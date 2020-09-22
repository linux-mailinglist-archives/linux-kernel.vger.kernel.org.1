Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF822746FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIVQwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbgIVQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600793551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QghsFN8I1DkvHVyY0c6ycpuSeL/z8MexSX8KO76bC/Y=;
        b=OFOgPldjSW3YUWIw4EJmI2wspl5Pi6K+MLtyxHMLx0WLuL5pseDdbOaFqAPKYJHYz6txqF
        GbPxJnBs5Lc3bbpeyVRdqaV0duwTynzyEBkC4yayTBT8mNwwfZffDlkMvJEdwPfmZcLJeq
        HEW6WUg2AAXaypskxpIbI11t8E80CtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-gSImXLNdNja_xc6MYWpZZQ-1; Tue, 22 Sep 2020 12:52:27 -0400
X-MC-Unique: gSImXLNdNja_xc6MYWpZZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B4801006706;
        Tue, 22 Sep 2020 16:52:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7058119D61;
        Tue, 22 Sep 2020 16:52:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Sep 2020 18:52:25 +0200 (CEST)
Date:   Tue, 22 Sep 2020 18:52:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200922165216.GF11679@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <20200922114839.GC11679@redhat.com>
 <20200922124013.GD11679@redhat.com>
 <20200922155842.GG19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922155842.GG19098@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22, Peter Xu wrote:
>
> On Tue, Sep 22, 2020 at 02:40:14PM +0200, Oleg Nesterov wrote:
> > On 09/22, Oleg Nesterov wrote:
> > >
> > > On 09/21, Peter Xu wrote:
> > > >
> > > > @@ -859,6 +989,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > >  			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
> > > >  				break;
> > > >  		}
> > > > +
> > > > +		if (unlikely(data.cow_new_page)) {
> > > > +			/*
> > > > +			 * If cow_new_page set, we must be at the 2nd round of
> > > > +			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
> > > > +			 * page now.  Note that in all cases page_break_cow()
> > > > +			 * will properly release the objects in copy_mm_data.
> > > > +			 */
> > > > +			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
> > > > +			if (pte_install_copied_page(dst_mm, new, src_pte,
> > > > +						    dst_pte, addr, rss,
> > > > +						    &data)) {
> > > > +				/* We installed the pte successfully; move on */
> > > > +				progress++;
> > > > +				continue;
> > >
> > > I'm afraid I misread this patch too ;)
> > >
> > > But it seems to me in this case the main loop can really "leak"
> > > COPY_MM_BREAK_COW. Suppose the the next 31 pte's are pte_none() and
> > > need_resched() is true.
> > >
> > > No?
>
> I still think it's a no...
>
> Note that now we'll reset "progress" every time before the do loop, so we'll
> never reach need_resched() (since progress<32) before pte_install_copied_page()
> when needed.

Yes. But copy_ret is still COPY_MM_BREAK_COW after pte_install_copied_page().
Now suppose that the next 31 pte's are pte_none(), progress will be incremented
every time.

> I explicitly put the pte_install_copied_page() into the loop just...
...
> >  	progress = 0;
> > +	if (unlikely(copy_ret == COPY_MM_BREAK_COW)) {
> > +		/*
> > +		 * Note that in all cases pte_install_copied_page()
> > +		 * will properly release the objects in copy_mm_data.
> > +		 */
> > +		copy_ret = COPY_MM_DONE;
> > +		if (pte_install_copied_page(dst_mm, new, src_pte,
> > +					    dst_pte, addr, rss,
> > +					    &data)) {
> > +			/* We installed the pte successfully; move on */
> > +			progress++;
> > +			goto next;
>
> ... to avoid jumps like this because I think it's really tricky. :)

To me it looks better before the main loop because we know that
data.cow_new_page != NULL is only possible at the 1st iterattion after
restart ;)

But I agree, this is subjective, please ignore. However, I still think
it is better to rely on the copy_ret == COPY_MM_BREAK_COW check rather
than data.cow_new_page != NULL.

> >  	case COPY_MM_SWAP_CONT:
> >  		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
> >  			return -ENOMEM;
> > -		break;
> > +		copy_ret = COPY_MM_DONE;
>
> Kind of a continuation of the discussion from previous patch - I think we'd
> better reset copy_ret not only for this case, but move it after the switch
> (just in case there'll be new ones).  The new BREAK_COW uses goto so it's quite
> special.
>
> > +		goto again;
>
> I feel like this could go wrong without the "addr != end" check later, when
> this is the last pte to check.

How? We know that copy_one_pte() failed and returned COPY_MM_SWAP_CONT
before addr = end.

And this matters "case COPY_MM_BREAK_COW" below which does "goto again"
without the "addr != end" check.

Oleg.

