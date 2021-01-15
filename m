Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3747E2F77A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbhAOL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:28:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:59904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhAOL2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:28:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A57AACAC;
        Fri, 15 Jan 2021 11:27:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD77B1E0800; Fri, 15 Jan 2021 12:27:21 +0100 (CET)
Date:   Fri, 15 Jan 2021 12:27:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
Message-ID: <20210115112721.GF27380@quack2.suse.cz>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <4100a6f5-ab0b-f7e5-962f-ea1dbcb1e47e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4100a6f5-ab0b-f7e5-962f-ea1dbcb1e47e@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-01-21 13:53:18, John Hubbard wrote:
> On 1/7/21 1:29 PM, Linus Torvalds wrote:
> > On Thu, Jan 7, 2021 at 12:59 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> > > 
> > > The problem is it's not even possible to detect reliably if there's
> > > really a long term GUP pin because of speculative pagecache lookups.
> > 
> > So none of the normal code _needs_ that any more these days, which is
> > what I think is so nice. Any pinning will do the COW, and then we have
> > the logic to make sure it stays writable, and that keeps everything
> > nicely coherent and is all fairly simple.
> > 
> > And yes, it does mean that if somebody then explicitly write-protects
> > a page, it may end up being COW'ed after all, but if you first pinned
> > it, and then started playing with the protections of that page, why
> > should you be surprised?
> > 
> > So to me, this sounds like a "don't do that then" situation.
> > 
> > Anybody who does page pinning and wants coherency should NOT TOUCH THE
> > MAPPING IT PINNED.
> > 
> > (And if you do touch it, it's your own fault, and you get to keep both
> > of the broken pieces)
> > 
> > Now, I do agree that from a QoI standpoint, it would be really lovely
> > if we actually enforced it. I'm not entirely sure we can, but maybe it
> > would be reasonable to use that
> > 
> >    mm->has_pinned && page_maybe_dma_pinned(page)
> > 
> > at least as the beginning of a heuristic.
> > 
> > In fact, I do think that "page_maybe_dma_pinned()" could possibly be
> > made stronger than it is. Because at *THAT* point, we might say "we
> 
> What exactly did you have in mind, to make it stronger? I think the
> answer is in this email but I don't quite see it yet...
> 
> Also, now seems to be a good time to mention that I've been thinking about
> a number of pup/gup pinning cases (Direct IO, GPU/NIC, NVMe/storage peer
> to peer with GUP/NIC, and HMM support for atomic operations from a device).
> And it seems like the following approach would help:
> 
> * Use pin_user_pages/FOLL_PIN for long-term pins. Long-term here (thanks
> to Jason for this point) means "user space owns the lifetime". We might
> even end up deleting either FOLL_PIN or FOLL_LONGTERM, because this would
> make them mean the same thing. The idea is that there are no "short term"
> pins of this kind of memory.
> 
> * Continue to use FOLL_GET (only) for Direct IO. That's a big change of plans,
> because several of us had thought that Direct IO needs FOLL_PIN. However, this
> recent conversation, plus my list of cases above, seems to indicate otherwise.
> That's because we only have one refcount approach for marking pages in this way,
> and we should spend it on the long-term pinned pages. Those are both hard to
> identify otherwise, and actionable once we identify them.

Somewhat late to the game but I disagree here. I think direct IO still
needs FOLL_PIN so that page_may_be_dma_pinned() returns true for it. At
least for shared pages. Because filesystems/mm in the writeback path need
to detect whether the page is pinned and thus its contents can change
anytime without noticing, the page can be dirtied at random times etc. In
that case we need to bounce the page during writeback (to avoid checksum
failures), keep page as dirty in internal filesystem bookkeeping (and in MM
as well) etc...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
