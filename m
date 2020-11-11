Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875102AF964
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgKKUAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKUAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:00:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542FAC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pdw432BM08KIhu5OWYpTxrpLUyrv33hd4sdkLAoya/4=; b=GfCfuIrsWAopPCFfw4VrjviNwR
        sIdXZPzalNoc/JHF7+9jfDccXq6DH5qazOa7FG4iw8sfK/HcsiRrgVM+3+Qhm4M9e6hRYY3tBZX1w
        mQktsnHVN65LnbwXcaGBy+812EBNnWiuWV5O7cmYsFgMNX5UXeiqUTAQWDbBcK6fGDHle+qxGy/sQ
        RFJF14mj4W3R5XJDNNE3ErYJc/82GHvgFSZEfBMnQsb1nW3noBaKXntsNvdT8T+WhZzgjgbDRWU/v
        L1uci6Fu0n3RcbQ+Tjv+9vnkXyWWhutZ2Mq1GOQSt8Q4U9OHBpKFpY8GqDCGBfo1Kme4pW0skEROc
        f7Pmp2jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcwHl-0005e0-0B; Wed, 11 Nov 2020 20:00:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BF0C306102;
        Wed, 11 Nov 2020 21:00:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D523203E65DE; Wed, 11 Nov 2020 21:00:00 +0100 (CET)
Date:   Wed, 11 Nov 2020 21:00:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20201111200000.GL2628@hirez.programming.kicks-ass.net>
References: <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
 <20201111124357.GS2651@hirez.programming.kicks-ass.net>
 <20201111153022.GT17076@casper.infradead.org>
 <20201111155724.GE2628@hirez.programming.kicks-ass.net>
 <20201111163848.GU17076@casper.infradead.org>
 <20201111172253.GG2628@hirez.programming.kicks-ass.net>
 <20201111182620.GW17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111182620.GW17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 06:26:20PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 11, 2020 at 06:22:53PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 11, 2020 at 04:38:48PM +0000, Matthew Wilcox wrote:
> > > 	if (pud_leaf(pud))
> > > 		return PUD_SIZE;
> > 
> > But that doesn't handle non-pagetable aligned hugetlb sizes. Granted,
> > that's unlikely at the PUD level, but why be inconsistent..
> > 
> > So we really want:
> > 
> > 	if (p*d_leaf(p*d)) {
> > 		if (!'special') {
> > 			page = p*d_page(p*d);
> > 			if (PageHuge(page))
> > 				return page_size(compound_head(page));
> > 		}
> > 		return P*D_SIZE;
> > 	}
> 
> Still doesn't work because pages can be mapped at funny offsets.

Wait, what?! Is there hardware that has unaligned TLB page-sizes?

Can you start a 64K page at an 8k offset? I don't think I've ever seen
that. Still even with that, how would the above go wrong there? It would
find the compound page covering @addr, PageHuge() (and possibly some
addition arch specific condition) returns true and we get the compound
size to find the hardware page size used.

> What we really want is for a weak definition of
> 
> unsigned long tlb_size(struct mm_struct *mm, unsigned long addr)
> {
> 	if (p*d_leaf(p*d))
> 		return p*d_size(p*d);
> }
> 
> then ARM can look at its special bit in the page table to determine
> whether this is a singleton or part of a brace of pages.

That's basically what we provide. but really the only thing that's
missing from this generic page walker is the ability to detect if a
!PageHuge compound page is actually still a hardware page.

> > Now, when you add !PMD THP sizes (presumably for architectures that have
> > 'funny' sizes, otherwise what's the point), then you get to add '||
> 
> This is the problem with all the huge page support in Linux today.
> It's written by people who work for hardware companies who think only
> about exploiting the hardware features they sell.  You all ignore the
> very real software overhedas of trying to manage millions of pages.
> I see a 6% reduction in kernel overhead when running kernbench using
> THPs that may go as large as 256kB.  On x86.  Intel x86, at that.

That's a really nice improvement. However then this code doesn't care
about it. Please make it possible to distinguish between THP on hardware
pages vs software pages.
