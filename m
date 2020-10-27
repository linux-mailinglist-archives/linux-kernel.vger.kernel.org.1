Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5921929ACF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900592AbgJ0NPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:15:15 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45577 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894469AbgJ0NPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:15:14 -0400
Received: by mail-qv1-f66.google.com with SMTP id w5so585935qvn.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sHmAyUwVAC1RZfyUSoKpUkH6mD5+QpMZcYlVXmkgxH0=;
        b=mU2kPOv7szjJ5zW+bQ6BFR26C8Luax041L0av4G8wiZg4RTt8WNFJsqiiTJVSSUqn9
         DHwUggweGomAj/XPHnVfixfeNqULEl7kOQL+gEtxw8gSHqAAGqRarmuFp6/OT9KwDIvP
         GGYaNHMMUmlxrP/xza5phRgRZy9Oa2piX7dSUZYvRhMdSue49g/k0v780Ak5zN0ywqxh
         eCskrH3/sbI1vLTBjZfm+xCXRPYYn5WaCj1/REItIr+voVRDHHRh3IE++6xUs7yX7EA2
         Zc3LtdzPASeNU/iXrWyyakPOamzq772fSyEjnZ3wjkAh5ZvgBeLpOsFzeeZf/DVa2z4y
         Go7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sHmAyUwVAC1RZfyUSoKpUkH6mD5+QpMZcYlVXmkgxH0=;
        b=SfVLKuAcjPVlQ1yJSsR2si+PJqb7jM2uoDUNjyvgrW+i+6f5xdOd4WGG/HP4NIw3R3
         bGm43UxxVTKBFx105BD0xTuRBOfBp8OsR4Jsos9oAFZWWZGBEiW3Iw+2iX/RptKbnOPp
         bTEDCfU+j0GVFF3CDn/PGNoz4umjrzLF+5KHoIbQU+Tb2mBJ1XtwrpOMdrWhKNbTDNCX
         0kE7uDk3q7IockytJZ9ojyzrD1yf81SMGEIvr1i1voPeBjck/vMeyn/RUgZhF/kyuz8N
         R4tmUXwFa1kz+d1XlS7DUj//ZvQB7nZjMaUjwdF3HeBZsXgdHQ1YG8LfCURLIRW5bQ1l
         Wtvw==
X-Gm-Message-State: AOAM533I7q2dP7+k+c9MYD7ZP2tU+N6eYeD5VTSEcavHrd+lr177q3Sz
        b9lgQ4twpArUc8TI7yfCDSJDwg==
X-Google-Smtp-Source: ABdhPJydTjKeY2w5KSD1T7IK56kSvz3ZZH+klUlmJHUCotvf185qdWyac85cxoit/yL6SaHTP/PABw==
X-Received: by 2002:a0c:e70d:: with SMTP id d13mr2017645qvn.45.1603804511081;
        Tue, 27 Oct 2020 06:15:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v14sm702222qta.44.2020.10.27.06.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:15:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kXOof-009JYh-D0; Tue, 27 Oct 2020 10:15:09 -0300
Date:   Tue, 27 Oct 2020 10:15:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
Message-ID: <20201027131509.GU36674@ziepe.ca>
References: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
 <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
 <20201027093301.GA16090@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027093301.GA16090@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:33:01AM +0100, Jan Kara wrote:
> On Fri 23-10-20 21:44:17, John Hubbard wrote:
> > On 10/23/20 5:19 PM, Jason Gunthorpe wrote:
> > > +	start += (unsigned long)nr_pinned << PAGE_SHIFT;
> > > +	pages += nr_pinned;
> > > +	ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned, gup_flags,
> > > +				      pages);
> > > +	if (ret < 0) {
> > >   		/* Have to be a bit careful with return values */
> > 
> > ...and can we move that comment up one level, so that it reads:
> > 
> > 	/* Have to be a bit careful with return values */
> > 	if (ret < 0) {
> > 		if (nr_pinned)
> > 			return nr_pinned;
> > 		return ret;
> > 	}
> > 	return ret + nr_pinned;
> > 
> > Thinking about this longer term, it would be nice if the whole gup/pup API
> > set just stopped pretending that anyone cares about partial success, because
> > they *don't*. If we had return values of "0 or -ERRNO" throughout, and an
> > additional set of API wrappers that did some sort of limited retry just like
> > some of the callers do, that would be a happier story.
> 
> Actually there are callers that care about partial success. See e.g.
> iov_iter_get_pages() usage in fs/direct_io.c:dio_refill_pages() or
> bio_iov_iter_get_pages(). These places handle partial success just fine and
> not allowing partial success from GUP could regress things...

I looked through a bunch of call sites, and there are a wack that
actually do only want a complete return and are carrying a bunch of
code to fix it:

	pvec = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
	if (!pvec)
		return -ENOMEM;

	do {
		unsigned num_pages = npages - pinned;
		uint64_t ptr = userptr->ptr + pinned * PAGE_SIZE;
		struct page **pages = pvec + pinned;

		ret = pin_user_pages_fast(ptr, num_pages,
					  !userptr->ro ? FOLL_WRITE : 0, pages);
		if (ret < 0) {
			unpin_user_pages(pvec, pinned);
			kvfree(pvec);
			return ret;
		}

		pinned += ret;

	} while (pinned < npages);

Is really a lot better if written as:

   	pvec = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
	if (!pvec)
		return -ENOMEM;
	ret = pin_user_pages_fast(userptr->ptr, npages, FOLL_COMPLETE |
	                          (!userptr->ro ? FOLL_WRITE : 0),
				  pvec);
        if (ret) {
              kvfree(pvec);
	      return ret;
        }

(eg FOLL_COMPLETE says to return exactly npages or fail)

Some code assumes things work that way already anyhow:

	/* Pin user pages for DMA Xfer */
	err = pin_user_pages_unlocked(user_dma.uaddr, user_dma.page_count,
			dma->map, FOLL_FORCE);

	if (user_dma.page_count != err) {
		IVTV_DEBUG_WARN("failed to map user pages, returned %d instead of %d\n",
			   err, user_dma.page_count);
		if (err >= 0) {
			unpin_user_pages(dma->map, err);
			return -EINVAL;
		}
		return err;
	}

Actually I'm quite surprised I didn't find too many missing the tricky
unpin_user_pages() on the error path - eg
videobuf_dma_init_user_locked() is wrong.

Jason
