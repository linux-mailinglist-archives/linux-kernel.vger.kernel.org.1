Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB2727B3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgI1SB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:26 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:40979 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1A50EE77;
        Mon, 28 Sep 2020 13:55:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=jf9MOR3sBUMFg
        yxBaYyCCqhD9F08ttqVhQdqPvz+Nqc=; b=FDCNTYRTGUIm7EhjfMEcOVwn77jgi
        otO8RqZCzYJQu0290xuafRsiElm0fDfst93ezHS8RD9h3iYgSx3FhjGQu7BxqVYP
        SnaOKnzdHFSaqUGgaG3u85k/oiisi2BI8SPZ/7uGvuBShdpl6bdjMgCIpob4fR02
        aftY08oE2bOrgHwF+piV1r0g1d3SjclRChIg5p4KRsT6DBEk1nTPYSuzNh1Wah4v
        Ue8wB+xJDuVlZ8PptTV9GBrxfc7mWhzuMlONS3Eb/oqyCUBulf8J5UIsAigzX737
        ZaEW7fHJ28Ku6xW2DZ+ZPEMbJIIB65mS6GtzDa4EgK4gKnGe64r0fDTPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jf9MOR3sBUMFgyxBaYyCCqhD9F08ttqVhQdqPvz+Nqc=; b=QihS4yJl
        aPVAJu8lWtNEC/4uc10tOpE+/x4Z/axjUarOMvlClwCPevSU0hQtCKh4SOMVLe8G
        Ol15TriqNQo5rYEjIWLI/m1SMKvSppdiE4//J0YtpYMi9mSPxMLgveRkaKGg8fxN
        Ri3AUBBltTnS+jWjN5XbTtevXnZdOF/ox7cgmfP8DIlrjr8cZuwkPWcQOO9uPORe
        HqoslYnIE9s4oZmZ0sULwjbFLmUcA9YjqdrpoM7xmjPVVg8C10Z00AKQGRavAs1u
        H4xaFmCb7vhCm5nDZOi6OktAYFoy47ABof3WzASOcLDR2hMVnR1dEOrNZZ7btUJ9
        iivLfkW96sNchA==
X-ME-Sender: <xms:iiNyX_ryQs50mh12HPQDus1E101d5-pOuxgiqnmUy3ACWuidnHojow>
    <xme:iiNyX5osPAtm0gcpa4s4qIk2ene6urwLOUjhD7DlQIa4d25bW375Q3I-sOJmhh01i
    CvnrdhqKAVgltWS0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:iiNyX8OxCXpSS3DljxhG8gal3XMEVr6_itsleLwpfTAmBiPT31k5mQ>
    <xmx:iiNyXy5OfeptZ0gV-U7W2n1lUEdoh69TtdLlv5fyR1koEL2IOVGHVQ>
    <xmx:iiNyX-5hQ54pQpxPNjfjp3SkGMYbQ2qsNt3fZbvThiyd10LyQJdgQg>
    <xmx:iiNyX9RuoMj_0d58bNSAgy2iudPn8xO8dudj_fcA4w9L_a193PUpzctjFA0>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F9D43064674;
        Mon, 28 Sep 2020 13:55:22 -0400 (EDT)
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
Subject: [RFC PATCH v2 12/30] mm: rmap: add mappped/unmapped page order to anonymous page rmap functions.
Date:   Mon, 28 Sep 2020 13:54:10 -0400
Message-Id: <20200928175428.4110504-13-zi.yan@sent.com>
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

page_add_anon_rmap, do_page_add_anon_rmap, page_add_new_anon_rmap,
page_remove_rmap are changed to have page order as a parameter. This
prepares for PMD-mapped PUD THP, since a PUD THP can be mapped in three
different ways, PTEs, PMDs, and PUDs and the original boolean parameter
is not enough to record the information.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/rmap.h    |  8 ++++----
 kernel/events/uprobes.c |  4 ++--
 mm/huge_memory.c        | 16 ++++++++--------
 mm/hugetlb.c            |  4 ++--
 mm/khugepaged.c         |  6 +++---
 mm/ksm.c                |  4 ++--
 mm/memory.c             | 16 ++++++++--------
 mm/migrate.c            | 10 +++++-----
 mm/rmap.c               | 22 +++++++++++++---------
 mm/swapfile.c           |  4 ++--
 mm/userfaultfd.c        |  2 +-
 11 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0af61dd193d2..1244549f3eaf 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -171,13 +171,13 @@ struct anon_vma *page_get_anon_vma(struct page *page);
  */
 void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
