Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5622F3564
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406260AbhALQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:16:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56950 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406229AbhALQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:16:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9eNs086594;
        Tue, 12 Jan 2021 16:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=C/WXiKs2BELoYIheVIId9ODGPyxgWiAbRTVOw7gsBQw=;
 b=GehlSHDb0sMKm7b9hIYlOjDLmHqraJtFzbfETkcp+BcWMZMuLWoMFTXOOv5Gwf0g+f83
 ohbStUSixKnYszPQcLM7eSAWLwId7LW2egh6IFrAv3x1zuY3err0kH94ViKCRVflKcIH
 mOe4pNQAR1RkWWWuUGBW+3cCNWqflEa2wwShMUvJYUaHS9o53lFyFj5lnWk5r/DujGro
 i10e0p2wywdjFBVde4ZI9yhyQArERPYSwIBHf5fg+PCmmIui2BUTz+uT2wt6r9xEChQy
 u2xZEsM/VI+/4wVyg45KlPH7bMc7XjlgwN0hqJ6ThzSpCAvYtimgdJdCS6c4uz+Qx/cw PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 360kg1q52n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAaXs100373;
        Tue, 12 Jan 2021 16:14:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 360keh7m1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:44 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGEhxe020380;
        Tue, 12 Jan 2021 16:14:43 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:43 -0800
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
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 69/70] mm: Remove vma linked list.
Date:   Tue, 12 Jan 2021 11:12:39 -0500
Message-Id: <20210112161240.2024684-70-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vma linked list has been replaced by the maple tree iterators and
vma_next() vma_prev() functions.

