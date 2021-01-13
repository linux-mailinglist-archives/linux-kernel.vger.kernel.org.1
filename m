Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE32F56DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbhANBy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:54:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729654AbhAMX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610582075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=as2BhiOSeOwWsZSJ+wtoAod/cmhjluP6SS6qqPvRZnI=;
        b=GXbNZsYMPwD/SS25ilJ7WiLYOhdCtwMBRalxhqmpcZJP5s9YmhE3QQsoOHFBUBeLxst0G2
        L2A+iGrJB4/0bPeyGC1tgszv0zpy2hfB8kmPqPKvQRCAy+gXv+jPcdoopqZDTku/xGPWly
        aUk1A4nB4dEcgljhhINWUFuevNxtfMo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-MHIv18gZP_GpxOaJaOw2YQ-1; Wed, 13 Jan 2021 18:54:31 -0500
X-MC-Unique: MHIv18gZP_GpxOaJaOw2YQ-1
Received: by mail-qt1-f200.google.com with SMTP id m27so2855422qtu.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=as2BhiOSeOwWsZSJ+wtoAod/cmhjluP6SS6qqPvRZnI=;
        b=HbLt601hmacaRe5fSju9lW+6QQZgVqvAYC5IOc5FltzVD+PihBGrtGfw+fR5yoWYai
         5EAorzzrH/gk/ieqV1GKguFVgFyo72Kk1BdgYNQcos3P4F1f9zTtBH/Oerc3b+n7hJ0r
         AGVGohYUQFDAqtPYphujbuI/O9C/4b6lCfW3sjWtrtIISa11Itrz2d33AW+CSLqqxBlz
         02gHSVVZivUoNJI9uZqTNNL8YdPsjJny78gMLceLlRdr+/qC5VCfXdQM+y6uTA66dxmI
         4HRE+7nQAzoOQfzudBwNbIq3IsMFHFulMJ0drQ6UVNTCF6XVZQTkJcnGt313z9tptcJD
         hq5w==
X-Gm-Message-State: AOAM533bop/1cILbPAuVNcvCUVS/HhW5SMXafcneOrbVXEwEQ8sOOjF/
        jIMyd/O1ULVBzvl7mTvAFwMFqiz06aEV+QWibxvMR/Cf/KZ0l4o2n/GOnFQJ8B/peF6Vywsqh8/
        Ie14qW0gOGzMhhq1wf3e2AhX3
X-Received: by 2002:a37:b204:: with SMTP id b4mr4701172qkf.72.1610582071105;
        Wed, 13 Jan 2021 15:54:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytKwDhITLQvIK8QF46ZjPSVdeXrmY+46mPyggYJhNjqJxY8IyLkHbA+V6oPIxuS4pYNAZdAA==
X-Received: by 2002:a37:b204:: with SMTP id b4mr4701140qkf.72.1610582070730;
        Wed, 13 Jan 2021 15:54:30 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id o5sm1990921qti.47.2021.01.13.15.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 15:54:29 -0800 (PST)
Date:   Wed, 13 Jan 2021 18:54:27 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210113235427.GF588752@xz-x1>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 11:30:57AM -0800, Linus Torvalds wrote:
> So if you start off with the rule that "I will always COW unless I can
> trivially see I'm the only owner", then I think we have really made
> for a really clear and unambiguous rule.

I must confess that's the major reason that when I saw the COW simplification
patch I felt it great.  Not only because it's an easier way to understand all
these, but also that it helped unbreak uffd-wp at that moment by dropping the
patch of "COW for read gups" instead of introducing more things to fix stuff,
like the FOLL_BREAK_COW idea [1].

But it's a pity that only until now, after I read all the threads... I found we
might start to lose things for the beautifulness the COW patch brought.

It turns out the simplicity is just not for free; there is always a cost.  The
complexity around GUP always existed probably because GUP is hard itself! It's
just a matter of where the complexity resides: either in the do_wp_page(), or
in the rest of the codes in some other ways, e.g., a complicated version of
page_trans_huge_map_swapcount().

For example, in the future we'll have no way to wr-protect any pinned pages, no
matter for soft-dirty or uffd-wp or else: it'll be illegal by definition!
While it's not extremely easy to get the reasoning from instinct of human being
I'd say...  "DMA pinned pages could be written after all by device", that's
true, but how about read DMA pins?  Oh read DMA pin does not exist because if
we try read DMA pin it broke... but is that a strong enough reason?

