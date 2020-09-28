Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63C27B3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgI1SCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:06 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:52727 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 0E19EDAA;
        Mon, 28 Sep 2020 13:55:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=vrkxZJEQEBPuH
        CVbBAj+BQgl5osnBBmheesqLl7iLcM=; b=W2K3Us/8YRs4FcMLHPHb+2LU+kawc
        sMht8gZOYrUjngiiuCmcVI/au1+l3/EYEXw3ADll8FIpZr50bHD6fT5kBGhTN90l
        h6Tqs++h4vj9tTvdKPLg1TfXzfTSCNIH5/NXUbgUesqi7GsOK/20Ch/weCl8MgPk
        SEH2Pt47IGxrPxRVnrl0V1+Q3c8p0bQqHe3XBO5EW9yKJXCPodqurxUuDbVZ5kHz
        x08DV22ZFN29KYuOgQ8K+MpaI4R/aD03GWxayBDvQsD6KXUJ6xiaTyGi2B4zbw/b
        lakaxoyprrosbT1ytZfPWkquE9emOSg99oXwRUq3yUHoL5cTQ4ylCgM7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=vrkxZJEQEBPuHCVbBAj+BQgl5osnBBmheesqLl7iLcM=; b=fxrT9c03
        fdx0/UW/BNcBqstgRcX+vG7MroPZKqt75Q2/VImuzPwmVoM5LmQoF6bbmXCS46b/
        Qs2ALEaNwoY8XH+VOQ29WGP81TEs4+5eIgX3y80lZ/CMwBP0PZOurSzLl/nB6ESL
        mf6dqX8UNIOKsCnKnVXc9jUGmQTYy1BRu7qinJJrEYy7g22ujZC9Og2PvR3/HVq1
        r5BGm425X/7lD0LVnwBeD59D+Oe2q3ZvTkiT+EwIvieRDVSZOngAujlbg0ac+MG3
        pniuCoN1PO1xOjn3ZYTZeaUhCHpFGhZ0aG8lk1/Z19sY5uuUVCh5trbXHF79RyZw
        wr3E057cwSrbXg==
X-ME-Sender: <xms:iSNyX-FizKg7ljL6c0DUmCIJmzr5KMm4UBs1om91Z3Ww19IS3D-cHQ>
    <xme:iSNyX_VbPg0WCyISMLssVOCGGrXxZ8YOgKRbqQTSMi3sMZiydNr2vVQEWaF6SRH7W
    XLDCrOngBLoEj2HIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:iSNyX4KdZ93yJJKjXqAlfnP2XLtP2-AXqdZEi2v9JOOQEm1seRP-BA>
    <xmx:iSNyX4FIXJGHqRtlY1p5Uag7WFORRgtywzlHTVHBU0stM4p-bxYYAw>
    <xmx:iSNyX0WJnr5nQ4u11rn4TbT7bZSzZDdAia4T5m-d5YO-9Q4IJp6wFg>
    <xmx:iSNyX1tU7FAgzStFK-HOiwgEgtAKnoSJgl5sAm2txtvnAx5ts4o7m-r8-3U>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1EC933064685;
        Mon, 28 Sep 2020 13:55:21 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 09/30] mm: thp: add PUD THP support to zap_huge_pud.
Date:   Mon, 28 Sep 2020 13:54:07 -0400
Message-Id: <20200928175428.4110504-10-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Preallocated 513 (1 PMD and 512 PTE) page table pages need to be freed
when PUD THP is removed. zap_pud_deposited_table is added to perform the
action.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ea9fbedcda26..76069affebef 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2013,11 +2013,27 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static inline void zap_pud_deposited_table(struct mm_struct *mm, pud_t *pud)
+{
+	pgtable_t pgtable;
+	int i;
+
+	pgtable = pgtable_trans_huge_pud_withdraw(mm, pud);
+	pmd_free_page_with_ptes(mm, (pmd_t *)page_address(pgtable));
+
+	mm_dec_nr_pmds(mm);
+	for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++)
+		mm_dec_nr_ptes(mm);
+}
+
 int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
+	pud_t orig_pud;
 	spinlock_t *ptl;
 
+	tlb_change_page_size(tlb, HPAGE_PUD_SIZE);
+
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
 		return 0;
@@ -2027,14 +2043,40 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * pgtable_trans_huge_withdraw after finishing pudp related
 	 * operations.
 	 */
-	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
+	orig_pud = pudp_huge_get_and_clear_full(tlb->mm, addr, pud,
+			tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
 	if (vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
+	} else if (is_huge_zero_pud(orig_pud)) {
+		zap_pud_deposited_table(tlb->mm, pud);
+		spin_unlock(ptl);
+		tlb_remove_page_size(tlb, pud_page(orig_pud), HPAGE_PUD_SIZE);
 	} else {
-		/* No support for anonymous PUD pages yet */
-		BUG();
+		struct page *page = NULL;
+		int flush_needed = 1;
+
+		if (pud_present(orig_pud)) {
+			page = pud_page(orig_pud);
+			page_remove_rmap(page, true);
+			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
+			VM_BUG_ON_PAGE(!PageHead(page), page);
+		} else
+			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
+
+		if (PageAnon(page)) {
+			zap_pud_deposited_table(tlb->mm, pud);
+			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PUD_NR);
+		} else {
+			if (arch_needs_pgtable_deposit())
+				zap_pud_deposited_table(tlb->mm, pud);
+			add_mm_counter(tlb->mm, MM_FILEPAGES, -HPAGE_PUD_NR);
+		}
+
+		spin_unlock(ptl);
+		if (flush_needed)
+			tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
 	}
 	return 1;
 }
-- 
2.28.0

