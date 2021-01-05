Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C90B2EB1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbhAESAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:00:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbhAESAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609869545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETjbPHZNWvnKCwDolzZzXTZwlnopq4mbI1nKd4J/RMk=;
        b=HelOibf6xHrebarWpx6gNnTu83fnOxgx81M38RzsODnR5YtAFhOjdUqURPmNGi4oJK5qBI
        ynRokrUSQiGESRdLlillRFBm+RYaR+U3DJkqBbW0SFVUdYpGx11VIE6gdn/Xij+wGMqZeD
        aCGPPn/rQeYIbejyUxewbpUaESGFiDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-5IbwvZi4NkKmN4n79Pfn1A-1; Tue, 05 Jan 2021 12:59:03 -0500
X-MC-Unique: 5IbwvZi4NkKmN4n79Pfn1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A35309CDA3;
        Tue,  5 Jan 2021 17:59:00 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BFC270959;
        Tue,  5 Jan 2021 17:58:56 +0000 (UTC)
Date:   Tue, 5 Jan 2021 12:58:55 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <X/So39qVhYYzDZ+8@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <20210105085857.GE3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105085857.GE3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 09:58:57AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 04, 2021 at 02:24:38PM -0500, Andrea Arcangeli wrote:
> > On Mon, Jan 04, 2021 at 01:22:27PM +0100, Peter Zijlstra wrote:
> > > On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> > > 
> > > > The scenario that happens in selftests/vm/userfaultfd is as follows:
> > > > 
> > > > cpu0				cpu1			cpu2
> > > > ----				----			----
> > > > 							[ Writable PTE
> > > > 							  cached in TLB ]
> > > > userfaultfd_writeprotect()
> > > > [ write-*unprotect* ]
> > > > mwriteprotect_range()
> > > > mmap_read_lock()
> > > > change_protection()
> > > > 
> > > > change_protection_range()
> > > > ...
> > > > change_pte_range()
> > > > [ *clear* “write”-bit ]
> > > > [ defer TLB flushes ]
> > > > 				[ page-fault ]
> > > > 				...
> > > > 				wp_page_copy()
> > > > 				 cow_user_page()
> > > > 				  [ copy page ]
> > > > 							[ write to old
> > > > 							  page ]
> > > > 				...
> > > > 				 set_pte_at_notify()
> > > 
> > > Yuck!
> > > 
> > 
> > Note, the above was posted before we figured out the details so it
> > wasn't showing the real deferred tlb flush that caused problems (the
> > one showed on the left causes zero issues).
> > 
> > The problematic one not pictured is the one of the wrprotect that has
> > to be running in another CPU which is also isn't picture above. More
> > accurate traces are posted later in the thread.
> 
> Lets assume CPU0 does a read-lock, W -> RO with deferred flush.

I was mistaken saying the deferred tlb flush was not shown in the v2
trace, just this appears a new different case we didn't happen to
consider before.

In the previous case we discussed earlier, when un-wrprotect above is
called it never should have been a W->RO since a wrprotect run first.

Doesn't it ring a bell that if an un-wrprotect does a W->RO
transition, something is a bit going backwards?

I don't recall from previous discussion that un-wrprotect was
considered as called on read-write memory. I think we need the below
change to fix this new case.

			if (uffd_wp) {
+				if (unlikely(pte_uffd_wp(oldpte)))
+					continue;
				ptent = pte_wrprotect(ptent);
				ptent = pte_mkuffd_wp(ptent);
			} else if (uffd_wp_resolve) {
+				if (unlikely(!pte_uffd_wp(oldpte)))
+					continue;
				/*
				 * Leave the write bit to be handled
				 * by PF interrupt handler, then
				 * things like COW could be properly
				 * handled.
				 */
				ptent = pte_clear_uffd_wp(ptent);
			}

I now get why the v2 patch touches preserved_write, but this is not
about preserve_write, it's not about leaving the write bit alone. This
is about leaving the whole pte alone if the uffd-wp bit doesn't
actually change.

We shouldn't just defer the tlb flush if un-wprotect is called on
read-write memory: we should not have flushed the tlb at all in such
case.

Same for hugepmd in huge_memory.c which will be somewhere else.

Once the above is optimized, then un-wrprotect as in
MM_CP_UFFD_WP_RESOLVE is usually preceded by wrprotect as in
MM_CP_UFFD_WP, and so it'll never be a W->RO but a RO->RO transition
that just clears the uffd_wp flag and nothing else and whose tlb flush
is in turn irrelevant.

The fix discussed still works for this new case too: I'm not
suggesting we should rely on the above optimization for the tlb
safety. The above is just a missing optimization.

> > > Isn't this all rather similar to the problem that resulted in the
> > > tlb_flush_pending mess?
> > > 
> > > I still think that's all fundamentally buggered, the much saner solution
> > > (IMO) would've been to make things wait for the pending flush, instead
> > 
> > How do intend you wait in PT lock while the writer also has to take PT
> > lock repeatedly before it can do wake_up_var?
> > 
> > If you release the PT lock before calling wait_tlb_flush_pending it
> > all falls apart again.
> 
> I suppose you can check for pending, if found, release lock, wait for 0,
> and re-take the fault?

Aborting the page fault unconditionally while MADV_DONTNEED is running
on some other unrelated vma, sounds not desirable.

Doing it only for !VM_SOFTDIRTY or soft dirty not compiled in sounds
less bad but it would still mean that while clear_refs is running, no
thread can write to any anon memory of the process.

> > This I guess explains why a local pte/hugepmd smp local invlpg is the
> > only working solution for this issue, similarly to how it's done in rmap.
> 
> In that case a local invalidate on CPU1 simply doesn't help anything.
> 
> CPU1 needs to do a global invalidate or wait for the in-progress one to
> complete, such that CPU2 is sure to not have a W entry left before CPU1
> goes and copies the page.

Yes, it was a global invlpg, definitely not local sorry for the
confusion, as in the PoC posted here which needs cleaning up:

       https://lkml.kernel.org/r/X+QLr1WmGXMs33Ld@redhat.com

+                       flush_tlb_page(vma, vmf->address);

I think instead of the flush_tlb_page above, we just need an
ad-hoc abstraction there.

The added complexity to the page fault common code consist in having
to call such abstract call in the right place of the page fault.

The vm_flags to check will be the same for both the flush_tlb_page and
the wait_tlb_pending approaches.

Once the filter on vm_flags pass, the only difference is between
"flush_tlb_page; return void" or "PT unlock; wait_; return
VM_FAULT_RETRY" so it looks more an implementation detail with a
different tradeoff at runtime.

Thanks,
Andrea

