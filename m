Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3071C27544C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:22:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIWJWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:22:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F97DAE93;
        Wed, 23 Sep 2020 09:22:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A01361E12E3; Wed, 23 Sep 2020 11:22:05 +0200 (CEST)
Date:   Wed, 23 Sep 2020 11:22:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
Message-ID: <20200923092205.GA6719@quack2.suse.cz>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
 <20200922103315.GD15112@quack2.suse.cz>
 <4a65586e-9282-beb0-1880-1ef8da03727c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a65586e-9282-beb0-1880-1ef8da03727c@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 13:01:13, John Hubbard wrote:
> On 9/22/20 3:33 AM, Jan Kara wrote:
> > On Mon 21-09-20 23:41:16, John Hubbard wrote:
> > > On 9/21/20 2:20 PM, Peter Xu wrote:
> > > ...
> > > > +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > > > +		     page_maybe_dma_pinned(src_page))) {
> > > 
> > > This condition would make a good static inline function. It's used in 3
> > > places, and the condition is quite special and worth documenting, and
> > > having a separate function helps with that, because the function name
> > > adds to the story. I'd suggest approximately:
> > > 
> > >      page_likely_dma_pinned()
> > > 
> > > for the name.
> > 
> > Well, but we should also capture that this really only works for anonymous
> > pages. For file pages mm->has_pinned does not work because the page may be
> > still pinned by completely unrelated process as Jann already properly
> > pointed out earlier in the thread. So maybe anon_page_likely_pinned()?
> > Possibly also assert PageAnon(page) in it if we want to be paranoid...
> > 
> > 								Honza
> 
> The file-backed case doesn't really change anything, though:
> page_maybe_dma_pinned() is already a "fuzzy yes" in the same sense: you
> can get a false positive. Just like here, with an mm->has_pinned that
> could be a false positive for a process.
> 
> And for that reason, I'm also not sure an "assert PageAnon(page)" is
> desirable. That assertion would prevent file-backed callers from being
> able to call a function that provides a fuzzy answer, but I don't see
> why you'd want or need to do that. The goal here is to make the fuzzy
> answer a little bit more definite, but it's not "broken" just because
> the result is still fuzzy, right?
> 
> Apologies if I'm missing a huge point here... :)

But the problem is that if you apply mm->has_pinned check on file pages,
you can get false negatives now. And that's not acceptable...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
