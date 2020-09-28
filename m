Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BC27B3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgI1SBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:24 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:47251 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbgI1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 75D5DE41;
        Mon, 28 Sep 2020 13:55:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=7v6dOQYL2X3KD
        +L3Optjt6XoQCTc8k9QrHm+vVl8mus=; b=ifGE3bk2Ya1oanKJQq3VYe/LYAh39
        AKN/UvwLpAbHeEZs8nvm3s0tv+RIOpbmro3Dd/amxZb0/1x4syyzeBzC4FX14OA3
        SXeqsTNrYDoo9m7RvuZ20v92ZRgzmJA0MfUpDPCVCxXBiRWryknxhNaxeynLsPtk
        LQzta6ZP9YIk2jG7HPh3JMgLfaLhVq40cBYcVZ+K0rMz8kTyXGspXaGe/Hl+Ap6Z
        oDK4yWHPXgrvY6tHToYOIHNoBv35aanAKy98xg9iKA6S/uixvJgXMI/mVkWcIwAy
        5Xb9PFICw4JV943rwhRAIQ9ueEKGqOBgKYsL0S/iK53jiYPkbRso4Pt4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7v6dOQYL2X3KD+L3Optjt6XoQCTc8k9QrHm+vVl8mus=; b=AbB0DpFI
        xvGjz/dzaDj4sX0cV6dB706UChhDZqLmQDI1+Kujh3tLs1qGtLF01mNJ4vxZLr5I
        jWsChplncE7yioNYP9E8vR2vbsi0Q6kWi6jOKZUyVDtQn4ikiuFDsXj/6GTzcH1w
        tDtHnfkQtyfqranSwI5WGdKZYDMcJ57Vw/sWnAqSAz5reiQfREN8H6ywaj/Eq6Ev
        TqtN8BeeJxPXhzuPtJ+aIU6He8CrXQAeI41J1GjlfRxvBd+vNAVbUmAiA2yYGgAW
        p4BXdCZiOO18K0cV7m5eAH3Do4L+OZjGO4T3SUbmYwQCer1vDqWKUJQgkZuoRV5X
        tl56iYTGQUUNQw==
X-ME-Sender: <xms:jSNyXwC2bt_1wkHOQAky3ScASDlwHJcETPwoj2xjOl7XfLD7utlxZA>
    <xme:jSNyXyiananiu0khknUPmVYU8wbhK_O6bL6eTPI9j7DySn_Q6q0rcr0CDUt53rJ0I
    oc0si5iqqpGQyrwJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jSNyXznr2pS62MHJk-pVaKld706Y6hmj6YfKwPWxKi3Lo0NPIiD6kg>
    <xmx:jSNyX2zJ-pt7mo2IHr6cggajRv65GhwIFlBgBwoxOpVqHhSITBXgYQ>
    <xmx:jSNyX1SPkk7LrH2PfYPvWtbNxLDkmjb6NaULvtgCbe5hqWYcwhRLoQ>
    <xmx:jiNyXxpKbsPpjup6Fc5-WlzqtDj0G0oL9lOvYBAcvY6dK9GlXYNVCDtNxIY>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 854B9306468A;
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
Subject: [RFC PATCH v2 21/30] mm: thp: PUD THP support in try_to_unmap().
Date:   Mon, 28 Sep 2020 13:54:19 -0400
Message-Id: <20200928175428.4110504-22-zi.yan@sent.com>
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

Unmap different subpages in different sized THPs properly in the
try_to_unmap() function. pvmw.pte, pvmw.pmd, pvmw.pud are used to
identify unmapped page sizes:

1. pvmw.pte != NULL: PTE pages or PageHuge.
2. pvmw.pte == NULL and pvmw.pmd != NULL: PMD pages.
3. pvmw.pte == NULL and pvmw.pmd == NULL and pvmw.pud != NULL: PUD pages.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c |   2 +-
 mm/rmap.c    | 156 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 117 insertions(+), 41 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a7320e9d859c..d0e6afe682aa 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -225,7 +225,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		/* PMD-mapped THP migration entry */
