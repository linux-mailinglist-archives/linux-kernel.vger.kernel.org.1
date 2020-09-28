Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C952127B3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgI1SBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:49 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43887 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id F2CEFE7C;
        Mon, 28 Sep 2020 13:55:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=L/Dj0ivDPFBMY
        /WClZZ2EstlDjqq1BXSs/PeEKi8pyw=; b=hkgG5GwCeCAjtbHKBt/x09LyA0XoB
        0JZC0FWmuv70JmRBW+lVKpyrP93sdJ3a1tvUccJ+ZhfOp7lOSHghRMX3VFr/sA5E
        0Kc9AbuVJ5WZu6EO0B2nUtdj8DG8HjMPVRtVB1Y+vTmqvGMVeI3tLcCn6aQADsoz
        waSVA2+5qRxb5CvLXgf1wifmQEeGNtN7MeCAi2kxLKYdp6NTYPZxMzWduLlpNUYp
        JCtbgpc84cBA0t1TZeiHOXUgioqz87u/T7+m6Ev+DhxuG6VBIfW89gAbxkQsDOFG
        G0VPBp09QYlgIs3izgIe8A9ZluUGPnJaxJuodJQEs58fotVXK8DxFmzkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=L/Dj0ivDPFBMY/WClZZ2EstlDjqq1BXSs/PeEKi8pyw=; b=vMyt8iH5
        k/kRRbnI9z40BI8UbV0hnpAuAOnGvxObp9biDlaPNdAfj4EA2M9IO3T6NnRt2+Bu
        FZt2BRgm1VCXjjsEB2fYTRb0AC28H9/l4ksQXOIDRQTtffB8YmWrorZJIpMujzes
        UbstBim/oDdpMKR5Y1AdTcyJ0npfdkWyinW9d2DcG4SuG0QlskQ2lG0KraXVnD7Y
        VRSRnzFOOoQViXGGuY9HMG/MR6GCgDg65qSqYOEM5pxC4E5AqmFGHyeUyloDJzmO
        M4gOjLhko5n6nOJ85yZ7/ucLiZTTrFRshk8Z/Cp7+fEOkZ81iahY6fjfexmWTe10
        lLePUP3X8eT9zQ==
X-ME-Sender: <xms:iyNyXwRrD89dUU3ZjRggpLOBUiJTq1Syu9BrWQco1XB2gNpI6VsfTw>
    <xme:iyNyX9xEXGsyFwHcgF--UVfd2Rux1MwDyoTD7BoZBjXhDfGsb3IcGFr-wS2355qcf
    _RBK7-wRPtLadTfjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:iyNyX91RV9bJ7wVAxPcBDuWH7SZrqALk1fdDxZtR6Q22UmdqWa_Cxg>
    <xmx:iyNyX0DVWRlo5nGtqYtof47ILioBYdQnhY56d8NDY_1lpopUSjV7rA>
    <xmx:iyNyX5gQG9Rp8knLEBJtBdBGRhSLmutpz_IJt2UgPMntYLnYevZM9Q>
    <xmx:iyNyX56Ezmyw2SUaAm-xXU9zVdbmjf8y4z02bLCV9gJgJuCjV4irARYB4jk>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 116E83064686;
        Mon, 28 Sep 2020 13:55:23 -0400 (EDT)
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
Subject: [RFC PATCH v2 14/30] mm: thp: add PUD THP split_huge_pud_page() function.
Date:   Mon, 28 Sep 2020 13:54:12 -0400
Message-Id: <20200928175428.4110504-15-zi.yan@sent.com>
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

It mimics PMD-level THP split. In addition, to support PMD-mapped PUD
THP, PMDPageInPUD() is added to identify the first page in the PMD sized
aligned physical pages. For example, in x86_64, the page[0], page[512],
page[1024], ... are regarded as PMDPageInPUD.

For the mapcount of PMD-mapped PUD THP, sub_compound_mapcount() is added
to uses (PMDPageInPUD+3).compound_mapcount as the mapcount, since each
base page's mapcount is used for PTE mapping, first tail page's
compound_mapcount is already in use, and second tail page's
compound_mapcount overlaps with in-use deferred_list.

PagePUDDoubleMap() is added to indicate both PUD-mapped and PMD-mapped
PUD THPs. PageDoubleMap() remains its original meaning, indicating both
PMD-mapped and PTE-mapped THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgalloc.h |   9 +
 arch/x86/include/asm/pgtable.h |  21 ++
 include/linux/huge_mm.h        |  31 +-
 include/linux/memcontrol.h     |   5 +
 include/linux/mm.h             |  25 +-
 include/linux/page-flags.h     |  48 +++
 include/linux/pgtable.h        |  17 ++
 include/linux/rmap.h           |   1 +
 include/linux/swap.h           |   2 +
 include/linux/vm_event_item.h  |   4 +
 mm/huge_memory.c               | 525 +++++++++++++++++++++++++++++++--
 mm/memcontrol.c                |  13 +
 mm/memory.c                    |   2 +-
 mm/page_alloc.c                |  21 +-
 mm/pagewalk.c                  |   2 +-
 mm/pgtable-generic.c           |  11 +
 mm/rmap.c                      |  93 +++++-
 mm/swap.c                      |  30 ++
 mm/util.c                      |  22 +-
 mm/vmstat.c                    |   4 +
 20 files changed, 832 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index b24284522973..f6926725c379 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -99,6 +99,15 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
+static inline void pud_populate_with_pgtable(struct mm_struct *mm, pud_t *pud,
+				struct page *pte)
+{
+	unsigned long pfn = page_to_pfn(pte);
+
+	paravirt_alloc_pmd(mm, pfn);
+	set_pud(pud, __pud(((pteval_t)pfn << PAGE_SHIFT) | _PAGE_TABLE));
+}
+
 #if CONFIG_PGTABLE_LEVELS > 2
 static inline pmd_t *pmd_alloc_one_page_with_ptes(struct mm_struct *mm, unsigned long addr)
 {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8bf7bfd71a46..575c349e08b2 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -630,6 +630,12 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 		      __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
 }
 
+static inline pud_t pud_mknotpresent(pud_t pud)
+{
+	return pfn_pud(pud_pfn(pud),
+	      __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
+}
+
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
@@ -1246,6 +1252,21 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 }
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
+#ifndef pudp_establish
+#define pudp_establish pudp_establish
+static inline pud_t pudp_establish(struct vm_area_struct *vma,
+		unsigned long address, pud_t *pudp, pud_t pud)
+{
+	if (IS_ENABLED(CONFIG_SMP)) {
+		return xchg(pudp, pud);
+	} else {
+		pud_t old = *pudp;
+		*pudp = pud;
+		return old;
+	}
+}
+#endif
+
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7528652400e4..e5c68e680907 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -222,17 +222,27 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 		bool freeze, struct page *page);
 
