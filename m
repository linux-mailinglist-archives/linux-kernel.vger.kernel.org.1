Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7FE27B3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgI1SCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:51 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42055 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1A2C8E9C;
        Mon, 28 Sep 2020 13:55:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=UVh0VnweyeEVQ
        +rLxzGuT0SDw8Id+iKtTujnmk1NI3o=; b=Yb7AuBe8LHothHCDCimJ8qPdzQi1S
        quLpm9keAzZDYTfqU54E4JCS5ZdmrkneT+HXaj9O3ILJZOHlXT9lLTJkSANrmNQu
        TFqu45k1gOhrNAhusDgnzexJKLvbhDG9GnVaDh+MdBy/7o0TEvEdIzfY6hvgw17t
        YSLVjFGFoi5tVcYX07TTiwlL1KVR6qpsL1+KPS1wJvu8X/zRh9RMct36aye+jIig
        RrO09bYeL7o0QmUlCCdIoEJqnE+uFiaSAQiIVbtO13lbDXM5yKuW0gIoHraCf8AA
        CSMCk0U/36t09FVtE/rkjJXU1IV75lZJ+xqRvrHUAil8PHgm20OVd9T6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=UVh0VnweyeEVQ+rLxzGuT0SDw8Id+iKtTujnmk1NI3o=; b=oGnbxuPk
        CZH9J57gwO5uDt84xEjPgIu+70w0mWYzXKR/G/o0UnKJ8pNMLqKPkA+8460HJALA
        jbmeiQ9TUraNbS+IyBs8QqMNN7oVuHRUH4ESxCbWqnh7JIlNYhGRBLPvYmlgH3TF
        rKWtL0vkqeh8uLyP2xnkhFO9ZuvA+4H88wGpunfDeTKgCseCZN9sSa8PmUGMgOg1
        nDcGg6Ljd/zbASr1OXJG8lkiD34tdgI5my1qDTyOe5VRSYt6jLXvNEAAbBRHjXkU
        aMMD7LoRlxpmx2+BpfdQnnJWlek4131d0xmUTz/7VZxgnInZ48q2FNFyOyEZeiva
        qZo63V4nA7+CbA==
X-ME-Sender: <xms:jSNyX60piUOWE2PVhECEIPLxjeuAKRqSPviZSSQGhXbhLFmrL4H2FQ>
    <xme:jSNyX9FISrZ2AttZNtdZYkxx-M7AyvRV_D9x7lLOsdRYrQaHBr17niCO7Se2P2VZp
    3qrwQoLnEm4BtnclA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jSNyXy4fGbHnHtRzFPpLwFqD3eJqvF9s4JPg3CkSIAntDpCRZc0WLw>
    <xmx:jSNyX70GAeGsoyn03xBSILq91eASL1V1HYSIt9N9Vej__z3TsEDuLA>
    <xmx:jSNyX9Fw_REC-beKDalbVc07udZEKGP8StvUj-YMfpHNbK3GC0j20Q>
    <xmx:jSNyX6dT5IuknOMpTkhk8nal4AQWBudgUyTa-gs7SG0LjtttLI1JzxqO4AA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E2A9306468C;
        Mon, 28 Sep 2020 13:55:25 -0400 (EDT)
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
Subject: [RFC PATCH v2 20/30] mm: page_vma_walk: teach it about PMD-mapped PUD THP.
Date:   Mon, 28 Sep 2020 13:54:18 -0400
Message-Id: <20200928175428.4110504-21-zi.yan@sent.com>
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

We now have PMD-mapped PUD THP and PTE-mapped PUD THP, page_vma_walk
should handle them properly.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_vma_mapped.c | 152 +++++++++++++++++++++++++++++++++----------
 1 file changed, 118 insertions(+), 34 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f88e845ad5e6..5a3c1b561ff5 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -7,6 +7,12 @@
 
 #include "internal.h"
 
