Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337C32BAEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgKTP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgKTP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:27:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D79C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jNq6zMPLktZtoS2qL8sEFiWIfZaAQcIh5txb1NsmFb8=; b=d/23pThHpa2YKI6TbnNcjfxcrP
        EU9GDAHNFNFmX/cjA8hX06z4eGT7DHYsH0RRNFS0BcswTMDkRjuaApfFSTZyGY2VSE7dgeEA59DxD
        RDZVdURohDgFjAEd62m/C8ttzYHks5T9MwBfn/D3S8hfci7HOvFu80KF5AHanh3boYzD6N34b1wqH
        afF7/aTKhik/Nf29xEBmxDd0QUtCG0NJ8mJISeCZxWbUhaQhEPJzCV/90ejr6TiVI9ed+DzAfq1uG
        LQx5IVpYpa6JW5w8jGS2Qrv0xY7mx5wFh5QiKhVddXHyGq1rtqRjyFVE8JZK5eKDURfIYeoSXAqP9
        bBvMa+zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg8Jw-0003Ef-Ew; Fri, 20 Nov 2020 15:27:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 006E3304D28;
        Fri, 20 Nov 2020 16:27:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E09B8202397FB; Fri, 20 Nov 2020 16:27:31 +0100 (CET)
Date:   Fri, 20 Nov 2020 16:27:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201120152731.GK3021@hirez.programming.kicks-ass.net>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120150023.GH3040@hirez.programming.kicks-ass.net>
 <20201120151523.GA6861@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120151523.GA6861@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 03:15:24PM +0000, Will Deacon wrote:
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
> 
> Ah, so you mean ditch the mmu_gather altogether?

Yes. Alternatively, if we decide mmu_gather is 'right', then we should
probably look at converting mprotect().

That is, I see no reason why this and mprotect should differ on this
point.

> > Why did you chose to make it work with mmu_gather instead? I'll grant
> > you that it's probably the smaller patch, but I still think it's weird
> > to use mmu_gather here.
> > 
> > Also, is tlb_remote_tlb_entry() actually correct? If you look at
> > __tlb_remove_tlb_entry() you'll find that Power-Hash-32 will clear the
> > entry, which might not be what we want here, we want to update the
> > entrty.
> 
> Hmm, I didn't spot that, although ptep_modify_prot_start() does actually
> clear the pte so we could just move this up a few lines.

Yes, but hash-entry != pte. If I'm not mistaken (and I could very well
be, it's Friday and Power-MMUs being the maze they are), the end result
here is an updated PTE but an empty hash-entry.
