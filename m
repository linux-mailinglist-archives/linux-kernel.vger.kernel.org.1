Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30C2F0333
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhAITeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbhAITeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:34:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB5C06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 11:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YK9bkc+ab6pT/dipKIxzM3oihklVajwXC+Iom3U0oGs=; b=uyerOwE4pe4/DqfSn97jIDMNkL
        fZIJky2MAsJVSJPzryAX9aGy5NNgNIihELIDVZ9L58TEekvFu2lUtTE2DO+9jRqbdcFVf1U5YlFf8
        p0tRUMxkrjuVXsUMw/WE1W6XRHJ0oOrSlrUdrgTjewQTqvRsh0I0vAjG23bAQW8bUG/UyNunYnSAd
        AMoKhEmulCwKEaa3YmoLlxPKqoHRouUtrwmnTRnwgYOgYjqo0KQyr1BsS0drCTw1WiM2J7RXurioP
        X3Lmrh82C4NPGUrcX04fi90CPdd73I0MU29zzMNr0bh6xaXtIaJ069gvLfdwmNZB9RNbkSF21rITd
        mvtSiP4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kyJyK-000qhE-Pd; Sat, 09 Jan 2021 19:32:42 +0000
Date:   Sat, 9 Jan 2021 19:32:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20210109193224.GB35215@casper.infradead.org>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
 <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:05:19PM -0800, Linus Torvalds wrote:
> Side note, and not really related to UFFD, but the mmap_sem in
> general: I was at one point actually hoping that we could make the
> mmap_sem a spinlock, or at least make the rule be that we never do any
> IO under it. At which point a write lock hopefully really shouldn't be
> such a huge deal.

There's a (small) group of us working towards that.  It has some
prerequisites, but where we're hoping to go currently:

 - Replace the vma rbtree with a b-tree protected with a spinlock
 - Page faults walk the b-tree under RCU, like peterz/laurent's SPF patchset
 - If we need to do I/O, take a refcount on the VMA

After that, we can gradually move things out from mmap_sem protection
to just the vma tree spinlock, or whatever makes sense for them.  In a
very real way the mmap_sem is the MM layer's BKL.
