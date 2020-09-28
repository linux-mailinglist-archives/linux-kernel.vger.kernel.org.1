Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBE27B3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1SBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:36 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:36797 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbgI1SBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4DB7FEB8;
        Mon, 28 Sep 2020 13:55:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=Nj/H1bhUbJdbY
        KZHa/71xGaBODpP4brVRKFdfTzhT6c=; b=gkWZtUubFT06rXcTnth5omC+yd5DX
        RyZJL4TCSVIbCb0v7g3+WlQ0Y7fqvw7Hubqd1pPUgMpDuD8QYF7zAP5zs1TauCHF
        3GcXAZTfxcxY9pLUAXi3HDPJ9HAKM1LGN4VzyGgnYeDcvRfq0Tspd+ZqOVdi3aYi
        mdiLmvI5MiYaEF+AKIieaRJ8RDiexxgVPNFd098rcYxi4xVZxkRV7QtspBcVg6XQ
        LR1QBEeNaoZGWaVc8eJKJyNqyeGIt6UmIcVYZ1uETD5AH4I4VI9fpb/tSraMOOs6
        dW/kNnEDBbEMHeDo4HprH2TsrtNhzsrpTZQ838hUHfgj2dC/1ceW3gY/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Nj/H1bhUbJdbYKZHa/71xGaBODpP4brVRKFdfTzhT6c=; b=Leevw8rq
        LQ5I5XbmbI+exRs8SO2qBixGTGP+sjKvn9XOx6mD6VQIrxf1fTuFvcAsAqymQXYR
        AaVcMwk/NFCcG2unWpnhw2+cHK0/iMgM5R31bcG8b47D/vEZ9PW3zfe4zCZJxPXd
        /ZnHtphbVlKC4cdBL7WUK8B4YpQihTPtqkPFvy2d1+hmf95kC9QAgglknFQChWUM
        P3DiQqTpknHJ/mfQ/QvXos+zKGdg1NaSHzvFz+TAcDAjtmeDHE4PMvGpsQt6JqlJ
        mNadnWBQSmNKOCjf/+DneDkoR6N8Uqg1JBEkGRjHaGPvE1ur/aOyRwS1LkiEHut5
        DU+QrhYcvGCSEA==
X-ME-Sender: <xms:kCNyX1UBu98IxRlKGeO4-jIz8QJLviO2vOX-K5Bd0IYLaCBL9UGTDA>
    <xme:kCNyX1kLJH44oz1B1Nxf-Zm9aArOWotXodZGvI_3a83o-xBDvSIzFxqSzkgZahxtL
    L-WaukVwYxTeZfeBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:kCNyXxYj97J93HJeuu3ai3N9HYpPV_pBhGApzQBu_oOETBItpll3eQ>
    <xmx:kCNyX4Ug6-0JbKs-9MtzWbYulZuVF3gSdOa98c1bCLq4MI4aQtcIEQ>
    <xmx:kCNyX_kaNBm7gHxabruci8odBE4v8MoMUsScTovnKRnYtOoTdV4pjQ>
    <xmx:kCNyX0_yfLhx9WaMnFE7q9nDw0Z4MFCgbmYCeZeIQOyMq3VNFSEo6Pg8HxA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 595303064683;
        Mon, 28 Sep 2020 13:55:28 -0400 (EDT)
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
Subject: [RFC PATCH v2 29/30] mm: thp: use cma reservation for pud thp allocation.
Date:   Mon, 28 Sep 2020 13:54:27 -0400
Message-Id: <20200928175428.4110504-30-zi.yan@sent.com>
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

Sharing hugepage_cma reservation with hugetlb for pud thp allocaiton.
The reserved cma regions still can be used for moveable page allocations.

During 1GB page split, all subpages are cleared from the CMA bitmap,
since they are no more 1GB pages and will be freed via the normal path
instead of cma_release().

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/cma.h     |  3 +++
 include/linux/huge_mm.h | 10 ++++++++++
 mm/cma.c                | 31 +++++++++++++++++++++++++++++++
 mm/huge_memory.c        | 34 ++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 21 +--------------------
 mm/mempolicy.c          | 14 +++++++++++++-
 mm/page_alloc.c         | 29 +++++++++++++++++++++++++++++
 7 files changed, 121 insertions(+), 21 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 9989d580c2a7..c299b62b3a7a 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -48,6 +48,9 @@ extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 			      bool no_warn);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
 
+extern bool cma_clear_bitmap_if_in_range(struct cma *cma, const struct page *page,
+					unsigned int count);
+
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
 
 extern void cma_reserve(int min_order, unsigned long requested_size,
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0d0f9cf25aeb..163b244d9acd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -24,6 +24,8 @@ extern struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
 					  unsigned long addr,
 					  pud_t *pud,
 					  unsigned int flags);
+extern struct page *alloc_thp_pud_page(int nid);
+extern bool free_thp_pud_page(struct page *page, int order);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
@@ -43,6 +45,14 @@ struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
 {
 	return NULL;
 }
+struct page *alloc_thp_pud_page(int nid)
+{
+	return NULL;
+}
+extern bool free_thp_pud_page(struct page *page, int order);
+{
+	return false;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
diff --git a/mm/cma.c b/mm/cma.c
index 1a9d997fa5ab..c595aad61f58 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -532,6 +532,37 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 	return true;
 }
 
