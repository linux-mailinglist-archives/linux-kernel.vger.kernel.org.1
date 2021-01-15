Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C132F7E40
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbhAOObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:31:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:59232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731685AbhAOObk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:31:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 800CBABDA;
        Fri, 15 Jan 2021 14:30:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0A3701E0800; Fri, 15 Jan 2021 15:30:58 +0100 (CET)
Date:   Fri, 15 Jan 2021 15:30:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <20210115143058.GG27380@quack2.suse.cz>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
 <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com>
 <20210109193224.GB35215@casper.infradead.org>
 <CAHk-=wgv=fz=c34MJOUbdSOVb6pGXkEXx9OnTz7weuYYBhd5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgv=fz=c34MJOUbdSOVb6pGXkEXx9OnTz7weuYYBhd5pQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 09-01-21 11:46:46, Linus Torvalds wrote:
> On Sat, Jan 9, 2021 at 11:33 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jan 07, 2021 at 01:05:19PM -0800, Linus Torvalds wrote:
> > > Side note, and not really related to UFFD, but the mmap_sem in
> > > general: I was at one point actually hoping that we could make the
> > > mmap_sem a spinlock, or at least make the rule be that we never do any
> > > IO under it. At which point a write lock hopefully really shouldn't be
> > > such a huge deal.
> >
> > There's a (small) group of us working towards that.  It has some
> > prerequisites, but where we're hoping to go currently:
> >
> >  - Replace the vma rbtree with a b-tree protected with a spinlock
> >  - Page faults walk the b-tree under RCU, like peterz/laurent's SPF patchset
> >  - If we need to do I/O, take a refcount on the VMA
> >
> > After that, we can gradually move things out from mmap_sem protection
> > to just the vma tree spinlock, or whatever makes sense for them.  In a
> > very real way the mmap_sem is the MM layer's BKL.
> 
> Well, we could do the "no IO" part first, and keep the semaphore part.
> 
> Some people actually prefer a semaphore to a spinlock, because it
> doesn't end up causing preemption issues.
> 
> As long as you don't do IO (or memory allocations) under a semaphore
> (ok, in this case it's a rwsem, same difference), it might even be
> preferable to keep it as a semaphore rather than as a spinlock.
> 
> So it doesn't necessarily have to go all the way - we _could_ just try
> something like "when taking the mmap_sem, set a thread flag" and then
> have a "warn if doing allocations or IO under that flag".
> 
> And since this is about performance, not some hard requirement, it
> might not even matter if we catch all cases.  If we fix it so that any
> regular load on most normal filesystems never see the warning, we'd
> already be golden.

Honestly, I'd *love* if a filesystem can be guaranteed that ->fault and
->mkwrite callbacks do not happen under mmap_sem (or if at least fs would
be free to drop mmap_sem if it finds the page is not already cached /
prepared for writing). Because for filesystems the locking of page fault is
really painful as the lock ordering wrt mmap_sem is exactly oposite
compared to read / write path (read & write path must be designed so that
mmap_sem can be taken inside it to copy user data, fault path may be all
happening under mmap_sem). As a result this has been a long term source of
deadlocks, stale data exposure issues, and filesystem corruption issues due
to insufficient locking for multiple filesystems.

But when I was looking at what it would take to achieve this several years
ago, fixing all GUP users to deal with mmap_sem being dropped during a
fault was a gigantic task because there were users of GUP relying on
mmap_sem being held for large code sections around the GUP call...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
