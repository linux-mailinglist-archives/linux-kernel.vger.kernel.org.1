Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3634727594C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgIWOBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:01:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:54716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWOBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:01:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57324ACC6;
        Wed, 23 Sep 2020 14:01:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 613271E12E3; Wed, 23 Sep 2020 16:01:14 +0200 (CEST)
Date:   Wed, 23 Sep 2020 16:01:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20200923140114.GA15875@quack2.suse.cz>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
 <20200922103315.GD15112@quack2.suse.cz>
 <4a65586e-9282-beb0-1880-1ef8da03727c@nvidia.com>
 <20200923092205.GA6719@quack2.suse.cz>
 <20200923135004.GB59978@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923135004.GB59978@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-09-20 09:50:04, Peter Xu wrote:
> On Wed, Sep 23, 2020 at 11:22:05AM +0200, Jan Kara wrote:
> > On Tue 22-09-20 13:01:13, John Hubbard wrote:
> > > On 9/22/20 3:33 AM, Jan Kara wrote:
> > > > On Mon 21-09-20 23:41:16, John Hubbard wrote:
> > > > > On 9/21/20 2:20 PM, Peter Xu wrote:
> > > > > ...
> > > > > > +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > > > > > +		     page_maybe_dma_pinned(src_page))) {
> > > > > 
> > > > > This condition would make a good static inline function. It's used in 3
> > > > > places, and the condition is quite special and worth documenting, and
> > > > > having a separate function helps with that, because the function name
> > > > > adds to the story. I'd suggest approximately:
> > > > > 
> > > > >      page_likely_dma_pinned()
> > > > > 
> > > > > for the name.
> > > > 
> > > > Well, but we should also capture that this really only works for anonymous
> > > > pages. For file pages mm->has_pinned does not work because the page may be
> > > > still pinned by completely unrelated process as Jann already properly
> > > > pointed out earlier in the thread. So maybe anon_page_likely_pinned()?
> > > > Possibly also assert PageAnon(page) in it if we want to be paranoid...
> > > > 
> > > > 								Honza
> > > 
> > > The file-backed case doesn't really change anything, though:
> > > page_maybe_dma_pinned() is already a "fuzzy yes" in the same sense: you
> > > can get a false positive. Just like here, with an mm->has_pinned that
> > > could be a false positive for a process.
> > > 
> > > And for that reason, I'm also not sure an "assert PageAnon(page)" is
> > > desirable. That assertion would prevent file-backed callers from being
> > > able to call a function that provides a fuzzy answer, but I don't see
> > > why you'd want or need to do that. The goal here is to make the fuzzy
> > > answer a little bit more definite, but it's not "broken" just because
> > > the result is still fuzzy, right?
> > > 
> > > Apologies if I'm missing a huge point here... :)
> > 
> > But the problem is that if you apply mm->has_pinned check on file pages,
> > you can get false negatives now. And that's not acceptable...
> 
> Do you mean the case where proc A pinned page P from a file, then proc B
> mapped the same page P on the file, then fork() on proc B?

Yes.

> If proc B didn't explicitly pinned page P in B's address space too,
> shouldn't we return "false" for page_likely_dma_pinned(P)?  Because if
> proc B didn't pin the page in its own address space, I'd think it's ok to
> get the page replaced at any time as long as the content keeps the same.
> Or couldn't we?

So it depends on the reason why you call page_likely_dma_pinned(). For your
COW purposes the check is correct but e.g. for "can filesystem safely
writeback this page" the page_likely_dma_pinned() would be wrong. So I'm
not objecting to the mechanism as such. I'm mainly objecting to the generic
function name which suggests something else than what it really checks and
thus it could be used in wrong places in the future... That's why I'd
prefer to restrict the function to PageAnon pages where there's no risk of
confusion what the check actually does.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
