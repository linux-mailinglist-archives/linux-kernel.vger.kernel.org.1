Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4628F2EFC4A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbhAIAni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAIAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:43:38 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D9FC061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:42:57 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id v3so12147268ilo.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mwpiQdCX3uSGLuWqcWsinO8OgVZgFTwuSUQpD9MWZw=;
        b=Xmqxco8LQwKpK8WR9ASPCun5zzFYLPzVT6cPJSKPnj0oC//gL9S6ZOJCYaNP/MOnkl
         E8mZa8sKFGhdC76VLXCwNUBaMlb8ajpe0PBvT5HIekbFySNP0txRhu7tqhSFMx8SSLmD
         OKt2Jaa6Q04hVlBoOe14H7KptAhUoRE0vsZF+KuJxlFpt4e5l8K9x8GOScwnuK0SzyJQ
         Cg+KPl8MoFMkEOMU4hZf2D4OzzN+GzOBcvxTR25ocDkl9yEmJnjsKGtAuDXadbyL86lq
         shYCwiYpFNuT9pOzQnrmtsYqFLod9ypXQfPHWilSmiGyEB5Xd94Ppr107nQIMOtsLNqa
         t/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mwpiQdCX3uSGLuWqcWsinO8OgVZgFTwuSUQpD9MWZw=;
        b=WCxiHrOp//50Fgl+rHXUuJu9qcQ279jWHpG+Vxz39yAxZoJRC1TaGXo8u5GXemwGl0
         wdjH4qBObwv5D+40moPFht2gYI6W1MnqVKD9AbzYSrXnkgq2NSh4TV4EvixI+PgD4FCd
         yfsHFXg+1D8easA8fAPHImoChi/pFmJGa2TCVISaTPk/dqkr+nJ4gFKgMBoanUtZHPO/
         eX4VjDPImlvrWqm8EXgt9dzFN8ViBQpciSBNnkh5qZXI0di/tgBPam6i7r1OoN+2sskp
         gqLaK++ceMoMUMTXLOq4scAl7jweNkB5b0tAAtc6nvWDi327P1tYvVHc4dM0ZeXlBDHA
         iIXA==
X-Gm-Message-State: AOAM533xd8RblET82sMZ0x9g+0IRyr+SXFoJR7LTGPBISnhkExN54Z7D
        qIcAdhDWl4CsEPzqqeWcbAIolw==
X-Google-Smtp-Source: ABdhPJw4QDpuM+jtgspX0Rxf2EmRs6Srt95dRaiXcPYDzd3H7EhygXayo+NQTg2RFyXPMQbYtNf8ew==
X-Received: by 2002:a05:6e02:1187:: with SMTP id y7mr6331061ili.143.1610152977144;
        Fri, 08 Jan 2021 16:42:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 9sm6170821iob.28.2021.01.08.16.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 16:42:56 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ky2LH-004TYf-Fm; Fri, 08 Jan 2021 20:42:55 -0400
Date:   Fri, 8 Jan 2021 20:42:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <20210109004255.GG504133@ziepe.ca>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
 <20210108181945.GF504133@ziepe.ca>
 <X/jgLGPgPb+Xms1t@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/jgLGPgPb+Xms1t@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 05:43:56PM -0500, Andrea Arcangeli wrote:
> On Fri, Jan 08, 2021 at 02:19:45PM -0400, Jason Gunthorpe wrote:
> > On Fri, Jan 08, 2021 at 12:00:36PM -0500, Andrea Arcangeli wrote:
> > > > The majority cannot be converted to notifiers because they are DMA
> > > > based. Every one of those is an ABI for something, and does not expect
> > > > extra privilege to function. It would be a major breaking change to
> > > > have pin_user_pages require some cap.
> > > 
> > > ... what makes them safe is to be transient GUP pin and not long
> > > term.
> > > 
> > > Please note the "long term" in the underlined line.
> > 
> > Many of them are long term, though only 50 or so have been marked
> > specifically with FOLL_LONGTERM. I don't see how we can make such a
> > major ABI break.
> 
> io_uring is one of those indeed and I already flagged it.
> 
> This isn't a black and white issue, kernel memory is also pinned but
> it's not in movable pageblocks... How do you tell the VM in GUP to
> migrate memory to a non movable pageblock before pinning it? Because
> that's what it should do to create less breakage.

There is already a patch series floating about to do exactly that for
FOLL_LONGTERM pins based on the existing code in GUP for CMA migration

> For example iommu obviously need to be privileged, if your argument
> that it's enough to use the right API to take long term pins
> unconstrained, that's not the case. Pins are pins and prevent moving
> or freeing the memory, their effect is the same and again worse than
> mlock on many levels.

The ship sailed on this a decade ago, it is completely infeasible to
go back now, it would completely break widely used things like GPU,
RDMA and more.

> Maybe io_uring could keep not doing mmu notifier, I'd need more
> investigation to be sure, but what's the point of keeping it
> VM-breaking when it doesn't need to? Is io_uring required to setup the
> ring at high frequency?