+		unsigned long, int);
 void do_page_add_anon_rmap(struct page *, struct vm_area_struct *,
-			   unsigned long, int);
+			   unsigned long, int, int);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
+		unsigned long, int);
 void page_add_file_rmap(struct page *, bool);
-void page_remove_rmap(struct page *, bool);
+void page_remove_rmap(struct page *, int);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 			    unsigned long);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0e18aaf23a7b..21b85bac881d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -183,7 +183,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		get_page(new_page);
-		page_add_new_anon_rmap(new_page, vma, addr, false);
+		page_add_new_anon_rmap(new_page, vma, addr, 0);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
@@ -200,7 +200,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		set_pte_at_notify(mm, addr, pvmw.pte,
 				  mk_pte(new_page, vma->vm_page_prot));
 
-	page_remove_rmap(old_page, false);
+	page_remove_rmap(old_page, 0);
 	if (!page_mapped(old_page))
 		try_to_free_swap(old_page);
 	page_vma_mapped_walk_done(&pvmw);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 76069affebef..6716c5286494 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -618,7 +618,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		page_add_new_anon_rmap(page, vma, haddr, true);
+		page_add_new_anon_rmap(page, vma, haddr, HPAGE_PMD_ORDER);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
@@ -991,7 +991,7 @@ static int __do_huge_pud_anonymous_page(struct vm_fault *vmf, struct page *page,
 
 		entry = mk_huge_pud(page, vma->vm_page_prot);
 		entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
-		page_add_new_anon_rmap(page, vma, haddr, true);
+		page_add_new_anon_rmap(page, vma, haddr, HPAGE_PUD_ORDER);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_pud_deposit(vma->vm_mm, vmf->pud,
 				virt_to_page(pmd_pgtable));
@@ -1773,7 +1773,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (pmd_present(orig_pmd)) {
 			page = pmd_page(orig_pmd);
-			page_remove_rmap(page, true);
+			page_remove_rmap(page, HPAGE_PMD_ORDER);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
 		} else if (thp_migration_supported()) {
@@ -2059,7 +2059,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (pud_present(orig_pud)) {
 			page = pud_page(orig_pud);
-			page_remove_rmap(page, true);
+			page_remove_rmap(page, HPAGE_PUD_ORDER);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
 		} else
@@ -2187,7 +2187,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			set_page_dirty(page);
 		if (!PageReferenced(page) && pmd_young(_pmd))
 			SetPageReferenced(page);
-		page_remove_rmap(page, true);
+		page_remove_rmap(page, HPAGE_PMD_ORDER);
 		put_page(page);
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
@@ -2319,7 +2319,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 	if (freeze) {
 		for (i = 0; i < HPAGE_PMD_NR; i++) {
-			page_remove_rmap(page + i, false);
+			page_remove_rmap(page + i, 0);
 			put_page(page + i);
 		}
 	}
@@ -3089,7 +3089,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	if (pmd_soft_dirty(pmdval))
 		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
 	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
-	page_remove_rmap(page, true);
+	page_remove_rmap(page, HPAGE_PMD_ORDER);
 	put_page(page);
 }
 
@@ -3115,7 +3115,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new))
-		page_add_anon_rmap(new, vma, mmun_start, true);
+		page_add_anon_rmap(new, vma, mmun_start, HPAGE_PMD_ORDER);
 	else
 		page_add_file_rmap(new, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 61469fd3ad92..25674d7b1e5f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4007,7 +4007,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			set_page_dirty(page);
 
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		page_remove_rmap(page, true);
+		page_remove_rmap(page, huge_page_order(h));
 
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
@@ -4232,7 +4232,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
 		set_huge_pte_at(mm, haddr, ptep,
 				make_huge_pte(vma, new_page, 1));
-		page_remove_rmap(old_page, true);
+		page_remove_rmap(old_page, huge_page_order(h));
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
 		set_page_huge_active(new_page);
 		/* Make the old page be freed below */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f1d5f6dde47c..636a0f32b09e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -765,7 +765,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			 * superfluous.
 			 */
 			pte_clear(vma->vm_mm, address, _pte);
-			page_remove_rmap(src_page, false);
+			page_remove_rmap(src_page, 0);
 			spin_unlock(ptl);
 			free_page_and_swap_cache(src_page);
 		}
