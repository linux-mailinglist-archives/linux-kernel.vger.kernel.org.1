Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD01627B3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgI1SBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:39 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42055 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgI1SBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 657D2E1B;
        Mon, 28 Sep 2020 13:55:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=lIEkADkjiRgN2
        eBw4b52cvu6kArTIQoE8NgK2aLJwLE=; b=SEbbQmedG4QyLRc+5zepJmelkZpLP
        FcKJ2Qw1JpE2tZewH3B6iOpnoy8mHcTdd14lMDTzWV0LtFGQ2kEx0otfFIjNJ0NU
        D8n02ApfgmYinn30FLg3s9FWX0Ef3f6mKWggYYZoakDCNVVPVUUQPRno4kRm2GnE
        CX9IsQ+EVCBdosacSp+TKGJdzOWCRwJbFMUkrc0eGwYKhwXjMk4/s5HpR7FAIila
        l0nnGY3mb/F2kkD6TCgPK+wU35Ctrjfc+dOQ0VgSKjaYBgLzLtQNz9v1LGfdWiKi
        p4b99jKfpv65BNNyICb+aS/TcCteLt+SlYIUs/u9r/64FgEi8FvVqU9IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=lIEkADkjiRgN2eBw4b52cvu6kArTIQoE8NgK2aLJwLE=; b=tYJqjIrU
        c+YHhYc2ZrOfx+ysmnmvB+TkNAQhFHvUJjPyQY+1objcdKbhrKDhcIkBnnKme41B
        gvXe/f6Zn2N26YlYRozSmX/veC2UlEV9miKYVts+VC53Hz6iL9toaRWTyH5puZZa
        uKsVPjqJxB51oWurD64qbYgx6sz5hxne7+jnexFzDgTdY+/qIqHO5QapF6NYy4km
        vcXpaWhU/YY/kGka/1OiPCrrn4eM1iAEbBJgrADlGTsaKnOto0cC9JpmZZXLoynk
        dS2ewb2WroLyJlPs2dWxFunAnEa2vomga7E9aJPK/96dy75fdo3YoVlOhl4WwnhG
        e0hPWqUonHCdqA==
X-ME-Sender: <xms:hiNyXy-inux5Pc1wfEtC0jsS3bbK5LDL__5E22R08genpWjLBUHqCQ>
    <xme:hiNyXytki9IWX5c3Fwpz-qkC052cojCXmk1FTtzkoNJPRqy0EnVVItmzNYZDnvXLc
    B_93l0Mc2ZNfdMktg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:hyNyX4CgXHrp9FGn2dNMJ0oBhREAQoc47yOdUjXG8GRHgIL5jD0wOg>
    <xmx:hyNyX6fChoxohnPZd5EroXdeQM-IMfx_fXN36HL1qVbHwyx6PDXD5A>
    <xmx:hyNyX3OvemistL49VzYAeUIUmKbL59CL3hlH-Wv6lvl1rsANDnvFuQ>
    <xmx:iCNyX-nOkg7jsFnztoDF5LsML4rMr3gktrhG0cvlnqU_fZesKGbM2bt00Ws>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 951493064682;
        Mon, 28 Sep 2020 13:55:18 -0400 (EDT)
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
Subject: [RFC PATCH v2 02/30] mm: pagewalk: use READ_ONCE when reading the PMD entry unlocked
Date:   Mon, 28 Sep 2020 13:54:00 -0400
Message-Id: <20200928175428.4110504-3-zi.yan@sent.com>
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

The pagewalker runs while only holding the mmap_sem for read. The pud can
be set asynchronously, while also holding the mmap_sem for read.

This follows the same way as the commit:
mm/pagewalk: use READ_ONCE when reading the PUD entry unlocked"

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c       | 69 ++++++++++++++++++++++++++--------------
 include/linux/pagewalk.h |  2 +-
 mm/madvise.c             | 59 ++++++++++++++++++----------------
 mm/memcontrol.c          | 30 +++++++++++------
 mm/mempolicy.c           | 15 ++++++---
 mm/mincore.c             | 10 +++---
 mm/pagewalk.c            | 21 ++++++------
 7 files changed, 124 insertions(+), 82 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 069978777423..a21484b1414d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -570,28 +570,33 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 #endif
 
