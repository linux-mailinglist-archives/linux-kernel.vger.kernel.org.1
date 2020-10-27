Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AEF29A7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409041AbgJ0JdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:33:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732268AbgJ0JdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:33:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2CC5AD6B;
        Tue, 27 Oct 2020 09:33:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6742D1E10F5; Tue, 27 Oct 2020 10:33:01 +0100 (CET)
Date:   Tue, 27 Oct 2020 10:33:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
Message-ID: <20201027093301.GA16090@quack2.suse.cz>
References: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
 <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-10-20 21:44:17, John Hubbard wrote:
> On 10/23/20 5:19 PM, Jason Gunthorpe wrote:
> > +	start += (unsigned long)nr_pinned << PAGE_SHIFT;
> > +	pages += nr_pinned;
> > +	ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned, gup_flags,
> > +				      pages);
> > +	if (ret < 0) {
> >   		/* Have to be a bit careful with return values */
> 
> ...and can we move that comment up one level, so that it reads:
> 
> 	/* Have to be a bit careful with return values */
> 	if (ret < 0) {
> 		if (nr_pinned)
> 			return nr_pinned;
> 		return ret;
> 	}
> 	return ret + nr_pinned;
> 
> Thinking about this longer term, it would be nice if the whole gup/pup API
> set just stopped pretending that anyone cares about partial success, because
> they *don't*. If we had return values of "0 or -ERRNO" throughout, and an
> additional set of API wrappers that did some sort of limited retry just like
> some of the callers do, that would be a happier story.

Actually there are callers that care about partial success. See e.g.
iov_iter_get_pages() usage in fs/direct_io.c:dio_refill_pages() or
bio_iov_iter_get_pages(). These places handle partial success just fine and
not allowing partial success from GUP could regress things...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