@@ -1175,7 +1175,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
-	page_add_new_anon_rmap(new_page, vma, address, true);
+	page_add_new_anon_rmap(new_page, vma, address, HPAGE_PMD_ORDER);
 	lru_cache_add_inactive_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
@@ -1478,7 +1478,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 		if (pte_none(*pte))
 			continue;
 		page = vm_normal_page(vma, addr, *pte);
-		page_remove_rmap(page, false);
+		page_remove_rmap(page, 0);
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
diff --git a/mm/ksm.c b/mm/ksm.c
index 9afccc36dbd2..f32bdfe768b4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1153,7 +1153,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	 */
 	if (!is_zero_pfn(page_to_pfn(kpage))) {
 		get_page(kpage);
-		page_add_anon_rmap(kpage, vma, addr, false);
+		page_add_anon_rmap(kpage, vma, addr, 0);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
@@ -1177,7 +1177,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	ptep_clear_flush(vma, addr, ptep);
 	set_pte_at_notify(mm, addr, ptep, newpte);
 
-	page_remove_rmap(page, false);
+	page_remove_rmap(page, 0);
 	if (!page_mapped(page))
 		try_to_free_swap(page);
 	put_page(page);
diff --git a/mm/memory.c b/mm/memory.c
index 05789aa4af12..37e206a7d213 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1090,7 +1090,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
+			page_remove_rmap(page, 0);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
 			if (unlikely(__tlb_remove_page(tlb, page))) {
@@ -1118,7 +1118,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
+			page_remove_rmap(page, 0);
 			put_page(page);
 			continue;
 		}
@@ -2726,7 +2726,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * thread doing COW.
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
+		page_add_new_anon_rmap(new_page, vma, vmf->address, 0);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -2758,7 +2758,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * mapcount is visible. So transitively, TLBs to
 			 * old page will be flushed before it can be reused.
 			 */
-			page_remove_rmap(old_page, false);
+			page_remove_rmap(old_page, 0);
 		}
 
 		/* Free the old page.. */
@@ -3249,10 +3249,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->address, 0);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
+		do_page_add_anon_rmap(page, vma, vmf->address, exclusive, 0);
 	}
 
 	swap_free(entry);
@@ -3396,7 +3396,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
+	page_add_new_anon_rmap(page, vma, vmf->address, 0);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -3655,7 +3655,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->address, 0);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
diff --git a/mm/migrate.c b/mm/migrate.c
index 3ab965f83029..a7320e9d859c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -270,7 +270,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 
 			if (PageAnon(new))
-				page_add_anon_rmap(new, vma, pvmw.address, false);
+				page_add_anon_rmap(new, vma, pvmw.address, 0);
 			else
 				page_add_file_rmap(new, false);
 		}
@@ -2194,7 +2194,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	 * new page and page_add_new_anon_rmap guarantee the copy is
 	 * visible before the pagetable update.
 	 */
