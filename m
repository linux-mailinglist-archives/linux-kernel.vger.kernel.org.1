Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F962D5A17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgLJMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgLJMMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:12:06 -0500
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
Subject: [PATCH v2 3/6] tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
Date:   Thu, 10 Dec 2020 12:11:07 +0000
Message-Id: <20201210121110.10094-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201210121110.10094-1-will@kernel.org>
References: <20201210121110.10094-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing the range '0, -1' to tlb_gather_mmu() sets the 'fullmm' flag,
which indicates that the mm_struct being operated on is going away. In
this case, some architectures (such as arm64) can elide TLB invalidation
by ensuring that the TLB tag (ASID) associated with this mm is not
immediately reclaimed. Although this behaviour is documented in
asm-generic/tlb.h, it's subtle and easily missed.

Introduce tlb_gather_mmu_fullmm() to make it clearer that this is for the
entire mm and WARN() if tlb_gather_mmu() is called with the 'fullmm'
address range.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/tlb.h |  6 ++++--
 include/linux/mm_types.h  |  1 +
 mm/mmap.c                 |  2 +-
 mm/mmu_gather.c           | 16 ++++++++++++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 6661ee1cff47..2c68a545ffa7 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -46,7 +46,9 @@
  *
  * The mmu_gather API consists of:
  *
- *  - tlb_gather_mmu() / tlb_finish_mmu(); start and finish a mmu_gather
+ *  - tlb_gather_mmu() / tlb_gather_mmu_fullmm() / tlb_finish_mmu()
+ *
+ *    start and finish a mmu_gather
  *
  *    Finish in particular will issue a (final) TLB invalidate and free
  *    all (remaining) queued pages.
@@ -91,7 +93,7 @@
  *
  *  - mmu_gather::fullmm
  *
- *    A flag set by tlb_gather_mmu() to indicate we're going to free
+ *    A flag set by tlb_gather_mmu_fullmm() to indicate we're going to free
  *    the entire mm; this allows a number of optimizations.
  *
  *    - We can ignore tlb_{start,end}_vma(); because we don't
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7b90058a62be..42231729affe 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -585,6 +585,7 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 				unsigned long start, unsigned long end);
+extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
diff --git a/mm/mmap.c b/mm/mmap.c
index a3e5854cd01e..cdd3dae6547c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3214,7 +3214,7 @@ void exit_mmap(struct mm_struct *mm)
 
 	lru_add_drain();
 	flush_cache_mm(mm);
-	tlb_gather_mmu(&tlb, mm, 0, -1);
+	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index b0be5a7aa08f..5f5e45d9eb50 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -261,8 +261,8 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
  * respectively when @mm is without users and we're going to destroy
  * the full address space (exit/execve).
  */
-void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-			unsigned long start, unsigned long end)
+static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+			     unsigned long start, unsigned long end)
 {
 	tlb->mm = mm;
 
@@ -287,6 +287,18 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	inc_tlb_flush_pending(tlb->mm);
 }
 
+void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+		    unsigned long start, unsigned long end)
+{
+	WARN_ON(!(start | (end + 1))); /* Use _fullmm() instead */
+	__tlb_gather_mmu(tlb, mm, start, end);
+}
+
+void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
+{
+	__tlb_gather_mmu(tlb, mm, 0, -1);
+}
+
 /**
  * tlb_finish_mmu - finish an mmu_gather structure
  * @tlb: the mmu_gather structure to finish
-- 
2.29.2.576.ga3fc446d84-goog

