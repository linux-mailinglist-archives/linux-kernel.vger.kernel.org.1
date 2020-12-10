Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525842D6303
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390975AbgLJRGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:06:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403880AbgLJRGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:06:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGo0cP119767;
        Thu, 10 Dec 2020 17:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=sxP9fa4aFT4lSfgs7eHA/3WLtSPwevoqZI18Sw5Q+dw=;
 b=rrdwicElw0/G8K3wSe1uGJSUntDCWkHXgNQc383z/K+KqUNTkcIlIiVbLPaYCTBQZdJF
 3odDAVkn2avQJpzlfeMrC6W/+fX3IPE+ozF+GjLGaFb2D1ENYymyQyfFmSfrxqYid0US
 WqBBvzEsHwGgPpSIe9QpGHQn62SETPsA9phllHPYuLAg21WvkVVcmHBMiurN/a3NkZQX
 0uGsBcwh70bVDHMzXDET0ehCApmUQm5db2JGe2tIfVoP9ccZae8QWCnfaUwxlYHqPJpT
 se2UcE9KroRoJ93uUX1WtfEpQvLopLkWmvm2KanP7Rt+4tcgWQ4goLYC/G1fXUtRGyGw 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3581mr6fh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:04:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGvK6G162534;
        Thu, 10 Dec 2020 17:04:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 358ksrr5j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:57 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4uAZ017596;
        Thu, 10 Dec 2020 17:04:56 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:56 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 19/28] mm: Remove vmacache
Date:   Thu, 10 Dec 2020 12:03:53 -0500
Message-Id: <20201210170402.3468568-20-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree is able to find a VMA quick enough to no longer need the
vma cache.  Remove the vmacache to reduce work in keeping it up to date
and code complexity.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c                     |   3 -
 fs/proc/task_mmu.c            |   1 -
 include/linux/mm_types.h      |   1 -
 include/linux/mm_types_task.h |   5 --
 include/linux/sched.h         |   1 -
 include/linux/vmacache.h      |  28 --------
 kernel/debug/debug_core.c     |  12 ----
 kernel/fork.c                 |   5 --
 mm/Makefile                   |   2 +-
 mm/debug.c                    |   4 +-
 mm/mmap.c                     |  20 ------
 mm/vmacache.c                 | 117 ----------------------------------
 12 files changed, 3 insertions(+), 196 deletions(-)
 delete mode 100644 include/linux/vmacache.h
 delete mode 100644 mm/vmacache.c

diff --git a/fs/exec.c b/fs/exec.c
index 547a2390baf54..aa466921d6a97 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -28,7 +28,6 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/swap.h>
@@ -1019,8 +1018,6 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
-	tsk->mm->vmacache_seqnum = 0;
-	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 217aa2705d5df..5161d8ea2d729 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
-#include <linux/vmacache.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
 #include <linux/mount.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fa3cf29f01f21..5a85b76bb9b9a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -380,7 +380,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125cb..33c9fa4d4f66a 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -31,11 +31,6 @@
 #define VMACACHE_SIZE (1U << VMACACHE_BITS)
 #define VMACACHE_MASK (VMACACHE_SIZE - 1)
 
-struct vmacache {
-	u64 seqnum;
-	struct vm_area_struct *vmas[VMACACHE_SIZE];
-};
-
 /*
  * When updating this, please also update struct resident_page_types[] in
  * kernel/fork.c
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b4593..6e4cb78e5d1ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -750,7 +750,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
 
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
 
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
deleted file mode 100644
index 6fce268a4588e..0000000000000
--- a/include/linux/vmacache.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_VMACACHE_H
-#define __LINUX_VMACACHE_H
-
-#include <linux/sched.h>
-#include <linux/mm.h>
-
-static inline void vmacache_flush(struct task_struct *tsk)
-{
-	memset(tsk->vmacache.vmas, 0, sizeof(tsk->vmacache.vmas));
-}
-
-extern void vmacache_update(unsigned long addr, struct vm_area_struct *newvma);
-extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
-						    unsigned long addr);
-
-#ifndef CONFIG_MMU
-extern struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-						  unsigned long start,
-						  unsigned long end);
-#endif
-
-static inline void vmacache_invalidate(struct mm_struct *mm)
-{
-	mm->vmacache_seqnum++;
-}
-
-#endif /* __LINUX_VMACACHE_H */
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 1e75a8923a8d1..f6e7156088ea7 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -53,7 +53,6 @@
 #include <linux/pid.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
 
@@ -286,17 +285,6 @@ static void kgdb_flush_swbreak_addr(unsigned long addr)
 	if (!CACHE_FLUSH_IS_SAFE)
 		return;
 
-	if (current->mm) {
-		int i;
-
-		for (i = 0; i < VMACACHE_SIZE; i++) {
-			if (!current->vmacache.vmas[i])
-				continue;
-			flush_cache_range(current->vmacache.vmas[i],
-					  addr, addr + BREAK_INSTR_SIZE);
-		}
-	}
-
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 5e4de4b860439..52ff974dac511 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -42,7 +42,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -1011,7 +1010,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 {
 	mm->mmap = NULL;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
-	mm->vmacache_seqnum = 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	mmap_init_lock(mm);
@@ -1408,9 +1406,6 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldmm)
 		return 0;
 