+bool can_split_huge_pud_page(struct page *page, int *pextra_pins);
+int split_huge_pud_page_to_list(struct page *page, struct list_head *list);
+static inline int split_huge_pud_page(struct page *page)
+{
+	return split_huge_pud_page_to_list(page, NULL);
+}
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-		unsigned long address);
+		unsigned long address, bool freeze, struct page *page);
 
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
 		if (pud_trans_huge(*____pud)				\
 					|| pud_devmap(*____pud))	\
-			__split_huge_pud(__vma, __pud, __address);	\
+			__split_huge_pud(__vma, __pud, __address,	\
+						false, NULL);		\
 	}  while (0)
 
+void split_huge_pud_address(struct vm_area_struct *vma, unsigned long address,
+		bool freeze, struct page *page);
+
 extern int hugepage_madvise(struct vm_area_struct *vma,
 			    unsigned long *vm_flags, int advice);
 extern void vma_adjust_trans_huge(struct vm_area_struct *vma,
@@ -422,8 +432,25 @@ static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 static inline void split_huge_pmd_address(struct vm_area_struct *vma,
 		unsigned long address, bool freeze, struct page *page) {}
 
+static inline bool
+can_split_huge_pud_page(struct page *page, int *pextra_pins)
+{
+	BUILD_BUG();
+	return false;
+}
+static inline int
+split_huge_pud_page_to_list(struct page *page, struct list_head *list)
+{
+	return 0;
+}
+static inline int split_huge_pud_page(struct page *page)
+{
+	return 0;
+}
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
+static inline void split_huge_pud_address(struct vm_area_struct *vma,
+		unsigned long address, bool freeze, struct page *page) {}
 
 static inline int hugepage_madvise(struct vm_area_struct *vma,
 				   unsigned long *vm_flags, int advice)
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e391e3c56de5..a7622510d43d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -932,6 +932,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void mem_cgroup_split_huge_fixup(struct page *head);
+void mem_cgroup_split_huge_pud_fixup(struct page *head);
 #endif
 
 #else /* CONFIG_MEMCG */
@@ -1264,6 +1265,10 @@ static inline void mem_cgroup_split_huge_fixup(struct page *head)
 {
 }
 
+static inline void mem_cgroup_split_huge_pud_fixup(struct page *head)
+{
+}
+
 static inline void count_memcg_events(struct mem_cgroup *memcg,
 				      enum vm_event_item idx,
 				      unsigned long count)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f54f06c8eb6..51b75ffa6a6c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -801,6 +801,24 @@ static inline int compound_mapcount(struct page *page)
 	return head_compound_mapcount(page);
 }
 
+static inline unsigned int compound_order(struct page *page);
+static inline atomic_t *sub_compound_mapcount_ptr(struct page *page, int sub_level)
+{
+	struct page *head = compound_head(page);
+
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	VM_BUG_ON_PAGE(compound_order(head) != HPAGE_PUD_ORDER, page);
+	VM_BUG_ON_PAGE((page - head) % HPAGE_PMD_NR, page);
+	VM_BUG_ON_PAGE(sub_level != 1, page);
+	return &page[2 + sub_level].compound_mapcount;
+}
+
+/* Only works for PUD pages */
+static inline int sub_compound_mapcount(struct page *page)
+{
+	return atomic_read(sub_compound_mapcount_ptr(page, 1)) + 1;
+}
+
 /*
  * The atomic page->_mapcount, starts from -1: so that transitions
  * both from it and to it can be tracked, using atomic_inc_and_test
@@ -893,13 +911,6 @@ static inline void destroy_compound_page(struct page *page)
 	compound_page_dtors[page[1].compound_dtor](page);
 }
 
-static inline unsigned int compound_order(struct page *page)
-{
-	if (!PageHead(page))
-		return 0;
-	return page[1].compound_order;
-}
-
 static inline bool hpage_pincount_available(struct page *page)
 {
 	/*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fbbb841a9346..f1bfb02622cf 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -235,6 +235,9 @@ static inline void page_init_poison(struct page *page, size_t size)
  *
  * PF_SECOND:
  *     the page flag is stored in the first tail page.
+ *
+ * PF_THIRD:
+ *     the page flag is stored in the second tail page.
  */
 #define PF_POISONED_CHECK(page) ({					\
 		VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);		\
@@ -253,6 +256,9 @@ static inline void page_init_poison(struct page *page, size_t size)
 #define PF_SECOND(page, enforce) ({					\
 		VM_BUG_ON_PGFLAGS(!PageHead(page), page);		\
 		PF_POISONED_CHECK(&page[1]); })
+#define PF_THIRD(page, enforce) ({					\
+		VM_BUG_ON_PGFLAGS(!PageHead(page), page);		\
+		PF_POISONED_CHECK(&page[2]); })
 
 /*
  * Macros to create function definitions for page flags
@@ -674,6 +680,30 @@ static inline int PageTransTail(struct page *page)
 	return PageTail(page);
 }
 
+#define HPAGE_PMD_SHIFT PMD_SHIFT
+#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
+
+#define HPAGE_PUD_SHIFT PUD_SHIFT
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+
+static inline unsigned int compound_order(struct page *page)
+{
+	if (!PageHead(page))
+		return 0;
+	return page[1].compound_order;
+}
+
+
+static inline int PMDPageInPUD(struct page *page)
+{
+	struct page *head = compound_head(page);
+
+	return (PageCompound(page) && compound_order(head) == HPAGE_PUD_ORDER &&
+		((page - head) % HPAGE_PMD_NR == 0));
+}
+
 /*
  * PageDoubleMap indicates that the compound page is mapped with PTEs as well
  * as PMDs.
@@ -689,13 +719,31 @@ static inline int PageTransTail(struct page *page)
  */
 PAGEFLAG(DoubleMap, double_map, PF_SECOND)
 	TESTSCFLAG(DoubleMap, double_map, PF_SECOND)
