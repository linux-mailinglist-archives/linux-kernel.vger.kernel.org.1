Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3932AFC01
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKLBba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgKKWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:43:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72410C061A4D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ag5PvPaul4H2hHbq3Crap5QwOwKCDcyfjL3Vc3uOxx8=; b=ervcDFDinHQ/rSbiRm8BRqRVuY
        EptOlsCXkryTJC3+cAZXKzTn1eaPM+p3NfxH6nJ688N42wltJLGRGI2Oi9elgmu4yRpZ0nFecV3v2
        q2HK1PAu5FtPf4xbSU+p8ruhXpmFFtmt2ykAPEPbxfhESQyAyJMnLQXCcOcsitiffa6PHMRUpE7np
        He4F00yifHKjYFNc196va6sgxzR5nx51l7Wrn0BiwR5EhcyH3PGc+326DJgbihMnkWzcp5RyF8BXu
        mUcapqyX3n/0sShWl0mgxk6+iymcFdMCNsEOJrTJUpTug1geqfksc7idgLOHmEdyerkxgkMnUOjQI
        yuCJdMag==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcygS-0005w4-5f; Wed, 11 Nov 2020 22:33:44 +0000
Date:   Wed, 11 Nov 2020 22:33:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>, vbabka@suse.cz
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201111223344.GX17076@casper.infradead.org>
References: <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
 <20201111124357.GS2651@hirez.programming.kicks-ass.net>
 <20201111153022.GT17076@casper.infradead.org>
 <20201111155724.GE2628@hirez.programming.kicks-ass.net>
 <20201111163848.GU17076@casper.infradead.org>
 <20201111172253.GG2628@hirez.programming.kicks-ass.net>
 <20201111182620.GW17076@casper.infradead.org>
 <20201111200000.GL2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111200000.GL2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:00:00PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 06:26:20PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 11, 2020 at 06:22:53PM +0100, Peter Zijlstra wrote:
> > > On Wed, Nov 11, 2020 at 04:38:48PM +0000, Matthew Wilcox wrote:
> > > > 	if (pud_leaf(pud))
> > > > 		return PUD_SIZE;
> > > 
> > > But that doesn't handle non-pagetable aligned hugetlb sizes. Granted,
> > > that's unlikely at the PUD level, but why be inconsistent..
> > > 
> > > So we really want:
> > > 
> > > 	if (p*d_leaf(p*d)) {
> > > 		if (!'special') {
> > > 			page = p*d_page(p*d);
> > > 			if (PageHuge(page))
> > > 				return page_size(compound_head(page));
> > > 		}
> > > 		return P*D_SIZE;
> > > 	}
> > 
> > Still doesn't work because pages can be mapped at funny offsets.
> 
> Wait, what?! Is there hardware that has unaligned TLB page-sizes?

No, you can force a 2MB page to be mapped at an address which isn't
2MB aligned.

> Can you start a 64K page at an 8k offset? I don't think I've ever seen
> that. Still even with that, how would the above go wrong there? It would
> find the compound page covering @addr, PageHuge() (and possibly some
> addition arch specific condition) returns true and we get the compound
> size to find the hardware page size used.

On any architecture I can think of, that 2MB page will be mapped with 4kB
TLB entries.

> > What we really want is for a weak definition of
> > 
> > unsigned long tlb_size(struct mm_struct *mm, unsigned long addr)
> > {
> > 	if (p*d_leaf(p*d))
> > 		return p*d_size(p*d);
> > }
> > 
> > then ARM can look at its special bit in the page table to determine
> > whether this is a singleton or part of a brace of pages.
> 
> That's basically what we provide. but really the only thing that's
> missing from this generic page walker is the ability to detect if a
> !PageHuge compound page is actually still a hardware page.
> 
> > > Now, when you add !PMD THP sizes (presumably for architectures that have
> > > 'funny' sizes, otherwise what's the point), then you get to add '||
> > 
> > This is the problem with all the huge page support in Linux today.
> > It's written by people who work for hardware companies who think only
> > about exploiting the hardware features they sell.  You all ignore the
> > very real software overhedas of trying to manage millions of pages.
> > I see a 6% reduction in kernel overhead when running kernbench using
> > THPs that may go as large as 256kB.  On x86.  Intel x86, at that.
> 
> That's a really nice improvement. However then this code doesn't care
> about it. Please make it possible to distinguish between THP on hardware
> pages vs software pages.

That can and should be done just by looking at the page table entries.
There's no need to convert it into a struct page.  The CPU obviously
decides what TLB entry size to use based solely on the page tables,
so we can too.
