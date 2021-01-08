Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A082EF62B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbhAHRCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbhAHRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610125245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOcUbpmkvyodnmbcbjn2yw2sSgOpt1bcxQuxu+L9fIw=;
        b=ElsrKb403M8bknkxoSIp9aDD24+y0F1yEcSFpfUk3raa+KxPMEwH8xDUtnaEKNH8tw9FZb
        ZjqEQpZwDAEuYSNpyinovCNLJbob2ORaPAzBJNGERL4y/tQ/czd/8JCm3w23wN+rhyiHM0
        h+EuWCmJrktG4spco5AWOVbBtWcrXSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-7rpUw-0pMH-JMhdGeDQ4eA-1; Fri, 08 Jan 2021 12:00:41 -0500
X-MC-Unique: 7rpUw-0pMH-JMhdGeDQ4eA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884BD100B38E;
        Fri,  8 Jan 2021 17:00:37 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE0955D9E4;
        Fri,  8 Jan 2021 17:00:36 +0000 (UTC)
Date:   Fri, 8 Jan 2021 12:00:36 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <X/iPtCktcQHwuK5T@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108133649.GE504133@ziepe.ca>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:36:49AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 07, 2021 at 04:45:33PM -0500, Andrea Arcangeli wrote:
> > On Thu, Jan 07, 2021 at 04:25:25PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Jan 07, 2021 at 03:04:00PM -0500, Andrea Arcangeli wrote:
> > > 
> > > > vmsplice syscall API is insecure allowing long term GUP PINs without
                                                  ^^^^^^^^^
> > > > privilege.
> > > 
> > > Lots of places are relying on pin_user_pages long term pins of memory,
> > > and cannot be converted to notifiers.
> > > 
> > > I don't think it is reasonable to just declare that insecure and
> > > requires privileges, it is a huge ABI break.
> > 
> > Where's that ABI? Are there specs or a code example in kernel besides
> > vmsplice itself?
> 
> If I understand you right, you are trying to say that the 193
> pin_user_pages() callers cannot exist as unpriv any more?

193, 1k 1m or their number in general, won't just make them safe...

> The majority cannot be converted to notifiers because they are DMA
> based. Every one of those is an ABI for something, and does not expect
> extra privilege to function. It would be a major breaking change to
> have pin_user_pages require some cap.

... what makes them safe is to be transient GUP pin and not long
term.

Please note the "long term" in the underlined line.

O_DIRECT is perfectly ok to be unprivileged obviously. The VM can
wait, eventually it goes away.

Even a swapout is not an instant event and can be hold off by any
number of other things besides a transient GUP pin. It can be hold off
by PG_lock just to make an example.

mlock however is long term, persistent, vmsplice takes persistent and
can pin way too much memory for each mm, that doesn't feel safe. The
more places doing stuff like that, the more likely one causes
a safety issue, not the other way around it in fact.

> > The whole zygote issue wouldn't even register if the child had the
> > exact same credentials of the parent. Problem is the child dropped
> > privileges and went with a luser id, that clearly cannot ptrace the
> > parent, and so if long term unprivileged GUP pins are gone from the
> > equation, what remains that the child can do is purely theoretical
> > even before commit 17839856fd588f4ab6b789f482ed3ffd7c403e1f.
> 
> Sorry, I'm not sure I've found a good explanation how ptrace and GUP
> are interacting to become a security problem.

ptrace is not involved. What I meant by mentioning ptrace, is that if
the child can ptrace the parent, then it doesn't matter if it can also
do the below, so the security concern is zero in such case.

With O_DIRECT or any transient pin you will never munmap while
O_DIRECT is in flight, if you munmap it's undefined what happens in
such case anyway.

