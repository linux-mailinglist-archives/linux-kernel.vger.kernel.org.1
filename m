Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BFC2AF7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKKS0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BBBC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9dKHZ03Oj9aGkBqeRTlKXIhZ5sPnfvf1wglGXCUcr2k=; b=fMhc+VgxU2FfGYQ2ZPNlVNwAhl
        4qM/zaAKl+TZTOoWg6sILLB4xmc60vEXtC09PMhueGtO7816tWh4U3LqUmf6M9T3HQt1eInfb4Gfz
        s31g3SYinutiGM/j93Typ4otnej1n9X6YXYAc56o5LweWY5nsNtYODkgTZwY40Lgc5lE17dueH5Zw
        5OlmnRsCFSQHS6+dJAF50v3TJ+6tpXnSxR5a1SlyxYRu8hMhb4HpjhXC0OTfzdI+b6q6wXsGIn9R3
        JooueGGCaBBzu5zjnHy6tvpwhoMHp5YL1noBoXCZS8oqIxeflWcT2tfiWIPaPrwH0DwmKHgbsEEWm
        VISUq0qQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcup2-0008VI-BQ; Wed, 11 Nov 2020 18:26:20 +0000
Date:   Wed, 11 Nov 2020 18:26:20 +0000
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
Message-ID: <20201111182620.GW17076@casper.infradead.org>
References: <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
 <20201111124357.GS2651@hirez.programming.kicks-ass.net>
 <20201111153022.GT17076@casper.infradead.org>
 <20201111155724.GE2628@hirez.programming.kicks-ass.net>
 <20201111163848.GU17076@casper.infradead.org>
 <20201111172253.GG2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111172253.GG2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 06:22:53PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 04:38:48PM +0000, Matthew Wilcox wrote:
> > 	if (pud_leaf(pud))
> > 		return PUD_SIZE;
> 
> But that doesn't handle non-pagetable aligned hugetlb sizes. Granted,
> that's unlikely at the PUD level, but why be inconsistent..
> 
> So we really want:
> 
> 	if (p*d_leaf(p*d)) {
> 		if (!'special') {
> 			page = p*d_page(p*d);
> 			if (PageHuge(page))
> 				return page_size(compound_head(page));
> 		}
> 		return P*D_SIZE;
> 	}

Still doesn't work because pages can be mapped at funny offsets.

What we really want is for a weak definition of

unsigned long tlb_size(struct mm_struct *mm, unsigned long addr)
{
	if (p*d_leaf(p*d))
		return p*d_size(p*d);
}

then ARM can look at its special bit in the page table to determine
whether this is a singleton or part of a brace of pages.

> Now, when you add !PMD THP sizes (presumably for architectures that have
> 'funny' sizes, otherwise what's the point), then you get to add '||

This is the problem with all the huge page support in Linux today.
It's written by people who work for hardware companies who think only
about exploiting the hardware features they sell.  You all ignore the
very real software overhedas of trying to manage millions of pages.
I see a 6% reduction in kernel overhead when running kernbench using
THPs that may go as large as 256kB.  On x86.  Intel x86, at that.

