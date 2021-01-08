Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E612EFB54
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhAHWpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAHWpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610145851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=89HwDezA+M4N11QTEFsVd3k9gUQ4DWKtZO/i4KGp7Pk=;
        b=MEzPi7CKwFDtmwjKf2Tl+vo2b4l/Ya+hdh4c1maIaqeNeCK+PQMtQXdd8Q+0VfZbgQhMX5
        aJ41WOelkncuEhjecjRsGfBbOV1k4NiJF5e80IG3kDDV8dwULxK8kQ4NKzci59I3ySLoFf
        lkNqSy6DZt5EX/WNi5pXraDeWVofQSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-DHvsVsxDP_WCIijkwSxC4Q-1; Fri, 08 Jan 2021 17:44:08 -0500
X-MC-Unique: DHvsVsxDP_WCIijkwSxC4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80EA4107ACE3;
        Fri,  8 Jan 2021 22:44:05 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E2B960BF3;
        Fri,  8 Jan 2021 22:43:57 +0000 (UTC)
Date:   Fri, 8 Jan 2021 17:43:56 -0500
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
Message-ID: <X/jgLGPgPb+Xms1t@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
 <20210108181945.GF504133@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108181945.GF504133@ziepe.ca>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 02:19:45PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 08, 2021 at 12:00:36PM -0500, Andrea Arcangeli wrote:
> > > The majority cannot be converted to notifiers because they are DMA
> > > based. Every one of those is an ABI for something, and does not expect
> > > extra privilege to function. It would be a major breaking change to
> > > have pin_user_pages require some cap.
> > 
> > ... what makes them safe is to be transient GUP pin and not long
> > term.
> > 
> > Please note the "long term" in the underlined line.
> 
> Many of them are long term, though only 50 or so have been marked
> specifically with FOLL_LONGTERM. I don't see how we can make such a
> major ABI break.

io_uring is one of those indeed and I already flagged it.

This isn't a black and white issue, kernel memory is also pinned but
it's not in movable pageblocks... How do you tell the VM in GUP to
migrate memory to a non movable pageblock before pinning it? Because
that's what it should do to create less breakage.

For example iommu obviously need to be privileged, if your argument
that it's enough to use the right API to take long term pins
unconstrained, that's not the case. Pins are pins and prevent moving
or freeing the memory, their effect is the same and again worse than
mlock on many levels.

(then I know on preempt-rt should behave like a pin, and that's fine,
you disable all features for such purpose there)