It is a theoretical security issue made practical by vmsplice API that
allows to enlarge the window to years of time (not guaranteed
milliseconds), to wait for the parent to trigger the
wp_page_reuse. Remove vmsplice and the security issue in theory
remains, but removed vmsplice it becomes irrelevant statistically
speaking in practice. io_uring has similar concern but it can use mmu
notifier, so it can totally fix it and be 100% safe from this.

The scheduler disclosure date was 2020-08-25 so I can freely explain
the case that motivated all these changes.

case A)

if !fork() {
   // in child
   mmap one page
   vmsplice takes gup pin long term on such page
   munmap one page
   // mapcount == 1 (parent mm)
   // page_count == 2 (gup in child, and parent mm)
} else {
   parent writes to the page
   // mapcount == 1, wp_page_reuse
}

parent did a COW with mapcount == 1 so the parent will take over a
page that is still GUP pinned in the child. That's the security issue
because in this case the GUP pin is malicious.

Now imagine this case B)

   mmap one page
   RDMA or any secondary MMU takes a long term GUP pin
   munmap one page
   // mapcount == 1 (parent mm)
   // page_count == 2 (gup in RDMA, and parent mm)

How does the VM can tell between the two different cases? It can't.

The current page_count in do_wp_page treats both cases the same and
because page_count is 2 in both cases, it calls wp_page_copy in both
cases breaking-COW in both cases.

However, you know full well in the second case it is a feature and not
a bug, that wp_page_reuse is called instead, and in fact it has to be
called or it's a bug (and that's the bug page_count in do_wp_page
introduces).

So page_count in do_wp_page is breaking all valid users, to take care
of the purely theoretical security issue that isn't a practical concern
if only vmsplice is secured at least as good as mlock.

page_count in do_wp_page is fundamentally flawed for all long term GUP
pin done by secondary MMUs attached to the memory.

The fix in 17839856fd588f4ab6b789f482ed3ffd7c403e1f had to work by
triggering a GUP(write=1), that would break-COW while vmsplice runs,
in turn fully resolving the security concern, but without breaking
your very important case B.

> 17839 makes sense to me, and read-only GUP has been avoided by places
> like RDMA and others for a very long time because of these issues,
> adding the same idea to the core code looks OK.

Yes I acked 17839856fd588f4ab6b789f482ed3ffd7c403e1f since it looked
the cleanest solution to take care of the purely theoretical security
issue (purely theoretical after vmsplice is taken care of).

I planned today to look what didn't work exactly in
17839856fd588f4ab6b789f482ed3ffd7c403e1f that may have required to
move to 09854ba94c6aad7886996bfbee2530b3d8a7f4f4, it was an huge email
thread and I was too busy with urgent work at the time.

> The semantics we discussed during the COW on fork thread for pin user
> pages were, more or less, that once pinned a page should not be
> silently removed from the mm it is currently in by COW or otherwise in
> the kernel.

I don't get what you mean here. Could you elaborate?

> So maybe ptrace should not be COW'ing pinned pages at all, as that is
> exactly the same kind of silent corruption fork was causing.

ptrace isn't involved, details above.

Could you elaborate also if fork started corrupting with
17839856fd588f4ab6b789f482ed3ffd7c403e1f applied? In which commit
exactly the corruption started.

In general fork(), unless you copy all GUP pinned pages and you don't
wrprotect them in fork(), must be handled by blocking all writes on
the RDMA region in the parent, then you fork, only after child did the
exec you're allowed to unblock the writes in the parent that holds the
GUP long term pins.

I don't see a notable difference from page_count or mapcount in
do_wp_page in this respect: only copying in fork() if the page is
pinned like I was also proposed here
https://lkml.kernel.org/r/20090311165833.GI27823@random.random will
also prevent having to block the writes until exec is run though. FWIW
I obviously agree in copying in fork any pinned page, but that was
supposed to be an orthogonal improvement and it wasn't supposed to fix
a recent regression (the fork vs thread vs gup race always existed,
and the need of stopping writes in between fork and exec also).

Thanks,
Andrea

