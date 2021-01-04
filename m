Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36682E94C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbhADMYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADMYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:24:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF4C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 04:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3RCmmiMt2hjnork/7M1G+NcD6b4PGitnpY8YIQ91D2M=; b=M+udqozSsQJ+BmdOB3yCZ/zy0H
        0oZbbU4IfAxIXr9fgqnzfGl05YO2OKugF4uxYf/hBOzj9B7zPqGmYp2KxlHYBPMxbPJ6sjJC/tObW
        XwUKvV/mmgeJbhfNUJgXgAxTlx3YJjGOdmVIBhLvdIJGR/x69l/twX9xDqG+KD4knS0Dr3RLmjyL5
        BRQ58pg5sba5G9oW/IoLggGL7Q5mydQ/KFzKYOhaETVREXFwWqlDjvu4uSKiLo8EBTUAem0glRduV
        WOERrP1lNTB/RAfl9UOF10LFG4oJPUXwPlig/PkRGr+49IUYJjAQ9DYOWBTbpWnjI0UFF0fS/QtOA
        CiHn7oLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwOsY-0004gb-GP; Mon, 04 Jan 2021 12:22:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E4DC307005;
        Mon,  4 Jan 2021 13:22:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5106C20BEF814; Mon,  4 Jan 2021 13:22:27 +0100 (CET)
Date:   Mon, 4 Jan 2021 13:22:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <20210104122227.GL3021@hirez.programming.kicks-ass.net>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201225092529.3228466-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:

> The scenario that happens in selftests/vm/userfaultfd is as follows:
> 
> cpu0				cpu1			cpu2
> ----				----			----
> 							[ Writable PTE
> 							  cached in TLB ]
> userfaultfd_writeprotect()
> [ write-*unprotect* ]
> mwriteprotect_range()
> mmap_read_lock()
> change_protection()
> 
> change_protection_range()
> ...
> change_pte_range()
> [ *clear* “write”-bit ]
> [ defer TLB flushes ]
> 				[ page-fault ]
> 				...
> 				wp_page_copy()
> 				 cow_user_page()
> 				  [ copy page ]
> 							[ write to old
> 							  page ]
> 				...
> 				 set_pte_at_notify()

Yuck!

Isn't this all rather similar to the problem that resulted in the
tlb_flush_pending mess?

I still think that's all fundamentally buggered, the much saner solution
(IMO) would've been to make things wait for the pending flush, instead
of doing a local flush and fudging things like we do now.

Then the above could be fixed by having wp_page_copy() wait for the
pending invalidate (although a more fine-grained pending state would be
awesome).

The below probably doesn't compile and will probably cause massive
header fail at the very least, but does show the general.


diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 07d9acb5b19c..0210547ac424 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -649,7 +649,8 @@ static inline void dec_tlb_flush_pending(struct mm_struct *mm)
 	 *
 	 * Therefore we must rely on tlb_flush_*() to guarantee order.
 	 */
-	atomic_dec(&mm->tlb_flush_pending);
+	if (atomic_dec_and_test(&mm->tlb_flush_pending))
+		wake_up_var(&mm->tlb_flush_pending);
 }
 
 static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
@@ -677,6 +678,12 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending) > 1;
 }
 
+static inline void wait_tlb_flush_pending(struct mm_struct *mm)
+{
+	wait_var_event(&mm->tlb_flush_pending,
+		       atomic_read(&mm->tlb_flush_pending) == 0);
+}
+
 struct vm_fault;
 
 /**
diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..3c36bca2972a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3087,6 +3087,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	wait_tlb_flush_pending(vma->vm_mm);
+
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return handle_userfault(vmf, VM_UFFD_WP);
