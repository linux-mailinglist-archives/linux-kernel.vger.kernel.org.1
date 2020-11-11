Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FABF2AF751
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgKKRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKKRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:23:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A492C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3F71YuHSzycH8kru8FWlRGlBynr9f/xVQKlAzH9f6kc=; b=LQ3pFkuz9JlRO+luUEY5BhpzBh
        sKNxwR/+OY35sexxmAn6DxjUEUVQtoN1S4phD+sggCsz3UbHbkNDs8S5BTVJOLeAxyNIc9Xu71U4w
        GtIIV0G8IJEt4Qt03f//anIiZbQSxtXI5tYpZVx9uaa9uj3so7dK1QdukZeEG1DC0hbc33oggwsnn
        lvzZq3MG+5a9PV3AAtlUP7Ms+NoL6sgoVELV99p50IJHa5p/VLXBU2nCfSLxT1oaSsFLoxwV1t8RP
        ZzqJv10uYbz9MRS6wPoGmcQKPlChYQ2UNVcaeX94/RWjfEAZ9KOYP9G6QQOFD/F7ChjMMKejnFIbB
        fhT4CliQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kctph-0004iS-IY; Wed, 11 Nov 2020 17:22:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC095301E02;
        Wed, 11 Nov 2020 18:22:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8AF28203E65DE; Wed, 11 Nov 2020 18:22:53 +0100 (CET)
Date:   Wed, 11 Nov 2020 18:22:53 +0100
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
Message-ID: <20201111172253.GG2628@hirez.programming.kicks-ass.net>
References: <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
 <20201111124357.GS2651@hirez.programming.kicks-ass.net>
 <20201111153022.GT17076@casper.infradead.org>
 <20201111155724.GE2628@hirez.programming.kicks-ass.net>
 <20201111163848.GU17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111163848.GU17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 04:38:48PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 11, 2020 at 04:57:24PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 11, 2020 at 03:30:22PM +0000, Matthew Wilcox wrote:
> > > This confuses me.  Why only special-case hugetlbfs pages here?  Should
> > > they really be treated differently from THP?  If you want to consider
> > > that we might be mapping a page that's twice as big as a PUD entry and
> > > this is only half of it, then the simple way is:
> > > 
> > > 	if (pud_leaf(pud)) {
> > > #ifdef pud_page
> > > 		page = compound_head(pud_page(*pud));
> > > 		return page_size(page);
> > 
> > Also; this is 'wrong'. The purpose of this function is to return the
> > hardware TLB size of a given address. The above will return the compound
> > size, for any random compound page, which would be myrads of reasons.
> 
> Oh, then the whole thing is overly-complicated.  This should just be
> 
> 	if (pud_leaf(pud))
> 		return PUD_SIZE;

But that doesn't handle non-pagetable aligned hugetlb sizes. Granted,
that's unlikely at the PUD level, but why be inconsistent..

So we really want:

	if (p*d_leaf(p*d)) {
		if (!'special') {
			page = p*d_page(p*d);
			if (PageHuge(page))
				return page_size(compound_head(page));
		}
		return P*D_SIZE;
	}

That gets us:

  - regular page-table aligned large-pages
  - 'funny' hugetlb sizes

The only thing it doesn't gets us is kernel usage of 'funny' sizes,
which is why that function is weak (arm64, power32, sparc64 have funny
sizes and at the very least arm64 uses them for kernel mappings too).

Now, when you add !PMD THP sizes (presumably for architectures that have
'funny' sizes, otherwise what's the point), then you get to add '||
PageTransHuge()' to the above PageHuge() (and fix PageTransHuge() to
actually do what it claims it does).

Arguably we could fix arm64 with something like the below, but then, I'd
have to audit powerpc32 and sparc64 again to see if I can make that work
for them too -- not today.

---

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7003,6 +7003,10 @@ static u64 perf_virt_to_phys(u64 virt)
 
 #ifdef CONFIG_MMU
 
+#ifndef pte_cont
+#define pte_cont(pte)	(false)
+#endif
+
 /*
  * Return the MMU page size of a given virtual address.
  *
@@ -7077,7 +7081,7 @@ __weak u64 arch_perf_get_page_size(struc
 
 	if (!pte_devmap(pte) && !pte_special(pte)) {
 		page = pte_page(pte);
-		if (PageHuge(page)) {
+		if (PageHuge(page) || pte_cont(pte)) {
 			u64 size = page_size(compound_head(page));
 			pte_unmap(ptep);
 			return size;
