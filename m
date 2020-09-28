Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB5D27B3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgI1SCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:49 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:37469 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E1D60EB6;
        Mon, 28 Sep 2020 13:55:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=g/l3kBF8ztP9z
        PFDpwOmayWvLlVcLVx1lR8mmO+yqpU=; b=OkzELMSDtU+ipHbiupKhYuKHKIbQZ
        rIlMg2ODpQVIHQQp7HzvouMgD2+IBl28OTAP0b37F8biiFzTRPotp4YiUXHCnhY6
        yYgPc0Wzf62geWF+gHwi//UIXMONQnpFvLZF3uGyVUuFtT2lKHVb2reTxP1vSR4c
        4OT2LnsjnByHeMosKy4d3MaBpNQDVZboxQvjieh3kg6cmhjIxL2MC0eizGtxJFUE
        Uwd0aTAG/moV1sEY50YYByqOglNn0ptwW3J10Yrd/qdeFxLhNmHg/ZY0gdpDlkDU
        o7YPKwQOBdRm7zBKYInGtzALtEmIbYTBagt+qJGwBb75Rqw2JzJnq+DbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=g/l3kBF8ztP9zPFDpwOmayWvLlVcLVx1lR8mmO+yqpU=; b=WSAfhOKn
        ECAXp1gmCjDXD7aQrVScPWaiKrk1whrDLpV7tae9dDCYtdPZ/PH+XJ7bfy//zN9u
        gn/JSvOwKocwQXMorq9kC37MxOJzgLPPDGY7CGJm1sG801vR4cIhtjsC0ESJhWPh
        mIcIag6Q2Vd8sp1rouPkBSYMZ9KDnCpIRFPqazJZ6svyZj3GN9EcITlhCPjxViiZ
        2nvaWAAI3gx7WU/Zm88FYACA9DiUUboFyS7tAC758HeZrmPWy7mJEzoHehdLmcN9
        xwz5+qlhX5pSllwv3GGuUbNbgq8BhhPB2qxLSeoiyY2PbOGXmF74RkGaulgqe3Yv
        YQ+cZp/J+Azc5w==
X-ME-Sender: <xms:kCNyXyqANKdwiXXMtam2BZtPLhQlE2HR1B7tQX-njL3OvKR7ukWHaw>
    <xme:kCNyXwpqLjemINueDLOAcsJhMYk9smutLvhGpZnW9EaAEcgofZl63CqEqbqmett_A
    U0XLkl-ObiLLRAS1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:kCNyX3N6oJZg_z5ndd8uQe5O4hlRC3Cw8rXUjErdnyL6R-1p42f_0Q>
    <xmx:kCNyXx7hPjGg-9-MS-XuKXBMakCozOL6lWtH6RG3rTdTBlwgFZo13w>
    <xmx:kCNyXx6S8j3LMSjPnZPojKeyIYT559PSKxCMk83FgxQJ5JQcHt_QqQ>
    <xmx:kCNyXwSeK2nlZ9cPCRyyt5S4YAe2TPxuRrdDRbIJ4cm8hB_DGHcbJ5g5hKM>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 03730306467D;
        Mon, 28 Sep 2020 13:55:27 -0400 (EDT)
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
Subject: [RFC PATCH v2 28/30] hugetlb: cma: move cma reserve function to cma.c.
Date:   Mon, 28 Sep 2020 13:54:26 -0400
Message-Id: <20200928175428.4110504-29-zi.yan@sent.com>
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

It will be used by other allocations, like 1GB THP allocation in the
upcoming commit.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/arm64/mm/hugetlbpage.c                   |  2 +-
 arch/powerpc/mm/hugetlbpage.c                 |  2 +-
 arch/x86/kernel/setup.c                       |  8 +-
 include/linux/cma.h                           | 15 +++
 include/linux/hugetlb.h                       | 12 ---
 mm/cma.c                                      | 88 ++++++++++++++++++
 mm/hugetlb.c                                  | 92 ++-----------------
 8 files changed, 120 insertions(+), 101 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7fbfc1a3e1e1..3f8f3199f4fc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1524,7 +1524,7 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
-	hugetlb_cma=	[HW] The size of a cma area used for allocation
+	hugepage_cma=	[HW] The size of a cma area used for allocation
 			of gigantic hugepages.
 			Format: nn[KMGTPE]
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 55ecf6de9ff7..8a3ad7eaae49 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -52,7 +52,7 @@ void __init arm64_hugetlb_cma_reserve(void)
 	 * breaking this assumption.
 	 */
 	WARN_ON(order <= MAX_ORDER);
