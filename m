Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512702D5A18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbgLJMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbgLJMMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:12:09 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org
Subject: [PATCH v2 4/6] tlb: mmu_gather: Remove start/end arguments from tlb_gather_mmu()
Date:   Thu, 10 Dec 2020 12:11:08 +0000
Message-Id: <20201210121110.10094-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201210121110.10094-1-will@kernel.org>
References: <20201210121110.10094-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'start' and 'end' arguments to tlb_gather_mmu() are no longer
needed now that there is a separate function for 'fullmm' flushing.

Remove the unused arguments and update all callers.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=wjQWa14_4UpfDf=fiineNP+RH74kZeDMo_f1D35xNzq9w@mail.gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/ia64/include/asm/tlb.h |  2 +-
 arch/x86/kernel/ldt.c       |  2 +-
 fs/exec.c                   |  2 +-
 include/linux/mm_types.h    |  3 +--
 mm/hugetlb.c                | 16 +---------------
 mm/madvise.c                |  6 +++---
 mm/memory.c                 |  4 ++--
 mm/mmap.c                   |  2 +-
 mm/mmu_gather.c             | 22 ++++++++--------------
 mm/oom_kill.c               |  2 +-
 10 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 7059eb2e867a..a15fe0809aae 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -23,7 +23,7 @@
  * unmapping a portion of the virtual address space, these hooks are called according to
  * the following template:
  *
- *	tlb <- tlb_gather_mmu(mm, start, end);		// start unmap for address space MM
+ *	tlb <- tlb_gather_mmu(mm);			// start unmap for address space MM
  *	{
  *	  for each vma that needs a shootdown do {
  *	    tlb_start_vma(tlb, vma);
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 0d4e1253c9c9..7ad9834e0d95 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -398,7 +398,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
-	tlb_gather_mmu(&tlb, mm, start, end);
+	tlb_gather_mmu(&tlb, mm);
 	free_pgd_range(&tlb, start, end, start, end);
 	tlb_finish_mmu(&tlb);
 #endif
diff --git a/fs/exec.c b/fs/exec.c
index aa846c6ec2f0..4b1d902267c4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -707,7 +707,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 		return -ENOMEM;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, old_start, old_end);
+	tlb_gather_mmu(&tlb, mm);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 42231729affe..135de3096ba7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -583,8 +583,7 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 }
 
 struct mmu_gather;
-extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-				unsigned long start, unsigned long end);
+extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4c0235122464..6a0aaaabe1a8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3967,23 +3967,9 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 			  unsigned long end, struct page *ref_page)
 {
-	struct mm_struct *mm;
 	struct mmu_gather tlb;
-	unsigned long tlb_start = start;
-	unsigned long tlb_end = end;
 
-	/*
-	 * If shared PMDs were possibly used within this vma range, adjust
-	 * start/end for worst case tlb flushing.
-	 * Note that we can not be sure if PMDs are shared until we try to
-	 * unmap pages.  However, we want to make sure TLB flushing covers
-	 * the largest possible range.
-	 */
-	adjust_range_if_pmd_sharing_possible(vma, &tlb_start, &tlb_end);
-
-	mm = vma->vm_mm;
-
-	tlb_gather_mmu(&tlb, mm, tlb_start, tlb_end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 3f16364aa163..0b8eb08248e3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -506,7 +506,7 @@ static long madvise_cold(struct vm_area_struct *vma,
 		return -EINVAL;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	tlb_gather_mmu(&tlb, mm);
 	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb);
 
@@ -558,7 +558,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 		return 0;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	tlb_gather_mmu(&tlb, mm);
 	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb);
 
@@ -723,7 +723,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 				range.start, range.end);
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, range.start, range.end);
+	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 
 	mmu_notifier_invalidate_range_start(&range);
diff --git a/mm/memory.c b/mm/memory.c
index 04a88c15e076..a26a7f925bf3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1523,7 +1523,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				start, start + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm, start, range.end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
@@ -1550,7 +1550,7 @@ static void zap_page_range_single(struct vm_area_struct *vma, unsigned long addr
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address, address + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm, address, range.end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	unmap_single_vma(&tlb, vma, address, range.end, details);
diff --git a/mm/mmap.c b/mm/mmap.c
index cdd3dae6547c..65f71a3b29a0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2671,7 +2671,7 @@ static void unmap_region(struct mm_struct *mm,
 	struct mmu_gather tlb;
 
 	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm, start, end);
+	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, vma, start, end);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 5f5e45d9eb50..0dc7149b0c61 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -253,21 +253,17 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
  * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
  * @tlb: the mmu_gather structure to initialize
  * @mm: the mm_struct of the target address space
- * @start: start of the region that will be removed from the page-table
- * @end: end of the region that will be removed from the page-table
+ * @fullmm: @mm is without users and we're going to destroy the full address
+ *	    space (exit/execve)
  *
  * Called to initialize an (on-stack) mmu_gather structure for page-table
- * tear-down from @mm. The @start and @end are set to 0 and -1
- * respectively when @mm is without users and we're going to destroy
- * the full address space (exit/execve).
+ * tear-down from @mm.
  */
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-			     unsigned long start, unsigned long end)
+			     bool fullmm)
 {
 	tlb->mm = mm;
-
-	/* Is it from 0 to ~0? */
-	tlb->fullmm     = !(start | (end+1));
+	tlb->fullmm = fullmm;
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb->need_flush_all = 0;
@@ -287,16 +283,14 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	inc_tlb_flush_pending(tlb->mm);
 }
 
-void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-		    unsigned long start, unsigned long end)
+void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
 {
-	WARN_ON(!(start | (end + 1))); /* Use _fullmm() instead */
-	__tlb_gather_mmu(tlb, mm, start, end);
+	__tlb_gather_mmu(tlb, mm, false);
 }
 
 void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
 {
-	__tlb_gather_mmu(tlb, mm, 0, -1);
+	__tlb_gather_mmu(tlb, mm, true);
 }
 
 /**
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c7936196a4ae..a11e4e379781 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -544,7 +544,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
 						vma, mm, vma->vm_start,
 						vma->vm_end);
-			tlb_gather_mmu(&tlb, mm, range.start, range.end);
+			tlb_gather_mmu(&tlb, mm);
 			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
 				tlb_finish_mmu(&tlb);
 				ret = false;
-- 
2.29.2.576.ga3fc446d84-goog

