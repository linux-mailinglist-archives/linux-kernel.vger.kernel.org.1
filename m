Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C809D2C13C6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgKWSlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbgKWSlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:41:19 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4632E20658;
        Mon, 23 Nov 2020 18:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606156879;
        bh=zvwUlE1bsbb8piym1lzeYg6Hi20pP/U0RsMsiCqmH3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0Wq6RmkqjomZjc9exaa3msJgEvmFoeBH7VsucYn7yMLqSayRn6019L09nE6IZX7x
         OJMY1M2U+AYGCbRLmDRw+uBehfQ96iXrHstQukwl7Jk9DQupc0YTFQOzHYfqEDT2oG
         ARuvFdjD9CSVYmNhb28gjl6jo+Y/oBquhekNx/IQ=
Date:   Mon, 23 Nov 2020 18:41:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201123184113.GD11688@willie-the-truck>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120150023.GH3040@hirez.programming.kicks-ass.net>
 <20201120155514.GA3377168@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120155514.GA3377168@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 07:55:14AM -0800, Minchan Kim wrote:
> On Fri, Nov 20, 2020 at 04:00:23PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> > > Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> > > TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> > > via the tlb_remove_*() functions. Consequently, the page-table modifications
> > > performed by clear_refs_write() in response to a write to
> > > /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> > > fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> > > state we can end up with entries where pte_write() is false, yet a
> > > writable mapping remains in the TLB.
> > > 
> > > Fix this by calling tlb_remove_tlb_entry() for each entry being
> > > write-protected when cleating soft-dirty.
> > > 
> > 
> > > @@ -1053,6 +1054,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
> > >  		ptent = pte_wrprotect(old_pte);
> > >  		ptent = pte_clear_soft_dirty(ptent);
> > >  		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> > > +		tlb_remove_tlb_entry(tlb, pte, addr);
> > >  	} else if (is_swap_pte(ptent)) {
> > >  		ptent = pte_swp_clear_soft_dirty(ptent);
> > >  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> > 
> > Oh!
> > 
> > Yesterday when you had me look at this code; I figured the sane thing
> > to do was to make it look more like mprotect().
> > 
> > Why did you chose to make it work with mmu_gather instead? I'll grant
> > you that it's probably the smaller patch, but I still think it's weird
> > to use mmu_gather here.
> 
> I agree. The reason why clear_refs_write used the gather API was [1] and
> seems like to overkill to me.

I don't see why it's overkill. Prior to that commit, it called
flush_tlb_mm() directly.

> We could just do like [inc|dec]_tlb_flush_pending with flush_tlb_mm at
> right before dec_tlb_flush_pending instead of gather.
> 
> thought?

I'm not sure why this is better; it's different to the madvise() path, and
will need special logic to avoid the flush in the case where we're just
doing aging.

Will

> [1] b3a81d0841a95, mm: fix KSM data corruption