-	hugetlb_cma_reserve(order);
+	hugepage_cma_reserve(order);
 }
 #endif /* CONFIG_CMA */
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 36c3800769fb..6c1e61251df2 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -713,6 +713,6 @@ void __init gigantic_hugetlb_cma_reserve(void)
 
 	if (order) {
 		VM_WARN_ON(order < MAX_ORDER);
-		hugetlb_cma_reserve(order);
+		hugepage_cma_reserve(order);
 	}
 }
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ad8f909b5dc8..a732ead4985a 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/root_dev.h>
 #include <linux/sfi.h>
-#include <linux/hugetlb.h>
+#include <linux/cma.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
@@ -641,7 +641,7 @@ static void __init trim_snb_memory(void)
 	 * already been reserved.
 	 */
 	memblock_reserve(0, 1<<20);
-	
+
 	for (i = 0; i < ARRAY_SIZE(bad_pages); i++) {
 		if (memblock_reserve(bad_pages[i], PAGE_SIZE))
 			printk(KERN_WARNING "failed to reserve 0x%08lx\n",
@@ -733,7 +733,7 @@ static void __init trim_low_memory_range(void)
 {
 	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
 }
-	
+
 /*
  * Dump out kernel offset information on panic.
  */
@@ -1144,7 +1144,7 @@ void __init setup_arch(char **cmdline_p)
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
-		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+		hugepage_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 217999c8a762..9989d580c2a7 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -49,4 +49,19 @@ extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
+
+extern void cma_reserve(int min_order, unsigned long requested_size,
+			const char *name, struct cma *cma_struct[N_MEMORY]);
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+extern void __init hugepage_cma_reserve(int order);
+extern void __init hugepage_cma_check(void);
+#else
+static inline void __init hugepage_cma_check(void)
+{
+}
+static inline void __init hugepage_cma_reserve(int order)
+{
+}
+#endif
+
 #endif
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d5cc5f802dd4..087d13a1dc24 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -935,16 +935,4 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 	return ptl;
 }
 
-#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
-extern void __init hugetlb_cma_reserve(int order);
-extern void __init hugetlb_cma_check(void);
-#else
-static inline __init void hugetlb_cma_reserve(int order)
-{
-}
-static inline __init void hugetlb_cma_check(void)
-{
-}
-#endif
-
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7cda9f..1a9d997fa5ab 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -38,6 +38,10 @@
 
 struct cma cma_areas[MAX_CMA_AREAS];
 unsigned cma_area_count;
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+struct cma *hugepage_cma[MAX_NUMNODES];
+#endif
+unsigned long hugepage_cma_size __initdata;
 static DEFINE_MUTEX(cma_mutex);
 
 phys_addr_t cma_get_base(const struct cma *cma)
@@ -541,3 +545,87 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 	return 0;
 }
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+/*
+ * cma_reserve() - reserve CMA for gigantic pages on nodes with memory
+ *
+ * must be called after free_area_init() that updates N_MEMORY via node_set_state().
+ * cma_reserve() scans over N_MEMORY nodemask and hence expects the platforms
+ * to have initialized N_MEMORY state.
+ */
+void __init cma_reserve(int min_order, unsigned long requested_size, const char *name,
+		 struct cma *cma_struct[MAX_NUMNODES])
+{
+	unsigned long size, reserved, per_node;
+	int nid;
+
+	if (!requested_size)
+		return;
+
+	if (requested_size < (PAGE_SIZE << min_order)) {
+		pr_warn("%s_cma: cma area should be at least %lu MiB\n",
+			name, (PAGE_SIZE << min_order) / SZ_1M);
+		return;
+	}
+
+	/*
+	 * If 3 GB area is requested on a machine with 4 numa nodes,
+	 * let's allocate 1 GB on first three nodes and ignore the last one.
+	 */
+	per_node = DIV_ROUND_UP(requested_size, nr_online_nodes);
+	pr_info("%s_cma: reserve %lu MiB, up to %lu MiB per node\n",
+		name, requested_size / SZ_1M, per_node / SZ_1M);
+
+	reserved = 0;
+	for_each_node_state(nid, N_ONLINE) {
+		int res;
+		char node_name[CMA_MAX_NAME];
+
+		size = min(per_node, requested_size - reserved);
+		size = round_up(size, PAGE_SIZE << min_order);
+
+		snprintf(node_name, sizeof(name), "%s%d", name, nid);
+		res = cma_declare_contiguous_nid(0, size, 0,
+						 PAGE_SIZE << min_order,
+						 0, false, node_name,
+						 &cma_struct[nid], nid);
+		if (res) {
+			pr_warn("%s_cma: reservation failed: err %d, node %d",
+				name, res, nid);
+			continue;
+		}
+
+		reserved += size;
+		pr_info("%s_cma: reserved %lu MiB on node %d\n",
+			name, size / SZ_1M, nid);
+
+		if (reserved >= requested_size)
+			break;
+	}
+}
+
+static bool hugepage_cma_reserve_called __initdata;
+
+static int __init cmdline_parse_hugepage_cma(char *p)
+{
+	hugepage_cma_size = memparse(p, &p);
+	return 0;
+}
+
+early_param("hugepage_cma", cmdline_parse_hugepage_cma);
+
+void __init hugepage_cma_reserve(int order)
+{
+	hugepage_cma_reserve_called = true;
+	cma_reserve(order, hugepage_cma_size, "hugepage", hugepage_cma);
+}
+
+void __init hugepage_cma_check(void)
+{
+	if (!hugepage_cma_size || hugepage_cma_reserve_called)
+		return;
+
+	pr_warn("hugepage_cma: the option isn't supported by current arch\n");
+}
+#endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 25674d7b1e5f..871f1c315c48 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -48,9 +48,9 @@ unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
 
 #ifdef CONFIG_CMA
