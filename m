Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5CA2BAC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgKTPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKTPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:00:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NiuizQJIYv9MbTQDyL6kr/KprFoXkhdzvZvshBrCr/c=; b=W5Y9nvrdN7SJJgjDkR857bMCI5
        WgHN1yn81J7n4R9+szMLSLmcnueBnCeriem/X9E77Fyo7lEVbPZ07lRDMfAlChRRgeBKGwqc5bfct
        LLnxaiKkI6zv7oOZ784WCJYfOCPqkHFdboEpkz0F+l5ghqvPvM57ZT4gA/SITHMH++QiXCnBuf4Kx
        UMAi8saLKQE1xeDOIIV7D80RNnvq2lFflYqB0JUT8HOfOqyw6ddbLCzoAty4fhBrUpLAF7MqlxU2u
        5WjZqhuqGlfe9gznf7/7Qr7PzDsWnu/wbk/Ma44+B95C5XvosCm2SHJnXd4hqshXaEz0rfjxjc6ei
        OG5ThHbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg7tg-00005F-Dg; Fri, 20 Nov 2020 15:00:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB369304D28;
        Fri, 20 Nov 2020 16:00:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A770C20244762; Fri, 20 Nov 2020 16:00:23 +0100 (CET)
Date:   Fri, 20 Nov 2020 16:00:23 +0100
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
Message-ID: <20201120150023.GH3040@hirez.programming.kicks-ass.net>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120143557.6715-5-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> via the tlb_remove_*() functions. Consequently, the page-table modifications
> performed by clear_refs_write() in response to a write to
> /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> state we can end up with entries where pte_write() is false, yet a
> writable mapping remains in the TLB.
> 
> Fix this by calling tlb_remove_tlb_entry() for each entry being
> write-protected when cleating soft-dirty.
> 

> @@ -1053,6 +1054,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>  		ptent = pte_wrprotect(old_pte);
>  		ptent = pte_clear_soft_dirty(ptent);
>  		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> +		tlb_remove_tlb_entry(tlb, pte, addr);
>  	} else if (is_swap_pte(ptent)) {
>  		ptent = pte_swp_clear_soft_dirty(ptent);
>  		set_pte_at(vma->vm_mm, addr, pte, ptent);

Oh!

Yesterday when you had me look at this code; I figured the sane thing
to do was to make it look more like mprotect().

Why did you chose to make it work with mmu_gather instead? I'll grant
you that it's probably the smaller patch, but I still think it's weird
to use mmu_gather here.

Also, is tlb_remote_tlb_entry() actually correct? If you look at
__tlb_remove_tlb_entry() you'll find that Power-Hash-32 will clear the
entry, which might not be what we want here, we want to update the
entrty.



