Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B752F127E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbhAKMns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAKMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:43:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A78C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BBQOmCJkOwz3g6A4Xgk+pDH19o/4X63N5JIMJHIzi24=; b=sUFkVOASsTCJQEwFd5Kile9b6C
        Yij+FARxJ2qwdfeKCS6mrASDnvwLX5Wt31Ht1smD44R510/PDFzuQ2PC3gkEqWSWalGZsX2qAL8AI
        z/+Ver7KjNHGJPvaJtcdwMI/GXcBZ3hMWskaGnkPjd6T1N89xoNEpgHMr0l+rxQooGFPxcCXUy4rx
        RlJEDLNF+Sr/M2cVv6wNfayUt+ZdROXjC2T3B757FnYXagfqMWvdHor3Z0Tj+XKvJbfGLReaTASl4
        cCUz/ncm4pkuTtTW5/vEpJxIx9wXcMkM5ZmZJxAaXtX/o094ov3n6oVoxasz2HcGfzQAQF6BFwQ+R
        7Wdhat9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kywWa-003DyG-Bb; Mon, 11 Jan 2021 12:42:24 +0000
Date:   Mon, 11 Jan 2021 12:42:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210111124220.GE35215@casper.infradead.org>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 11:26:57PM -0800, John Hubbard wrote:
> IMHO, a lot of the bits in page _refcount are still being wasted (even
> after GUP_PIN_COUNTING_BIAS overloading), because it's unlikely that
> there are many callers of gup/pup per page. If anyone points out that
> that is wrong, then the rest of this falls apart, but...if we were to
> make a rule that "only a very few FOLL_GET or FOLL_PIN pins are ever
> simultaneously allowed on a given page", then several things become
> possible:

There's "the normal case" and then there's "the attacker case" where
someone's deliberately trying to wrap page->_refcount.  There are lots of
interesting games people can play with an anon page, like stuffing it into
(lots of) pipes, forking lots of children, starting lots of O_DIRECT I/O
against it to a FUSE filesystem that's deliberately engineered to be slow.

We have some protection against that, but I'm not 100% sure it's working,
and making it easier to increase refcount in large chunks makes it more
likely that we would defeat that protection.