A part of this change is also the iterators free_pgd_range(),
zap_page_range(), and unmap_single_vma()

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm_types.h |   8 +-
 kernel/fork.c            |  15 +-
 mm/debug.c               |  12 +-
 mm/internal.h            |   4 +-
 mm/memory.c              |  39 +--
 mm/mmap.c                | 522 +++++++++++++++------------------------
 6 files changed, 241 insertions(+), 359 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5a85b76bb9b9a..630673866af94 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -303,14 +303,11 @@ struct vm_userfaultfd_ctx {};
  * library, the executable area etc).
  */
 struct vm_area_struct {
-	/* The first cache line has the info for VMA tree walking. */
-
 	unsigned long vm_start;		/* Our start address within vm_mm. */
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
 
 	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
 
 	/*
@@ -324,8 +321,7 @@ struct vm_area_struct {
 	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
 					 * units
 					 */
-	/* Second cache line starts here. */
-	struct file *vm_file;		/* File we map to (can be NULL). */
+	struct file * vm_file;		/* File we map to (can be NULL). */
 	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree.
@@ -378,7 +374,6 @@ struct core_state {
 struct kioctx_table;
 struct mm_struct {
 	struct {
-		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -393,7 +388,6 @@ struct mm_struct {
 		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
-		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
 
 #ifdef CONFIG_MEMBARRIER
diff --git a/kernel/fork.c b/kernel/fork.c
index b8c25c2e9587f..d3c22604493f9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -363,7 +363,6 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 */
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
-		new->vm_next = new->vm_prev = NULL;
 	}
 	return new;
 }
@@ -468,7 +467,7 @@ EXPORT_SYMBOL(free_task);
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
-	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
+	struct vm_area_struct *mpnt, *tmp;
 	int retval;
 	unsigned long charge = 0;
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
@@ -495,7 +494,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mm->exec_vm = oldmm->exec_vm;
 	mm->stack_vm = oldmm->stack_vm;
 
-	pprev = &mm->mmap;
 	retval = ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
@@ -503,8 +501,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	if (retval)
 		goto out;
 
-	prev = NULL;
-
 	retval = mas_entry_count(&mas, oldmm->map_count);
 	if (retval)
 		goto fail_nomem;
@@ -579,14 +575,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (is_vm_hugetlb_page(tmp))
 			reset_vma_resv_huge_pages(tmp);
 
-		/*
-		 * Link in the new vma and copy the page table entries.
-		 */
-		*pprev = tmp;
-		pprev = &tmp->vm_next;
-		tmp->vm_prev = prev;
-		prev = tmp;
-
 		/* Link the vma into the MT */
 		mas.index = tmp->vm_start;
 		mas.last = tmp->vm_end - 1;
@@ -1008,7 +996,6 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
-	mm->mmap = NULL;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/debug.c b/mm/debug.c
index d8ed9d7383267..8dd7a23782480 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -203,8 +203,8 @@ void dump_vma(const struct vm_area_struct *vma)
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
 		"flags: %#lx(%pGv)\n",
-		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
-		vma->vm_prev, vma->vm_mm,
+		vma, (void *)vma->vm_start, (void *)vma->vm_end,
+		vma_next(vma->vm_mm, vma), vma_prev(vma->vm_mm, vma), vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
 		vma->vm_file, vma->vm_private_data,
@@ -214,11 +214,11 @@ EXPORT_SYMBOL(dump_vma);
 
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px task_size %lu\n"
+	pr_emerg("mm %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
-		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
+		"mmap_base %lu mmap_legacy_base %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
@@ -242,11 +242,11 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
 
-		mm, mm->mmap, mm->task_size,
+		mm, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
-		mm->mmap_base, mm->mmap_legacy_base, mm->highest_vm_end,
+		mm->mmap_base, mm->mmap_legacy_base,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
diff --git a/mm/internal.h b/mm/internal.h
index c43ccdddb0f6e..aaf382dbee14e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -36,8 +36,8 @@ void page_writeback_init(void);
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long floor, unsigned long ceiling);
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
+	struct vm_area_struct *vma, unsigned long floor, unsigned long ceiling);
 
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e5026..3217c46fa32b8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -387,13 +387,18 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr = next, addr != end);
 }
 
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
+	struct vm_area_struct *vma, unsigned long floor, unsigned long ceiling)
 {
-	while (vma) {
-		struct vm_area_struct *next = vma->vm_next;
+	struct vm_area_struct *next;
+	struct ma_state ma_next = *mas;
+
+	do {
 		unsigned long addr = vma->vm_start;
 
+		next = mas_find(&ma_next, ceiling - 1);
+		BUG_ON(vma->vm_start < floor);
+		BUG_ON(vma->vm_end - 1 > ceiling - 1);
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
 		 * pgtables
@@ -410,16 +415,17 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
-				vma = next;
-				next = vma->vm_next;
+				next = mas_find(&ma_next, ceiling - 1);
+				vma = mas_find(mas, ceiling - 1);
+				BUG_ON(vma->vm_start < floor);
+				BUG_ON(vma->vm_end -1 > ceiling - 1);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
 		}
-		vma = next;
-	}
+	} while ((vma = mas_find(mas, (ceiling - 1))) != NULL);
 }
 
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
@@ -1493,16 +1499,19 @@ static void unmap_single_vma(struct mmu_gather *tlb,
  * drops the lock and schedules.
  */
 void unmap_vmas(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr)
+		struct vm_area_struct *vma, struct ma_state *mas,
+		unsigned long start_addr, unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
+	do {
+		BUG_ON(vma->vm_start < start_addr);
+		BUG_ON(vma->vm_end > end_addr);
 		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+	} while ((vma = mas_find(mas, end_addr - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
@@ -1519,6 +1528,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 {
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, start, start);
 
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
@@ -1526,8 +1536,9 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	tlb_gather_mmu(&tlb, vma->vm_mm, start, range.end);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
+	do {
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+	} while ((vma = mas_find(&mas, range.end - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb, start, range.end);
 }
@@ -4903,8 +4914,8 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
-			vma = find_vma(mm, addr);
-			if (!vma || vma->vm_start > addr)
+			vma = find_vma_intersection(mm, addr, addr + 1);
+			if (!vma)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
 				ret = vma->vm_ops->access(vma, addr, buf,
diff --git a/mm/mmap.c b/mm/mmap.c
index 964582c0f16ee..ce8857b9abd89 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -73,10 +73,6 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
-
 /* description of effects of mapping type and prot in current implementation.
  * this is due to the limited x86 page protection hardware.  The expected
  * behavior is in parens:
@@ -168,10 +164,8 @@ void unlink_file_vma(struct vm_area_struct *vma)
 /*
  * Close a vm structure and free it, returning the next.
  */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static void remove_vma(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *next = vma->vm_next;
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
@@ -179,13 +173,13 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
-	return next;
 }
 
 static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
+static int do_brk_flags(struct ma_state *mas, struct ma_state *ma_prev,
+			struct vm_area_struct **brkvma,
 			unsigned long addr, unsigned long request,
 			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
@@ -198,6 +192,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded = false;
 	LIST_HEAD(uf);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct ma_state ma_neighbour;
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -254,7 +249,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk = brk;
-		mas.last = oldbrk - 1;
 		ret = do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
 		if (ret == 1)  {
 			downgraded = true;
@@ -265,19 +259,21 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mm->brk = origbrk;
 		goto out;
 	}
+	ma_neighbour = mas;
+	next = mas_next(&ma_neighbour, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Only check if the next VMA is within the stack_guard_gap of the
 	 * expansion area */
-	next = mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
 
-	brkvma = mas_prev(&mas, mm->start_brk);
+	brkvma = mas_prev(&ma_neighbour, mm->start_brk);
 	if (brkvma && (brkvma->vm_start >= oldbrk))
 		goto out; // Trying to map over another vma.
 
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&mas, &brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+	if (do_brk_flags(&mas, &ma_neighbour, &brkvma, oldbrk,
+			 newbrk - oldbrk, 0) < 0)
 		goto out;
 
 	mm->brk = brk;
@@ -303,83 +299,15 @@ extern void mt_validate(struct maple_tree *mt);
 extern void mt_dump(const struct maple_tree *mt);
 
 /* Validate the maple tree */
-static void validate_mm_mt(struct mm_struct *mm)
-{
-	struct maple_tree *mt = &mm->mm_mt;
-	struct vm_area_struct *vma_mt, *vma = mm->mmap;
-
-	MA_STATE(mas, mt, 0, 0);
-	rcu_read_lock();
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if (xa_is_zero(vma_mt))
-			continue;
-
-		if (!vma)
-			break;
-
-		if ((vma != vma_mt) ||
-		    (vma->vm_start != vma_mt->vm_start) ||
-		    (vma->vm_end != vma_mt->vm_end) ||
-		    (vma->vm_start != mas.index) ||
-		    (vma->vm_end - 1 != mas.last)) {
-			pr_emerg("issue in %s\n", current->comm);
-			dump_stack();
-#ifdef CONFIG_DEBUG_VM
-			dump_vma(vma_mt);
-			pr_emerg("and vm_next\n");
-			dump_vma(vma->vm_next);
-#endif // CONFIG_DEBUG_VM
-			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
-				 mas.index, mas.last);
-			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
-				 vma_mt->vm_start, vma_mt->vm_end);
-			if (vma->vm_prev) {
-				pr_emerg("ll prev: %px %lu - %lu\n",
-					 vma->vm_prev, vma->vm_prev->vm_start,
-					 vma->vm_prev->vm_end);
-			}
-			pr_emerg("ll vma: %px %lu - %lu\n", vma,
-				 vma->vm_start, vma->vm_end);
-			if (vma->vm_next) {
-				pr_emerg("ll next: %px %lu - %lu\n",
-					 vma->vm_next, vma->vm_next->vm_start,
-					 vma->vm_next->vm_end);
-			}
-
-			mt_dump(mas.tree);
-			if (vma_mt->vm_end != mas.last + 1) {
-				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
-						mm, vma_mt->vm_start, vma_mt->vm_end,
-						mas.index, mas.last);
-				mt_dump(mas.tree);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
-			if (vma_mt->vm_start != mas.index) {
-				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
-						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
-		}
-		VM_BUG_ON(vma != vma_mt);
-		vma = vma->vm_next;
-
-	}
-	VM_BUG_ON(vma);
-
-	rcu_read_unlock();
-	mt_validate(&mm->mm_mt);
-}
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
 	int i = 0;
-	unsigned long highest_address = 0;
-	struct vm_area_struct *vma = mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
-	validate_mm_mt(mm);
 
-	while (vma) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma = vma->anon_vma;
 		struct anon_vma_chain *avc;
@@ -390,23 +318,15 @@ static void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
-		highest_address = vm_end_gap(vma);
-		vma = vma->vm_next;
 		i++;
 	}
 	if (i != mm->map_count) {
-		pr_emerg("map_count %d vm_next %d\n", mm->map_count, i);
-		bug = 1;
-	}
-	if (highest_address != mm->highest_vm_end) {
-		pr_emerg("mm->highest_vm_end %lx, found %lx\n",
-			  mm->highest_vm_end, highest_address);
+		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
 		bug = 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
 }
 #else // !CONFIG_DEBUG_MAPLE_TREE
-#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif // CONFIG_DEBUG_MAPLE_TREE
 
@@ -453,7 +373,7 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
  *
  * Returns: True if there is an overlapping VMA, false otherwise
  */
-static bool range_has_overlap(struct mm_struct *mm, unsigned long start,
+static inline bool range_has_overlap(struct mm_struct *mm, unsigned long start,
 			      unsigned long end, struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *existing;
@@ -464,24 +384,6 @@ static bool range_has_overlap(struct mm_struct *mm, unsigned long start,
 	return existing ? true : false;
 }
 
-/*
- * vma_next() - Get the next VMA.
- * @mm: The mm_struct.
- * @vma: The current vma.
- *
- * If @vma is NULL, return the first vma in the mm.
- *
- * Returns: The next VMA after @vma.
- */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
-					 struct vm_area_struct *vma)
-{
-	if (!vma)
-		return mm->mmap;
-
-	return vma->vm_next;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -591,7 +493,7 @@ static inline void vma_mt_store(struct mm_struct *mm, struct vm_area_struct *vma
 
 
 static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct ma_state *mas, struct vm_area_struct *prev)
+			 struct ma_state *mas)
 {
 	struct address_space *mapping = NULL;
 
@@ -601,7 +503,6 @@ static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	vma_mas_store(vma, mas);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
 
 	if (mapping)
@@ -611,8 +512,7 @@ static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	validate_mm(mm);
 }
 
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev)
+static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = NULL;
 
@@ -622,7 +522,6 @@ static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	vma_mt_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
 
 	if (mapping)
@@ -636,14 +535,12 @@ static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into the
  * mm's list and the mm tree.  It has already been inserted into the interval tree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
+static inline void __insert_vm_struct(struct mm_struct *mm,
+				      struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		BUG();
 	vma_mt_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 }
 
@@ -691,7 +588,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
 	vma_mas_store(vma, mas);
 
 	if (file) {
@@ -701,14 +597,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 
 	/* Expanding over the next vma */
 	if (remove_next) {
-		/* Remove from mm linked list - also updates highest_vm_end */
-		__vma_unlink_list(mm, next);
-
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
-
-	} else if (!next) {
-		mm->highest_vm_end = vm_end_gap(vma);
 	}
 
 	if (anon_vma) {
@@ -748,7 +638,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *next = vma->vm_next, *orig_vma = vma;
+	struct vm_area_struct *next = vma_next(mm, vma), *orig_vma = vma;
 	struct address_space *mapping = NULL;
 	struct rb_root_cached *root = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -789,7 +679,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 				 */
 				remove_next = 1 + (end > next->vm_end);
 				VM_WARN_ON(remove_next == 2 &&
-					   end != next->vm_next->vm_end);
+					   end != vma_next(mm, next)->vm_end);
 				/* trim end to next, for case 6 first pass */
 				end = next->vm_end;
 			}
@@ -802,7 +692,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * next, if the vma overlaps with it.
 			 */
 			if (remove_next == 2 && !next->anon_vma)
-				exporter = next->vm_next;
+				exporter = vma_next(mm, next);
 
 		} else if (end > next->vm_start) {
 			/*
@@ -894,8 +784,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		else
 			vma_changed = true;
 		vma->vm_end = end;
-		if (!next)
-			mm->highest_vm_end = vm_end_gap(vma);
 	}
 
 	if (vma_changed)
@@ -916,7 +804,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	}
 
 	if (remove_next) {
-		__vma_unlink_list(mm, next);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -965,7 +852,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * "next->vm_prev->vm_end" changed and the
 			 * "vma->vm_next" gap must be updated.
 			 */
-			next = vma->vm_next;
+			next = vma_next(mm, vma);
 		} else {
 			/*
 			 * For the scope of the comment "next" and
@@ -983,27 +870,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			remove_next = 1;
 			end = next->vm_end;
 			goto again;
-		} else if (!next) {
-			/*
-			 * If remove_next == 2 we obviously can't
-			 * reach this path.
-			 *
-			 * If remove_next == 3 we can't reach this
-			 * path because pre-swap() next is always not
-			 * NULL. pre-swap() "next" is not being
-			 * removed and its next->vm_end is not altered
-			 * (and furthermore "end" already matches
-			 * next->vm_end in remove_next == 3).
-			 *
-			 * We reach this only in the remove_next == 1
-			 * case if the "next" vma that was removed was
-			 * the highest vma of the mm. However in such
-			 * case next->vm_end == "end" and the extended
-			 * "vma" has vma->vm_end == next->vm_end so
-			 * mm->highest_vm_end doesn't need any update
-			 * in remove_next == 1 case.
-			 */
-			VM_WARN_ON(mm->highest_vm_end != vm_end_gap(vma));
 		}
 	}
 	if (insert && file)
@@ -1163,10 +1029,14 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	next = vma_next(mm, prev);
+	if (!prev)
+		next = find_vma(mm, 0);
+	else
+		next = vma_next(mm, prev);
+
 	area = next;
 	if (area && area->vm_end == end)		/* cases 6, 7, 8 */
-		next = next->vm_next;
+		next = vma_next(mm, next);
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
@@ -1301,17 +1171,20 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
 	struct anon_vma *anon_vma = NULL;
+	struct vm_area_struct *next, *prev;
 
 	/* Try next first. */
-	if (vma->vm_next) {
-		anon_vma = reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
+	next = vma_next(vma->vm_mm, vma);
+	if (next) {
+		anon_vma = reusable_anon_vma(next, vma, next);
 		if (anon_vma)
 			return anon_vma;
 	}
 
 	/* Try prev next. */
-	if (vma->vm_prev)
-		anon_vma = reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
+	prev = vma_prev(vma->vm_mm, vma);
+	if (prev)
+		anon_vma = reusable_anon_vma(prev, prev, vma);
 
 	/*
 	 * We might reach here with anon_vma == NULL if we can't find
@@ -2082,7 +1955,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr = TASK_SIZE;
 
-	next = vma->vm_next;
+	next = vma_next(mm, vma);
 	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
 			return -ENOMEM;
@@ -2128,8 +2001,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				vma->vm_end = address;
 				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (!vma->vm_next)
-					mm->highest_vm_end = vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
 
 				perf_event_mmap(vma);
@@ -2158,7 +2029,7 @@ int expand_downwards(struct vm_area_struct *vma,
 		return -EPERM;
 
 	/* Enforce stack_guard_gap */
-	prev = vma->vm_prev;
+	prev = vma_prev(mm, vma);
 	/* Check that both stack segments have the same anon_vma? */
 	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
 			vma_is_accessible(prev)) {
@@ -2294,20 +2165,20 @@ EXPORT_SYMBOL_GPL(find_extend_vma);
  *
  * Called with the mm semaphore held.
  */
-static inline void remove_vma_list(struct mm_struct *mm,
-				   struct vm_area_struct *vma)
+static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 {
+	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
 
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
-	do {
+	mas_for_each(mas, vma, -1) {
 		long nrpages = vma_pages(vma);
 
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		vma = remove_vma(vma);
+		remove_vma(vma);
 	} while (vma);
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
@@ -2319,21 +2190,22 @@ static inline void remove_vma_list(struct mm_struct *mm,
  * Called with the mm semaphore held.
  */
 static void unmap_region(struct mm_struct *mm,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end)
+		     struct vm_area_struct *vma, struct ma_state *mas,
+		     unsigned long start, unsigned long end,
+		     struct vm_area_struct *prev, unsigned long max)
 {
-	struct vm_area_struct *next = vma_next(mm, prev);
 	struct mmu_gather tlb;
+	struct ma_state ma_pgtb = *mas;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start, end);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
-	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING);
+	unmap_vmas(&tlb, vma, mas, start, end);
+	free_pgtables(&tlb, &ma_pgtb, vma,
+		      prev ? prev->vm_end : FIRST_USER_ADDRESS,
+		      max);
 	tlb_finish_mmu(&tlb, start, end);
 }
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
@@ -2343,7 +2215,6 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
-	validate_mm_mt(mm);
 
 	if (vma->vm_ops && vma->vm_ops->split) {
 		err = vma->vm_ops->split(vma, addr);
@@ -2396,7 +2267,6 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(mm);
 	return err;
 }
 
@@ -2413,25 +2283,44 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
 
-static inline int unlock_range(struct vm_area_struct *start,
-			       struct vm_area_struct **tail, unsigned long limit)
+static inline unsigned long detach_range(struct mm_struct *mm,
+	 struct ma_state *src, struct ma_state *dst, struct vm_area_struct *vma,
+	 struct vm_area_struct *prev, struct vm_area_struct **last)
 {
-	struct mm_struct *mm = start->vm_mm;
-	struct vm_area_struct *tmp = start;
 	int count = 0;
+	struct ma_state mas;
 
-	while (tmp && tmp->vm_start < limit) {
-		*tail = tmp;
+	/*
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
+	 */
+	mas = *src;
+	mas.last = src->index;
+	do {
+		BUG_ON(vma->vm_start < src->index);
+		BUG_ON(vma->vm_end > (src->last + 1));
+		*last = vma;
 		count++;
-		if (tmp->vm_flags & VM_LOCKED) {
-			mm->locked_vm -= vma_pages(tmp);
-			munlock_vma_pages_all(tmp);
+		if (vma->vm_flags & VM_LOCKED) {
+			mm->locked_vm -= vma_pages(vma);
+			munlock_vma_pages_all(vma);
 		}
+		vma_mas_store(vma, dst);
+	} while ((vma = mas_find(&mas, src->last)) != NULL);
 
-		tmp = tmp->vm_next;
-	}
+	/* Find the one after the series before overwrite */
+	mas.index = mas.last = src->last + 1;
+	vma = mas_find(&mas, -1);
+	/* Drop removed area from the tree */
+	mas_store_gfp(src, NULL, GFP_KERNEL);
+	/* Decrement map_count */
+	mm->map_count -= count;
+	/* Set the upper limit */
+	if (!vma)
+		return USER_PGTABLES_CEILING;
 
-	return count;
+	return vma->vm_start;
 }
 
 /* do_mas_align_munmap() - munmap the aligned region from @start to @end.
@@ -2451,8 +2340,15 @@ int do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			unsigned long end, struct list_head *uf, bool downgrade)
 {
 	struct vm_area_struct *prev, *last;
+	struct maple_tree mt_detach = MTREE_INIT(mt_detach, MAPLE_ALLOC_RANGE);
+	unsigned long max;
+	MA_STATE(dst, &mt_detach, start, start);
+	struct ma_state tmp;
 	/* we have start < vma->vm_end  */
 
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2474,27 +2370,33 @@ int do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 		if (error)
 			return error;
 		prev = vma;
-		vma = vma_next(mm, prev);
-		mas->index = start;
-		mas_reset(mas);
+		// Split invalidated node, reset.
+		mas_set_range(mas, start, end - 1);
 	} else {
-		prev = vma->vm_prev;
+		tmp = *mas;
+		prev = mas_prev(&tmp, 0);
 	}
 
 	if (vma->vm_end >= end)
 		last = vma;
-	else
-		last = find_vma_intersection(mm, end - 1, end);
+	else {
+		tmp = *mas;
+		mas_set(&tmp, end - 1);
+		last = mas_walk(&tmp);
+	}
 
 	/* Does it split the last one? */
 	if (last && end < last->vm_end) {
 		int error = __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
-		vma = vma_next(mm, prev);
-		mas_reset(mas);
+		// Split invalidated node, reset.
+		mas_set_range(mas, start, end - 1);
+
 	}
 
+	if (mas->node == MAS_START)
+		vma = mas_walk(mas);
 
 	if (unlikely(uf)) {
 		/*
@@ -2512,27 +2414,8 @@ int do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			return error;
 	}
 
-	/*
-	 * unlock any mlock()ed ranges before detaching vmas, count the number
-	 * of VMAs to be dropped, and return the tail entry of the affected
-	 * area.
-	 */
-	mm->map_count -= unlock_range(vma, &last, end);
-	/* Drop removed area from the tree */
-	mas_store_gfp(mas, NULL, GFP_KERNEL);
-
-	/* Detach vmas from the MM linked list */
-	vma->vm_prev = NULL;
-	if (prev)
-		prev->vm_next = last->vm_next;
-	else
-		mm->mmap = last->vm_next;
-
-	if (last->vm_next) {
-		last->vm_next->vm_prev = prev;
-		last->vm_next = NULL;
-	} else
-		mm->highest_vm_end = prev ? vm_end_gap(prev) : 0;
+	/* Point of no return */
+	max = detach_range(mm, mas, &dst, vma, prev, &last);
 
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2548,10 +2431,17 @@ int do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			mmap_write_downgrade(mm);
 	}
 
-	unmap_region(mm, vma, prev, start, end);
+	/* Unmap the region */
+	mas_set(&dst, start);
+	tmp = dst;
+	vma = mas_walk(&dst);
+	unmap_region(mm, vma, &dst, start, end, prev, max);
 
-	/* Fix up all other VM information */
-	remove_vma_list(mm, vma);
+	/* Statistics and freeing VMAs */
+	dst = tmp;
+	remove_mt(mm, &dst);
+
+	mtree_destroy(&mt_detach);
 
 	return downgrade ? 1 : 0;
 }
@@ -2577,16 +2467,14 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 	unsigned long end;
 	struct vm_area_struct *vma;
 
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
+	if ((offset_in_page(start)) || (start > TASK_SIZE) ||
+	    (len > TASK_SIZE - start))
 		return -EINVAL;
 
 	end = start + PAGE_ALIGN(len);
 	if (end == start)
 		return -EINVAL;
 
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
 	/* Find the first overlapping VMA */
 	vma = mas_find(mas, end - 1);
 	if (!vma)
@@ -2619,8 +2507,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long charged = 0;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
+	unsigned long max = USER_PGTABLES_CEILING;
 	pgoff_t vm_pgoff;
 	int error;
+	struct ma_state ma_prev, tmp;
 	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
 
 	/* Check against address space limit. */
@@ -2652,37 +2542,44 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-
+	mas_set_range(&mas, addr, end - 1);
 	if (vm_flags & VM_SPECIAL) {
-		prev = mas_prev(&mas, 0);
+		ma_prev = mas;
+		prev = mas_prev(&ma_prev, 0);
 		goto cannot_expand;
 	}
 
 	/* Attempt to expand an old mapping */
 
 	/* Check next */
-	next = mas_next(&mas, ULONG_MAX);
-	if (next && next->vm_start == end && vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff + pglen,
-				 NULL_VM_UFFD_CTX)) {
-		merge_end = next->vm_end;
-		vma = next;
-		vm_pgoff = next->vm_pgoff - pglen;
+	tmp = mas;
+	next = mas_next(&tmp, ULONG_MAX);
+	if (next) {
+		max = next->vm_start;
+		if (next->vm_start == end && vma_policy(next) &&
+		    can_vma_merge_before(next, vm_flags, NULL, file,
+					 pgoff + pglen, NULL_VM_UFFD_CTX)) {
+			merge_end = next->vm_end;
+			vma = next;
+			vm_pgoff = next->vm_pgoff - pglen;
+		}
 	}
 
 	/* Check prev */
-	prev = mas_prev(&mas, 0);
+	ma_prev = tmp;
+	prev = mas_prev(&ma_prev, 0);
 	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
 	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
 				NULL_VM_UFFD_CTX)) {
 		merge_start = prev->vm_start;
 		vma = prev;
+		tmp = ma_prev;
 		vm_pgoff = prev->vm_pgoff;
 	}
 
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&tmp, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma_merge(prev, vm_flags);
 		goto expanded;
 	}