+/*
+ * PagePUDDoubleMap indicates that the compound page is mapped with PMDs as well
+ * as PUDs.
+ *
+ * This is required for optimization of rmap operations for THP: we can postpone
+ * per small page mapcount accounting (and its overhead from atomic operations)
+ * until the first PUD split.
+ *
+ * For the page PagePUDDoubleMap means ->_mapcount in all sub-PMD pages is
+ * offset up by one. This reference will go away with last sub_compound_mapcount.
+ *
+ * See also __split_huge_pud_locked() and page_remove_anon_compound_rmap().
+ */
+PAGEFLAG(PUDDoubleMap, double_map, PF_THIRD)
+	TESTSCFLAG(PUDDoubleMap, double_map, PF_THIRD)
 #else
 TESTPAGEFLAG_FALSE(TransHuge)
 TESTPAGEFLAG_FALSE(TransCompound)
 TESTPAGEFLAG_FALSE(TransCompoundMap)
 TESTPAGEFLAG_FALSE(TransTail)
+TESTPAGEFLAG_FALSE(PMDPageInPUD)
 PAGEFLAG_FALSE(DoubleMap)
 	TESTSCFLAG_FALSE(DoubleMap)
+PAGEFLAG_FALSE(PUDDoubleMap)
+	TESTSETFLAG_FALSE(PUDDoubleMap)
 #endif
 
 /*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index bb163504fb01..02279a97e170 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -508,6 +508,11 @@ extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_INVALIDATE
+extern pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			    pud_t *pudp);
+#endif
+
 #ifndef __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
@@ -1161,6 +1166,18 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 }
 #endif
 
+#ifndef pud_read_atomic
+static inline pud_t pud_read_atomic(pud_t *pudp)
+{
+	/*
+	 * Depend on compiler for an atomic pmd read. NOTE: this is
+	 * only going to work, if the pmdval_t isn't larger than
+	 * an unsigned long.
+	 */
+	return *pudp;
+}
+#endif
+
 #ifndef arch_needs_pgtable_deposit
 #define arch_needs_pgtable_deposit() (false)
 #endif
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 1244549f3eaf..0680b9fff2b3 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -99,6 +99,7 @@ enum ttu_flags {
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
 	TTU_SPLIT_FREEZE	= 0x100,		/* freeze pte under splitting thp */
+	TTU_SPLIT_HUGE_PUD	= 0x200,		/* split huge PUD if any */
 };
 
 #ifdef CONFIG_MMU
diff --git a/include/linux/swap.h b/include/linux/swap.h
index f32804e2fad5..dee400a56e84 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -340,6 +340,8 @@ extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void lru_add_page_tail(struct page *page, struct page *page_tail,
 			 struct lruvec *lruvec, struct list_head *head);
+extern void lru_add_pud_page_tail(struct page *page, struct page *page_tail,
+			 struct lruvec *lruvec, struct list_head *head);
 extern void mark_page_accessed(struct page *);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 416d9966fa3f..cf2b5632b96c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -97,6 +97,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_FAULT_FALLBACK_PUD,
 		THP_FAULT_FALLBACK_PUD_CHARGE,
 		THP_SPLIT_PUD,
+		THP_SPLIT_PUD_PAGE,
+		THP_SPLIT_PUD_PAGE_FAILED,
+		THP_ZERO_PUD_PAGE_ALLOC,
+		THP_ZERO_PUD_PAGE_ALLOC_FAILED,
 #endif
 		THP_ZERO_PAGE_ALLOC,
 		THP_ZERO_PAGE_ALLOC_FAILED,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6716c5286494..4a899e856088 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1775,7 +1775,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			page = pmd_page(orig_pmd);
 			page_remove_rmap(page, HPAGE_PMD_ORDER);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
-			VM_BUG_ON_PAGE(!PageHead(page), page);
+			VM_BUG_ON_PAGE(!PageHead(page) && !PMDPageInPUD(page), page);
 		} else if (thp_migration_supported()) {
 			swp_entry_t entry;
 
@@ -2082,8 +2082,16 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 }
 
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
-		unsigned long haddr)
+		unsigned long haddr, bool freeze)
 {
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page;
+	pgtable_t pgtable;
+	pud_t _pud, old_pud;
+	bool young, write, dirty, soft_dirty;
+	unsigned long addr;
+	int i;
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
@@ -2091,23 +2099,141 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
 	count_vm_event(THP_SPLIT_PUD);
 
-	pudp_huge_clear_flush_notify(vma, haddr, pud);
+	if (!vma_is_anonymous(vma)) {
+		_pud = pudp_huge_clear_flush_notify(vma, haddr, pud);
+		/*
+		 * We are going to unmap this huge page. So
+		 * just go ahead and zap it
+		 */
+		if (arch_needs_pgtable_deposit())
+			zap_pud_deposited_table(mm, pud);
+		if (vma_is_dax(vma))
+			return;
+		page = pud_page(_pud);
+		if (!PageReferenced(page) && pud_young(_pud))
+			SetPageReferenced(page);
+		page_remove_rmap(page, HPAGE_PUD_ORDER);
+		put_page(page);
+		add_mm_counter(mm, MM_FILEPAGES, -HPAGE_PUD_NR);
+		return;
+	}
+
+	/* See the comment above pmdp_invalidate() in __split_huge_pmd_locked() */
+	old_pud = pudp_invalidate(vma, haddr, pud);
+
+	page = pud_page(old_pud);
+	VM_BUG_ON_PAGE(!page_count(page), page);
+	page_ref_add(page, (1<<(HPAGE_PUD_ORDER-HPAGE_PMD_ORDER)) - 1);
+	if (pud_dirty(old_pud))
+		SetPageDirty(page);
+	write = pud_write(old_pud);
+	young = pud_young(old_pud);
+	dirty = pud_dirty(old_pud);
+	soft_dirty = pud_soft_dirty(old_pud);
+
+	pgtable = pgtable_trans_huge_pud_withdraw(mm, pud);
+	pud_populate_with_pgtable(mm, &_pud, pgtable);
+
+	for (i = 0, addr = haddr; i < HPAGE_PUD_NR;
+		 i += HPAGE_PMD_NR, addr += PMD_SIZE) {
+		pmd_t entry, *pmd;
+		/*
+		 * Note that NUMA hinting access restrictions are not
+		 * transferred to avoid any possibility of altering
+		 * permissions across VMAs.
+		 */
+		if (freeze) {
+			swp_entry_t swp_entry;
+
+			swp_entry = make_migration_entry(page + i, write);
+			entry = swp_entry_to_pmd(swp_entry);
+			if (soft_dirty)
+				entry = pmd_swp_mksoft_dirty(entry);
+		} else {
+			entry = mk_huge_pmd(page + i, READ_ONCE(vma->vm_page_prot));
+			entry = maybe_pmd_mkwrite(entry, vma);
+			if (!write)
+				entry = pmd_wrprotect(entry);
+			if (!young)
+				entry = pmd_mkold(entry);
+			if (soft_dirty)
+				entry = pmd_mksoft_dirty(entry);
+		}
+		pmd = pmd_offset(&_pud, addr);
+		VM_BUG_ON(!pmd_none(*pmd));
+		set_pmd_at(mm, addr, pmd, entry);
+		/* distinguish between pud compound_mapcount and pmd compound_mapcount */
+		if (atomic_inc_and_test(sub_compound_mapcount_ptr(&page[i], 1))) {
+			/* first pmd-mapped pud page */
+			lock_page_memcg(page);
+			__inc_lruvec_page_state(page, NR_ANON_THPS);
+			unlock_page_memcg(page);
+		}
+	}
+
+	/*
+	 * Set PG_double_map before dropping compound_mapcount to avoid
+	 * false-negative page_mapped().
+	 */
+	if (compound_mapcount(page) > 1 && !TestSetPagePUDDoubleMap(page)) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+		/* distinguish between pud compound_mapcount and pmd compound_mapcount */
+			atomic_inc(sub_compound_mapcount_ptr(&page[i], 1));
+	}
+
+	lock_page_memcg(page);
+	if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
+		/* Last compound_mapcount is gone. */
+		__dec_lruvec_page_state(page, NR_ANON_THPS_PUD);
+		if (TestClearPagePUDDoubleMap(page)) {
+			/* No need in mapcount reference anymore */
+			for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+		/* distinguish between pud compound_mapcount and pmd compound_mapcount */
+				atomic_dec(sub_compound_mapcount_ptr(&page[i], 1));
+		}
+	}
+	unlock_page_memcg(page);
+
+	smp_wmb(); /* make pte visible before pmd */
+	pud_populate_with_pgtable(mm, pud, pgtable);
+
+	if (freeze) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR) {
+			page_remove_rmap(page + i, HPAGE_PMD_ORDER);
+			put_page(page + i);
+		}
+	}
 }
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-		unsigned long address)
+		unsigned long address, bool freeze, struct page *page)
 {
 	spinlock_t *ptl;
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long haddr = address & HPAGE_PUD_MASK;
 	struct mmu_notifier_range range;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address & HPAGE_PUD_MASK,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
-	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	ptl = pud_lock(mm, pud);
+
+	/*
+	 * If caller asks to setup a migration entries, we need a page to check
+	 * pmd against. Otherwise we can end up replacing wrong page.
+	 */
+	VM_BUG_ON(freeze && !page);
+	if (page && page != pud_page(*pud))
+		goto out;
+
+	if (pud_trans_huge(*pud)) {
+		page = pud_page(*pud);
+		if (PageMlocked(page))
+			clear_page_mlock(page);
+	} else if (unlikely(!pud_devmap(*pud)))
 		goto out;
-	__split_huge_pud_locked(vma, pud, range.start);
+	__split_huge_pud_locked(vma, pud, haddr, freeze);
 
 out:
 	spin_unlock(ptl);
@@ -2117,6 +2243,280 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 	 */
 	mmu_notifier_invalidate_range_only_end(&range);
 }