If we want to have a high speed copy_from_user like thing that is not
based on page pins but on mmu notifiers, then we should make that
infrastructure and the various places that need it should use common
code. At least vhost and io_uring are good candidates.

Otherwise, we are pretending that they are DMA and using the DMA
centric pin_user_pages() interface, which we still have to support and
make work.

> In any case, the extra flags required in FOLL_LONGTERM should be
> implied by FOLL_LONGTERM itself, once it enters the gup code, because
> it's not cool having to FOLL_WRITE in all drivers for a GUP(write=0),
> let alone having to specify FOLL_FORCE for just a read. But this is
> going offtopic.

We really should revise this, I've been thinking for a while we need
to internalize into gup.c the FOLL_FORCE|FOLL_WRITE|FOLL_LONGTERM
idiom at least..

> > simply because it is using the CPU to memory copy as its "DMA".
> 
> vmsplice can't find all put_pages that may release the pages when the
> pipe is read, or it'd be at least be able to do the unreliable
> RLIMIT_MEMLOCK accounting.

Yikes! So it can't even use pin_user_pages FOLL_LONGTERM properly
because that requires unpin_user_pages(), which means finding all the
unpin sites too :\
 
> I'm glad we agree vmsplice is unsafe. The PR for the seccomp filter is
> open so if you don't mind, I'll link your review as confirmation.

OK
 
> To make another example a single unprivileged pin on the movable zone,
> can break memhotunplug unless you use the mmu notifier. Every other
> advanced feature falls apart.

As above FOLL_LONGTERM will someday migrate from movable zones.

The fact that people keep adding MM features that are incompatible
with FOLL_LONGTERM is troublesome.

However, the people who want hot-pluggable DIMMS don't get to veto the
people who want RDMA, GPU and so on out of the kernel. (or vice versa)

It seems we will end up with a MM where some work loads will be
incompatible with some MM features.

> So again, if an unprivileged syscalls allows a very limited number of
> pages, maybe it checks also if it got a THP or a gigapage page from
> the pin, it sets its own limit, maybe again it's not a big
> concern.

We also don't do a good job uniformly tracking rmlimit/etc. I'd
ideally like to see that in the core code too. Someone once tried that
a bit but we couldn't ge agreement what the right thing was because
different drivers do different things. Sigh.

> Any transient GUP pin no matter which fancy API you use to take it, is
> enough to open the window for the above attack, not just FOLL_LONGERM.

Yes, that is interesting. We've always known that the FOLL_LONGTERM
special machinery is techincally needed for O_DIRECT and basically all
other cases for coherence, but till now I hand't heard of a security
argument. It does make sense :(

> For those with the reproducer for the bug fixed in
> 17839856fd588f4ab6b789f482ed3ffd7c403e1f here's the patch to apply to
> reproduce it once on v5.11 once again:

So this is still at least because vmsplice is buggy to use plain
get_user_pages() for it's long term usage, and buggy to not use the
FOLL_FORCE|FOLL_WRITE idiom for read :\

A small patch to make vmsplice set those flags on its gup would at
least robustly close this immediate security problem without whatever
side effects caused the revert of commit forcing that in GUP iteself.

> You're thinking at your use case only.

I'm thinking about the rules to make pin_user_pages(FOLL_LONGTERM)
sane and working, yes. It is an API we have that is used widely, and
really needs a solid definition. This idea we can just throw it out
completely is a no-go to me.

There are other similar APIs, like normal GUP, hmm_range_fault, and so
on, but these are different things, with different rules.

> Thinking long term GUP pin is read-write DMA is very reductive.
>
> There doesn't need to be DMA at all.
> 
> KVM and a shadow MMU can attach to the RAM in readonly totally
> fine. And if it writes, it'll write not through the PCI bus, still
> with the CPU access.

That is not gup FOLL_LONGTERM, that is mmu notifiers..

mmu notifier users who are using hmm_range_fault() do not ever take any
page references when doing their work, that seems like the right
approach, for a shadow mmu?

> Nothing at all can go wrong, unless wp_copy_page suddenly makes the
> secondary MMU go out of sync the moment you wrprotect the page with
> clear_refs.

To be honest, I've read most of this discussion, and the prior one,
between you and Linus carefully, but I still don't understand what
clear_refs is about or how KVM's use of mmu notifiers got broken. This
is probably because I'm only a little familiar with those areas :\

Is it actually broken or just inefficient? If wp_copy_page is going
more often than it should the secondary mmu should still fully track
that?

> Overall a design where the only safety of a secondary MMU from going
> out of sync comes from the wrprotection not happening looks weak.

To be clear, here I am only talking about pin_user_pages. We now have
logic to tell if a page is under pin_user_pages(FOLL_LONGTERM) or not,
and that is what is driving the copy on fork logic.

secondary-mmu drivers using mmu notifier should not trigger this logic
and should not restrict write protect.

> Ultimately, what do we really gain from all this breakage?

Well, the clean definition of pin_user_pages(FOLL_LONGTERM) is very
positive for DMA drivers working in that area.
 
Jason
