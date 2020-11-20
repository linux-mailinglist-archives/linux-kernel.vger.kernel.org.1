Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923302BAE5B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgKTPPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgKTPP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:15:29 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726E42222F;
        Fri, 20 Nov 2020 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605885329;
        bh=myF2EzCes4UVMutespd8PDoerC1yzUqdk7cGgmK3HWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRDorcB6ldF3sNlcORjj2k73XJBnmxxSjcSDRg1jxvIfT96O4MqbTKjmNtoGNUIrU
         lKbjYVfTXF+0+uDHZPITUOToP+Ct1EsDmk5iRd2om4XbZ6ZbYn7QJDJdcyFqtoCtl/
         edQ6erShqwUz/0RpRBDNw+8k8ogMf5rXVAC52jms=
Date:   Fri, 20 Nov 2020 15:15:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201120151523.GA6861@willie-the-truck>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120150023.GH3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120150023.GH3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 04:00:23PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> > Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> > TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> > via the tlb_remove_*() functions. Consequently, the page-table modifications
> > performed by clear_refs_write() in response to a write to
> > /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> > fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> > state we can end up with entries where pte_write() is false, yet a
> > writable mapping remains in the TLB.
> > 
> > Fix this by calling tlb_remove_tlb_entry() for each entry being
> > write-protected when cleating soft-dirty.
> > 
> 
> > @@ -1053,6 +1054,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
> >  		ptent = pte_wrprotect(old_pte);
> >  		ptent = pte_clear_soft_dirty(ptent);
> >  		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> > +		tlb_remove_tlb_entry(tlb, pte, addr);
> >  	} else if (is_swap_pte(ptent)) {
> >  		ptent = pte_swp_clear_soft_dirty(ptent);
> >  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> 
> Oh!
> 
> Yesterday when you had me look at this code; I figured the sane thing
> to do was to make it look more like mprotect().

Ah, so you mean ditch the mmu_gather altogether?

> Why did you chose to make it work with mmu_gather instead? I'll grant
> you that it's probably the smaller patch, but I still think it's weird
> to use mmu_gather here.
> 
> Also, is tlb_remote_tlb_entry() actually correct? If you look at
> __tlb_remove_tlb_entry() you'll find that Power-Hash-32 will clear the
> entry, which might not be what we want here, we want to update the
> entrty.

Hmm, I didn't spot that, although ptep_modify_prot_start() does actually
clear the pte so we could just move this up a few lines.

Will

> 
> 
> 
