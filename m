Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC432EE753
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbhAGVAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:00:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbhAGVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610053152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SU9fkbj5UxsB6lrJGFLGhzRsIq9fOkWtazZU8CPZUgA=;
        b=NtQeBJglVM8g1H3AI9EOWr47/gpICdf3bgOMPjGYjigJ27u5MsqCVs2jq+Ejhfd32Q9fxo
        ogsfO0ukEwo4WxK5FyrTcnsl5PYxt1LMK343AA9680fjB8A+55TMCBHnNxXtvIY8hXyinV
        lJJYrs11O+LjClxhMnm8nkYxIgZT568=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-KFHJWfvZNkebwPPYguja2Q-1; Thu, 07 Jan 2021 15:59:06 -0500
X-MC-Unique: KFHJWfvZNkebwPPYguja2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95088801B14;
        Thu,  7 Jan 2021 20:59:02 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F5D110013BD;
        Thu,  7 Jan 2021 20:58:56 +0000 (UTC)
Date:   Thu, 7 Jan 2021 15:58:55 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
Message-ID: <X/d2DyLfXZmBIreY@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Jan 07, 2021 at 12:17:40PM -0800, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 12:04 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > However there are two cases that could wrprotecting exclusive anon
> > pages with only the mmap_read_lock:
> 
> I still think the real fix is "Don't do that then", and just take the
> write lock.
> 
> The UFFDIO_WRITEPROTECT case simply isn't that critical. It's not a
> normal operation. Same goes for softdirty.
> 
> Why have those become _so_ magical that they can break the VM for
> everybody else?

I see what you mean above and I agree. Like said below:

==
In simple terms: the page_count check in do_wp_page makes it
impossible to wrprotect memory, if such memory is under a !FOLL_WRITE
GUP pin.
==

So to simplify let's ignore UFFDIO_WRITEPROTECT here, which is new and
adds no dependency on top of clear_refs in this respect.

So yes, if we drop any code that has to wrprotect memory in place in
the kernel (since all userland memory can be under GUP pin in read
mode) and we make such an operation illegal, then it's fine, but that
means clear_refs has to go or it has to fail if there's a GUP pin
during the wrprotection.

The problem is it's not even possible to detect reliably if there's
really a long term GUP pin because of speculative pagecache lookups.

We would need to declare that any secondary MMU which is supposed to
be VM-neutral using mmu notifier like a GPU or a RDMA device, cannot
be used in combination on clear_refs and it would need to be enforced
fully in userland. Most mmu notifier users drop the GUP pin during the
invalidate for extra safety in case an invalidate goes missing: they
would all need to drop FOLL_GET to be compliant and stop causing
memory corruption if clear_refs shall be still allowed to happen on
mmu notifier capable secondary MMUs. Even then how does userland know
which devices attaches to the memory with mmu notifer and never using
FOLL_GET and which aren't? It doesn't sound reliable to enforce this
in userland. So I don't see how clear_refs can be saved.

Now let's make another example that still shows at least some
fundamental inefficiency that has nothing to do with clear_refs.

Let's suppose a GUP pin is taken on a subpageA by a RDMA device by
process A (parent). Let's now assume subpageB is mapped in process B
(child of process A). Both subpageA and subpageB are exclusive
(mapcount == 1) and read-write but they share the same page_count
atomic counter (only the page_mapcounts are subpage granular). To
still tame the zygote concern with the page_count in do_wp_page, then
process B when it forks a child (processC) would forever have to do an
extra superflous COW even after process C exits. Is that what we want
on top of the fundamental unsafety added to clear_refs?

Thanks,
Andrea

