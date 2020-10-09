Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBDD2885C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbgJIJKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbgJIJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:10:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57DC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gu4C2Ll0mRf0xNrsEC7rJuJ4uSifjVCeUXfWf7zQKBk=; b=SoQCbFHJFvds9KMHjFMSqZK3YT
        lbw7FRD8CkHxp3wr7LIGBz65K4LXCAo6XJytG3QBGR4nOIJs2VmatpW4ZkJEYXQbuqIrDpLD7bFo1
        NJ/v9MWsyUmWA5m9PX5zLgwcPl8V7PI/WWhqCB+QE5QyewaAjdTzzdJMoE8gfZ5iSbDRtlMbtd+Tz
        WSa0E/kGne41puE7GZQQ3H0wnUQ6OqdNvqlcodzs+HmwzRXRtksU4sazdLtS0u5rS6CbrvJAV22lP
        sepDVRRRbmOiJ+UtRwvV8uTDnls0/83HwkGHR7E6qzosYZDvoa0/Bn0t6KsTPXsTXJ3rZHwXxHZ6x
        jAjCGeHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQoP8-0000He-0e; Fri, 09 Oct 2020 09:09:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7492430008D;
        Fri,  9 Oct 2020 11:09:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6E1C20DB441C; Fri,  9 Oct 2020 11:09:27 +0200 (CEST)
Date:   Fri, 9 Oct 2020 11:09:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Will Deacon <will@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001135749.2804-2-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 06:57:46AM -0700, kan.liang@linux.intel.com wrote:
> +/*
> + * Return the MMU page size of a given virtual address
> + */
> +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	pgd = pgd_offset(mm, addr);
> +	if (pgd_none(*pgd))
> +		return 0;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (!p4d_present(*p4d))
> +		return 0;
> +
> +	if (p4d_leaf(*p4d))
> +		return 1ULL << P4D_SHIFT;
> +
> +	pud = pud_offset(p4d, addr);
> +	if (!pud_present(*pud))
> +		return 0;
> +
> +	if (pud_leaf(*pud))
> +		return 1ULL << PUD_SHIFT;
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (!pmd_present(*pmd))
> +		return 0;
> +
> +	if (pmd_leaf(*pmd))
> +		return 1ULL << PMD_SHIFT;
> +
> +	pte = pte_offset_map(pmd, addr);
> +	if (!pte_present(*pte)) {
> +		pte_unmap(pte);
> +		return 0;
> +	}
> +
> +	pte_unmap(pte);
> +	return PAGE_SIZE;
> +}

So this mostly works, but gets a number of hugetlb and arch specific
things wrong.

With the first 3 patches, this is only exposed to x86 and Power.
Michael, does the above work for you?

Looking at:

arch/powerpc/include/asm/book3s/64/hugetlb.h:check_and_get_huge_psize()

You seem to limit yourself to page-table sizes, however if I then look
at the same function in:

arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
arch/powerpc/include/asm/nohash/hugetlb-book3e.h

it doesn't seem to constrain itself so.

Patch 4 makes it all far worse by exposing it to pretty much everybody.

Now, I think we can fix at least the user mappings with the below delta,
but if archs are using non-page-table MMU sizes we'll need arch helpers.

ARM64 is in that last boat.

Will, can you live with the below, if not, what would you like to do,
make the entire function __weak so that you can override it, or hook
into it somewhere?

DaveM, I saw Sparc64 also has 'funny' hugetlb sizes. Are those only for
hugetlb, or are you also using them for the kernel map?

(we might not need the #ifdef gunk, but I've not yet dug out my cross
 compilers this morning)

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7009,6 +7009,7 @@ static u64 perf_virt_to_phys(u64 virt)
  */
 static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 {
+	struct page *page;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -7030,15 +7031,27 @@ static u64 __perf_get_page_size(struct m
 	if (!pud_present(*pud))
 		return 0;
 
-	if (pud_leaf(*pud))
+	if (pud_leaf(*pud)) {
+#ifdef pud_page
+		page = pud_page(*pud);
+		if (PageHuge(page))
+			return page_size(compound_head(page));
+#endif
 		return 1ULL << PUD_SHIFT;
+	}
 
 	pmd = pmd_offset(pud, addr);
 	if (!pmd_present(*pmd))
 		return 0;
 
-	if (pmd_leaf(*pmd))
+	if (pmd_leaf(*pmd)) {
+#ifdef pmd_page
+		page = pmd_page(*pmd);
+		if (PageHuge(page))
+			return page_size(compound_head(page));
+#endif
 		return 1ULL << PMD_SHIFT;
+	}
 
 	pte = pte_offset_map(pmd, addr);
 	if (!pte_present(*pte)) {
@@ -7046,6 +7059,10 @@ static u64 __perf_get_page_size(struct m
 		return 0;
 	}
 
+	page = pte_page(*pte);
+	if (PageHuge(page))
+		return page_size(compound_head(page));
+
 	pte_unmap(pte);
 	return PAGE_SIZE;
 }