+enum check_pmd_result {
+	PVM_NOT_MAPPED = 0,
+	PVM_LEAF_ENTRY,
+	PVM_NONLEAF_ENTRY,
+};
+
 static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 {
 	page_vma_mapped_walk_done(pvmw);
@@ -52,6 +58,22 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 	return true;
 }
 
+static bool map_pmd(struct page_vma_mapped_walk *pvmw)
+{
+	pmd_t pmde;
+
+	pvmw->pmd = pmd_offset(pvmw->pud, pvmw->address);
+	pmde = READ_ONCE(*pvmw->pmd);
+	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		pvmw->ptl = pmd_lock(pvmw->vma->vm_mm, pvmw->pmd);
+		return true;
+	} else if (!pmd_present(pmde))
+		return false;
+
+	pvmw->ptl = pmd_lock(pvmw->vma->vm_mm, pvmw->pmd);
+	return true;
+}
+
 static inline bool pfn_is_match(struct page *page, unsigned long pfn)
 {
 	unsigned long page_pfn = page_to_pfn(page);
@@ -115,6 +137,57 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 	return pfn_is_match(pvmw->page, pfn);
 }
 
+/**
+ * check_pmd - check if @pvmw->page is mapped at the @pvmw->pmd
+ *
+ * page_vma_mapped_walk() found a place where @pvmw->page is *potentially*
+ * mapped. check_pmd() has to validate this.
+ *
+ * @pvmw->pmd may point to empty PMD, migraiton PMD, PMD pointing to arbitrary
+ * huge page, or PMD pointing to a PTE page table page.
+ *
+ * If PVMW_MIGRATION flag is set, returns PVM_LEAF_ENTRY if @pvmw->pmd contains
+ * migration entry that points to @pvmw->page.
+ *
+ * If PVMW_MIGRATION flag is not set, returns PVM_LEAF_ENTRY if @pvmw->pmd
+ * points to @pvmw->page.
+ *
+ * If @pvmw->pmd points to a PTE page table page, returns PVM_NONLEAF_ENTRY.
+ *
+ * Otherwise, return PVM_NOT_MAPPED.
+ *
+ */
+static enum check_pmd_result check_pmd(struct page_vma_mapped_walk *pvmw)
+{
+	unsigned long pfn;
+
+	if (likely(pmd_trans_huge(*pvmw->pmd))) {
+		if (pvmw->flags & PVMW_MIGRATION)
+			return 0;
+		pfn = pmd_pfn(*pvmw->pmd);
+		if (!pfn_is_match(pvmw->page, pfn))
+			return PVM_NOT_MAPPED;
+		return PVM_LEAF_ENTRY;
+	} else if (!pmd_present(*pvmw->pmd)) {
+		if (thp_migration_supported()) {
+			if (!(pvmw->flags & PVMW_MIGRATION))
+				return 0;
+			if (is_migration_entry(pmd_to_swp_entry(*pvmw->pmd))) {
+				swp_entry_t entry = pmd_to_swp_entry(*pvmw->pmd);
+
+				pfn = migration_entry_to_pfn(entry);
+				if (!pfn_is_match(pvmw->page, pfn))
+					return PVM_NOT_MAPPED;
+				return PVM_LEAF_ENTRY;
+			}
+		}
+		return 0;
+	}
+	/* THP pmd was split under us: handle on pte level */
+	spin_unlock(pvmw->ptl);
+	pvmw->ptl = NULL;
+	return PVM_NONLEAF_ENTRY;
+}
 /**
  * page_vma_mapped_walk - check if @pvmw->page is mapped in @pvmw->vma at
  * @pvmw->address
@@ -146,14 +219,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t pude;
-	pmd_t pmde;
+	enum check_pmd_result pmd_check_res;
 
 	if (!pvmw->pte && !pvmw->pmd && pvmw->pud)
 		return not_found(pvmw);
 
 	/* The only possible pmd mapping has been handled on last iteration */
 	if (pvmw->pmd && !pvmw->pte)
