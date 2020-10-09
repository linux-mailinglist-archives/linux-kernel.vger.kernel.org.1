Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596F328896D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbgJIM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbgJIM5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:57:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C8EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ciiPvaZqbMG6HZYHrOzAH/ReMGF4QzryMy+6/rRjM+c=; b=iSsDgTMEUOFovS146KsV64gqD5
        zZLF3ifegUuPfJUd+evyRTNCk5ATVgAtFcXtxVnnUrGE1kdpsKmfwX4r3OIVwHRqQkXVYgwoeDnSt
        80mymIk8b1YI6CyW8XZms+ugTBgtVuliwpL+33SIXdY8V+1A5jF25mSKn3I1SSEj1pDVk1ni8/3Ph
        Gzk7vU+fBarpAJGYhoUinPl2eichy5kxvRyk9LB3q2tHNJD2UB0qIKxPfy/zgSQUoROwnE1V6rDKB
        /ZEFwTqX7DeY+y/4XS0ijID61ZXWtBOxNBiLJwiO7TdcHM7LfFXSLvkY8GDTAqt7HPy6St3p8V48j
        y6TMOBoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQrxd-0001Pm-Bp; Fri, 09 Oct 2020 12:57:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92C213019CE;
        Fri,  9 Oct 2020 14:57:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BB182B856EA8; Fri,  9 Oct 2020 14:57:21 +0200 (CEST)
Date:   Fri, 9 Oct 2020 14:57:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Will Deacon <will@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201009125721.GO2628@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <a184fa36-a25d-cc7f-57b7-a1cf278b5465@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a184fa36-a25d-cc7f-57b7-a1cf278b5465@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 08:29:25AM -0400, Liang, Kan wrote:
> 
> 
> On 10/9/2020 5:09 AM, Peter Zijlstra wrote:
> > (we might not need the #ifdef gunk, but I've not yet dug out my cross
> >   compilers this morning)
> > 
> > ---
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7009,6 +7009,7 @@ static u64 perf_virt_to_phys(u64 virt)
> >    */
> >   static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> >   {
> > +	struct page *page;
> >   	pgd_t *pgd;
> >   	p4d_t *p4d;
> >   	pud_t *pud;
> > @@ -7030,15 +7031,27 @@ static u64 __perf_get_page_size(struct m
> >   	if (!pud_present(*pud))
> >   		return 0;
> > -	if (pud_leaf(*pud))
> > +	if (pud_leaf(*pud)) {
> > +#ifdef pud_page
> > +		page = pud_page(*pud);
> > +		if (PageHuge(page))
> > +			return page_size(compound_head(page));
> 
> I think the page_size() returns the Kernel Page Size of a compound page.
> What we want is the MMU page size.
> 
> If it's for the generic code, I think it should be a problem for X86.

See the PageHuge() condition before it. It only makes sense to provide a
hugetlb page-size if the actual hardware supports it.

For x86 hugetlb only supports PMD and PUD sized pages, so the added code
is pointless and should result in identical behaviour.

For architectures that have hugetlb page sizes that do not align with
the page-table levels (arm64, sparc64 and possibly power) this will
(hopefully) give the right number.

