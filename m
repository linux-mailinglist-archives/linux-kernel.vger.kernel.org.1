Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C683B2E9E14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhADT0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbhADT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609788289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WFUsWXvGZlvYFGW5zLUZV3SAVOw5bpW8rc0isSU/ko=;
        b=CLR+oaydS04gYgQioDafI6rsfT8MT+HXWyBA9lDrJJmReoAu5bcDq0JnJRWu7ZiQuqiCGY
        gQRSmIzhm8YTi+tW7RHuJFKvy/BQjAhA8y4kCeXCBsHw0xXxLK1YHiup2pj47vUUrG9Zfg
        wcKPxdtCwT6CPXzu6EIr4ywkUvV+Nx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-yYcZ4XfAMSmZCEUQAMjNdA-1; Mon, 04 Jan 2021 14:24:45 -0500
X-MC-Unique: yYcZ4XfAMSmZCEUQAMjNdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E5E5801AC0;
        Mon,  4 Jan 2021 19:24:43 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55E2B5D756;
        Mon,  4 Jan 2021 19:24:39 +0000 (UTC)
Date:   Mon, 4 Jan 2021 14:24:38 -0500
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
Message-ID: <X/NrdnoDHgFd0Ku1@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210104122227.GL3021@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 04, 2021 at 01:22:27PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
> 
> > The scenario that happens in selftests/vm/userfaultfd is as follows:
> > 
> > cpu0				cpu1			cpu2
> > ----				----			----
> > 							[ Writable PTE
> > 							  cached in TLB ]
> > userfaultfd_writeprotect()
> > [ write-*unprotect* ]
> > mwriteprotect_range()
> > mmap_read_lock()
> > change_protection()
> > 
> > change_protection_range()
> > ...
> > change_pte_range()
> > [ *clear* “write”-bit ]
> > [ defer TLB flushes ]
> > 				[ page-fault ]
> > 				...
> > 				wp_page_copy()
> > 				 cow_user_page()
> > 				  [ copy page ]
> > 							[ write to old
> > 							  page ]
> > 				...
> > 				 set_pte_at_notify()
> 
> Yuck!
> 

Note, the above was posted before we figured out the details so it
wasn't showing the real deferred tlb flush that caused problems (the
one showed on the left causes zero issues).

The problematic one not pictured is the one of the wrprotect that has
to be running in another CPU which is also isn't picture above. More
accurate traces are posted later in the thread.

> Isn't this all rather similar to the problem that resulted in the
> tlb_flush_pending mess?
> 
> I still think that's all fundamentally buggered, the much saner solution
> (IMO) would've been to make things wait for the pending flush, instead

How do intend you wait in PT lock while the writer also has to take PT
lock repeatedly before it can do wake_up_var?

If you release the PT lock before calling wait_tlb_flush_pending it
all falls apart again.

This I guess explains why a local pte/hugepmd smp local invlpg is the
only working solution for this issue, similarly to how it's done in rmap.

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 07d9acb5b19c..0210547ac424 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -649,7 +649,8 @@ static inline void dec_tlb_flush_pending(struct mm_struct *mm)
>  	 *
>  	 * Therefore we must rely on tlb_flush_*() to guarantee order.
>  	 */
> -	atomic_dec(&mm->tlb_flush_pending);
> +	if (atomic_dec_and_test(&mm->tlb_flush_pending))
> +		wake_up_var(&mm->tlb_flush_pending);
>  }
>  
>  static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
> @@ -677,6 +678,12 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
>  	return atomic_read(&mm->tlb_flush_pending) > 1;
>  }
>  
> +static inline void wait_tlb_flush_pending(struct mm_struct *mm)
> +{
> +	wait_var_event(&mm->tlb_flush_pending,
> +		       atomic_read(&mm->tlb_flush_pending) == 0);
> +}

I appreciate the effort in not regressing soft dirty and uffd-wp
writeprotect to disk-I/O spindle bandwidth and not using mmap_sem for
writing.

At the same time what was posted so far wasn't clean enough but it
wasn't even tested... if we abstract it in some clean way and we mark
all connected points (soft dirty, uffd-wp, the wrprotect page fault),
then I can be optimistic it will remain understandable when we look at
it again a few years down the road.

Or at the very least it can't get worse than the "tlb_flush_pending
mess" you mentioned above.

flush_tlb_batched_pending() has to be orthogonally re-reviewed for
those things Nadav pointed out. But I'd rather keep that review in a
separate thread since any bug in that code has zero connection to this
issue. The basic idea is similar but the methods and logic are
different and our flush here will be granular and it's going to be
only run if VM_SOFTDIRTY isn't set and soft dirty is compiled in, or
if VM_UFFD_WP is set. The flush_tlb_batched_pending is mm wide,
unconditional etc.. Pretty much all different.

Thanks,
Andrea

