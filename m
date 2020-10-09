Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73B288606
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbgJIJh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733111AbgJIJh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:37:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB15F22258;
        Fri,  9 Oct 2020 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602236277;
        bh=qKDWHZKc2QllAAp0MK7WBMA0uqYrzQj6Jk2nI8Ea0pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrhMPzARymQIZS5n3bb1V7YpdIkjja0LwIcZZFkdfCzI2Nio04DHrCOY0mCS1zXkv
         5PvY+yhh5938AoR0j/ZaQzY03WcMv9Rg0Q6Wb/8kRVmyZf5u+B2aTP3B8zGCCCXt5l
         mcNbBQdWw2vhC2U+Cw+DW1JoyhnjPCkZ2OzOJDFo=
Date:   Fri, 9 Oct 2020 10:37:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201009093750.GD29594@willie-the-truck>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:09:27AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 01, 2020 at 06:57:46AM -0700, kan.liang@linux.intel.com wrote:
> > +/*
> > + * Return the MMU page size of a given virtual address
> > + */
> > +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> > +{
> > +	pgd_t *pgd;
> > +	p4d_t *p4d;
> > +	pud_t *pud;
> > +	pmd_t *pmd;
> > +	pte_t *pte;
> > +
> > +	pgd = pgd_offset(mm, addr);
> > +	if (pgd_none(*pgd))
> > +		return 0;
> > +
> > +	p4d = p4d_offset(pgd, addr);
> > +	if (!p4d_present(*p4d))
> > +		return 0;
> > +
> > +	if (p4d_leaf(*p4d))
> > +		return 1ULL << P4D_SHIFT;
> > +
> > +	pud = pud_offset(p4d, addr);
> > +	if (!pud_present(*pud))
> > +		return 0;
> > +
> > +	if (pud_leaf(*pud))
> > +		return 1ULL << PUD_SHIFT;
> > +
> > +	pmd = pmd_offset(pud, addr);
> > +	if (!pmd_present(*pmd))
> > +		return 0;
> > +
> > +	if (pmd_leaf(*pmd))
> > +		return 1ULL << PMD_SHIFT;
> > +
> > +	pte = pte_offset_map(pmd, addr);
> > +	if (!pte_present(*pte)) {
> > +		pte_unmap(pte);
> > +		return 0;
> > +	}
> > +
> > +	pte_unmap(pte);
> > +	return PAGE_SIZE;
> > +}
> 
> So this mostly works, but gets a number of hugetlb and arch specific
> things wrong.
> 
> With the first 3 patches, this is only exposed to x86 and Power.
> Michael, does the above work for you?
> 
> Looking at:
> 
> arch/powerpc/include/asm/book3s/64/hugetlb.h:check_and_get_huge_psize()
> 
> You seem to limit yourself to page-table sizes, however if I then look
> at the same function in:
> 
> arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
> arch/powerpc/include/asm/nohash/hugetlb-book3e.h
> 
> it doesn't seem to constrain itself so.
> 
> Patch 4 makes it all far worse by exposing it to pretty much everybody.
> 
> Now, I think we can fix at least the user mappings with the below delta,
> but if archs are using non-page-table MMU sizes we'll need arch helpers.
> 
> ARM64 is in that last boat.
> 
> Will, can you live with the below, if not, what would you like to do,
> make the entire function __weak so that you can override it, or hook
> into it somewhere?

Hmm, so I don't think we currently have any PMUs that set 'data->addr'
on arm64, in which case maybe none of this currently matters for us.

However, I must admit that I couldn't figure out exactly what gets exposed
to userspace when the backend drivers don't look at the sample_type or
do anything with the addr field.

Will
