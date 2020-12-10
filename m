Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B662D5A15
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbgLJMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:12:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgLJMMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:12:00 -0500
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
Subject: [PATCH v2 1/6] mm: proc: Invalidate TLB after clearing soft-dirty page state
Date:   Thu, 10 Dec 2020 12:11:05 +0000
Message-Id: <20201210121110.10094-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201210121110.10094-1-will@kernel.org>
References: <20201210121110.10094-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double
flush"), TLB invalidation is elided in tlb_finish_mmu() if no entries
were batched via the tlb_remove_*() functions. Consequently, the
page-table modifications performed by clear_refs_write() in response to
a write to /proc/<pid>/clear_refs do not perform TLB invalidation.
Although this is fine when simply aging the ptes, in the case of
clearing the "soft-dirty" state we can end up with entries where
pte_write() is false, yet a writable mapping remains in the TLB.

Fix this by avoiding the mmu_gather API altogether: managing both the
'tlb_flush_pending' flag on the 'mm_struct' and explicit TLB
invalidation for the sort-dirty path, much like mprotect() does already.

Signed-off-by: Will Deacon <will@kernel.org>
---
 fs/proc/task_mmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 217aa2705d5d..132771edff7b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1189,7 +1189,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
-	struct mmu_gather tlb;
 	int itype;
 	int rv;
 
@@ -1234,7 +1233,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			count = -EINTR;
 			goto out_mm;
 		}
-		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
@@ -1252,15 +1250,18 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				break;
 			}
 
+			inc_tlb_flush_pending(mm);
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
 		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
 				&cp);
-		if (type == CLEAR_REFS_SOFT_DIRTY)
+		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
-		tlb_finish_mmu(&tlb, 0, -1);
+			flush_tlb_mm(mm);
+			dec_tlb_flush_pending(mm);
+		}
 		mmap_read_unlock(mm);
 out_mm:
 		mmput(mm);
-- 
2.29.2.576.ga3fc446d84-goog

