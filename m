Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576512F4BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAMM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhAMM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:58:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E5C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8W+YeZCRHcgbsYU4MRilZbbZCOazPjouIMGS7e+DlSg=; b=CXxXBMBwjMrPcvbKXw9qj+Y013
        3o/bKQmMdi6oApNqXGFrPPTLJuq1trU+edOVn2owS4/yYaBB797T7rEibLGPb5wybmpPZZ1bq76Zu
        RaAokAIO1V+kbxfx1oEEs1ivOFpxeVQNGDOFBIZIyk5NR0oHMRyHWKVfxat1BMCnQ4JgCG9hhEO6g
        8FY4iszlgKKnTfp+9wcy5Zo2Ql3r1EUCccwkgfSASvD+WhbeLO/V7q4/h/QJNvYYPyEEqAXEGoOWG
        tBKkvJDFA0R1aWzxsViOBzz795I4OSeR8YhTn7XVQbKTn1/YpTaB57n1FjqrZgTf+6HVRaIUsLmiG
        +siVW3XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzfgS-006GlI-R6; Wed, 13 Jan 2021 12:56:04 +0000
Date:   Wed, 13 Jan 2021 12:55:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210113125532.GN35215@casper.infradead.org>
References: <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
 <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
 <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
 <20210113021619.GL35215@casper.infradead.org>
 <CAHk-=wjWMieNV3nAJgoG5prEHBEcOZiREmLUr499tA9NMttEqQ@mail.gmail.com>
 <20210113123232.62vv6xsrpitne7hc@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113123232.62vv6xsrpitne7hc@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 03:32:32PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jan 12, 2021 at 07:31:07PM -0800, Linus Torvalds wrote:
> > On Tue, Jan 12, 2021 at 6:16 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > The thing about the speculative page cache references is that they can
> > > temporarily bump a refcount on a page which _used_ to be in the page
> > > cache and has now been reallocated as some other kind of page.
> > 
> > Oh, and thinking about this made me think we might actually have a
> > serious bug here, and it has nothing what-so-ever to do with COW, GUP,
> > or even the page count itself.
> > 
> > It's unlikely enough that I think it's mostly theoretical, but tell me
> > I'm wrong.
> > 
> > PLEASE tell me I'm wrong:
> > 
> > CPU1 does page_cache_get_speculative under RCU lock
> > 
> > CPU2 frees and re-uses the page
> > 
> >     CPU1                CPU2
> >     ----                ----
> > 
> >     page = xas_load(&xas);
> >     if (!page_cache_get_speculative(page))
> >             goto repeat;
> >     .. succeeds ..
> > 
> >                         remove page from XA
> >                         release page
> >                         reuse for something else
> 
> How can it be reused if CPU1 hold reference to it?

Yes, Linus mis-stated it:

    page = xas_load(&xas);
                        remove page from XA
                        release page
                        reuse for something else
    if (!page_cache_get_speculative(page))
            goto repeat;
    if (unlikely(page != xas_reload(&xas))) {
            put_page(page);

... but as David pointed out, I fixed this in e320d3012d25