@@ -2736,7 +2633,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 						 pgoff, NULL_VM_UFFD_CTX))) {
 			merge_start = prev->vm_start;
 			vm_pgoff = prev->vm_pgoff;
-			if (!vma_expand(&mas, prev, merge_start, merge_end,
+			if (!vma_expand(&ma_prev, prev, merge_start, merge_end,
 					vm_pgoff, next)) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
@@ -2782,15 +2679,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto free_vma;
 	}
 
-	/*
-	 * mas was called for the prev vma, and that may not be the correct
-	 * location for the vma being inserted, but is is before that location
-	 * and so the call to vma_mas_link()->vma_mas_store()->mas_store_gfp()
-	 * will detect the write as a spanning store and reset mas if necessary.
-	 */
-	mas.index = mas.last = addr;
+	// Very likely a shorter walk.
+	mas = ma_prev;
+	mas.last = end - 1;
+	mas.index = addr;
 	mas_walk(&mas);
-	vma_mas_link(mm, vma, &mas, prev);
+	vma_mas_link(mm, vma, &mas);
+
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -2834,7 +2729,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	fput(file);
 
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	unmap_region(mm, vma, &mas, vma->vm_start, vma->vm_end, prev, max);
 	charged = 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
@@ -2900,15 +2795,17 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	unsigned long populate = 0;
 	unsigned long ret = -EINVAL;
 	struct file *file;
+	struct ma_state ma_lock;
+	MA_STATE(mas, &mm->mm_mt, start, start);
 
 	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/vm/remap_file_pages.rst.\n",
 		     current->comm, current->pid);
 
 	if (prot)
 		return ret;
+
 	start = start & PAGE_MASK;
 	size = size & PAGE_MASK;
-
 	if (start + size <= start)
 		return ret;
 
@@ -2919,20 +2816,23 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	vma = find_vma(mm, start);
+	mas_set(&mas, start);
+	vma = mas_walk(&mas);
+	ma_lock = mas;
 
 	if (!vma || !(vma->vm_flags & VM_SHARED))
 		goto out;
 
-	if (start < vma->vm_start)
+	if (!vma->vm_file)
 		goto out;
 
 	if (start + size > vma->vm_end) {
-		struct vm_area_struct *next;
+		struct vm_area_struct *prev, *next;
 
-		for (next = vma->vm_next; next; next = next->vm_next) {
+		prev = vma;
+		mas_for_each(&mas, next, start + size) {
 			/* hole between vmas ? */
-			if (next->vm_start != next->vm_prev->vm_end)
+			if (next->vm_start != prev->vm_end)
 				goto out;
 
 			if (next->vm_file != vma->vm_file)
@@ -2943,6 +2843,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 
 			if (start + size <= next->vm_end)
 				break;
+
+			prev = next;
 		}
 
 		if (!next)
@@ -2955,24 +2857,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 
 	flags &= MAP_NONBLOCK;
 	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-	if (vma->vm_flags & VM_LOCKED) {
-		struct vm_area_struct *tmp;
-		flags |= MAP_LOCKED;
-
-		/* drop PG_Mlocked flag for over-mapped range */
-		for (tmp = vma; tmp->vm_start >= start + size;
-				tmp = tmp->vm_next) {
-			/*
-			 * Split pmd and munlock page on the border
-			 * of the range.
-			 */
-			vma_adjust_trans_huge(tmp, start, start + size, 0);
-
-			munlock_vma_pages_range(tmp,
-					max(tmp->vm_start, start),
-					min(tmp->vm_end, start + size));
-		}
-	}
 
 	file = get_file(vma->vm_file);
 	ret = do_mmap(vma->vm_file, start, size,
@@ -3003,13 +2887,15 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			 struct list_head *uf)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct unmap;
+	struct vm_area_struct unmap, *next;
 	unsigned long unmap_pages;
 	int ret;
+	struct ma_state ma_next;
 
 	arch_unmap(mm, newbrk, oldbrk);
 
 	if (likely(vma->vm_start >= newbrk)) { // remove entire mapping(s)
+		mas->last = oldbrk - 1;
 		ret = do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
 					  true);
 		goto munmap_full_vma;
@@ -3018,6 +2904,7 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	vma_init(&unmap, mm);
 	unmap.vm_start = newbrk;
 	unmap.vm_end = oldbrk;
+	unmap.vm_pgoff = newbrk >> PAGE_SHIFT;
 	ret = userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
@@ -3030,10 +2917,10 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 		anon_vma_interval_tree_pre_update_vma(vma);
 	}
 
-	vma->vm_end = newbrk;
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
 
+	vma->vm_end = newbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
@@ -3046,18 +2933,19 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	}
 
 	mmap_write_downgrade(mm);
-	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	ma_next = *mas;
+	next = mas_next(&ma_next, -1);
+	unmap_region(mm, &unmap, mas, newbrk, oldbrk, vma,
+		     next ? next->vm_start : 0);
 	/* Statistics */
 	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
 	if (unmap.vm_flags & VM_ACCOUNT)
 		vm_unacct_memory(unmap_pages);
 
 munmap_full_vma:
-	validate_mm_mt(mm);
 	return ret;
 
 mas_store_fail:
-	vma->vm_end = oldbrk;
 	anon_vma_interval_tree_post_update_vma(vma);
 	anon_vma_unlock_write(vma->anon_vma);
 	return -ENOMEM;
@@ -3075,15 +2963,15 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
  * do not match then create a new anonymous VMA.  Eventually we may be able to
  * do some brk-specific accounting here.
  */
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
+static int do_brk_flags(struct ma_state *mas, struct ma_state *ma_prev,
+			struct vm_area_struct **brkvma,
 			unsigned long addr, unsigned long len,
 			unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *prev = NULL, *vma;
+	struct vm_area_struct *vma;
 	int error;
 	unsigned long mapped_addr;
-	validate_mm_mt(mm);
 
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) != 0)
@@ -3108,7 +2996,6 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	mas->last = addr + len - 1;
 	if (*brkvma) {
 		vma = *brkvma;
 		/* Expand the existing vma if possible; almost never a singular
@@ -3117,7 +3004,8 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
 		if ((!vma->anon_vma ||
 		     list_is_singular(&vma->anon_vma_chain)) &&
 		     ((vma->vm_flags & ~VM_SOFTDIRTY) == flags)){
-			mas->index = vma->vm_start;
+			ma_prev->index = vma->vm_start;
+			ma_prev->last = addr + len - 1;
 
 			vma_adjust_trans_huge(vma, addr, addr + len, 0);
 			if (vma->anon_vma) {
@@ -3126,7 +3014,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
 			}
 			vma->vm_end = addr + len;
 			vma->vm_flags |= VM_SOFTDIRTY;
-			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			if (mas_store_gfp(ma_prev, vma, GFP_KERNEL))
 				goto mas_mod_fail;
 			if (vma->anon_vma) {
 				anon_vma_interval_tree_post_update_vma(vma);
@@ -3135,11 +3023,9 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
 			khugepaged_enter_vma_merge(vma, flags);
 			goto out;
 		}
-		prev = vma;
 	}
-	mas->index = addr;
-	mas_walk(mas);
 
+	mas->last = addr + len - 1;
 	/* create a vma struct for an anonymous mapping */
 	vma = vm_area_alloc(mm);
 	if (!vma)
@@ -3154,10 +3040,6 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
 	if (vma_mas_store(vma, mas))
 		goto mas_store_fail;
 
-	if (!prev)
-		prev = mas_prev(mas, 0);
-
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 	*brkvma = vma;
 out:
@@ -3167,7 +3049,6 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm += (len >> PAGE_SHIFT);
 	vma->vm_flags |= VM_SOFTDIRTY;
-	validate_mm_mt(mm);
 	return 0;
 
 mas_store_fail:
@@ -3204,7 +3085,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 
 	// This vma left intentionally blank.
 	mas_walk(&mas);
-	ret = do_brk_flags(&mas, &vma, addr, len, flags);
+	ret = do_brk_flags(&mas, &mas, &vma, addr, len, flags);
 	mmap_write_unlock(mm);
 	populate = ((mm->def_flags & VM_LOCKED) != 0);
 	if (populate && !ret)
@@ -3225,6 +3106,8 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
+	struct ma_state mas2;
+	MA_STATE(mas, &mm->mm_mt, FIRST_USER_ADDRESS, FIRST_USER_ADDRESS);
 
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -3253,32 +3136,43 @@ void exit_mmap(struct mm_struct *mm)
 		mmap_write_unlock(mm);
 	}
 
