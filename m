Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FDC2AF6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgKKQjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgKKQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:39:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83433C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fQYZt5U9dNGVW/jFVMV2DnqgQdqA/K9jcjiiRpZxmR8=; b=VDHv5PgOMsYSGeXf8irdYrEmir
        1yiAv1bL/Rt+0SyCOZRyzZMlucKLyzTePZoF2+w6KHzuuwkC1mg3ZiWf/++i6uBrM7rRXt2/miJOO
        joavkvGIxqT0/5WePnKXjzYj/pJsvNgn6f2l7d+FcUXNqy/+bfCQOhAMb7VE42Ytl9gc2ejJ0cJkW
        adcF3kIncWHqQgIAHmGMqtxcnsWJWcuWRZglV4ZTQFPvwk/grTEfKVSH5LkoOhFNMSxwdTFzktzYr
        BJ9+MmfdxChOqul/3fzoWDNEMV8w9lEg5wiZiOAIR07EXtB06M0oeXOxBuXl+hA8YKmfDrCWvRqir
        HbHnXhLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kct8z-0001pt-0n; Wed, 11 Nov 2020 16:38:49 +0000
Date:   Wed, 11 Nov 2020 16:38:48 +0000
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
Message-ID: <20201111163848.GU17076@casper.infradead.org>
References: <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
 <20201111124357.GS2651@hirez.programming.kicks-ass.net>
 <20201111153022.GT17076@casper.infradead.org>
 <20201111155724.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111155724.GE2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 04:57:24PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 03:30:22PM +0000, Matthew Wilcox wrote:
> > This confuses me.  Why only special-case hugetlbfs pages here?  Should
> > they really be treated differently from THP?  If you want to consider
> > that we might be mapping a page that's twice as big as a PUD entry and
> > this is only half of it, then the simple way is:
> > 
> > 	if (pud_leaf(pud)) {
> > #ifdef pud_page
> > 		page = compound_head(pud_page(*pud));
> > 		return page_size(page);
> 
> Also; this is 'wrong'. The purpose of this function is to return the
> hardware TLB size of a given address. The above will return the compound
> size, for any random compound page, which would be myrads of reasons.

Oh, then the whole thing is overly-complicated.  This should just be

	if (pud_leaf(pud))
		return PUD_SIZE;

