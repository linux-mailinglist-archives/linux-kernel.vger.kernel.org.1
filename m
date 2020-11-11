Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C682AF115
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgKKMob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKMoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:44:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DEC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 04:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6tLGLpk1EezWZwtwUC8VAuKl13a1TQOC6LFMQf+zejg=; b=moyXqW+upZidbk4p/nGEeku4bp
        EJ774Vg9KfGW5BWbjA7puJv9vzEPUgM6yJabRuKv+zO21a92tmwJeiVz+6b8kqUikxpBVGvn2O9gO
        oZXyq/Wma2LEfxxqfWZhz30doBdXoqwSB6lcNui8ejcLKdPUUSZN4r8yWG1BnFEzIfvMz9XuCsAFr
        kZ/HuMuJ2x+U1SNBw7l9BohJyCNAyCb+ORHQajutXr5CBIQINiXkvRutUMOxJC7Z1EmubZPiRIEnl
        y5g5kUkN9f+FWx3nbutTbublHeRIXnvsvKpsA5rk+fMG5MaeyQIK3exZsSzn9dz0XhDwZpjbkM7oc
        T32pGW7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcpTl-0003SN-Hc; Wed, 11 Nov 2020 12:44:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 079DB301324;
        Wed, 11 Nov 2020 13:43:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8F912025CA2B; Wed, 11 Nov 2020 13:43:57 +0100 (CET)
Date:   Wed, 11 Nov 2020 13:43:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>, vbabka@suse.cz,
        willy@infradead.org
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201111124357.GS2651@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au>
 <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111112246.GR2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 12:22:46PM +0100, Peter Zijlstra wrote:

> Trying to match the Code: to PageHuge as generate here makes this the
> PageCompound() test burning, not even compound_head() going bad.
> 
> must ponder more...

Oooh.. does this help?

---
 kernel/events/core.c | 81 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d2f3ca792936..3b42576c99f1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7015,65 +7015,82 @@ static u64 perf_virt_to_phys(u64 virt)
  */
 __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 {
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 	struct page *page;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset(mm, addr);
-	if (pgd_none(*pgd))
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep, pte;
+
+	pgdp = pgd_offset(mm, addr);
+	pgd = READ_ONCE(*pgdp);
+	if (pgd_none(pgd))
 		return 0;
 
-	p4d = p4d_offset(pgd, addr);
-	if (!p4d_present(*p4d))
+	p4dp = p4d_offset(&pgd, addr);
+	p4d = READ_ONCE(*p4dp);
+	if (!p4d_present(p4d))
 		return 0;
 
-	if (p4d_leaf(*p4d))
+	if (p4d_leaf(p4d))
 		return 1ULL << P4D_SHIFT;
 
-	pud = pud_offset(p4d, addr);
-	if (!pud_present(*pud))
+	pudp = pud_offset(&p4d, addr);
+	pud = READ_ONCE(*pudp);
+	if (!pud_present(pud))
 		return 0;
 
-	if (pud_leaf(*pud)) {
+	if (pud_leaf(pud)) {
 #ifdef pud_page
-		page = pud_page(*pud);
-		if (PageHuge(page))
-			return page_size(compound_head(page));
+		if (!pud_devmap(pud)) {
+			page = pud_page(pud);
+			if (PageHuge(page))
+				return page_size(compound_head(page));
+		}
 #endif
 		return 1ULL << PUD_SHIFT;
 	}
 
-	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
+	pmdp = pmd_offset(&pud, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (!pmd_present(pmd))
 		return 0;
 
-	if (pmd_leaf(*pmd)) {
+	if (pmd_leaf(pmd)) {
 #ifdef pmd_page
-		page = pmd_page(*pmd);
-		if (PageHuge(page))
-			return page_size(compound_head(page));
+		if (!pmd_devmap(pmd)) {
+			page = pmd_page(pmd);
+			if (PageHuge(page))
+				return page_size(compound_head(page));
+		}
 #endif
 		return 1ULL << PMD_SHIFT;
 	}
 
-	pte = pte_offset_map(pmd, addr);
-	if (!pte_present(*pte)) {
-		pte_unmap(pte);
+	ptep = pte_offset_map(&pmd, addr);
+	pte = READ_ONCE(*ptep); // gup_get_pte()
+	if (!pte_present(pte)) {
+		pte_unmap(ptep);
 		return 0;
 	}
 
-	page = pte_page(*pte);
-	if (PageHuge(page)) {
-		u64 size = page_size(compound_head(page));
-		pte_unmap(pte);
-		return size;
+	if (!pte_devmap(pte) && !pte_special(pte)) {
+		page = pte_page(pte);
+		if (PageHuge(page)) {
+			u64 size = page_size(compound_head(page));
+			pte_unmap(ptep);
+			return size;
+		}
 	}
 
-	pte_unmap(pte);
+	pte_unmap(ptep);
 	return PAGE_SIZE;
+
+#else /* CONFIG_ARCH_HAS_PTE_SPECIAL */
+
+	return 0;
+#endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 }
 
 #else
