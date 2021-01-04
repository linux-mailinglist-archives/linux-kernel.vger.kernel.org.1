Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD832E9F41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 22:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbhADVDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 16:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbhADVDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 16:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609794106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tY+Elpc7SnbmLCyNsKOB0BDPeVmtTALwwEA3Eq9XNRE=;
        b=DnaD+MhYbWAfnWxp5A+YNQmci591L7pZMEQhoMU7Zi9+ZpozP2nyVUhmInEoR3iLFYboSK
        WwK2NWOXc8BE+og4H6Mes70/wVulw/NiyPzwZJ6wKyHxKY4ljbpomQPAEJzoopevXT6JIk
        tgturkGSk3bhi/pEzwVsy+j+G/WiDeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-YFsE2j1KMd2hJeASdX9_TQ-1; Mon, 04 Jan 2021 16:01:44 -0500
X-MC-Unique: YFsE2j1KMd2hJeASdX9_TQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDC9B107ACF6;
        Mon,  4 Jan 2021 21:01:41 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC9C85D9C6;
        Mon,  4 Jan 2021 21:01:37 +0000 (UTC)
Date:   Mon, 4 Jan 2021 16:01:37 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <X/OCMalFYnDdGnch@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
 <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:39:37PM +0000, Nadav Amit wrote:
> > On Jan 4, 2021, at 12:19 PM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> > 
> > On Mon, Jan 04, 2021 at 07:35:06PM +0000, Nadav Amit wrote:
> >>> On Jan 4, 2021, at 11:24 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> >>> 
> >>> Hello,
> >>> 
> >>> On Mon, Jan 04, 2021 at 01:22:27PM +0100, Peter Zijlstra wrote:
> >>>> On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> >>>> 
> >>>>> The scenario that happens in selftests/vm/userfaultfd is as follows:
> >>>>> 
> >>>>> cpu0				cpu1			cpu2
> >>>>> ----				----			----
> >>>>> 							[ Writable PTE
> >>>>> 							  cached in TLB ]
> >>>>> userfaultfd_writeprotect()
> >>>>> [ write-*unprotect* ]
> >>>>> mwriteprotect_range()
> >>>>> mmap_read_lock()
> >>>>> change_protection()
> >>>>> 
> >>>>> change_protection_range()
> >>>>> ...
> >>>>> change_pte_range()
> >>>>> [ *clear* “write”-bit ]
> >>>>> [ defer TLB flushes ]
> >>>>> 				[ page-fault ]
> >>>>> 				...
> >>>>> 				wp_page_copy()
> >>>>> 				 cow_user_page()
> >>>>> 				  [ copy page ]
> >>>>> 							[ write to old
> >>>>> 							  page ]
> >>>>> 				...
> >>>>> 				 set_pte_at_notify()
> >>>> 
> >>>> Yuck!
> >>> 
> >>> Note, the above was posted before we figured out the details so it
> >>> wasn't showing the real deferred tlb flush that caused problems (the
> >>> one showed on the left causes zero issues).
> >> 
> >> Actually it was posted after (note that this is v2). The aforementioned
> >> scenario that Peter regards to is the one that I actually encountered (not
> >> the second scenario that is “theoretical”). This scenario that Peter regards
> >> is indeed more “stupid” in the sense that we should just not write-protect
> >> the PTE on userfaultfd write-unprotect.
> >> 
> >> Let me know if I made any mistake in the description.
> > 
> > I didn't say there is a mistake. I said it is not showing the real
> > deferred tlb flush that cause problems.
> > 
> > The issue here is that we have a "defer tlb flush" that runs after
> > "write to old page".
> > 
> > If you look at the above, you're induced to think the "defer tlb
> > flush" that causes issues is the one in cpu0. It's not. That is
> > totally harmless.
> 
> I do not understand what you say. The deferred TLB flush on cpu0 *is* the
> the one that causes the problem. The PTE is write-protected (although it is
> a userfaultfd unprotect operation), causing cpu1 to encounter a #PF, handle
> the page-fault (and copy), while cpu2 keeps writing to the source page. If
> cpu0 did not defer the TLB flush, this problem would not happen.

Your argument "If cpu0 did not defer the TLB flush, this problem would
not happen" is identical to "if the cpu0 has a small TLB size and the
tlb entry is recycled, the problem would not happen".

There are a multitude of factors that are unrelated to the real
problematic deferred tlb flush that may happen and still won't cause
the issue, including a parallel IPI.

The point is that we don't need to worry about the "defer TLB flushes"
of the un-wrprotect, because you said earlier that deferring tlb
flushes when you're doing "permission promotions" does not cause
problems.

The only "deferred tlb flush" we need to worry about, not in the
picture, is the one following the actual permission removal (the
wrprotection).

> it shows the write that triggers the corruption instead of discussing
> “windows”, which might be less clear. Running copy_user_page() with stale

I think showing exactly where the race window opens is key to
understand the issue, but then that's the way I work and feel free to
think it in any other way that may sound simpler.

I just worried people thinks the deferred tlb flush in your v2 trace
is the one that causes problem when obviously it's not since it
follows a permission promotion. Once that is clear, feel free to
reject my trace.

All I care about is that performance don't regress from CPU-speed to
disk I/O spindle speed, for soft dirty and uffd-wp.

> I am not married to my description and if you (and others) insist I would
> copy-paste your version.

I definitely don't insist, I only wanted to clarify in case it may not
have been clear the problematic deferred tlb flush wasn't part of your
trace.

> Are you talking about the first scenario (write-unprotect), the second one
> (write-protect followed by write-unprotect), both? It seems to me that all
> the deferred TLB flushes are mentioned at the point they are deferred. I can
> add the point in which they are performed.

The only case that has an issue for uffd-wp is in my trace and only
ever happens if there's a wrprotect in flight, the deferred tlb flush
of the wrprotect is deferred (and that's the problematic one that
closes the window when it finally runs) and un-wrprotect runs. The
window opens when the un-wrprotect unlocks the PT lock. The deferred
tlb flush of un-wrprotect is as relevant for this race, as random tlb
flushes from IPI or the TLB being small or none.

Thanks,
Andrea

