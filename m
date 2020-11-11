Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449192AF582
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgKKPxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgKKPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:53:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76791C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kZ5YcKTFMcR465R74Gyqi/DlPtSKpvKAV4f6sxMGVXU=; b=OX4k6n1vzR1aId7s02oxv5ueTE
        E6mlui1vu3Adnf+JIMqPZLfFfRLV+C+nXDf0GrPn5zeExqlvsJ6g5E3HmE2MWgi9on6PyFEHVQbuG
        9F4bDYj0Wqzy1dLxWSaKsppZ9KQLpIieJ1f3jMjXtOtAqezdTz2/0DVa0erKeHNSvpin4nCbx9nOq
        am2qCzLvOtfJyUkDDBTJXZEndktltTSXdKzXBYpksBIgOvy4GpzCrfGghN6N7y8/HUNfjRwEpMd1G
        V78ofDlUGWQEINAwPVd1pfDzI85Kyf8QYrXIqGneztniwbAnQVysS6FzTt+Pb8XCeSoJxc8ZvbdmK
        Joa+mfMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcsQX-00079c-TU; Wed, 11 Nov 2020 15:52:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0374A301E02;
        Wed, 11 Nov 2020 16:52:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3C5620A2A306; Wed, 11 Nov 2020 16:52:51 +0100 (CET)
Date:   Wed, 11 Nov 2020 16:52:51 +0100
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
Message-ID: <20201111155251.GD2628@hirez.programming.kicks-ass.net>
References: <877drz1qbc.fsf@mpe.ellerman.id.au>
 <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
 <20201111124357.GS2651@hirez.programming.kicks-ass.net>
 <20201111153022.GT17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111153022.GT17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 03:30:22PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 11, 2020 at 01:43:57PM +0100, Peter Zijlstra wrote:
> > +	if (pud_leaf(pud)) {
> >  #ifdef pud_page
> > -		page = pud_page(*pud);
> > -		if (PageHuge(page))
> > -			return page_size(compound_head(page));
> > +		if (!pud_devmap(pud)) {
> > +			page = pud_page(pud);
> > +			if (PageHuge(page))
> > +				return page_size(compound_head(page));
> > +		}
> >  #endif
> >  		return 1ULL << PUD_SHIFT;
> 
> This confuses me.  Why only special-case hugetlbfs pages here?  Should
> they really be treated differently from THP?

Do we have non-pagetable aligned THP ? I thought THP was always PUD
sized.

> If you want to consider that we might be mapping a page that's twice
> as big as a PUD entry and this is only half of it, then the simple way
> is:
> 
> 	if (pud_leaf(pud)) {
> #ifdef pud_page
> 		page = compound_head(pud_page(*pud));
> 		return page_size(page);
> #else
> 		return 1ULL << PUD_SHIFT;
> #endif
> 	}
> 
> Also, what's up with the special-casing of devmap pages here?  Did the
> devmap people fuck up their compound pages?  If so, they should fix their
> shit, not expect the rest of the kernel to work around this brokenness.

Well, the PTE code we have today (in tip/perf/core) is:

	pte = pte_offset_map(pmd, addr);
	if (!pte_present(*pte)) {
		pte_unmap(pte);
		return 0;
	}

	page = pte_page(*pte);
	if (PageHuge(page)) {
		u64 size = page_size(compound_head(page));
		pte_unmap(pte);
		return size;
	}

	pte_unmap(pte);
	return PAGE_SIZE;

and that's crashing in PageHuge()'s PageCompound() test. Clearly I
should be checking pte_special() here (as well as all the READ_ONCE()s I
added in the patch you just commented on). But I wasn't quite sure about
devmap and paranoia won.

You're saying devmap should be valid compound pages? Then I can remove
all that and only keep pte_special().