-		if (!pvmw.pte) {
+		if (!pvmw.pte && pvmw.pmd) {
 			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
 			remove_migration_pmd(&pvmw, new);
 			continue;
diff --git a/mm/rmap.c b/mm/rmap.c
index 424322807966..32f2e0312e16 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1125,6 +1125,7 @@ void do_page_add_anon_rmap(struct page *page,
 {
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
+	struct page *head = compound_head(page);
 
 	if (unlikely(PageKsm(page)))
 		lock_page_memcg(page);
@@ -1134,7 +1135,7 @@ void do_page_add_anon_rmap(struct page *page,
 	if (compound) {
 		atomic_t *mapcount = NULL;
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
+		VM_BUG_ON_PAGE(!PMDPageInPUD(page) && !PageTransHuge(page), page);
 		if (compound_order(page) == HPAGE_PUD_ORDER) {
 			if (map_order == HPAGE_PUD_ORDER) {
 				mapcount = compound_mapcount_ptr(page);
@@ -1143,7 +1144,7 @@ void do_page_add_anon_rmap(struct page *page,
 				mapcount = sub_compound_mapcount_ptr(page, 1);
 			} else
 				VM_BUG_ON(1);
-		} else if (compound_order(page) == HPAGE_PMD_ORDER) {
+		} else if (compound_order(head) == HPAGE_PMD_ORDER) {
 			mapcount = compound_mapcount_ptr(page);
 		} else
 			VM_BUG_ON(1);
@@ -1153,7 +1154,7 @@ void do_page_add_anon_rmap(struct page *page,
 	}
 
 	if (first) {
-		int nr = compound ? thp_nr_pages(page) : 1;
+		int nr = 1<<map_order;
 		/*
 		 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
 		 * these counters are not modified in interrupt context, and
@@ -1474,10 +1475,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		.address = address,
 	};
 	pte_t pteval;
-	struct page *subpage;
+	pmd_t pmdval;
+	pud_t pudval;
+	struct page *subpage = NULL;
 	bool ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	int map_order = 0;
 
 	/* munlock has nothing to gain from examining un-locked vmas */
 	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
@@ -1487,6 +1491,11 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	    is_zone_device_page(page) && !is_device_private_page(page))
 		return true;
 
+	if (flags & TTU_SPLIT_HUGE_PUD) {
+		split_huge_pud_address(vma, address,
+				flags & TTU_SPLIT_FREEZE, page);
+	}
+
 	if (flags & TTU_SPLIT_HUGE_PMD) {
 		split_huge_pmd_address(vma, address,
 				flags & TTU_SPLIT_FREEZE, page);
@@ -1519,7 +1528,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	while (page_vma_mapped_walk(&pvmw)) {
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		/* PMD-mapped THP migration entry */
-		if (!pvmw.pte && (flags & TTU_MIGRATION)) {
+		if (!pvmw.pte && pvmw.pmd && (flags & TTU_MIGRATION)) {
 			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
 
 			set_pmd_migration_entry(&pvmw, page);
@@ -1551,9 +1560,25 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		}
 
 		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_PAGE(!pvmw.pte, page);
 
-		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+		if (pvmw.pte) {
+			subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
+			/*
+			 * PageHuge always uses pvmw.pte to store relevant page
+			 * table entry
+			 */
+			if (PageHuge(page))
+				map_order = compound_order(page);
+			else
+				map_order = 0;
+		} else if (!pvmw.pte && pvmw.pmd) {
+			subpage = page - page_to_pfn(page) + pmd_pfn(*pvmw.pmd);
+			map_order = HPAGE_PMD_ORDER;
+		} else if (!pvmw.pte && !pvmw.pmd && pvmw.pud) {
+			subpage = page - page_to_pfn(page) + pud_pfn(*pvmw.pud);
+			map_order = HPAGE_PUD_ORDER;
+		}
+		VM_BUG_ON(!subpage);
 		address = pvmw.address;
 
 		if (PageHuge(page)) {
@@ -1631,8 +1656,12 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		}
 
 		if (!(flags & TTU_IGNORE_ACCESS)) {
-			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte)) {
+			if ((pvmw.pte &&
+				 ptep_clear_flush_young_notify(vma, address, pvmw.pte)) ||
+				((!pvmw.pte && pvmw.pmd) &&
+				 pmdp_clear_flush_young_notify(vma, address, pvmw.pmd)) ||
+				((!pvmw.pte && !pvmw.pmd && pvmw.pud) &&
+				 pudp_clear_flush_young_notify(vma, address, pvmw.pud))) {
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
@@ -1640,7 +1669,12 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		}
 
 		/* Nuke the page table entry. */
-		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+		if (pvmw.pte)
+			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+		else if (!pvmw.pte && pvmw.pmd)
+			flush_cache_page(vma, address, pmd_pfn(*pvmw.pmd));
+		else if (!pvmw.pte && !pvmw.pmd && pvmw.pud)
+			flush_cache_page(vma, address, pud_pfn(*pvmw.pud));
 		if (should_defer_flush(mm, flags)) {
 			/*
 			 * We clear the PTE but do not flush so potentially
@@ -1650,16 +1684,34 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			 * transition on a cached TLB entry is written through
 			 * and traps if the PTE is unmapped.
 			 */
-			pteval = ptep_get_and_clear(mm, address, pvmw.pte);
+			if (pvmw.pte) {
+				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
+
+				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+			} else if (!pvmw.pte && pvmw.pmd) {
+				pmdval = pmdp_huge_get_and_clear(mm, address, pvmw.pmd);
 
-			set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				set_tlb_ubc_flush_pending(mm, pmd_dirty(pmdval));
+			} else if (!pvmw.pte && !pvmw.pmd && pvmw.pud) {
+				pudval = pudp_huge_get_and_clear(mm, address, pvmw.pud);
+
+				set_tlb_ubc_flush_pending(mm, pud_dirty(pudval));
+			}
 		} else {
-			pteval = ptep_clear_flush(vma, address, pvmw.pte);
+			if (pvmw.pte)
+				pteval = ptep_clear_flush(vma, address, pvmw.pte);
+			else if (!pvmw.pte && pvmw.pmd)
+				pmdval = pmdp_huge_clear_flush(vma, address, pvmw.pmd);
+			else if (!pvmw.pte && !pvmw.pmd && pvmw.pud)
+				pudval = pudp_huge_clear_flush(vma, address, pvmw.pud);
 		}
 
 		/* Move the dirty bit to the page. Now the pte is gone. */
-		if (pte_dirty(pteval))
-			set_page_dirty(page);
+			if ((pvmw.pte && pte_dirty(pteval)) ||
+				((!pvmw.pte && pvmw.pmd) && pmd_dirty(pmdval)) ||
+				((!pvmw.pte && !pvmw.pmd && pvmw.pud) && pud_dirty(pudval))
+				)
+				set_page_dirty(page);
 
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
@@ -1694,35 +1746,59 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		} else if (IS_ENABLED(CONFIG_MIGRATION) &&
 				(flags & (TTU_MIGRATION|TTU_SPLIT_FREEZE))) {
 			swp_entry_t entry;
-			pte_t swp_pte;
 
-			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
-				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
-			}
+			if (pvmw.pte) {
+				pte_t swp_pte;
 
-			/*
-			 * Store the pfn of the page in a special migration
-			 * pte. do_swap_page() will wait until the migration
-			 * pte is removed and then restart fault handling.
-			 */
-			entry = make_migration_entry(subpage,
-					pte_write(pteval));
-			swp_pte = swp_entry_to_pte(entry);
-			if (pte_soft_dirty(pteval))
-				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-			if (pte_uffd_wp(pteval))
-				swp_pte = pte_swp_mkuffd_wp(swp_pte);
-			set_pte_at(mm, address, pvmw.pte, swp_pte);
-			/*
-			 * No need to invalidate here it will synchronize on
-			 * against the special swap migration pte.
-			 */
+				if (arch_unmap_one(mm, vma, address, pteval) < 0) {
+					set_pte_at(mm, address, pvmw.pte, pteval);
+					ret = false;
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+
+				/*
+				 * Store the pfn of the page in a special migration
+				 * pte. do_swap_page() will wait until the migration
+				 * pte is removed and then restart fault handling.
+				 */
+				entry = make_migration_entry(subpage,
+						pte_write(pteval));
+				swp_pte = swp_entry_to_pte(entry);
+				if (pte_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+				set_pte_at(mm, address, pvmw.pte, swp_pte);
+				/*
+				 * No need to invalidate here it will synchronize on
+				 * against the special swap migration pte.
+				 */
+			} else if (!pvmw.pte && pvmw.pmd) {
+				pmd_t swp_pmd;
+				/*
+				 * Store the pfn of the page in a special migration
+				 * pte. do_swap_page() will wait until the migration
+				 * pte is removed and then restart fault handling.
+				 */
+				entry = make_migration_entry(subpage,
+						pmd_write(pmdval));
+				swp_pmd = swp_entry_to_pmd(entry);
+				if (pmd_soft_dirty(pmdval))
+					swp_pmd = pmd_swp_mksoft_dirty(swp_pmd);
+				set_pmd_at(mm, address, pvmw.pmd, swp_pmd);
+				/*
+				 * No need to invalidate here it will synchronize on
+				 * against the special swap migration pte.
+				 */
+			} else if (!pvmw.pte && !pvmw.pmd && pvmw.pud) {
+				VM_BUG_ON(1);
+			}
 		} else if (PageAnon(page)) {
 			swp_entry_t entry = { .val = page_private(subpage) };
 			pte_t swp_pte;
+
+			VM_BUG_ON(!pvmw.pte);
 			/*
 			 * Store the swap location in the pte.
 			 * See handle_pte_fault() ...
@@ -1808,7 +1884,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, compound_order(page));
+		page_remove_rmap(subpage, map_order);
 		put_page(page);
 	}
 
-- 
2.28.0