io_uring is fine in comparison to vmpslice but still not perfect,
because it does the RLIMIT_MEMLOCK accounting but unfortunately, is
tangibly unreliable since a pin can cost 2m or 1G (now 1G is basically
privileged so it doesn't hurt to get the accounting wrong in such
case, but it's still technically mixing counting apples as oranges).

Maybe io_uring could keep not doing mmu notifier, I'd need more
investigation to be sure, but what's the point of keeping it
VM-breaking when it doesn't need to? Is io_uring required to setup the
ring at high frequency?

> Looking at it, vmsplice() is simply wrong. A long term page pin must
> use pin_user_pages(), and either FOLL_LONGTERM|FOLL_WRITE (write mode)
> FOLL_LONGTERM|FOLL_FORCE|FOLL_WRITE (read mode)
> 
> ie it must COW and it must reject cases that are not longterm safe,
> like DAX and CMA and so on.
>
> These are the well established rules, vmsplice does not get a pass

Where are the established rules written down? pin_user_pages.rst
doesn't even make a mention of FOLL_FORCE or FOLL_WRITE at all, mm.h
same thing.

In any case, the extra flags required in FOLL_LONGTERM should be
implied by FOLL_LONGTERM itself, once it enters the gup code, because
it's not cool having to FOLL_WRITE in all drivers for a GUP(write=0),
let alone having to specify FOLL_FORCE for just a read. But this is
going offtopic.

> simply because it is using the CPU to memory copy as its "DMA".

vmsplice can't find all put_pages that may release the pages when the
pipe is read, or it'd be at least be able to do the unreliable
RLIMIT_MEMLOCK accounting.

I'm glad we agree vmsplice is unsafe. The PR for the seccomp filter is
open so if you don't mind, I'll link your review as confirmation.

> > speaking in practice. io_uring has similar concern but it can use mmu
> > notifier, so it can totally fix it and be 100% safe from this.
> 
> IIRC io_uring does use FOLL_LONGTERM and FOLL_WRITE..

Right it's one of those 50. FOLL_WRITE won't magically allow the
memory to be swapped or migrated.

To make another example a single unprivileged pin on the movable zone,
can break memhotunplug unless you use the mmu notifier. Every other
advanced feature falls apart.

So again, if an unprivileged syscalls allows a very limited number of
pages, maybe it checks also if it got a THP or a gigapage page from
the pin, it sets its own limit, maybe again it's not a big
concern.

vmsplice currently with zero privilege allows this:

 2  0 1074432 9589344  13548 1321860    4    0     4   172 2052 9997  5  2 93  0  0
-> vmsplice reproducer started here
 1  0 1074432 8538184  13548 1325820    0    0     0     0 1973 8838  4  3 93  0  0
 1  0 1074432 8538436  13548 1325524    0    0     0     0 1730 8168  4  2 94  0  0
 1  0 1074432 8539096  13556 1321880    0    0     0    72 1811 8640  3  2 95  0  0
 0  0 1074432 8539348  13564 1322028    0    0     0    36 1936 8684  4  2 95  0  0
-> vmsplice killed here
 1  0 1074432 9586720  13564 1322248    0    0     0     0 1893 8514  4  2 94  0  0
  
That's ~1G that goes away for each task and I didn't even check if
it's all THP pages getting in there, the rss is 3MB despite 1G is
taken down in GUP pins with zero privilege:

 1512 pts/25   S      0:00      0     0 133147 3044  0.0 ./vmsplice

Again memcg is robust so it's not a concern for the host, the attack
remains contained in the per-memcg OOM killer. It'd only reach the
host OOM killer logic if the host itself does the accounting wrong and
runs out of memory which can be enforced it won't happen.

> > The scheduler disclosure date was 2020-08-25 so I can freely explain
> > the case that motivated all these changes.
> > 
> > case A)
> > 
> > if !fork() {
> >    // in child
> >    mmap one page
> >    vmsplice takes gup pin long term on such page
> >    munmap one page
> >    // mapcount == 1 (parent mm)
> >    // page_count == 2 (gup in child, and parent mm)
> > } else {
> >    parent writes to the page
> >    // mapcount == 1, wp_page_reuse
> > }
> > 
> > parent did a COW with mapcount == 1 so the parent will take over a
> > page that is still GUP pinned in the child. 
> 
> Sorry, I missed something, how does mmaping a fresh new page in the
> child impact the parent?

Apologies... of course the "mmap" line had to be moved before fork.

> I guess the issue is not to mmap but to GUP a shared page in a way
> that doesn't trigger COW during GUP and then munmap that page so a
> future parent COW does re-use, leaking access.

Right. Jann reported the writes of the parent are readable then by
reading the pipe 1 year later.

> It seems enforcing FOLL_WRITE to always COW on GUP closes this, right?

Exactly, it was supposed to do that. And I don't mean in the caller
with FOLL_WRITE/write=1 explicitly set in vmsplice, I mean with
17839856fd588f4ab6b789f482ed3ffd7c403e1f which looked great to me as a
solution for it.

> This is what all correct FOLL_LONGTERM users do today, it is required
> for many other reasons beyond this interesting security issue.

Exactly. Except this also applies to O_DIRECT not just FOLL_LONGTERM,
in theory. And only in theory.

Any transient GUP pin no matter which fancy API you use to take it, is
enough to open the window for the above attack, not just FOLL_LONGERM.

However only unprivileged long term GUP pins can make this race
reproducible.

So this has to be fixed in the GUP core too, as it was supposed to be
fixed for a while reliably (and it's not fixed anymore on current
upstream if taking the GUP pin on a THP).

For those with the reproducer for the bug fixed in
17839856fd588f4ab6b789f482ed3ffd7c403e1f here's the patch to apply to
reproduce it once on v5.11 once again:

