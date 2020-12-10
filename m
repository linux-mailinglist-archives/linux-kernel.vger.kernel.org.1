Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646E92D5A16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgLJMMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgLJMMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:12:03 -0500
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
Subject: [PATCH v2 2/6] tlb: mmu_gather: Remove unused start/end arguments from tlb_finish_mmu()
Date:   Thu, 10 Dec 2020 12:11:06 +0000
Message-Id: <20201210121110.10094-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201210121110.10094-1-will@kernel.org>
References: <20201210121110.10094-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7a30df49f63a ("mm: mmu_gather: remove __tlb_reset_range()
for force flush"), the 'start' and 'end' arguments to tlb_finish_mmu()
are no longer used, since we flush the whole mm in case of a nested
invalidation.

Remove the unused arguments and update all callers.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/ia64/include/asm/tlb.h | 2 +-
 arch/x86/kernel/ldt.c       | 2 +-
 fs/exec.c                   | 2 +-
 include/linux/mm_types.h    | 3 +--
 mm/hugetlb.c                | 2 +-
 mm/madvise.c                | 6 +++---
 mm/memory.c                 | 4 ++--
 mm/mmap.c                   | 4 ++--
 mm/mmu_gather.c             | 5 +----
 mm/oom_kill.c               | 4 ++--
 10 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 8d9da6f08a62..7059eb2e867a 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -36,7 +36,7 @@
  *	    tlb_end_vma(tlb, vma);
  *	  }
  *	}
- *	tlb_finish_mmu(tlb, start, end);	// finish unmap for address space MM
+ *	tlb_finish_mmu(tlb);				// finish unmap for address space MM
  */
 #include <linux/mm.h>
 #include <linux/pagemap.h>
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index b8aee71840ae..0d4e1253c9c9 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -400,7 +400,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 
 	tlb_gather_mmu(&tlb, mm, start, end);
 	free_pgd_range(&tlb, start, end, start, end);
-	tlb_finish_mmu(&tlb, start, end);
+	tlb_finish_mmu(&tlb);
 #endif
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 547a2390baf5..aa846c6ec2f0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -724,7 +724,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 		free_pgd_range(&tlb, old_start, old_end, new_end,
 			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
 	}
-	tlb_finish_mmu(&tlb, old_start, old_end);
+	tlb_finish_mmu(&tlb);
 
 	/*
 	 * Shrink the vma to just the new range.  Always succeeds.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5a9238f6caad..7b90058a62be 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -585,8 +585,7 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 				unsigned long start, unsigned long end);
-extern void tlb_finish_mmu(struct mmu_gather *tlb,
-				unsigned long start, unsigned long end);
+extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 37f15c3c24dc..4c0235122464 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3985,7 +3985,7 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 
 	tlb_gather_mmu(&tlb, mm, tlb_start, tlb_end);
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
-	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb);
 }
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index a8d8d48a57fe..3f16364aa163 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -508,7 +508,7 @@ static long madvise_cold(struct vm_area_struct *vma,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
 	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
-	tlb_finish_mmu(&tlb, start_addr, end_addr);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
@@ -560,7 +560,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
 	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
-	tlb_finish_mmu(&tlb, start_addr, end_addr);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
@@ -732,7 +732,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 			&madvise_free_walk_ops, &tlb);
 	tlb_end_vma(&tlb, vma);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, range.start, range.end);
+	tlb_finish_mmu(&tlb);
 
 	return 0;
 }
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..04a88c15e076 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1529,7 +1529,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, start, range.end);
+	tlb_finish_mmu(&tlb);
 }
 
 /**
@@ -1555,7 +1555,7 @@ static void zap_page_range_single(struct vm_area_struct *vma, unsigned long addr
 	mmu_notifier_invalidate_range_start(&range);
 	unmap_single_vma(&tlb, vma, address, range.end, details);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb, address, range.end);
+	tlb_finish_mmu(&tlb);
 }
 
 /**
diff --git a/mm/mmap.c b/mm/mmap.c
index 5c8b4485860d..a3e5854cd01e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2676,7 +2676,7 @@ static void unmap_region(struct mm_struct *mm,
 	unmap_vmas(&tlb, vma, start, end);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
-	tlb_finish_mmu(&tlb, start, end);
+	tlb_finish_mmu(&tlb);
 }
 
 /*
@@ -3219,7 +3219,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
-	tlb_finish_mmu(&tlb, 0, -1);
+	tlb_finish_mmu(&tlb);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 03c33c93a582..b0be5a7aa08f 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -290,14 +290,11 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 /**
  * tlb_finish_mmu - finish an mmu_gather structure
  * @tlb: the mmu_gather structure to finish
- * @start: start of the region that will be removed from the page-table
- * @end: end of the region that will be removed from the page-table
  *
  * Called at the end of the shootdown operation to free up any resources that
  * were required.
  */
-void tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end)
+void tlb_finish_mmu(struct mmu_gather *tlb)
 {
 	/*
 	 * If there are parallel threads are doing PTE changes on same range
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8b84661a6410..c7936196a4ae 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -546,13 +546,13 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 						vma->vm_end);
 			tlb_gather_mmu(&tlb, mm, range.start, range.end);
 			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
-				tlb_finish_mmu(&tlb, range.start, range.end);
+				tlb_finish_mmu(&tlb);
 				ret = false;
 				continue;
 			}
 			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
 			mmu_notifier_invalidate_range_end(&range);
-			tlb_finish_mmu(&tlb, range.start, range.end);
+			tlb_finish_mmu(&tlb);
 		}
 	}
 
-- 
2.29.2.576.ga3fc446d84-goog