+
+void split_huge_pud_address(struct vm_area_struct *vma, unsigned long address,
+		bool freeze, struct page *page)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	pgd = pgd_offset(vma->vm_mm, address);
+	if (!pgd_present(*pgd))
+		return;
+
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return;
+
+	pud = pud_offset(p4d, address);
+
+	__split_huge_pud(vma, pud, address, freeze, page);
+}
+
+static void unmap_pud_page(struct page *page)
+{
+	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
+		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PUD;
+	bool unmap_success;
+
+	VM_BUG_ON_PAGE(!PageHead(page), page);
+
+	if (PageAnon(page))
+		ttu_flags |= TTU_SPLIT_FREEZE;
+
+	unmap_success = try_to_unmap(page, ttu_flags);
+	VM_BUG_ON_PAGE(!unmap_success, page);
+}
+
+static void remap_pud_page(struct page *page)
+{
+	int i;
+
+	VM_BUG_ON(!PageTransHuge(page));
+	if (compound_order(page) == HPAGE_PUD_ORDER) {
+		remove_migration_ptes(page, page, true);
+	} else if (compound_order(page) == HPAGE_PMD_ORDER) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+			remove_migration_ptes(page + i, page + i, true);
+	} else
+		VM_BUG_ON_PAGE(1, page);
+}
+
+static void __split_huge_pud_page_tail(struct page *head, int tail,
+		struct lruvec *lruvec, struct list_head *list)
+{
+	struct page *page_tail = head + tail;
+
+	VM_BUG_ON_PAGE(page_ref_count(page_tail) != 0, page_tail);
+
+	/*
+	 * Clone page flags before unfreezing refcount.
+	 *
+	 * After successful get_page_unless_zero() might follow flags change,
+	 * for example lock_page() which set PG_waiters.
+	 */
+
+	page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page_tail->flags |= (head->flags &
+			((1L << PG_referenced) |
+			 (1L << PG_swapbacked) |
+			 (1L << PG_swapcache) |
+			 (1L << PG_mlocked) |
+			 (1L << PG_uptodate) |
+			 (1L << PG_active) |
+			 (1L << PG_locked) |
+			 (1L << PG_unevictable) |
+			 (1L << PG_dirty) |
+			 /* preserve THP */
+			 (1L << PG_head)));
+
+	/* ->mapping in first tail page is compound_mapcount */
+	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
+			page_tail);
+	page_tail->mapping = head->mapping;
+	page_tail->index = head->index + tail;
+
+	/* Page flags also must be visible before we make the page PMD-compound. */
+	smp_wmb();
+
+	clear_compound_head(page_tail);
+	prep_compound_page(page_tail, HPAGE_PMD_ORDER);
+	prep_transhuge_page(page_tail);
+
+	/* Finally unfreeze refcount. Additional reference from page cache. */
+	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
+					  PageSwapCache(head)));
+
+	if (page_is_young(head))
+		set_page_young(page_tail);
+	if (page_is_idle(head))
+		set_page_idle(page_tail);
+
+	page_cpupid_xchg_last(page_tail, page_cpupid_last(head));
+	lru_add_pud_page_tail(head, page_tail, lruvec, list);
+}
+
+static void __split_huge_pud_page(struct page *page, struct list_head *list,
+		unsigned long flags)
+{
+	struct page *head = compound_head(page);
+	pg_data_t *pgdat = page_pgdat(head);
+	struct lruvec *lruvec;
+	int i;
+
+	lruvec = mem_cgroup_page_lruvec(head, pgdat);
+
+	/* complete memcg works before add pages to LRU */
+	mem_cgroup_split_huge_pud_fixup(head);
+
+	/* no file-back page support yet */
+	VM_BUG_ON(!PageAnon(page));
+
+	for (i = HPAGE_PUD_NR - HPAGE_PMD_NR; i >= 1; i -= HPAGE_PMD_NR)
+		__split_huge_pud_page_tail(head, i, lruvec, list);
+
+	/* reset head page order  */
+	prep_compound_page(head, HPAGE_PMD_ORDER);
+	prep_transhuge_page(head);
+
+	page_ref_inc(head);
+
+	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
+
+	remap_pud_page(head);
+
+	for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR) {
+		struct page *subpage = head + i;
+
+		if (subpage == page)
+			continue;
+		unlock_page(subpage);
+
+		/*
+		 * Subpages may be freed if there wasn't any mapping
+		 * like if add_to_swap() is running on a lru page that
+		 * had its mapping zapped. And freeing these pages
+		 * requires taking the lru_lock so we do the put_page
+		 * of the tail pages after the split is complete.
+		 */
+		put_page(subpage);
+	}
+}
+/* Racy check whether the huge page can be split */
+bool can_split_huge_pud_page(struct page *page, int *pextra_pins)
+{
+	int extra_pins;
+
+	VM_BUG_ON(!PageAnon(page));
+
+	extra_pins = PageSwapCache(page) ? HPAGE_PUD_NR : 0;
+
+	if (pextra_pins)
+		*pextra_pins = extra_pins;
+	return total_mapcount(page) == page_count(page) - extra_pins - 1;
+}
+
+/*
+ * This function splits huge page into normal pages. @page can point to any
+ * subpage of huge page to split. Split doesn't change the position of @page.
+ *
+ * Only caller must hold pin on the @page, otherwise split fails with -EBUSY.
+ * The huge page must be locked.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * Both head page and tail pages will inherit mapping, flags, and so on from
+ * the hugepage.
+ *
+ * GUP pin and PG_locked transferred to @page. Rest subpages can be freed if
+ * they are not mapped.
+ *
+ * Returns 0 if the hugepage is split successfully.
+ * Returns -EBUSY if the page is pinned or if anon_vma disappeared from under
+ * us.
+ */
+int split_huge_pud_page_to_list(struct page *page, struct list_head *list)
+{
+	struct page *head = compound_head(page);
+	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
+	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	struct anon_vma *anon_vma = NULL;
+	struct address_space *mapping = NULL;
+	int count, mapcount, extra_pins, ret;
+	bool mlocked;
+	unsigned long flags;
+
+	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	VM_BUG_ON_PAGE(!PageAnon(page), page);
+
+	if (PageWriteback(page))
+		return -EBUSY;
+
+	/*
+	 * The caller does not necessarily hold an mmap_sem that would
+	 * prevent the anon_vma disappearing so we first we take a
+	 * reference to it and then lock the anon_vma for write. This
+	 * is similar to page_lock_anon_vma_read except the write lock
+	 * is taken to serialise against parallel split or collapse
+	 * operations.
+	 */
+	anon_vma = page_get_anon_vma(head);
+	if (!anon_vma) {
+		ret = -EBUSY;
+		goto out;
+	}
+	mapping = NULL;
+	anon_vma_lock_write(anon_vma);
+	/*
+	 * Racy check if we can split the page, before unmap_pud_page() will
+	 * split PUDs
+	 */
+	if (!can_split_huge_pud_page(head, &extra_pins)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	mlocked = PageMlocked(page);
+	unmap_pud_page(head);
+	VM_BUG_ON_PAGE(compound_mapcount(head), head);
+
+	/* Make sure the page is not on per-CPU pagevec as it takes pin */
+	if (mlocked)
+		lru_add_drain();
+
+	/* prevent PageLRU to go away from under us, and freeze lru stats */
+	spin_lock_irqsave(&pgdata->lru_lock, flags);
+
+	/* Prevent deferred_split_scan() touching ->_refcount */
+	spin_lock(&ds_queue->split_queue_lock);
+	count = page_count(head);
+	mapcount = total_mapcount(head);
+	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
+		if (!list_empty(page_deferred_list(head))) {
+			ds_queue->split_queue_len--;
+			list_del(page_deferred_list(head));
+		}
+		if (mapping)
+			__dec_node_page_state(page, NR_SHMEM_THPS);
+		spin_unlock(&ds_queue->split_queue_lock);
+		__split_huge_pud_page(page, list, flags);
+		ret = 0;
+	} else {
+		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
+			pr_alert("total_mapcount: %u, page_count(): %u\n",
+					mapcount, count);
+			if (PageTail(page))
+				dump_page(head, NULL);
+			dump_page(page, "total_mapcount(head) > 0");
+		}
+		spin_unlock(&ds_queue->split_queue_lock);
+		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
+		remap_pud_page(head);
+		ret = -EBUSY;
+	}
+
+out_unlock:
+	if (anon_vma) {
+		anon_vma_unlock_write(anon_vma);
+		put_anon_vma(anon_vma);
+	}
+out:
+	count_vm_event(!ret ? THP_SPLIT_PUD_PAGE : THP_SPLIT_PUD_PAGE_FAILED);
+	return ret;
+}
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
@@ -2157,7 +2557,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
+	struct page *page, *head;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
 	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
