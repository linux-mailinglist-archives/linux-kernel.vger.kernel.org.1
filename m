Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51F62AF4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKKPas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKKPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:30:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465CC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vxADKWsfDNlkWbQuA/V8yobZQ2kcfLFZo+4tJJGDR2s=; b=qycWmBJWdG4hYAYqpFqRTViuwU
        TUQ3ZQ/Owu6LcQauB0uqD2g/hE42gR/abd8NRjbICVnJvwhwCAJTyzIdyj+2cBhVaPAq4goXf6UkS
        c4W12C7kEieH28W+3lI68PR72I9Q03pzqs4qoAlQHqzWp0hXDnTbjfZN7oKL2O4Feq3eQLetlFtvX
        cabS1K0nR3ZvDxn6RU+UUs2pzo0dn5BR2u+GsfMi8+x4mlHsiCVnCGMNhXdD7Nz27SpJo/C8kPBul
        8rqof+mDCJQkxCkXxhVQmYzGo/GHHwbeGgLjwVRFDEQJulI9g19Vy3cZhfGshvhNLOJcflK2iwsrZ
        qUsXGqIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcs4k-0005b7-RU; Wed, 11 Nov 2020 15:30:22 +0000
Date:   Wed, 11 Nov 2020 15:30:22 +0000
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
Message-ID: <20201111153022.GT17076@casper.infradead.org>
References: <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au>
 <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
 <20201111124357.GS2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111124357.GS2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 01:43:57PM +0100, Peter Zijlstra wrote:
> +	if (pud_leaf(pud)) {
>  #ifdef pud_page
> -		page = pud_page(*pud);
> -		if (PageHuge(page))
> -			return page_size(compound_head(page));
> +		if (!pud_devmap(pud)) {
> +			page = pud_page(pud);
> +			if (PageHuge(page))
> +				return page_size(compound_head(page));
> +		}
>  #endif
>  		return 1ULL << PUD_SHIFT;

This confuses me.  Why only special-case hugetlbfs pages here?  Should
they really be treated differently from THP?  If you want to consider
that we might be mapping a page that's twice as big as a PUD entry and
this is only half of it, then the simple way is:

	if (pud_leaf(pud)) {
#ifdef pud_page
		page = compound_head(pud_page(*pud));
		return page_size(page);
#else
		return 1ULL << PUD_SHIFT;
#endif
	}

Also, what's up with the special-casing of devmap pages here?  Did the
devmap people fuck up their compound pages?  If so, they should fix their
shit, not expect the rest of the kernel to work around this brokenness.

