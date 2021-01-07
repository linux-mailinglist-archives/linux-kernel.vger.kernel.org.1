Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B262EE68D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbhAGUFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:05:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbhAGUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610049856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjBQDyb+UR51GMjYTAgjDh/0rFi95uSEp5zXAxVr1/E=;
        b=RCKtkhm/0dzRRckds0C74WjShqD1ZOF6YkBdiWl11hIUJaTGaIS9qdKoKMswrtsJLRqJVP
        /RvZ61e3Xf0LE57bzUDLJ1D+pT2vUxe8NyuMv7q2pmVxPHDMYKO+jJPliIeY7VEIbBmCtU
        1XGSn2sG0M3oo6GGFEhm+4uiZxoWyzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-7_M4EOxEP3mCL46IYGKPkw-1; Thu, 07 Jan 2021 15:04:14 -0500
X-MC-Unique: 7_M4EOxEP3mCL46IYGKPkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBDFC612B2;
        Thu,  7 Jan 2021 20:04:10 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3DD1803E;
        Thu,  7 Jan 2021 20:04:03 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Date:   Thu,  7 Jan 2021 15:04:00 -0500
Message-Id: <20210107200402.31095-1-aarcange@redhat.com>
In-Reply-To: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I prepared in 2/2 a fix to make UFFDIO_WRITEPROTECT and
clear_refs_write cope with page_count in do_wp_page. It'd stack
perfectly on top of 1/2 from will which fixes an orthogonal regression
and it'd need to be applied first since its Fixes tag comes first.

I hope this patchset shows and my initial my answer in
https://lkml.kernel.org/r/X+PoXCizo392PBX7@redhat.com shows I tried to
keep an open mind and to try to fix what
09854ba94c6aad7886996bfbee2530b3d8a7f4f4 broke. Even in the commit of
2/2 I wrote "is completely correct" despite I had to change my mind
about that.

It turns out the memory corruption caused by the breakage in the TLB
flushing is a walk in the park to fix for clear_refs and
UFFDIO_WRITEPROTECT, that is only the tip of the icerberg.

To simplify, let's forget the mmap_read_lock and let's assume we
hypothetically throw away the mmap_read_lock from the kernel and
UFFDIO_WRITEPROTECT and clear_refs and everything else takes the
mmap_write_lock only.

Even then, clear_refs and UFFDIO_WRITEPROTECT will remain broken if
the memory they're wrprotecting is GUP pinned by a secondary MMU or
RDMA or something, that is reading the memory through a read GUP
pin.

You can only make fork safe from the page_count by COWing any page
that has a GUP pin, because fork is actually allowed to COW (and that
will also fix the longstanding fork vs threads vs GUP race as result,
which I tried already once in
https://lkml.kernel.org/r/20090311165833.GI27823@random.random
). However it's fundamentally flawed and forbidden to COW after
clear_refs and UFFDIO_WRITEPROTECT, if fork or clone have never been
called and there's any GUP pin on the pages that were wrprotected.

In other words, the page_count check in do_wp_page, extends the old
fork vs gup vs threads race, so that it also happens within a single
thread without fork() involvement.

The above scenario is even more explicit and unfixable when it's not
just a single page but something bigger mapped by multiple processes
that was GUP pinned.

Either COWs would have to be forbidden and features clear_refs dropped
from the kernel and mprotect also would be strictly forbidden to ever
leave any pte_write bit clear for any reason, or do_wp_page requires
full accuracy on exclusive pages in MAP_PRIVATE private COWs or
MAP_ANON do_wp_page.

In simple terms: the page_count check in do_wp_page makes it
impossible to wrprotect memory, if such memory is under a !FOLL_WRITE
GUP pin.

It's a feature (not a bug) that the GUP pin must not trigger a COW,
and this is also already explicitly documented in comments in the
current source in places that are still using mapcount, or we'd be
probably dealing with more breakage than what's reproducible right
now.

Can we take a step back and start looking at what started all this VM
breakage? I mean specifically Jann's discovery that parent can attack
the child after the child does drop privs by using vmsplice long term
unprivileged GUP pins?

vmsplice syscall API is insecure allowing long term GUP PINs without
privilege.

