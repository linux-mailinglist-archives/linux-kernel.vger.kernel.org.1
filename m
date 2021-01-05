Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CCF2EA6DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhAEJBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbhAEJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:01:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0241C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zkGwQVpT36gCI4ARYhJdLse+sYnJDQpho9D+RW3CCPM=; b=BVW+TM2mvKNW1RESBNOXWft0Pg
        9H3XdzAjO68uKY3mRqtw8+LDVgJ/qGl94Aw/ZY0QKKCyncZ/yg13G9OOwJpGD93a6qoEb4h+0NPjK
        TsujGi532VRiW94THx0KaicmsBy5GOUEf/FjnO9CAlnxT3iMd1h/e+ma/UDjzbQJJExRPY+saJ4Hy
        dbfoygpjwCz9wgjLRL1T26Sa9kLUOC13GJtRrG7aDjM5irv4W6mb/FPHV0DifcS9QrZoPZf5uBwza
        El8swWSWu1wdaBS+6Eu1V+AqPGikkRmNQArslrVNRchFrIT/Tgklh8NHMcDavmyHYZbDCuHA33xAo
        FDq/I7RA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwiB8-0013NO-Lt; Tue, 05 Jan 2021 08:59:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42181305815;
        Tue,  5 Jan 2021 09:58:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BB4B20CBF47D; Tue,  5 Jan 2021 09:58:57 +0100 (CET)
Date:   Tue, 5 Jan 2021 09:58:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
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
Message-ID: <20210105085857.GE3040@hirez.programming.kicks-ass.net>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/NrdnoDHgFd0Ku1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:24:38PM -0500, Andrea Arcangeli wrote:
> On Mon, Jan 04, 2021 at 01:22:27PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> > 
> > > The scenario that happens in selftests/vm/userfaultfd is as follows:
> > > 
> > > cpu0				cpu1			cpu2
> > > ----				----			----
> > > 							[ Writable PTE
> > > 							  cached in TLB ]
> > > userfaultfd_writeprotect()
> > > [ write-*unprotect* ]
> > > mwriteprotect_range()
> > > mmap_read_lock()
> > > change_protection()
> > > 
> > > change_protection_range()
> > > ...
> > > change_pte_range()
> > > [ *clear* “write”-bit ]
> > > [ defer TLB flushes ]
> > > 				[ page-fault ]
> > > 				...
> > > 				wp_page_copy()
> > > 				 cow_user_page()
> > > 				  [ copy page ]
> > > 							[ write to old
> > > 							  page ]
> > > 				...
> > > 				 set_pte_at_notify()
> > 
> > Yuck!
> > 
> 
> Note, the above was posted before we figured out the details so it
> wasn't showing the real deferred tlb flush that caused problems (the
> one showed on the left causes zero issues).
> 
> The problematic one not pictured is the one of the wrprotect that has
> to be running in another CPU which is also isn't picture above. More
> accurate traces are posted later in the thread.

Lets assume CPU0 does a read-lock, W -> RO with deferred flush.

> > Isn't this all rather similar to the problem that resulted in the
> > tlb_flush_pending mess?
> > 
> > I still think that's all fundamentally buggered, the much saner solution
> > (IMO) would've been to make things wait for the pending flush, instead
> 
> How do intend you wait in PT lock while the writer also has to take PT
> lock repeatedly before it can do wake_up_var?
> 
> If you release the PT lock before calling wait_tlb_flush_pending it
> all falls apart again.

I suppose you can check for pending, if found, release lock, wait for 0,
and re-take the fault?

> This I guess explains why a local pte/hugepmd smp local invlpg is the
> only working solution for this issue, similarly to how it's done in rmap.

In that case a local invalidate on CPU1 simply doesn't help anything.

CPU1 needs to do a global invalidate or wait for the in-progress one to
complete, such that CPU2 is sure to not have a W entry left before CPU1
goes and copies the page.
