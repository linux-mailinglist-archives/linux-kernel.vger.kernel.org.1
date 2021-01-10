Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2932F04DF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 04:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAJD0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 22:26:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbhAJD0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 22:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610249107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+8EcBqhJXYrraKAb9xX5znLleqitaHZlI2nnyEeNlE=;
        b=Hp+UFFPLBk059CZiqujqX8wpIT3CmDia5hNV0x75vBfaQn96LIXyh9V3udM3nHxyN17OZI
        fnkwpA/vDi9678oZ+u+bMDwx1PnWevnGlsQT4GrWXrHM5RbkxvNsSiB2DITZF/IrlNVE6e
        cqiFA23Yab04wHxsBhLmE+7zQ0Co7jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-X3KvbQBtNUule9ZWTCgMXw-1; Sat, 09 Jan 2021 22:25:04 -0500
X-MC-Unique: X3KvbQBtNUule9ZWTCgMXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08B3800D25;
        Sun, 10 Jan 2021 03:25:00 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A533E19D9B;
        Sun, 10 Jan 2021 03:24:53 +0000 (UTC)
Date:   Sat, 9 Jan 2021 22:24:52 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <X/pzhKj2m48brSdN@redhat.com>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <CAHk-=wg3zWaXaKN1N=qTWiuLFvEz3e_d5oZSgOEfbSOrXJvVtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3zWaXaKN1N=qTWiuLFvEz3e_d5oZSgOEfbSOrXJvVtQ@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 05:37:09PM -0800, Linus Torvalds wrote:
> On Sat, Jan 9, 2021 at 5:19 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And no, I didn't make the UFFDIO_WRITEPROTECT code take the mmap_sem
> > for writing. For whoever wants to look at that, it's
> > mwriteprotect_range() in mm/userfaultfd.c and the fix is literally to
> > turn the read-lock (and unlock) into a write-lock (and unlock).
> 
> Oh, and if it wasn't obvious, we'll have to debate what to do with
> trying to mprotect() a pinned page. Do we just ignore the pinned page
> (the way my clear_refs patch did)? Or do we turn it into -EBUSY? Or
> what?

Agreed, I assume mprotect would have the same effect.

mprotect in parallel of a read or recvmgs may be undefined, so I
didn't bring it up, but it was pretty clear.

The moment the write bit is cleared (no matter why and from who) and
the PG lock relased, if there's any GUP pin, GUP currently loses
synchrony.

In any case I intended to help exercising the new page_count logic
with the testcase, possibly to make it behave better somehow, no
matter how.

I admit I'm also wondering myself the exact semantics of O_DIRECT on
clear_refs or uffd-wp tracking, but the point is that losing reads and
getting unexpected data in the page, still doesn't look a good
behavior and it had to be at least checked.

To me ultimately the useful use case that is become impossible with
page_count isn't even clear_refs nor uffd-wp.

The useful case that I can see zero fundamental flaws in it, is a RDMA
or some other device computing in pure readonly DMA on the data while
a program runs normally and produces it. It could be even a
framebuffer that doesn't care about coherency. You may want to
occasionally wrprotect the memory under readonly long term GUP pin for
consistency even against bugs of the program itself. Why should
wrprotecting make the device lose synchrony? And kind of performance
we gain to the normal useful cases by breaking the special case? Is
there a benchmark showing it?

> So it's not *just* the locking that needs to be fixed. But just take a
> look at that suggested clear_refs patch of mine - it sure isn't
> complicated.

If we can skip the wrprotection it's fairly easy, I fully agree, even
then it still looks more difficult than using page_mapcount in
do_wp_page in my view, so I also don't see the simplification. And
overall the amount of kernel code had a net increase as result.

Thanks,
Andrea