Before touching any of the COW code, something had to be done on
vmsplice because even after 09854ba94c6aad7886996bfbee2530b3d8a7f4f4
there's still no way to way to tame the other VM breakage and working
DoS caused by vmsplice. (I already sent the vmsplice DoS PoC exploit
to who of may concern on Aug 27 2020)

zygote before worrying about COWs, needs to block vmsplice in the
child (and io_uring until it's fixed) with seccomp by default until
the syscall become privileged.

I also recommended such change to podman default allowlist, but
apparently it wasn't committed checking below, vmsplice still there in
the allowlist unfortunately. I'll try to suggest it again in a follow
up.

https://github.com/containers/common/blob/master/pkg/seccomp/seccomp.json

io_uring unlike vmsplice can remain unprivileged, but it needs to use
the mmu notifier to make those GUP pins become VM neutral.

After io_uring is fixed with mmu notifier, and vmsplice becomes a
privileged syscall, the concern that remains for the zygote model is
on par with the fact that there is RAM carelessly shared with L1 and
L2 cache also shared between parent and child. It'll take DMA and
burning the flash in order to keep poking for the parent to write at
the wrong time. So the phone would get so hot or the battery would run
out of juice before the attack can expose data from the parent. So for
an attacker it may be easier to look for a side channel with flush and
reload on the shared L2 that doesn't rely on more costly GUP transient
pins.

So the concern that started all this, once vmsplice and io_uring are
both fixes, in my view becomes theoretical.

Especially on enterprise (non-embedded), this issue is not even
theoretical but it's fully irrelevant, since execve has to be used
after drop privs (or the app needs to use MADV_DONTFORK or unshare all
memory if using a jailer that doesn't execve) to avoid the
aforementioned side channel to remain. Only RAM constrained embedded
devices are justified to take shortcuts with the ensuing side channel
security concern that emerges from it.

For all the above reasons, because so far the cure has been worse than
the disease itself, I'd recommend enterprise distro kernels to ignore
the zygote embedded model attack for the time being and not to
backport anything in this regard. What should not be backported,
specifically starts in 17839856fd588f4ab6b789f482ed3ffd7c403e1f.

17839856fd588f4ab6b789f482ed3ffd7c403e1f was supposed to be fine and
not break anything and unfortunately I was too busy while
17839856fd588f4ab6b789f482ed3ffd7c403e1f morphed into
09854ba94c6aad7886996bfbee2530b3d8a7f4f4, so I still miss a whole huge
discussion in that transition. I don't know what was fundamentally
flawed in 17839856fd588f4ab6b789f482ed3ffd7c403e1f yet.

All I comment about here is purely the current end result:
09854ba94c6aad7886996bfbee2530b3d8a7f4f4 not any of the intermediate
steps that brought us there.

I already mentioned the page_count wasn't workable in do_wp_page in
Message-ID: <20200527212005.GC31990@redhat.com> on May 27 2020, quote:

"I don't see how we can check the page_count to decide if to COW or not
in the wrprotect fault, given [..] introduced in >="

Then Hugh said he wasn't happy about on 1 Sep 2020 in Message-ID:
<alpine.LSU.2.11.2008312207450.1212@eggly.anvils>.

In https://lkml.kernel.org/r/X+O49HrcK1fBDk0Q@redhat.com I suggested
"I hope we can find a way put the page_mapcount back where there" and
now I have to double down and suggest that the page_count is
fundamentally unsafe in do_wp_page.

I see how the page_count would also fix the specific zygote
child->parent attack and I kept an open mind hoping it would just
solve all problems magically. So I tried to fix even clear_refs to
cope with it, but this is only the tip of the icerbeg of what really
breaks.

So in short I contextually self-NAK 2/2 of this patchset and we need
to somehow reverse 09854ba94c6aad7886996bfbee2530b3d8a7f4f4 instead.

Thanks,
Andrea

Andrea Arcangeli (1):
  mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending

Will Deacon (1):
  mm: proc: Invalidate TLB after clearing soft-dirty page state

 fs/proc/task_mmu.c       | 26 ++++++++++++---
 include/linux/mm.h       | 46 +++++++++++++++++++++++++++
 include/linux/mm_types.h |  5 +++
 kernel/fork.c            |  1 +
 mm/memory.c              | 69 ++++++++++++++++++++++++++++++++++++++++
 mm/mprotect.c            |  4 +++
 6 files changed, 146 insertions(+), 5 deletions(-)