-	/* initialize the new vmacache entries */
-	vmacache_flush(tsk);
-
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm = oldmm;
diff --git a/mm/Makefile b/mm/Makefile
index d73aed0fc99c1..ca05b84ac738b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -50,7 +50,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o vmacache.o \
+			   compaction.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o $(mmu-y)
 
diff --git a/mm/debug.c b/mm/debug.c
index ccca576b28990..d8ed9d7383267 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -214,7 +214,7 @@ EXPORT_SYMBOL(dump_vma);
 
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
+	pr_emerg("mm %px mmap %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
@@ -242,7 +242,7 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
 
-		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index d7a7d01f696c1..c3ac4d6f970d3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -693,9 +692,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 		/* Remove from mm linked list - also updates highest_vm_end */
 		__vma_unlink_list(mm, next);
 
-		/* Kill the cache */
-		vmacache_invalidate(mm);
-
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 
@@ -909,8 +905,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 
 	if (remove_next) {
 		__vma_unlink_list(mm, next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -2197,19 +2191,9 @@ struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
-
-	/* Check the cache first. */
-	vma = vmacache_find(mm, start_addr);
-	if (likely(vma))
-		return vma;
-
 	rcu_read_lock();
 	vma = mas_find(&mas, end_addr - 1);
 	rcu_read_unlock();
-
-	if (vma)
-		vmacache_update(start_addr, vma);
-
 	return vma;
 }
 EXPORT_SYMBOL(find_vma_intersection);
@@ -2604,9 +2588,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
 		mm->highest_vm_end = prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next = NULL;
 
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
@@ -3003,7 +2984,6 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
 
-	vmacache_invalidate(vma->vm_mm);
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
diff --git a/mm/vmacache.c b/mm/vmacache.c
deleted file mode 100644
index 01a6e6688ec1f..0000000000000
--- a/mm/vmacache.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2014 Davidlohr Bueso.
- */
-#include <linux/sched/signal.h>
-#include <linux/sched/task.h>
-#include <linux/mm.h>
-#include <linux/vmacache.h>
-
-/*
- * Hash based on the pmd of addr if configured with MMU, which provides a good
- * hit rate for workloads with spatial locality.  Otherwise, use pages.
- */
-#ifdef CONFIG_MMU
-#define VMACACHE_SHIFT	PMD_SHIFT
-#else
-#define VMACACHE_SHIFT	PAGE_SHIFT
-#endif
-#define VMACACHE_HASH(addr) ((addr >> VMACACHE_SHIFT) & VMACACHE_MASK)
-
-/*
- * This task may be accessing a foreign mm via (for example)
- * get_user_pages()->find_vma().  The vmacache is task-local and this
- * task's vmacache pertains to a different mm (ie, its own).  There is
- * nothing we can do here.
- *
- * Also handle the case where a kernel thread has adopted this mm via
- * kthread_use_mm(). That kernel thread's vmacache is not applicable to this mm.
- */
-static inline bool vmacache_valid_mm(struct mm_struct *mm)
-{
-	return current->mm == mm && !(current->flags & PF_KTHREAD);
-}
-
-void vmacache_update(unsigned long addr, struct vm_area_struct *newvma)
-{
-	if (vmacache_valid_mm(newvma->vm_mm))
-		current->vmacache.vmas[VMACACHE_HASH(addr)] = newvma;
-}
-
-static bool vmacache_valid(struct mm_struct *mm)
-{
-	struct task_struct *curr;
-
-	if (!vmacache_valid_mm(mm))
-		return false;
-
-	curr = current;
-	if (mm->vmacache_seqnum != curr->vmacache.seqnum) {
-		/*
-		 * First attempt will always be invalid, initialize
-		 * the new cache for this task here.
-		 */
-		curr->vmacache.seqnum = mm->vmacache_seqnum;
-		vmacache_flush(curr);
-		return false;
-	}
-	return true;
-}
-
-struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long addr)
-{
-	int idx = VMACACHE_HASH(addr);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i = 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma = current->vmacache.vmas[idx];
-
-		if (vma) {
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-			if (WARN_ON_ONCE(vma->vm_mm != mm))
-				break;
-#endif
-			if (vma->vm_start <= addr && vma->vm_end > addr) {
-				count_vm_vmacache_event(VMACACHE_FIND_HITS);
-				return vma;
-			}
-		}
-		if (++idx == VMACACHE_SIZE)
-			idx = 0;
-	}
-
-	return NULL;
-}
-
-#ifndef CONFIG_MMU
-struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
-{
-	int idx = VMACACHE_HASH(start);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i = 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma = current->vmacache.vmas[idx];
-
-		if (vma && vma->vm_start == start && vma->vm_end == end) {
-			count_vm_vmacache_event(VMACACHE_FIND_HITS);
-			return vma;
-		}
-		if (++idx == VMACACHE_SIZE)
-			idx = 0;
-	}
-
-	return NULL;
-}
-#endif
-- 
2.28.0

