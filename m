Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0F2AEE49
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgKKJ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:58:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE00C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFOszazCU67aESPWKTY5JtrCm0f6NuulY6dzz0Vxtxo=; b=ejLdzUz5uwJo7psp++c0V8C84I
        k3mNTtvBLRveK+XpCZfJuEDtpO7yeLD/w8yxANrK9/ga/Eh3uLstjta3/agGWEJURuq90epMF45X3
        9Prw15qDdDyPYerGlWopg8B9XhF4FsTbQTa/Rb0JqwE/g8Oj4PgHX6GNzAZ+FpbbjN96RFPoL6Sa6
        7up1VO/HfURB0ASBm65dXwkiS7nIByy9Zjk/sRz87TK5ShUyJoSkoXxp6tfhOlAZ2Ifb/AfOU6iru
        GQec3JFjK+xJ+11lIS7NCf0Kek7IddJDQNrfXxC9FjKAYyTgfhoW5WBy9slk9Pr5ZIab4mu+E3QrR
        lwCiT9CQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcmt2-0000V6-0P; Wed, 11 Nov 2020 09:57:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCBDA301EE3;
        Wed, 11 Nov 2020 10:57:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFDA82C886BD7; Wed, 11 Nov 2020 10:57:50 +0100 (CET)
Date:   Wed, 11 Nov 2020 10:57:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201111095750.GS2594@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au>
 <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:11:16PM -0500, Liang, Kan wrote:
> On 10/13/2020 12:34 PM, Peter Zijlstra wrote:

> > @@ -7037,13 +7057,20 @@ static u64 __perf_get_page_size(struct m
> >   		return 0;
> >   	}
> > +	page = pte_page(*pte);
> > +	if (PageHuge(page)) {
> > +		u64 size = page_size(compound_head(page));
> > +		pte_unmap(pte);
> > +		return size;
> > +	}
> > +
> 
> The PageHuge() check for PTE crashes my machine when I did page size test.
> (Sorry, I didn't find the issue earlier. I just found some time to re-run
> the page size test.)
> 
> It seems we don't need the check for PTE here. The size should be always
> PAGE_SIZE, no? After I remove the check, everything looks good.

That's the thing, an architecture could have non-page-table aligned
huge-pages. For example using 4 consecutive 4k pages to create 16k
pages. In that case the above code would trigger and find a 16k compound
page with HUGETLB_PAGE_DTOR (assuming it was created through hugetlbfs).

What is this page size test; I'd like to reproduce.
