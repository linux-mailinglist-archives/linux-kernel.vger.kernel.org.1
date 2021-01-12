Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6942F36A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392610AbhALRI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391783AbhALRI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D26E2311F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610471266;
        bh=cvSSa71LyJluu9Pmxtib+8PkanVmQCGP38gGA91zZLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aiX6W+2hh9vDBoB5yv2VVNmnSpj5y6boU05JLBlRKrkF6ssO1umskBbq9qpjMFke7
         DfaIo30hZbYD26zXLgy0bUfbG7lGPEhk/WKRlS7KnJ/WY8cXIiOHa8UvajWoVj1lJ/
         b/ZibR6VJzQ7PgQfiTRZs2C9vHeXYEKiSnEVGfoOdJHfjLVaXxeWScOZB78JkKE7YF
         /TYMBS6N+gUlsmY5LW/jZq7grlkjntd0SeaTJd0vpJ3d9M3GuZa1NR3IFkhg6W5F/J
         tyQpOIL1gfwdQIRnbA6Uq3+sqDvYc+3BIb34M/dOQ2JHItgbGGAE4zVNqUROb1Fi4j
         xI1wJKljfY3VQ==
Received: by mail-ed1-f44.google.com with SMTP id i24so3125138edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:07:46 -0800 (PST)
X-Gm-Message-State: AOAM532tXuKbdKZJzQAaasE4PYNuzBd9iMkT8wzK+CgWSqezBgKH7x+5
        tRw6fTYRr7Dsg0uRgL5lwO+6gG0fNWTwUdVrs+6/Yw==
X-Google-Smtp-Source: ABdhPJzR3berhPHmwdu4k3CI9o5QDPNM8DlEFu4t/iWEZD4mSxM9oS5q3rpkf6x6Hf+3Dgdkqu5GN94T109tKPuYAW0=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr91352edr.97.1610471265004;
 Tue, 12 Jan 2021 09:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com> <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com> <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
 <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
In-Reply-To: <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jan 2021 09:07:31 -0800
X-Gmail-Original-Message-ID: <CALCETrWEAOj28Y6SaBVuxahuRmk9exp1fqcJO0ibGKbFw4HQ4A@mail.gmail.com>
Message-ID: <CALCETrWEAOj28Y6SaBVuxahuRmk9exp1fqcJO0ibGKbFw4HQ4A@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jan 11, 2021 at 11:19 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:

> Actually, what I think might be a better model is to actually
> strengthen the rules even more, and get rid of GUP_PIN_COUNTING_BIAS
> entirely.
>
> What we could do is just make a few clear rules explicit (most of
> which we already basically hold to). Starting from that basic
>
>  (a) Anonymous pages are made writable (ie COW) only when they have a
> page_count() of 1

Seems reasonable to me.

>
> That very simple rule then automatically results in the corollary
>
>  (b) a writable page in a COW mapping always starts out reachable
> _only_ from the page tables

Seems reasonable.  I guess that if the COW is triggered by GUP, then
it starts out reachable only from the page tables but then because
reachable through GUP very soon thereafter.

>
> and now we could have a couple of really simple new rules:
>
>  (c) we never ever make a writable page in a COW mapping read-only
> _unless_ it has a page_count() of 1

I don't love this.  Having mprotect() fail in a multithreaded process
because another thread happens to be doing a short-lived IO seems like
it may result in annoying intermittent bugs.

As I understand it, the issue is that the way we determine that we
need to COW a COWable page is that we see that it's read-only.  It
would be nice if we could separately track "the VMA allows writes" and
"this PTE points to a page that is private to the owning VMA", but
maybe there's no bit available for the latter other than looking at RO
vs RW directly.

>
>  (d) we never create a swap cache page out of a writable COW mapping page
>
> Now, if you combine these rules, the whole need for the
> GUP_PIN_COUNTING_BIAS basically goes away.
>
> Why? Because we know that the _only_ thing that can elevate the
> refcount of a writable COW page is GUP - we'll just make sure nothing
> else touches it.

How common is !FOLL_WRITE GUP?  We could potentially say that a
short-term !FOLL_WRITE GUP is permitted on an RO COW page and that a
subsequent COW on the page will wait for the GUP to go away.  This
might be too big a can of worms for the benefit it would provide,
though.

--Andy