-	page_add_anon_rmap(new_page, vma, start, true);
+	page_add_anon_rmap(new_page, vma, start, HPAGE_PMD_ORDER);
 	/*
 	 * At this point the pmd is numa/protnone (i.e. non present) and the TLB
 	 * has already been flushed globally.  So no TLB can be currently
@@ -2211,7 +2211,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 	page_ref_unfreeze(page, 2);
 	mlock_migrate_page(new_page, page);
-	page_remove_rmap(page, true);
+	page_remove_rmap(page, HPAGE_PMD_ORDER);
 	set_page_owner_migrate_reason(new_page, MR_NUMA_MISPLACED);
 
 	spin_unlock(ptl);
@@ -2455,7 +2455,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			 * drop page refcount. Page won't be freed, as we took
 			 * a reference just above.
 			 */
-			page_remove_rmap(page, false);
+			page_remove_rmap(page, 0);
 			put_page(page);
 
 			if (pte_present(pte))
@@ -2940,7 +2940,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto unlock_abort;
 
 	inc_mm_counter(mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, addr, false);
+	page_add_new_anon_rmap(page, vma, addr, 0);
 	if (!is_zone_device_page(page))
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
diff --git a/mm/rmap.c b/mm/rmap.c
index 629f8fe7ffac..0d922e5fb38c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1100,7 +1100,7 @@ static void __page_check_anon_rmap(struct page *page,
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
- * @compound:	charge the page as compound or small page
+ * @map_order:	the order of the charged page
  *
  * The caller needs to hold the pte lock, and the page must be locked in
  * the anon_vma case: to serialize mapping,index checking after setting,
@@ -1108,9 +1108,10 @@ static void __page_check_anon_rmap(struct page *page,
  * (but PageKsm is never downgraded to PageAnon).
  */
 void page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, bool compound)
+	struct vm_area_struct *vma, unsigned long address, int map_order)
 {
-	do_page_add_anon_rmap(page, vma, address, compound ? RMAP_COMPOUND : 0);
+	do_page_add_anon_rmap(page, vma, address,
+			      map_order > 0 ? RMAP_COMPOUND : 0, map_order);
 }
 
 /*
@@ -1119,7 +1120,8 @@ void page_add_anon_rmap(struct page *page,
  * Everybody else should continue to use page_add_anon_rmap above.
  */
 void do_page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, int flags)
+	struct vm_area_struct *vma, unsigned long address, int flags,
+	int map_order)
 {
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
@@ -1174,15 +1176,16 @@ void do_page_add_anon_rmap(struct page *page,
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
- * @compound:	charge the page as compound or small page
+ * @map_order:	the order of the charged page
  *
  * Same as page_add_anon_rmap but must only be called on *new* pages.
  * This means the inc-and-test can be bypassed.
  * Page does not have to be locked.
  */
 void page_add_new_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, bool compound)
+	struct vm_area_struct *vma, unsigned long address, int map_order)
 {
+	bool compound = map_order > 0;
 	int nr = compound ? thp_nr_pages(page) : 1;
 
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
@@ -1339,12 +1342,13 @@ static void page_remove_anon_compound_rmap(struct page *page)
 /**
  * page_remove_rmap - take down pte mapping from a page
  * @page:	page to remove mapping from
- * @compound:	uncharge the page as compound or small page
+ * @map_order:	the order of the uncharged page
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page, bool compound)
+void page_remove_rmap(struct page *page, int map_order)
 {
+	bool compound = map_order > 0;
 	lock_page_memcg(page);
 
 	if (!PageAnon(page)) {
@@ -1734,7 +1738,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, PageHuge(page));
+		page_remove_rmap(subpage, compound_order(page));
 		put_page(page);
 	}
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 20012c0c0252..495ecdbd7859 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1919,9 +1919,9 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	set_pte_at(vma->vm_mm, addr, pte,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
-		page_add_anon_rmap(page, vma, addr, false);
+		page_add_anon_rmap(page, vma, addr, 0);
 	} else { /* ksm created a completely new copy */
-		page_add_new_anon_rmap(page, vma, addr, false);
+		page_add_new_anon_rmap(page, vma, addr, 0);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	swap_free(entry);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9a3d451402d7..4979e64d7e47 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -122,7 +122,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_uncharge_unlock;
 
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+	page_add_new_anon_rmap(page, dst_vma, dst_addr, 0);
 	lru_cache_add_inactive_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
-- 
2.28.0

