Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04652F81D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbhAORMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732751AbhAORKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1vlUeHhytX0Zn1XKXcct2jvLo89TqfY4pIBek2Nk6w=;
        b=i2PMG+VQU1ZSf5nDoTJ9gvLkGgoaKjjN+Fs9+n2j3cR1xI2vUyLpC1aCQ8ew84PgoaYuEi
        CIVdco5OpXrv0xaLMCgUfCgX2D/2e1JZJncNcS86QPz8pL4Yc2uQSFFe2o8DDp7vfbHPFk
        jY/u3KDrBKq8h2zFslCdtv9wrSpv3Ic=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-S1cSDfZHM5-JmGk8BF1ClQ-1; Fri, 15 Jan 2021 12:09:25 -0500
X-MC-Unique: S1cSDfZHM5-JmGk8BF1ClQ-1
Received: by mail-qt1-f199.google.com with SMTP id c14so7880722qtn.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1vlUeHhytX0Zn1XKXcct2jvLo89TqfY4pIBek2Nk6w=;
        b=mW9zzOSIhMUMYuiHwBfV8hA9AjbsA2UWktZtRiKxy7Z1ZWz6gTSJgHkpcQi5W0SVyi
         LZaF/AMc7RUb9Axa2PeIf6sWL7Jb6ojIXYC3lj2vrmsUFWtFi/ADWRosKE4yh2aYr00B
         rN1C0hwgjS4mWcduPEWXIxwR9y2ESaPlex0nS+U56QDfxwSTCQMhiW0lotP7DXaeCqkF
         +oU2Vo/yqDS8P/euwx3GzqjdCqwHKV7Cm7xrEg0dmJdErT0lysN0AStB6mdO52GERxfV
         OHSPwSRI4cq0mRyGA/doe58yg1xbmzl7actoL4tK5xLcIp8B3G/44v6Z1CRWTfsB4VIQ
         HXKw==
X-Gm-Message-State: AOAM531WlLStLs2jvfNLJwEBAdFva5Aq2Mus2vCnZwaPdqc/eC6NOt8I
        LALw6YGBjuu/7JlfX4tpm1ewJUbyw/waf4ZLpLQbNzC+3GqrBHhlMDBCLmgBUMOT0WKUEDdTlfQ
        r6IKoRifSzDhYTnONjMcUIdkBCmVZQ5cApSuP3cKiGVQPcMhRUxw+sorXTQCEWV3pWXC6LlIBaQ
        ==
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr13509311qke.384.1610730563156;
        Fri, 15 Jan 2021 09:09:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUDTEd6KHwD8hcYvYDXopX+e8jSdEwnqhv+y4ihKk9o1h30UduZojRTJB6Qc+C6GSA3qFLSQ==
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr13509268qke.384.1610730562780;
        Fri, 15 Jan 2021 09:09:22 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:21 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 07/30] mm/swap: Introduce the idea of special swap ptes
Date:   Fri, 15 Jan 2021 12:08:44 -0500
Message-Id: <20210115170907.24498-8-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115170907.24498-1-peterx@redhat.com>
References: <20210115170907.24498-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have special swap entries, like migration entries, hw-poison
entries, device private entries, etc.

Those "special swap entries" reside in the range that they need to be at least
swap entries first, and their types are decided by swp_type(entry).

This patch introduces another idea called "special swap ptes".

It's very easy to get confused against "special swap entries", but a speical
swap pte should never contain a swap entry at all.  It means, it's illegal to
call pte_to_swp_entry() upon a special swap pte.

Make the uffd-wp special pte to be the first special swap pte.