We probably want to fix mprotect() too with pinned pages, because even if
mprotect(READ) is fine then in mprotect(READ|WRITE) we'll need to make sure the
write bit being solid if the page is pinned (because now we'll assume all
pinned pages should always be with the write bit set in ptes), or another
alternative could be we'll just fail some mprotect() upon pinned pages.

Limitations just start to pile up, it seems to me..

We also unveiled the vmsplice issue with thp, because for now on COW we don't
have symmetric behavior for small/huge pages any more: for small pages, we'll
do page_count() check to make that copy decision; while we're still with
page_mapcount() for thps.  Do we finally need to convert do_huge_pmd_wp_page()
to also use the same logic as the small pages?  The risk in front is not clear
to me, though.

GUP(write=0) will be extremely special from now on, simply because read won't
trigger COW... I must confess, from instinction, GUP(write=0) should simply
mean that "I want to get this page, but for reading".  Then I realized it's not
extremelyl obvious to me why it should be treated totally differently against a
write GUP on this matter.

Due to my lack on memory management experience, I just started to notice that a
huge amount of work that previously done hard on maintaining page_mapcount()
simply just to make sure GUP pages keep its meaning by instinction, which is:
when we GUP a page, it'll be always coherent with the page we've got in the
process page table.  Now that instinct will go away too, because the GUPed page
now could be some different page rather than the one that sits in the pgtable.

Then I remembered something very nice about the COW simplification change: As
the test case reported [2], there is a huge boost with 31.4% after COW
simplification.  Today I went back and try to understand why, because I
suddenly found I cannot fully understand it - I thought it was majorly because
of the page lock, but maybe not, since the page lock is actually a fine granule
lock in this test that covers 1G mem.

The test was carried out on a host with 192G mem + 104 cores, what it did was
simply:

  ./usemem --runtime 300 -n 104 --prealloc --prefault 959297984

./usemem is the memory workload that does memory accesses, it fork()s into 104
processes with a shared 1G mem region for those accesses so after it's all done
it could use up to 104G pages after all the COWs.  When it runs, COW happens
very frequently across merely all the cores, triggering the do_wp_page() path.

However 104 processes won't easily collapse on the same 4K page at the same
time which shares the lock.  I just noticed maybe it's simply the overhead of
reuse_swap_page().

But how heavy would reuse_swap_page() be?  It'll be heavier if THP is the case
because page_trans_huge_map_swapcount() has a complicated loop for those small
pages, then I found that indeed the test was carried out with THP enabled and
also by default on:

        CONFIG_TRANSPARENT_HUGEPAGE=y
        CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y

IIUC that'll make reuse_swap_page() very heavy, I think.  Because initially the
100+ processes share some THPs, first writes on the THPs will split the THPs,
then reuse_swap_page() will always go the slowest path on looping over each
small pages for each small page writes of COW.

So that 31.4% number got "shrinked" a bit after I noticed all these - this is
already a specific test which merely do COW only but nothing else.  It'll be
hard to tell how many performance gain we can get by this simplification of COW
on other real-life workloads.  Not to mention that removing the
reuse_swap_page() seems to also delayed swap recycle (which is something we'll
need to do sooner or later; so if COW got fast something else got slower,
e.g. the page reclaim logic) and I noticed Ying tried to partly recover it [3].
It's not clear to me where it's the best place to do the recycle, but that
sounds like a different problem.

The major two benefits to me with the current COW simplification are simplicity
of logic and performance gains. But they start to fade away with above.  Not
really that much, but big enough to let me start questioning myself on whether
it's the best approach from pure technical pov...

Then I do also notice that actually the other path of FOLL_BREAK_COW [1] might
be able to fix all of above frustrations like mentioned by others.  It's still
complicated, I really don't like that part.  But again, it just seems to be the
matter of where the complexity would be, there's just no way to avoid those
complexity.  The thing that I'm afraid is that the complexity is by nature and
we can't change it.  I'm also afraid that if we go the current way it'll be
even more complicated at last.  So it seems wise to think more about the
direction since we're at a cross road before starting to fix all the todos
e.g. soft-dirty and mprotect against pinned pages, and all the rest of things
we'd need to fix with current COW page reuse with current solution.

I felt extremely sorry to have dumped my brain somehow, especially considering
above could be completely garbage so I wasted time for a lot of people reading
it or simply scanning it over...  However I expressed it just in case it could
help in some form.

Thanks,

[1] https://lore.kernel.org/lkml/20200811183950.10603-1-peterx@redhat.com/
[2] https://lore.kernel.org/lkml/20200914024321.GG26874@shao2-debian/
[3] https://lore.kernel.org/lkml/20210113024241.179113-1-ying.huang@intel.com/

-- 
Peter Xu