-		return not_found(pvmw);
+		goto next_pmd;
 
 	if (pvmw->pte)
 		goto next_pte;
@@ -202,42 +275,47 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	} else if (!pud_present(pude))
 		return false;
 
-	pvmw->pmd = pmd_offset(pvmw->pud, pvmw->address);
-	/*
-	 * Make sure the pmd value isn't cached in a register by the
-	 * compiler and used as a stale value after we've observed a
-	 * subsequent update.
-	 */
-	pmde = READ_ONCE(*pvmw->pmd);
-	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
-		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-		if (likely(pmd_trans_huge(*pvmw->pmd))) {
-			if (pvmw->flags & PVMW_MIGRATION)
-				return not_found(pvmw);
-			if (pmd_page(*pvmw->pmd) != page)
-				return not_found(pvmw);
+	if (!map_pmd(pvmw))
+		goto next_pmd;
+	/* pmd locked after map_pmd  */
+	while (1) {
+		pmd_check_res = check_pmd(pvmw);
+		if (pmd_check_res == PVM_LEAF_ENTRY)
 			return true;
-		} else if (!pmd_present(*pvmw->pmd)) {
-			if (thp_migration_supported()) {
-				if (!(pvmw->flags & PVMW_MIGRATION))
-					return not_found(pvmw);
-				if (is_migration_entry(pmd_to_swp_entry(*pvmw->pmd))) {
-					swp_entry_t entry = pmd_to_swp_entry(*pvmw->pmd);
-
-					if (migration_entry_to_page(entry) != page)
-						return not_found(pvmw);
-					return true;
+		else if (pmd_check_res == PVM_NONLEAF_ENTRY)
+			goto pte_level;
+next_pmd:
+		/* Only PMD-mapped PUD THP has next pmd. */
+		if (!(PageTransHuge(pvmw->page) && compound_order(pvmw->page) == HPAGE_PUD_ORDER))
+			return not_found(pvmw);
+		do {
+			pvmw->address += HPAGE_PMD_SIZE;
+			if (pvmw->address >= pvmw->vma->vm_end ||
+			    pvmw->address >=
+					__vma_address(pvmw->page, pvmw->vma) +
+					thp_nr_pages(pvmw->page) * PAGE_SIZE)
+				return not_found(pvmw);
+			/* Did we cross page table boundary? */
+			if (pvmw->address % PUD_SIZE == 0) {
+				/*
+				 * Reset pmd here, so we will no stay at PMD
+				 * level after restart.
+				 */
+				pvmw->pmd = NULL;
+				if (pvmw->ptl) {
+					spin_unlock(pvmw->ptl);
+					pvmw->ptl = NULL;
 				}
+				goto restart;
+			} else {
+				pvmw->pmd++;
 			}
-			return not_found(pvmw);
-		} else {
-			/* THP pmd was split under us: handle on pte level */
-			spin_unlock(pvmw->ptl);
-			pvmw->ptl = NULL;
-		}
-	} else if (!pmd_present(pmde)) {
-		return false;
+		} while (pmd_none(*pvmw->pmd));
+
+		if (!pvmw->ptl)
+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 	}
+pte_level:
 	if (!map_pte(pvmw))
 		goto next_pte;
 	while (1) {
@@ -257,6 +335,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			/* Did we cross page table boundary? */
 			if (pvmw->address % PMD_SIZE == 0) {
 				pte_unmap(pvmw->pte);
+				/*
+				 * In the case of PTE-mapped PUD THP, next entry
+				 * can be PMD. Reset pte here, so we will not
+				 * stay at PTE level after restart.
+				 */
+				pvmw->pte = NULL;
 				if (pvmw->ptl) {
 					spin_unlock(pvmw->ptl);
 					pvmw->ptl = NULL;
-- 
2.28.0