-	if (mm->locked_vm)
-		unlock_range(mm->mmap, &vma, ULONG_MAX);
+	if (mm->locked_vm) {
+		mas_for_each(&mas, vma, -1) {
+			if (vma->vm_flags & VM_LOCKED) {
+				mm->locked_vm -= vma_pages(vma);
+				munlock_vma_pages_all(vma);
+			}
+		}
+		mas_set(&mas, FIRST_USER_ADDRESS);
+	}
 
 	arch_exit_mmap(mm);
 
-	vma = mm->mmap;
+	vma = mas_find(&mas, -1);
 	if (!vma)	/* Can happen if dup_mmap() received an OOM */
 		return;
 
+	mas2 = mas;
+	mas_set(&mas, FIRST_USER_ADDRESS);
+
 	lru_add_drain();
 	flush_cache_mm(mm);
 	tlb_gather_mmu(&tlb, mm, 0, -1);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
-	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	/* Use 0 here to ensure all VMAs in the mm are unmapped */
+	unmap_vmas(&tlb, vma, &mas, 0, -1);
+	free_pgtables(&tlb, &mas2, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb, 0, -1);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
 	 * with preemption enabled, without holding any MM locks.
 	 */
-	while (vma) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, -1) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		vma = remove_vma(vma);
+		remove_vma(vma);
 		cond_resched();
 	}
 