Before this patch, is_swap_pte()==true means one of the below:

   (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
         example, when an anonymous page got swapped out.

   (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
         example, a migration entry, a hw-poison entry, etc.

After this patch, is_swap_pte()==true means one of the below, where case (b) is
added:

 (a) The pte contains a swap entry.

   (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
         example, when an anonymous page got swapped out.

   (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
         example, a migration entry, a hw-poison entry, etc.

 (b) The pte does not contain a swap entry at all (so it cannot be passed
     into pte_to_swp_entry()).  For example, uffd-wp special swap pte.

Teach the whole mm core about this new idea.  It's done by introducing another
helper called pte_has_swap_entry() which stands for case (a.1) and (a.2).
Before this patch, it will be the same as is_swap_pte() because there's no
special swap pte yet.  Now for most of the previous use of is_swap_entry() in
mm core, we'll need to use the new helper pte_has_swap_entry() instead, to make
sure we won't try to parse a swap entry from a swap special pte (which does not
contain a swap entry at all!).  We either handle the swap special pte, or it'll
naturally use the default "else" paths.

Warn properly (e.g., in do_swap_page()) when we see a special swap pte - we
should never call do_swap_page() upon those ptes, but just to bail out early if
it happens.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c      | 14 ++++++++------
 include/linux/swapops.h | 39 ++++++++++++++++++++++++++++++++++++++-
 mm/khugepaged.c         | 11 ++++++++++-
 mm/memcontrol.c         |  2 +-
 mm/memory.c             |  7 +++++++
 mm/migrate.c            |  2 +-
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  2 +-
 mm/page_vma_mapped.c    |  6 +++---
 9 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ee5a235b3056..5286fd23bbf4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -498,7 +498,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 
 	if (pte_present(*pte)) {
 		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
+	} else if (pte_has_swap_entry(*pte)) {
 		swp_entry_t swpent = pte_to_swp_entry(*pte);
 
 		if (!non_swap_entry(swpent)) {
@@ -518,8 +518,10 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 			page = migration_entry_to_page(swpent);
 		else if (is_device_private_entry(swpent))
 			page = device_private_entry_to_page(swpent);
-	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) && mss->check_shmem_swap
-							&& pte_none(*pte))) {
+	} else if (unlikely(IS_ENABLED(CONFIG_SHMEM) &&
+			    mss->check_shmem_swap &&
+			    /* Here swap special pte is the same as none pte */
+			    (pte_none(*pte) || is_swap_special_pte(*pte)))) {
 		page = xa_load(&vma->vm_file->f_mapping->i_pages,
 						linear_page_index(vma, addr));
 		if (xa_is_value(page))
@@ -688,7 +690,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 
 	if (pte_present(*pte)) {
 		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
+	} else if (pte_has_swap_entry(*pte)) {
 		swp_entry_t swpent = pte_to_swp_entry(*pte);
 
 		if (is_migration_entry(swpent))
@@ -1053,7 +1055,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		ptent = pte_wrprotect(old_pte);
 		ptent = pte_clear_soft_dirty(ptent);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
+	} else if (pte_has_swap_entry(ptent)) {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
@@ -1366,7 +1368,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		page = vm_normal_page(vma, addr, pte);
 		if (pte_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else if (pte_has_swap_entry(pte)) {
 		swp_entry_t entry;
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 7dd57303bb0c..7b7387d2892f 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -5,6 +5,7 @@
 #include <linux/radix-tree.h>
 #include <linux/bug.h>
 #include <linux/mm_types.h>
+#include <linux/userfaultfd_k.h>
 
 #ifdef CONFIG_MMU
 
@@ -52,12 +53,48 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-/* check whether a pte points to a swap entry */
+/*
+ * is_swap_pte() returns true for three cases:
+ *
+ * (a) The pte contains a swap entry.
+ *
+ *   (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
+ *         example, when an anonymous page got swapped out.
+ *
+ *   (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
+ *         example, a migration entry, a hw-poison entry, etc.
+ *
+ * (b) The pte does not contain a swap entry at all (so it cannot be passed
+ *     into pte_to_swp_entry()).  For example, uffd-wp special swap pte.
+ */
 static inline int is_swap_pte(pte_t pte)
 {
 	return !pte_none(pte) && !pte_present(pte);
 }
 
+/*
+ * A swap-like special pte should only be used as special marker to trigger a
+ * page fault.  We should treat them similarly as pte_none() in most cases,
+ * except that it may contain some special information that can persist within
+ * the pte.  Currently the only special swap pte is UFFD_WP_SWP_PTE_SPECIAL.
+ *
+ * Note: we should never call pte_to_swp_entry() upon a special swap pte,
+ * Because a swap special pte does not contain a swap entry!
+ */
+static inline bool is_swap_special_pte(pte_t pte)
+{
+	return pte_swp_uffd_wp_special(pte);
+}
+
+/*
+ * Returns true if the pte contains a swap entry.  This includes not only the
+ * normal swp entry case, but also for migration entries, etc.
+ */
+static inline bool pte_has_swap_entry(pte_t pte)
+{
+	return is_swap_pte(pte) && !is_swap_special_pte(pte);
+}
+
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4e3dff13eb70..20807163a25f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1006,7 +1006,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
 			vmf.pte++, vmf.address += PAGE_SIZE) {
 		vmf.orig_pte = *vmf.pte;
-		if (!is_swap_pte(vmf.orig_pte))
+		if (!pte_has_swap_entry(vmf.orig_pte))
 			continue;
 		swapped_in++;
 		ret = do_swap_page(&vmf);
@@ -1238,6 +1238,15 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
 		if (is_swap_pte(pteval)) {
+			if (is_swap_special_pte(pteval)) {
+				/*
+				 * Reuse SCAN_PTE_UFFD_WP.  If there will be
+				 * new users of is_swap_special_pte(), we'd
+				 * better introduce a new result type.
+				 */
+				result = SCAN_PTE_UFFD_WP;
+				goto out_unmap;
+			}
 			if (++unmapped <= khugepaged_max_ptes_swap) {
 				/*
 				 * Always be strict with uffd-wp
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29459a6ce1c7..3af43a218b8b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5776,7 +5776,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 
 	if (pte_present(ptent))
 		page = mc_handle_present_pte(vma, addr, ptent);
-	else if (is_swap_pte(ptent))
+	else if (pte_has_swap_entry(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
 	else if (pte_none(ptent))
 		page = mc_handle_file_pte(vma, addr, ptent, &ent);
diff --git a/mm/memory.c b/mm/memory.c
index 5ab3106cdd35..394c2602dce7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3255,6 +3255,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
+	/*
+	 * We should never call do_swap_page upon a swap special pte; just be
+	 * safe to bail out if it happens.
+	 */
+	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
+		goto out;
+
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
diff --git a/mm/migrate.c b/mm/migrate.c
index 5795cb82e27c..8a5459859e17 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -318,7 +318,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 
 	spin_lock(ptl);
 	pte = *ptep;
-	if (!is_swap_pte(pte))
+	if (!pte_has_swap_entry(pte))
 		goto out;
 
 	entry = pte_to_swp_entry(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 56c02beb6041..e75bfe43cedd 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -139,7 +139,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			pages++;
-		} else if (is_swap_pte(oldpte)) {
+		} else if (pte_has_swap_entry(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 			pte_t newpte;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..f736fcbe1247 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -106,7 +106,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 #ifdef CONFIG_MEM_SOFT_DIRTY
 	if (pte_present(pte))
 		pte = pte_mksoft_dirty(pte);
-	else if (is_swap_pte(pte))
+	else if (pte_has_swap_entry(pte))
 		pte = pte_swp_mksoft_dirty(pte);
 #endif
 	return pte;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 5e77b269c330..c97884007232 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -36,7 +36,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 			 * For more details on device private memory see HMM
 			 * (include/linux/hmm.h or mm/hmm.c).
 			 */
-			if (is_swap_pte(*pvmw->pte)) {
+			if (pte_has_swap_entry(*pvmw->pte)) {
 				swp_entry_t entry;
 
 				/* Handle un-addressable ZONE_DEVICE memory */
@@ -88,7 +88,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 
 	if (pvmw->flags & PVMW_MIGRATION) {
 		swp_entry_t entry;
-		if (!is_swap_pte(*pvmw->pte))
+		if (!pte_has_swap_entry(*pvmw->pte))
 			return false;
 		entry = pte_to_swp_entry(*pvmw->pte);
 
@@ -96,7 +96,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 			return false;
 
 		pfn = migration_entry_to_pfn(entry);
-	} else if (is_swap_pte(*pvmw->pte)) {
+	} else if (pte_has_swap_entry(*pvmw->pte)) {
 		swp_entry_t entry;
 
 		/* Handle un-addressable ZONE_DEVICE memory */
-- 
2.26.2