--- vmsplice.c	2020-05-28 03:03:26.760303487 -0400
+++ vmsplice-v5.11.c	2021-01-08 17:28:37.028747370 -0500
@@ -24 +24 @@
-  struct iovec iov = {.iov_base = data, .iov_len = 0x1000 };
+  struct iovec iov = {.iov_base = data, .iov_len = 2*1024*1024 };
@@ -26 +26 @@
-  SYSCHK(munmap(data, 0x1000));
+  SYSCHK(munmap(data, 2*1024*1024));
@@ -28,2 +28,2 @@
-  char buf[0x1000];
-  SYSCHK(read(pipe_fds[0], buf, 0x1000));
+  char buf[2*1024*1024];
+  SYSCHK(read(pipe_fds[0], buf, 2*1024*1024));
@@ -34 +34 @@
-  if (posix_memalign(&data, 0x1000, 0x1000))
+  if (posix_memalign(&data, 2*1024*1024, 2*1024*1024))
@@ -35,0 +36,2 @@
+  if (madvise(data, 2*1024*1024, MADV_HUGEPAGE))
+    errx(1, "madvise()");

$ /tmp/x
read string from child: THIS IS SECRET

I exploited it just to be sure I didn't miss something in the source
review of the THP code.

So I hope after all this discussion I could at least provide 1 single
useful information, if nothing else.

> > However, you know full well in the second case it is a feature and not
> > a bug, that wp_page_reuse is called instead, and in fact it has to be
> > called or it's a bug (and that's the bug page_count in do_wp_page
> > introduces).
> 
> What I was trying to explain below, is I think we agreed that a page
> under active FOLL_LONGTERM pin *can not* be write protected.
> 
> Establishing the FOLL_LONGTERM pin (for read or write) must *always*
> break the write protection and the VM *cannot* later establish a new
> write protection on that page while the pin is active.
> 
> Indeed, it is complete nonsense to try and write protect a page that
> has active DMA write activity! Changing the CPU page protection bits
> will not stop any DMA! Doing so will inevitably become a security
> problem with an attack similar to what you described.
> 
> So this is what was done during fork() - fork will no longer write
> protect pages under FOLL_LONGTERM to make them COWable, instead it
> will copy them at fork time.
> 
> Any other place doing write protect must also follow these same
> rules.
> 
> I wasn't aware this could be used to create a security problem, but it
> does make sense. write protect really must mean writes to the memory
> must stop and that is fundementally incompatible with active DMA.
> 
> Thus write protect of pages under DMA must be forbidden, as a matter
> of security.

You're thinking at your use case only.

Thinking long term GUP pin is read-write DMA is very reductive.

There doesn't need to be DMA at all.

KVM and a shadow MMU can attach to the RAM in readonly totally
fine. And if it writes, it'll write not through the PCI bus, still
with the CPU access.

In fact Peter did an awesome work by writing the dirty ring for the
KVM shadow MMU and some vmx also provides a page modification logging
on some CPUs. So we have already all the dirty tracking that protects
the shadow pagetable:

https://kvmforum2020.sched.com/event/eE4R/kvm-dirty-ring-a-new-approach-to-logging-peter-xu-red-hat

So it's completely normal that you could plug that with clear_refs and
wrprotecting the linux pagetable while a KVM mapping exists that
absolutely must not go out of sync.

Nothing at all can go wrong, unless wp_copy_page suddenly makes the
secondary MMU go out of sync the moment you wrprotect the page with
clear_refs.

You don't even need readonly access from DMA for the above to make
sense, the above makes perfect sense even with the secondary MMU and
primary MMU all writing at the same time and it must not break.

Overall a design where the only safety of a secondary MMU from going
out of sync comes from the wrprotection not happening looks weak.

Ultimately, what do we really gain from all this breakage?

Where are the do_wp_page benchmarks comparing
09854ba94c6aad7886996bfbee2530b3d8a7f4f4 against
b7333b58f358f38d90d78e00c1ee5dec82df10ad ? Link? Definitely there's no
benchmark in the git log justifying this sudden breakage on so many
levels that even re-opened the old zygote bug as shown above.

Thanks,
Andrea

