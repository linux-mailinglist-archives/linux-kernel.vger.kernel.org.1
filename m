Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC728D251
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgJMQfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJMQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:35:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55D4C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xfu/ebxb/UYFOqqMbLllxczv7MOxN3Wzob0VED+pAio=; b=ol0BDvd3j4XzUMB99fNnsM+D1G
        n9jFecDUIF0qzgjbGPuuSQG6Wt1gfZU8wP1bkuxaVavH9h3QObC5YLkwd8HqA5M7TLi9gBRO4jU5z
        ZNlICrQqF2RFJgBGM0pYGsGqpGwgx65c5y2HM9Oh/uhMkssBu6Kmjatp9/ZBKViWgAtMCXiI2jAfK
        Uq7MEv3poSFC3WAlNJXMrw6QdGEhooaPgelwjS0cNMRzObqTTz6aU+NbQQvm7QFnhkqzkut0sdOIx
        8XmewLrtpiQI3LHwTaliIfoefZ5QPR0ZUnX6ZZRL40qGhhqOck3s1PdHKjo4D3FoqTnRMmgoAtVdR
        dmApB3HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSNGG-0005Hv-IT; Tue, 13 Oct 2020 16:34:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93E14304B90;
        Tue, 13 Oct 2020 18:34:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A07E203CD911; Tue, 13 Oct 2020 18:34:49 +0200 (CEST)
Date:   Tue, 13 Oct 2020 18:34:49 +0200
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
Message-ID: <20201013163449.GR2651@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au>
 <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013154615.GE2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 05:46:15PM +0200, Peter Zijlstra wrote:
> Nah, that generic function, should work for 90% of all archs, it's just
> a few oddballs that need something else.
> 
> Also, if we add that hugetlb exception, we'll even get the usermap for
> those oddballs right.
> 
> I'll take this version after the merge window, I'll add __weak for the
> oddballs and also add the hugetlb userspace thing on top.

Like so.. 

---
Subject: perf,mm: Handle non-page-table-aligned hugetlbfs
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 9 Oct 2020 11:09:27 +0200

A limited nunmber of architectures support hugetlbfs sizes that do not
align with the page-tables (ARM64, Power, Sparc64). Add support for
this to the generic perf_get_page_size() implementation, and also
allow an architecture to override this implementation.

This latter is only needed when it uses non-page-table aligned huge
pages in its kernel map.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6996,10 +6996,18 @@ static u64 perf_virt_to_phys(u64 virt)
 #ifdef CONFIG_MMU
 
 /*
- * Return the MMU page size of a given virtual address
+ * Return the MMU page size of a given virtual address.
+ *
+ * This generic implementation handles page-table aligned huge pages, as well
+ * as non-page-table aligned hugetlbfs compound pages.
+ *
+ * If an architecture supports and uses non-page-table aligned pages in their
+ * kernel mapping it will need to provide it's own implementation of this
+ * function.
  */
-static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+__weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 {
+	struct page *page;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -7021,15 +7029,27 @@ static u64 __perf_get_page_size(struct m
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
@@ -7037,13 +7057,20 @@ static u64 __perf_get_page_size(struct m
 		return 0;
 	}
 
+	page = pte_page(*pte);
+	if (PageHuge(page)) {
+		u64 size = page_size(compound_head(page));
+		pte_unmap(pte);
+		return size;
+	}
+
 	pte_unmap(pte);
 	return PAGE_SIZE;
 }
 
 #else
 
-static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+static u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 {
 	return 0;
 }
@@ -7074,7 +7101,7 @@ static u64 perf_get_page_size(unsigned l
 		mm = &init_mm;
 	}
 
-	size = __perf_get_page_size(mm, addr);
+	size = arch_perf_get_page_size(mm, addr);
 
 	local_irq_restore(flags);
 
