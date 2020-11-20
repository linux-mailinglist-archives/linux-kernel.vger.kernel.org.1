Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1732BABFF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgKTOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgKTOgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:36:18 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6A12236F;
        Fri, 20 Nov 2020 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605882977;
        bh=JrUunaT13FOAbVs5krWn+S3cSLbG3IZElKuxk2ra5Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hewr0Z2s9VAjf449FFaVKXNLa3oxpQEFrq22RF7GnyAapbmtehNsFPQ4nI053WAXp
         11ca/MGmrJ+tDWmfwVDghHg8kd2bDwxDl7qa3iE9ckSeXg1uAXoXqlAQb5jYtCTlHc
         fTRbYX+P0e5QjWzWHdIGwzK2IYcm5ozrbF3sVFC8=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
Date:   Fri, 20 Nov 2020 14:35:56 +0000
Message-Id: <20201120143557.6715-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120143557.6715-1-will@kernel.org>
References: <20201120143557.6715-1-will@kernel.org>
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
asm-generic/tlb.h, it's subtle and easily missed. Consequently, the
/proc walker for manipulating the young and soft-dirty bits passes this
range regardless.

Introduce tlb_gather_mmu_fullmm() to make it clearer that this is for the
entire mm and WARN() if tlb_gather_mmu() is called with an 'end' address
greated than TASK_SIZE.

Signed-off-by: Will Deacon <will@kernel.org>
---
 fs/proc/task_mmu.c        |  2 +-
 include/asm-generic/tlb.h |  6 ++++--
 include/linux/mm_types.h  |  1 +
 mm/mmap.c                 |  2 +-
 mm/mmu_gather.c           | 16 ++++++++++++++--
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3308292ee5c5..a76d339b5754 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1238,7 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			count = -EINTR;
 			goto out_mm;
 		}
-		tlb_gather_mmu(&tlb, mm, 0, -1);
+		tlb_gather_mmu_fullmm(&tlb, mm);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
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
index 6d94b2ee9c45..4b2809fbbd4a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3216,7 +3216,7 @@ void exit_mmap(struct mm_struct *mm)
 
 	lru_add_drain();
 	flush_cache_mm(mm);
-	tlb_gather_mmu(&tlb, mm, 0, -1);
+	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index b0be5a7aa08f..87b48444e7e5 100644
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
+	WARN_ON(end > TASK_SIZE);
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
2.29.2.454.gaff20da3a2-goog