@@ -3293,9 +3187,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
 
 	if ((vma->vm_flags & VM_ACCOUNT) &&
@@ -3319,7 +3211,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
 	}
 
-	vma_link(mm, vma, prev);
+	vma_link(mm, vma);
 	return 0;
 }
 
@@ -3337,7 +3229,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	bool faulted_in_anon_vma = true;
 
-	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3390,10 +3281,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev);
+		vma_link(mm, new_vma);
 		*need_rmap_locks = false;
 	}
-	validate_mm_mt(mm);
 	return new_vma;
 
 out_free_mempol:
@@ -3401,7 +3291,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
-	validate_mm_mt(mm);
 	return NULL;
 }
 
@@ -3526,7 +3415,6 @@ static struct vm_area_struct *__install_special_mapping(
 	int ret;
 	struct vm_area_struct *vma;
 
-	validate_mm_mt(mm);
 	vma = vm_area_alloc(mm);
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3548,12 +3436,10 @@ static struct vm_area_struct *__install_special_mapping(
 
 	perf_event_mmap(vma);
 
-	validate_mm_mt(mm);
 	return vma;
 
 out:
 	vm_area_free(vma);
-	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
 
@@ -3678,12 +3564,13 @@ int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	BUG_ON(mmap_read_trylock(mm));
 
 	mutex_lock(&mm_all_locks_mutex);
 
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3691,7 +3578,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
 
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3699,7 +3587,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
 
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
@@ -3758,11 +3647,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	BUG_ON(mmap_read_trylock(mm));
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
 
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
-- 
2.28.0

