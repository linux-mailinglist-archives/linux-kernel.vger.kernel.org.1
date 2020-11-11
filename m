Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C5F2AF595
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgKKP5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgKKP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:57:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DDAC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MEGb7UN/dO8w705bNEi6IvOss6dkaZRvJn4WNx36WmY=; b=y1oq36mv4/DaS2Yne5QBRDix9j
        uamBCSMr9WbUrognsDgBn/0awKWpaULBT4pYPBo26ZpwfoAoX++sS8ulx+q7bLHZ692NwuRH6WkfW
        XxqNxVvNOJS2vCSHjklOr75jZvIFFN9dEiHVWkLInFeDyAj23PMy5zaKQktYNdPQKD0Z7IL8ovZG0
        +Je+4ipQ6odTaMRCasIfH/88uFrcFS59IbcrJ3HhFlhMSrHTzfO0TOimOilujwg6+Vg328O7i7Urp
        SVjK9qOyNU+gMR3PAkxz38cwSIX/5IuyqMBJcxa/HNBCsjbOi544DiDpDjkP3JhnxyOaYGWTSJqC5
        AXqCQQyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcsUw-0000RM-Ne; Wed, 11 Nov 2020 15:57:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93FFA301E02;
        Wed, 11 Nov 2020 16:57:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 803672B2E2BEE; Wed, 11 Nov 2020 16:57:24 +0100 (CET)
Date:   Wed, 11 Nov 2020 16:57:24 +0100
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
Message-ID: <20201111155724.GE2628@hirez.programming.kicks-ass.net>
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
> This confuses me.  Why only special-case hugetlbfs pages here?  Should
> they really be treated differently from THP?  If you want to consider
> that we might be mapping a page that's twice as big as a PUD entry and
> this is only half of it, then the simple way is:
> 
> 	if (pud_leaf(pud)) {
> #ifdef pud_page
> 		page = compound_head(pud_page(*pud));
> 		return page_size(page);

Also; this is 'wrong'. The purpose of this function is to return the
hardware TLB size of a given address. The above will return the compound
size, for any random compound page, which would be myrads of reasons.

So the PageHuge() thing tells us it is a HugeTLB page and those are
(barring hardware TLB promotion/demotion) guaranteed to reflect the
actual TLB size.

> #else
> 		return 1ULL << PUD_SHIFT;
> #endif
> 	}