-static struct cma *hugetlb_cma[MAX_NUMNODES];
+extern struct cma *hugepage_cma[MAX_NUMNODES];
 #endif
-static unsigned long hugetlb_cma_size __initdata;
+extern unsigned long hugepage_cma_size __initdata;
 
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
@@ -1227,7 +1227,7 @@ static void free_gigantic_page(struct page *page, unsigned int order)
 	 * cma_release() returns false.
 	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
+	if (cma_release(hugepage_cma[page_to_nid(page)], page, 1 << order))
 		return;
 #endif
 
@@ -1247,8 +1247,8 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 		struct page *page;
 		int node;
 
-		if (hugetlb_cma[nid]) {
-			page = cma_alloc(hugetlb_cma[nid], nr_pages,
+		if (hugepage_cma[nid]) {
+			page = cma_alloc(hugepage_cma[nid], nr_pages,
 					huge_page_order(h), true);
 			if (page)
 				return page;
@@ -1256,10 +1256,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 
 		if (!(gfp_mask & __GFP_THISNODE)) {
 			for_each_node_mask(node, *nodemask) {
-				if (node == nid || !hugetlb_cma[node])
+				if (node == nid || !hugepage_cma[node])
 					continue;
 
-				page = cma_alloc(hugetlb_cma[node], nr_pages,
+				page = cma_alloc(hugepage_cma[node], nr_pages,
 						huge_page_order(h), true);
 				if (page)
 					return page;
@@ -2554,8 +2554,8 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (hugetlb_cma_size) {
-				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
+			if (hugepage_cma_size) {
+				pr_warn_once("HugeTLB: hugepage_cma is enabled, skip boot time allocation\n");
 				break;
 			}
 			if (!alloc_bootmem_huge_page(h))
@@ -3231,7 +3231,7 @@ static int __init hugetlb_init(void)
 		}
 	}
 
-	hugetlb_cma_check();
+	hugepage_cma_check();
 	hugetlb_init_hstates();
 	gather_bootmem_prealloc();
 	report_hugepages();
@@ -5665,75 +5665,3 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		spin_unlock(&hugetlb_lock);
 	}
 }
-
-#ifdef CONFIG_CMA
-static bool cma_reserve_called __initdata;
-
-static int __init cmdline_parse_hugetlb_cma(char *p)
-{
-	hugetlb_cma_size = memparse(p, &p);
-	return 0;
-}
-
-early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
-
-void __init hugetlb_cma_reserve(int order)
-{
-	unsigned long size, reserved, per_node;
-	int nid;
-
-	cma_reserve_called = true;
-
-	if (!hugetlb_cma_size)
-		return;
-
-	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
-		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
-			(PAGE_SIZE << order) / SZ_1M);
-		return;
-	}
-
-	/*
-	 * If 3 GB area is requested on a machine with 4 numa nodes,
-	 * let's allocate 1 GB on first three nodes and ignore the last one.
-	 */
-	per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
-	pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
-		hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
-
-	reserved = 0;
-	for_each_node_state(nid, N_ONLINE) {
-		int res;
-		char name[CMA_MAX_NAME];
-
-		size = min(per_node, hugetlb_cma_size - reserved);
-		size = round_up(size, PAGE_SIZE << order);
-
-		snprintf(name, sizeof(name), "hugetlb%d", nid);
-		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
-						 0, false, name,
-						 &hugetlb_cma[nid], nid);
-		if (res) {
-			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
-				res, nid);
-			continue;
-		}
-
-		reserved += size;
-		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
-			size / SZ_1M, nid);
-
-		if (reserved >= hugetlb_cma_size)
-			break;
-	}
-}
-
-void __init hugetlb_cma_check(void)
-{
-	if (!hugetlb_cma_size || cma_reserve_called)
-		return;
-
-	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
-}
-
-#endif /* CONFIG_CMA */
-- 
2.28.0