+/**
+ * cma_clear_bitmap_if_in_range() - clear bitmap for a given page
+ * @cma:   Contiguous memory region for which the allocation is performed.
+ * @pages: Allocated pages.
+ * @count: Number of allocated pages.
+ *
+ * This function clears bitmap of memory allocated by cma_alloc().
+ * It returns false when provided pages do not belong to contiguous area and
+ * true otherwise.
+ */
+bool cma_clear_bitmap_if_in_range(struct cma *cma, const struct page *pages,
+				  unsigned int count)
+{
+	unsigned long pfn;
+
+	if (!cma || !pages)
+		return false;
+
+	pfn = page_to_pfn(pages);
+
+	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
+		return false;
+
+	if (pfn + count > cma->base_pfn + cma->count)
+		return false;
+
+	cma_clear_bitmap(cma, pfn, count);
+
+	return true;
+}
+
 int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 {
 	int i;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 20ecffc27396..910e51f35910 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -33,6 +33,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/page_owner.h>
+#include <linux/cma.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -62,6 +63,10 @@ static struct shrinker deferred_split_shrinker;
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 
+#ifdef CONFIG_CMA
+extern struct cma *hugepage_cma[MAX_NUMNODES];
+#endif
+
 bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	/* The addr is used to check if the vma size fits */
@@ -2498,6 +2503,17 @@ static void __split_huge_pud_page(struct page *page, struct list_head *list,
 	/* no file-back page support yet */
 	VM_BUG_ON(!PageAnon(page));
 
+	/*
+	 * clear cma bitmap when we split pud page so the subpages can be freed
+	 * as normal pages
+	 */
+	if (IS_ENABLED(CONFIG_CMA)) {
+		struct cma *cma = hugepage_cma[page_to_nid(head)];
+
+		VM_BUG_ON(!cma_clear_bitmap_if_in_range(cma, head,
+				thp_nr_pages(head)));
+	}
+
 	for (i = HPAGE_PUD_NR - HPAGE_PMD_NR; i >= 1; i -= HPAGE_PMD_NR)
 		__split_huge_pud_page_tail(head, i, lruvec, list);
 
@@ -3732,3 +3748,21 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
 #endif
+
+struct page *alloc_thp_pud_page(int nid)
+{
+	struct page *page = NULL;
+#ifdef CONFIG_CMA
+	page = cma_alloc(hugepage_cma[nid], HPAGE_PUD_NR, HPAGE_PUD_ORDER, true);
+#endif
+	return page;
+}
+
+bool free_thp_pud_page(struct page *page, int order)
+{
+	bool ret = false;
+#ifdef CONFIG_CMA
+	ret = cma_release(hugepage_cma[page_to_nid(page)], page, 1<<order);
+#endif
+	return ret;
+}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 871f1c315c48..0282110c72b5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1200,26 +1200,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_page(struct page *page,
-					unsigned int order)
-{
-	int i;
-	int nr_pages = 1 << order;
-	struct page *p = page + 1;
-
-	atomic_set(compound_mapcount_ptr(page), 0);
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
-
-	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
-		clear_compound_head(p);
-		set_page_refcounted(p);
-	}
-
-	set_compound_order(page, 0);
-	__ClearPageHead(page);
-}
-
+extern void destroy_compound_gigantic_page(struct page *page, unsigned int order);
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 731a7710395f..dc3d6371195f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2143,7 +2143,12 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
 {
 	struct page *page;
 
-	page = __alloc_pages(gfp, order, nid);
+	if (order == HPAGE_PUD_ORDER) {
+		page = alloc_thp_pud_page(nid);
+		if (page && (gfp & __GFP_COMP))
+			prep_compound_page(page, order);
+	} else
+		page = __alloc_pages(gfp, order, nid);
 	/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
 	if (!static_branch_likely(&vm_numa_stat_key))
 		return page;
@@ -2217,6 +2222,13 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
 			mpol_cond_put(pol);
+
+			if (order == HPAGE_PUD_ORDER) {
+				page = alloc_thp_pud_page(hpage_node);
+				if (page && (gfp & __GFP_COMP))
+					prep_compound_page(page, order);
+				goto out;
+			}
 			/*
 			 * First, try to allocate THP only on local node, but
 			 * don't reclaim unnecessarily, just compact.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6bdb38a8fb48..5251ecb30465 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1481,6 +1481,25 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 	}
 }
 
+void destroy_compound_gigantic_page(struct page *page, unsigned int order)
+{
+	int i;
+	int nr_pages = 1 << order;
+	struct page *p = page + 1;
+
+	atomic_set(compound_mapcount_ptr(page), 0);
+	if (hpage_pincount_available(page))
+		atomic_set(compound_pincount_ptr(page), 0);
+
+	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+		clear_compound_head(p);
+		set_page_refcounted(p);
+	}
+
+	set_compound_order(page, 0);
+	__ClearPageHead(page);
+}
+
 static void __free_pages_ok(struct page *page, unsigned int order)
 {
 	unsigned long flags;
@@ -1490,6 +1509,16 @@ static void __free_pages_ok(struct page *page, unsigned int order)
 	if (!free_pages_prepare(page, order, true))
 		return;
 
+	if (order == HPAGE_PUD_ORDER) {
+		bool thp_pud_page_freed = false;
+
+		destroy_compound_gigantic_page(page, order);
+		set_page_refcounted(page);
+		thp_pud_page_freed = free_thp_pud_page(page, order);
+		VM_BUG_ON_PAGE(!thp_pud_page_freed, page);
+		return;
+	}
+
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	local_irq_save(flags);
 	__count_vm_events(PGFREE, 1 << order);
-- 
2.28.0