-static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
-			   struct mm_walk *walk)
+static int smaps_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
+			unsigned long end, struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
-		smaps_pmd_entry(pmd, addr, walk);
+		if (memcmp(pmdp, &pmd, sizeof(pmd)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
+		smaps_pmd_entry(pmdp, addr, walk);
 		spin_unlock(ptl);
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(&pmd))
 		goto out;
 	/*
 	 * The mmap_lock held all the way back in m_start() is what
 	 * keeps khugepaged out of here and from collapsing things
 	 * in here.
 	 */
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_offset_map_lock(vma->vm_mm, pmdp, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
@@ -1091,7 +1096,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 }
 #endif
 
-static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
+static int clear_refs_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 {
 	struct clear_refs_private *cp = walk->private;
@@ -1100,20 +1105,25 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	struct page *page;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
+		if (memcmp(pmdp, &pmd, sizeof(pmd)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
-			clear_soft_dirty_pmd(vma, addr, pmd);
+			clear_soft_dirty_pmd(vma, addr, pmdp);
 			goto out;
 		}
 
-		if (!pmd_present(*pmd))
+		if (!pmd_present(pmd))
 			goto out;
 
-		page = pmd_page(*pmd);
+		page = pmd_page(pmd);
 
 		/* Clear accessed and referenced bits. */
-		pmdp_test_and_clear_young(vma, addr, pmd);
+		pmdp_test_and_clear_young(vma, addr, pmdp);
 		test_and_clear_page_young(page);
 		ClearPageReferenced(page);
 out:
@@ -1121,10 +1131,10 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(&pmd))
 		return 0;
 
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_offset_map_lock(vma->vm_mm, pmdp, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
 
@@ -1388,8 +1398,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	return make_pme(frame, flags);
 }
 
-static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
-			     struct mm_walk *walk)
+static int pagemap_pmd_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
+			unsigned long end, struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->vma;
 	struct pagemapread *pm = walk->private;
@@ -1401,9 +1411,14 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
 		u64 flags = 0, frame = 0;
-		pmd_t pmd = *pmdp;
 		struct page *page = NULL;
 
+		if (memcmp(pmdp, &pmd, sizeof(pmd)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
+
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			flags |= PM_SOFT_DIRTY;
 
@@ -1456,7 +1471,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		return err;
 	}
 
-	if (pmd_trans_unstable(pmdp))
+	if (pmd_trans_unstable(&pmd))
 		return 0;
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -1768,7 +1783,7 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 }
 #endif
 
-static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
+static int gather_pte_stats(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, struct mm_walk *walk)
 {
 	struct numa_maps *md = walk->private;
@@ -1778,22 +1793,28 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	pte_t *pte;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
 		struct page *page;
 
-		page = can_gather_numa_stats_pmd(*pmd, vma, addr);
+		if (memcmp(pmdp, &pmd, sizeof(pmd)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
+
+		page = can_gather_numa_stats_pmd(pmd, vma, addr);
 		if (page)
-			gather_stats(page, md, pmd_dirty(*pmd),
+			gather_stats(page, md, pmd_dirty(pmd),
 				     HPAGE_PMD_SIZE/PAGE_SIZE);
 		spin_unlock(ptl);
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(&pmd))
 		return 0;
 #endif
-	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_offset_map_lock(walk->mm, pmdp, addr, &ptl);
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
 		if (!page)
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 6caf28aadafb..686b57e94a9f 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -41,7 +41,7 @@ struct mm_walk_ops {
 			 unsigned long next, struct mm_walk *walk);
 	int (*pud_entry)(pud_t pud, pud_t *pudp, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
-	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
+	int (*pmd_entry)(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
 	int (*pte_entry)(pte_t *pte, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
diff --git a/mm/madvise.c b/mm/madvise.c
index ae266dfede8a..16e7b8eadb13 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -183,14 +183,14 @@ static long madvise_behavior(struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_SWAP
-static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
+static int swapin_walk_pmd_entry(pmd_t pmd, pmd_t *pmdp, unsigned long start,
 	unsigned long end, struct mm_walk *walk)
 {
 	pte_t *orig_pte;
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
 
-	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+	if (pmd_none_or_trans_huge_or_clear_bad(&pmd))
 		return 0;
 
 	for (index = start; index != end; index += PAGE_SIZE) {
@@ -199,7 +199,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		struct page *page;
 		spinlock_t *ptl;
 
-		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
+		orig_pte = pte_offset_map_lock(vma->vm_mm, pmdp, start, &ptl);
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
 		pte_unmap_unlock(orig_pte, ptl);
 
@@ -304,7 +304,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	return 0;
 }
 
-static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
+static int madvise_cold_or_pageout_pte_range(pmd_t pmd, pmd_t *pmdp,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
 {
@@ -322,26 +322,29 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		return -EINTR;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_trans_huge(*pmd)) {
-		pmd_t orig_pmd;
+	if (pmd_trans_huge(pmd)) {
 		unsigned long next = pmd_addr_end(addr, end);
 
 		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
-		ptl = pmd_trans_huge_lock(pmd, vma);
+		ptl = pmd_trans_huge_lock(pmdp, vma);
 		if (!ptl)
 			return 0;
 
-		orig_pmd = *pmd;
-		if (is_huge_zero_pmd(orig_pmd))
+		if (memcmp(pmdp, &pmd, sizeof(pmd)) != 0) {
+			walk->action = ACTION_AGAIN;
+			goto huge_unlock;
+		}
+
+		if (is_huge_zero_pmd(pmd))
 			goto huge_unlock;
 
-		if (unlikely(!pmd_present(orig_pmd))) {
+		if (unlikely(!pmd_present(pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
-					!is_pmd_migration_entry(orig_pmd));
+					!is_pmd_migration_entry(pmd));
 			goto huge_unlock;
 		}
 
-		page = pmd_page(orig_pmd);
+		page = pmd_page(pmd);
 
 		/* Do not interfere with other mappings of this page */
 		if (page_mapcount(page) != 1)
@@ -361,12 +364,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			return 0;
 		}
 
-		if (pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
+		if (pmd_young(pmd)) {
+			pmdp_invalidate(vma, addr, pmdp);
+			pmd = pmd_mkold(pmd);
 
-			set_pmd_at(mm, addr, pmd, orig_pmd);
-			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
+			set_pmd_at(mm, addr, pmdp, pmd);
+			tlb_remove_pmd_tlb_entry(tlb, pmdp, addr);
 		}
 
 		ClearPageReferenced(page);
@@ -388,11 +391,11 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	}
 
 regular_page:
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(&pmd))
 		return 0;
 #endif
 	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmdp, addr, &ptl);
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
@@ -424,12 +427,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			if (split_huge_page(page)) {
 				unlock_page(page);
 				put_page(page);
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
+				pte_offset_map_lock(mm, pmdp, addr, &ptl);
 				break;
 			}
 			unlock_page(page);
 			put_page(page);
-			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			pte = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
@@ -566,7 +569,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 	return 0;
 }
 
-static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
+static int madvise_free_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 
 {
@@ -580,15 +583,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long next;
 
 	next = pmd_addr_end(addr, end);
-	if (pmd_trans_huge(*pmd))
-		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
+	if (pmd_trans_huge(pmd))
+		if (madvise_free_huge_pmd(tlb, vma, pmdp, addr, next))
 			goto next;
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(&pmd))
 		return 0;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
@@ -634,12 +637,12 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			if (split_huge_page(page)) {
 				unlock_page(page);
 				put_page(page);
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
+				pte_offset_map_lock(mm, pmdp, addr, &ptl);
 				goto out;
 			}
 			unlock_page(page);
 			put_page(page);
-			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			pte = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9c4a0851348f..b28f620c1c5b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5827,7 +5827,7 @@ static inline enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
 }
 #endif
 
-static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
+static int mem_cgroup_count_precharge_pte_range(pmd_t pmd, pmd_t *pmdp,
 					unsigned long addr, unsigned long end,
 					struct mm_walk *walk)
 {
@@ -5835,22 +5835,27 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
+		if (memcmp(pmdp, &pmd, sizeof(pmd)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
 		/*
 		 * Note their can not be MC_TARGET_DEVICE for now as we do not
 		 * support transparent huge page with MEMORY_DEVICE_PRIVATE but
 		 * this might change.
 		 */
-		if (get_mctgt_type_thp(vma, addr, *pmd, NULL) == MC_TARGET_PAGE)
+		if (get_mctgt_type_thp(vma, addr, pmd, NULL) == MC_TARGET_PAGE)
 			mc.precharge += HPAGE_PMD_NR;
 		spin_unlock(ptl);
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(&pmd))
 		return 0;
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_offset_map_lock(vma->vm_mm, pmdp, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		if (get_mctgt_type(vma, addr, *pte, NULL))
 			mc.precharge++;	/* increment precharge temporarily */
@@ -6023,7 +6028,7 @@ static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
 		mem_cgroup_clear_mc();
 }
 
-static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
+static int mem_cgroup_move_charge_pte_range(pmd_t pmd, pmd_t *pmdp,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
 {
@@ -6035,13 +6040,18 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	union mc_target target;
 	struct page *page;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
+		if (memcmp(pmdp, &pmd, sizeof(pmd)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
 		if (mc.precharge < HPAGE_PMD_NR) {
 			spin_unlock(ptl);
 			return 0;
 		}
-		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
+		target_type = get_mctgt_type_thp(vma, addr, pmd, &target);
 		if (target_type == MC_TARGET_PAGE) {
 			page = target.page;
 			if (!isolate_lru_page(page)) {
@@ -6066,10 +6076,10 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(&pmd))
 		return 0;
 retry:
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_offset_map_lock(vma->vm_mm, pmdp, addr, &ptl);
 	for (; addr != end; addr += PAGE_SIZE) {
 		pte_t ptent = *(pte++);
 		bool device = false;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..731a7710395f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -516,7 +516,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
  * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
  *        on a node that does not follow the policy.
  */
-static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
+static int queue_pages_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->vma;
@@ -528,18 +528,23 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
-		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
+		if (memcmp(pmdp, &pmd, sizeof(pmd)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
+		ret = queue_pages_pmd(pmdp, ptl, addr, end, walk);
 		if (ret != 2)
 			return ret;
 	}
 	/* THP was split, fall through to pte walk */
 
-	if (pmd_trans_unstable(pmd))
+	if (pmd_trans_unstable(&pmd))
 		return 0;
 
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	pte = pte_offset_map_lock(walk->mm, pmdp, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
diff --git a/mm/mincore.c b/mm/mincore.c
index 02db1a834021..168661f32aaa 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -96,8 +96,8 @@ static int mincore_unmapped_range(unsigned long addr, unsigned long end,
 	return 0;
 }
 
-static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
-			struct mm_walk *walk)
+static int mincore_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
+			unsigned long end, struct mm_walk *walk)
 {
 	spinlock_t *ptl;
 	struct vm_area_struct *vma = walk->vma;
@@ -105,19 +105,19 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	unsigned char *vec = walk->private;
 	int nr = (end - addr) >> PAGE_SHIFT;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
 		memset(vec, 1, nr);
 		spin_unlock(ptl);
 		goto out;
 	}
 
-	if (pmd_trans_unstable(pmd)) {
+	if (pmd_trans_unstable(&pmd)) {
 		__mincore_unmapped_range(addr, end, vma, vec);
 		goto out;
 	}
 
-	ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	ptep = pte_offset_map_lock(walk->mm, pmdp, addr, &ptl);
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		pte_t pte = *ptep;
 
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 15d1e423b4a3..a3752c82a7b2 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -61,17 +61,19 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 static int walk_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
-	pmd_t *pmd;
+	pmd_t *pmdp;
+	pmd_t pmd;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 	int depth = real_depth(3);
 
-	pmd = pmd_offset(&pud, addr);
+	pmdp = pmd_offset(&pud, addr);
 	do {
 again:
+		pmd = READ_ONCE(*pmdp);
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
+		if (pmd_none(pmd) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
@@ -86,7 +88,7 @@ static int walk_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		 * needs to know about pmd_trans_huge() pmds
 		 */
 		if (ops->pmd_entry)
-			err = ops->pmd_entry(pmd, addr, next, walk);
+			err = ops->pmd_entry(pmd, pmdp, addr, next, walk);
 		if (err)
 			break;
 
@@ -97,21 +99,22 @@ static int walk_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		 * Check this here so we only break down trans_huge
 		 * pages when we _need_ to
 		 */
-		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
+		if ((!walk->vma && (pmd_leaf(pmd) || !pmd_present(pmd))) ||
 		    walk->action == ACTION_CONTINUE ||
 		    !(ops->pte_entry))
 			continue;
 
 		if (walk->vma) {
-			split_huge_pmd(walk->vma, pmd, addr);
-			if (pmd_trans_unstable(pmd))
+			split_huge_pmd(walk->vma, pmdp, addr);
+			pmd = READ_ONCE(*pmdp);
+			if (pmd_trans_unstable(&pmd))
 				goto again;
 		}
 
-		err = walk_pte_range(pmd, addr, next, walk);
+		err = walk_pte_range(pmdp, addr, next, walk);
 		if (err)
 			break;
-	} while (pmd++, addr = next, addr != end);
+	} while (pmdp++, addr = next, addr != end);
 
 	return err;
 }
-- 
2.28.0