@@ -2246,7 +2646,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		uffd_wp = pmd_uffd_wp(old_pmd);
 	}
 	VM_BUG_ON_PAGE(!page_count(page), page);
-	page_ref_add(page, HPAGE_PMD_NR - 1);
+	head = compound_head(page);
+	page_ref_add(head, HPAGE_PMD_NR - 1);
 
 	/*
 	 * Withdraw the table only after we mark the pmd entry invalid.
@@ -2294,15 +2695,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		/*
 		 * Set PG_double_map before dropping compound_mapcount to avoid
 		 * false-negative page_mapped().
+		 * Don't set it if the PUD page is mapped at PUD level, since
+		 * page_mapped() is true in that case.
 		 */
-		if (compound_mapcount(page) > 1 &&
-		    !TestSetPageDoubleMap(page)) {
+		if (((PMDPageInPUD(page) &&
+			sub_compound_mapcount(page) >
+				(1 + PagePUDDoubleMap(compound_head(page)))) ||
+		    (!PMDPageInPUD(page) &&
+			compound_mapcount(page) > 1))
+			&& !TestSetPageDoubleMap(page)) {
 			for (i = 0; i < HPAGE_PMD_NR; i++)
 				atomic_inc(&page[i]._mapcount);
 		}
 
 		lock_page_memcg(page);
-		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
+
+		if ((PMDPageInPUD(page) &&
+			atomic_add_negative(-1, sub_compound_mapcount_ptr(page, 1))) ||
+		    (!PMDPageInPUD(page) &&
+			atomic_add_negative(-1, compound_mapcount_ptr(page)))) {
 			/* Last compound_mapcount is gone. */
 			__dec_lruvec_page_state(page, NR_ANON_THPS);
 			if (TestClearPageDoubleMap(page)) {
@@ -2430,6 +2841,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	 * previously contain an hugepage: check if we need to split
 	 * an huge pmd.
 	 */
+	if (start & ~HPAGE_PUD_MASK &&
+	    (start & HPAGE_PUD_MASK) >= vma->vm_start &&
+	    (start & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE <= vma->vm_end)
+		split_huge_pud_address(vma, start, false, NULL);
+
 	if (start & ~HPAGE_PMD_MASK &&
 	    (start & HPAGE_PMD_MASK) >= vma->vm_start &&
 	    (start & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= vma->vm_end)
@@ -2440,6 +2856,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	 * previously contain an hugepage: check if we need to split
 	 * an huge pmd.
 	 */
+	if (end & ~HPAGE_PUD_MASK &&
+	    (end & HPAGE_PUD_MASK) >= vma->vm_start &&
+	    (end & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE <= vma->vm_end)
+		split_huge_pud_address(vma, end, false, NULL);
+
 	if (end & ~HPAGE_PMD_MASK &&
 	    (end & HPAGE_PMD_MASK) >= vma->vm_start &&
 	    (end & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= vma->vm_end)
@@ -2454,6 +2875,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long nstart = next->vm_start;
 		nstart += adjust_next;
+		if (nstart & ~HPAGE_PUD_MASK &&
+		    (nstart & HPAGE_PUD_MASK) >= next->vm_start &&
+		    (nstart & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE <= next->vm_end)
+			split_huge_pud_address(next, nstart, false, NULL);
+
 		if (nstart & ~HPAGE_PMD_MASK &&
 		    (nstart & HPAGE_PMD_MASK) >= next->vm_start &&
 		    (nstart & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= next->vm_end)
@@ -2645,12 +3071,23 @@ int total_mapcount(struct page *page)
 	if (PageHuge(page))
 		return compound;
 	ret = compound;
-	for (i = 0; i < nr; i++)
-		ret += atomic_read(&page[i]._mapcount) + 1;
+	/* if PMD, read all base page, if PUD, read the sub_compound_mapcount()*/
+	if (compound_order(page) == HPAGE_PMD_ORDER) {
+		for (i = 0; i < nr; i++)
+			ret += atomic_read(&page[i]._mapcount) + 1;
+	} else if (compound_order(page) == HPAGE_PUD_ORDER) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+			ret += sub_compound_mapcount(&page[i]);
+		for (i = 0; i < nr; i++)
+			ret += atomic_read(&page[i]._mapcount) + 1;
+		/* both PUD and PMD has HPAGE_PMD_NR sub pages */
+		nr = HPAGE_PMD_NR;
+	} else
+		VM_BUG_ON_PAGE(1, page);
 	/* File pages has compound_mapcount included in _mapcount */
 	if (!PageAnon(page))
 		return ret - compound * nr;
-	if (PageDoubleMap(page))
+	if (PagePUDDoubleMap(page) || PageDoubleMap(page))
 		ret -= nr;
 	return ret;
 }
@@ -2681,7 +3118,7 @@ int total_mapcount(struct page *page)
  */
 int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
 {
-	int i, ret, _total_mapcount, mapcount;
+	int i, ret, _total_mapcount, mapcount, nr;
 
 	/* hugetlbfs shouldn't call it */
 	VM_BUG_ON_PAGE(PageHuge(page), page);
@@ -2696,14 +3133,41 @@ int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
 	page = compound_head(page);
 
 	_total_mapcount = ret = 0;
-	for (i = 0; i < thp_nr_pages(page); i++) {
-		mapcount = atomic_read(&page[i]._mapcount) + 1;
-		ret = max(ret, mapcount);
-		_total_mapcount += mapcount;
-	}
-	if (PageDoubleMap(page)) {
+	nr = thp_nr_pages(page);
+	/* if PMD, read all base page, if PUD, read the sub_compound_mapcount()*/
+	if (compound_order(page) == HPAGE_PMD_ORDER) {
+		for (i = 0; i < nr; i++) {
+			mapcount = atomic_read(&page[i]._mapcount) + 1;
+			ret = max(ret, mapcount);
+			_total_mapcount += mapcount;
+		}
+	} else if (compound_order(page) == HPAGE_PUD_ORDER) {
+		for (i = 0; i < nr; i += HPAGE_PMD_NR) {
+			int j;
+
+			mapcount = sub_compound_mapcount(&page[i]);
+			ret = max(ret, mapcount);
+			_total_mapcount += mapcount;
+
+			/* Triple mapped at base page size */
+			for (j = 0; j < HPAGE_PMD_NR; j++) {
+				mapcount = atomic_read(&page[i + j]._mapcount) + 1;
+				ret = max(ret, mapcount);
+				_total_mapcount += mapcount;
+			}
+
+			if (PageDoubleMap(&page[i])) {
+				ret -= 1;
+				_total_mapcount -= HPAGE_PMD_NR;
+			}
+		}
+		/* both PUD and PMD has HPAGE_PMD_NR sub pages */
+		nr = HPAGE_PMD_NR;
+	} else
+		VM_BUG_ON_PAGE(1, page);
+	if (PageDoubleMap(page) || PagePUDDoubleMap(page)) {
 		ret -= 1;
-		_total_mapcount -= thp_nr_pages(page);
+		_total_mapcount -= nr;
 	}
 	mapcount = compound_mapcount(page);
 	ret += mapcount;
@@ -2948,6 +3412,9 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 	return READ_ONCE(ds_queue->split_queue_len);
 }
 
+#define deferred_list_entry(x) (compound_head(list_entry((void *)x, \
+					struct page, mapping)))
+
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
@@ -2981,12 +3448,18 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	list_for_each_safe(pos, next, &list) {
-		page = list_entry((void *)pos, struct page, mapping);
+		page = deferred_list_entry(pos);
 		if (!trylock_page(page))
 			goto next;
 		/* split_huge_page() removes page from list on success */
-		if (!split_huge_page(page))
-			split++;
+		if (compound_order(page) == HPAGE_PUD_ORDER) {
+			if (!split_huge_pud_page(page))
+				split++;
+		} else if (compound_order(page) == HPAGE_PMD_ORDER) {
+			if (!split_huge_page(page))
+				split++;
+		} else
+			VM_BUG_ON_PAGE(1, page);
 		unlock_page(page);
 next:
 		put_page(page);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b28f620c1c5b..ed75ef95b24a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3281,6 +3281,19 @@ void mem_cgroup_split_huge_fixup(struct page *head)
 		head[i].mem_cgroup = memcg;
 	}
 }
+
+void mem_cgroup_split_huge_pud_fixup(struct page *head)
+{
+	int i;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	for (i = HPAGE_PMD_NR; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+		head[i].mem_cgroup = head->mem_cgroup;
+
+	/*__mod_memcg_state(head->mem_cgroup, MEMCG_RSS_HUGE, -HPAGE_PUD_NR);*/
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_MEMCG_SWAP
diff --git a/mm/memory.c b/mm/memory.c
index 37e206a7d213..e0e0459c0caf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4133,7 +4133,7 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 	}
 split:
 	/* COW or write-notify not handled on PUD level: split pud.*/
-	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
+	__split_huge_pud(vmf->vma, vmf->pud, vmf->address, false, NULL);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 	return VM_FAULT_FALLBACK;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 29abeff09fcc..6bdb38a8fb48 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -679,6 +679,9 @@ void prep_compound_page(struct page *page, unsigned int order)
 	atomic_set(compound_mapcount_ptr(page), -1);
 	if (hpage_pincount_available(page))
 		atomic_set(compound_pincount_ptr(page), 0);
+	if (order == HPAGE_PUD_ORDER)
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+			atomic_set(sub_compound_mapcount_ptr(&page[i], 1), -1);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
@@ -1132,6 +1135,16 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 		 */
 		break;
 	default:
+		/* sub_compound_map_ptr store here */
+		if (compound_order(head_page) == HPAGE_PUD_ORDER &&
+			(page - head_page) % HPAGE_PMD_NR == 3) {
+			if (unlikely(atomic_read(&page->compound_mapcount) != -1)) {
+				pr_err("sub_compound_mapcount: %d\n",
+				       atomic_read(&page->compound_mapcount) + 1);
+				bad_page(page, "nonzero sub_compound_mapcount");
+			}
+			break;
+		}
 		if (page->mapping != TAIL_MAPPING) {
 			bad_page(page, "corrupted mapping in tail page");
 			goto out;
@@ -1183,8 +1196,14 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
 
-		if (compound)
+		if (compound) {
 			ClearPageDoubleMap(page);
+			if (order == HPAGE_PUD_ORDER) {
+				ClearPagePUDDoubleMap(page);
+				for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR)
+					ClearPageDoubleMap(&page[i]);
+			}
+		}
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a3752c82a7b2..c190140637c9 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -160,7 +160,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (walk->vma) {
 			split_huge_pud(walk->vma, pudp, addr);
 			pud = READ_ONCE(*pudp);
-			if (pud_none(pud))
+			if (pud_trans_unstable(&pud))
 				goto again;
 		}
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a014cf847067..2b83dd4807e5 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -218,6 +218,17 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_INVALIDATE
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		     pud_t *pudp)
+{
+	pud_t old = pudp_establish(vma, address, pudp, pud_mknotpresent(*pudp));
+
+	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	return old;
+}
+#endif
+
 #ifndef pmdp_collapse_flush
 pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 			  pmd_t *pmdp)
diff --git a/mm/rmap.c b/mm/rmap.c
index 7fc0bf07b9bc..b4950f7a0978 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1132,10 +1132,21 @@ void do_page_add_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
 	if (compound) {
-		atomic_t *mapcount;
+		atomic_t *mapcount = NULL;
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
-		mapcount = compound_mapcount_ptr(page);
+		if (compound_order(page) == HPAGE_PUD_ORDER) {
+			if (map_order == HPAGE_PUD_ORDER) {
+				mapcount = compound_mapcount_ptr(page);
+			} else if (map_order == HPAGE_PMD_ORDER) {
+				VM_BUG_ON(!PMDPageInPUD(page));
+				mapcount = sub_compound_mapcount_ptr(page, 1);
+			} else
+				VM_BUG_ON(1);
+		} else if (compound_order(page) == HPAGE_PMD_ORDER) {
+			mapcount = compound_mapcount_ptr(page);
+		} else
+			VM_BUG_ON(1);
 		first = atomic_inc_and_test(mapcount);
 	} else {
 		first = atomic_inc_and_test(&page->_mapcount);
@@ -1150,7 +1161,7 @@ void do_page_add_anon_rmap(struct page *page,
 		 * disabled.
 		 */
 		if (compound) {
-			if (nr == HPAGE_PMD_NR)
+			if (map_order == HPAGE_PMD_ORDER)
 				__inc_lruvec_page_state(page, NR_ANON_THPS);
 			else
 				__inc_lruvec_page_state(page, NR_ANON_THPS_PUD);
@@ -1197,10 +1208,15 @@ void page_add_new_anon_rmap(struct page *page,
 		if (hpage_pincount_available(page))
 			atomic_set(compound_pincount_ptr(page), 0);
 
-		if (nr == HPAGE_PMD_NR)
-			__inc_lruvec_page_state(page, NR_ANON_THPS);
-		else
+		if (map_order == HPAGE_PUD_ORDER) {
+			VM_BUG_ON(compound_order(page) != HPAGE_PUD_ORDER);
+			/* Anon THP always mapped first with PMD */
 			__inc_lruvec_page_state(page, NR_ANON_THPS_PUD);
+		} else if (map_order == HPAGE_PMD_ORDER) {
+			VM_BUG_ON(compound_order(page) != HPAGE_PMD_ORDER);
+			__inc_lruvec_page_state(page, NR_ANON_THPS);
+		} else
+			VM_BUG_ON(1);
 	} else {
 		/* Anon THP always mapped first with PMD */
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
@@ -1294,10 +1310,38 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 static void page_remove_anon_compound_rmap(struct page *page, int map_order)
 {
-	int i, nr;
+	int i, nr = 0;
+	struct page *head = compound_head(page);
+
+	if (compound_order(head) == HPAGE_PUD_ORDER) {
+		if (map_order == HPAGE_PMD_ORDER) {
+			VM_BUG_ON(!PMDPageInPUD(page));
+			if (atomic_add_negative(-1, sub_compound_mapcount_ptr(page, 1))) {
+				if (TestClearPageDoubleMap(page)) {
+					/*
+					 * Subpages can be mapped with PTEs too. Check how many of
+					 * themi are still mapped.
+					 */
+					for (i = 0; i < thp_nr_pages(head); i++) {
+						if (atomic_add_negative(-1, &head[i]._mapcount))
+							nr++;
+					}
+				}
+				__dec_node_page_state(page, NR_ANON_THPS);
+			}
+			nr += HPAGE_PMD_NR;
+			__mod_node_page_state(page_pgdat(head), NR_ANON_MAPPED, -nr);
+			return;
+		}
 
-	if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
-		return;
+		VM_BUG_ON(map_order != HPAGE_PUD_ORDER);
+		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
+			return;
+	} else if (compound_order(head) == HPAGE_PMD_ORDER) {
+		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
+			return;
+	} else
+		VM_BUG_ON_PAGE(1, page);
 
 	/* Hugepages are not counted in NR_ANON_PAGES for now. */
 	if (unlikely(PageHuge(page)))
@@ -1308,10 +1352,31 @@ static void page_remove_anon_compound_rmap(struct page *page, int map_order)
 
 	if (map_order == HPAGE_PMD_ORDER)
 		__dec_lruvec_page_state(page, NR_ANON_THPS);
-	else
+	else if (map_order == HPAGE_PUD_ORDER)
 		__dec_lruvec_page_state(page, NR_ANON_THPS_PUD);
+	else
+		VM_BUG_ON(1);
 
-	if (TestClearPageDoubleMap(page)) {
+	/* PMD-mapped PUD THP is handled above */
+	if (TestClearPagePUDDoubleMap(head)) {
+		VM_BUG_ON(!(compound_order(head) == HPAGE_PUD_ORDER || head == page));
+		/*
+		 * Subpages can be mapped with PMDs too. Check how many of
+		 * them are still mapped.
+		 */
+		for (i = 0, nr = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR) {
+			if (atomic_add_negative(-1, sub_compound_mapcount_ptr(&head[i], 1)))
+				nr += HPAGE_PMD_NR;
+		}
+		/*
+		 * Queue the page for deferred split if at least one pmd page
+		 * of the pud compound page is unmapped, but at least one
+		 * pmd page is still mapped.
+		 */
+		if (nr && nr < thp_nr_pages(head))
+			deferred_split_huge_page(head);
+	} else if (TestClearPageDoubleMap(head)) {
+		VM_BUG_ON(compound_order(head) != HPAGE_PMD_ORDER);
 		/*
 		 * Subpages can be mapped with PTEs too. Check how many of
 		 * them are still mapped.
@@ -1335,8 +1400,10 @@ static void page_remove_anon_compound_rmap(struct page *page, int map_order)
 	if (unlikely(PageMlocked(page)))
 		clear_page_mlock(page);
 
-	if (nr)
-		__mod_lruvec_page_state(page, NR_ANON_MAPPED, -nr);
+	if (nr) {
+		__mod_lruvec_page_state(head, NR_ANON_MAPPED, -nr);
+		deferred_split_huge_page(head);
+	}
 }
 
 /**
diff --git a/mm/swap.c b/mm/swap.c
index 7e79829a2e73..43c18e5b6916 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1005,6 +1005,36 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 					  page_lru(page_tail));
 	}
 }
+
+/* used by __split_pud_huge_page_tail() */
+void lru_add_pud_page_tail(struct page *page, struct page *page_tail,
+		       struct lruvec *lruvec, struct list_head *list)
+{
+	VM_BUG_ON_PAGE(!PageHead(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
+
+	if (!list)
+		SetPageLRU(page_tail);
+
+	if (likely(PageLRU(page)))
+		list_add_tail(&page_tail->lru, &page->lru);
+	else if (list) {
+		/* page reclaim is reclaiming a huge page */
+		get_page(page_tail);
+		list_add_tail(&page_tail->lru, list);
+	} else {
+		/*
+		 * Head page has not yet been counted, as an hpage,
+		 * so we must account for each subpage individually.
+		 *
+		 * Put page_tail on the list at the correct position
+		 * so they all end up in order.
+		 */
+		add_page_to_lru_list_tail(page_tail, lruvec,
+					  page_lru(page_tail));
+	}
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
diff --git a/mm/util.c b/mm/util.c
index bb902f5a6582..e22d04d9e020 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -653,6 +653,12 @@ bool page_mapped(struct page *page)
 	page = compound_head(page);
 	if (atomic_read(compound_mapcount_ptr(page)) >= 0)
 		return true;
+	if (compound_order(page) == HPAGE_PUD_ORDER) {
+		for (i = 0; i < HPAGE_PUD_NR; i += HPAGE_PMD_NR) {
+			if (sub_compound_mapcount(page + i) > 0)
+				return true;
+		}
+	}
 	if (PageHuge(page))
 		return false;
 	for (i = 0; i < compound_nr(page); i++) {
@@ -713,17 +719,27 @@ struct address_space *page_mapping_file(struct page *page)
 int __page_mapcount(struct page *page)
 {
 	int ret;
+	struct page *head = compound_head(page);
 
+	/* base page mapping */
 	ret = atomic_read(&page->_mapcount) + 1;
+
+	/* PMDInPUD mapping */
+	if (compound_order(head) == HPAGE_PUD_ORDER) {
+		struct page *sub_compound_page = head +
+			(((page - head) / HPAGE_PMD_NR) * HPAGE_PMD_NR);
+
+		ret += sub_compound_mapcount(sub_compound_page);
+	}
 	/*
 	 * For file THP page->_mapcount contains total number of mapping
 	 * of the page: no need to look into compound_mapcount.
 	 */
 	if (!PageAnon(page) && !PageHuge(page))
 		return ret;
-	page = compound_head(page);
-	ret += atomic_read(compound_mapcount_ptr(page)) + 1;
-	if (PageDoubleMap(page))
+	/* highest compound mapping */
+	ret += atomic_read(compound_mapcount_ptr(head)) + 1;
+	if (PageDoubleMap(head))
 		ret--;
 	return ret;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a9e50ef6a40d..2bb702d79f01 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1331,6 +1331,10 @@ const char * const vmstat_text[] = {
 	"thp_fault_fallback_pud",
 	"thp_fault_fallback_pud_charge",
 	"thp_split_pud",
+	"thp_split_pud_page",
+	"thp_split_pud_page_failed",
+	"thp_zero_pud_page_alloc",
+	"thp_zero_pud_page_alloc_failed",
 #endif
 	"thp_zero_page_alloc",
 	"thp_zero_page_alloc_failed",
-- 
2.28.0

