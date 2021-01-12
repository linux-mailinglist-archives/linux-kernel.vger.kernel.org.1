Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851592F3533
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392717AbhALQOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34236 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391919AbhALQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9vIc142103;
        Tue, 12 Jan 2021 16:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=5myRZ9+tIyaONGJoDezUWw6XIZcmXgdkE7LuLVuS7EA=;
 b=gK+yHvKuqNa2CnqCg7yaCqfIAX0cLhZMaMtFHSh8MQucRJzMWMysmixBq1t6VbYNlwnp
 TU4DVZUPBwKwui5x/0YlGo8X87lDxFiLp4ie2BjU3AYpaOLIxlh4gFpwX6Gizj4XHSlg
 TF/GZ6bBy+Gd3O1I9Lh1vD9lQqMnNEd/ji21J7lCML7R5fEwZufhSyUa4Wb2Pjhd55zX
 vBOMwiJCxdAhYc4nAnx25aEpGiw4qlDFmogwPqInMOtyuCDTQZ+NyE+XY8pGJyAgYLL6
 AHjXLtYRtf5NbFmvSvHZw1tKY5qZCO8HhD+GtQGHQWm1DYsJgpTvxjPUfbJajuH8nLOL Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 360kcyq5bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAWbN161760;
        Tue, 12 Jan 2021 16:13:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 360kf5q3b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:06 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGD4ls017411;
        Tue, 12 Jan 2021 16:13:04 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:04 -0800
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
Subject: [PATCH v2 06/70] mm: Start tracking VMAs with maple tree
Date:   Tue, 12 Jan 2021 11:11:36 -0500
Message-Id: <20210112161240.2024684-7-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start tracking the VMAs with the new maple tree structure in parallel
with the rb_tree.  Add debug and trace events for maple tree operations
and duplicate the rb_tree that is created on forks into the maple tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   2 +
 include/linux/mm_types.h    |   2 +
 include/trace/events/mmap.h |  71 ++++++++++++
 init/main.c                 |   2 +
 kernel/fork.c               |   4 +
 mm/init-mm.c                |   2 +
 mm/mmap.c                   | 218 +++++++++++++++++++++++++++++++++++-
 9 files changed, 301 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index ae64f98ec2ab6..d9b1cc30976c4 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -90,6 +90,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm = {
 	.mm_rb          = RB_ROOT,
+	.mm_mt          = MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 6c6eec044a978..e40effbf028a6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
 
 struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
+	.mm_mt			= MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
 	MMAP_LOCK_INITIALIZER(efi_mm)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4ed..9cbbbbc3043a9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2467,6 +2467,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* maple_tree */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
 
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5a9238f6caad9..f2c725e1052f8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -388,6 +389,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c05..4ffe3d348966f 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,77 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mt_szero,
+	TP_PROTO(struct mm_struct *mm, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mm, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		= mm;
+			__entry->start		= start;
+			__entry->end		= end - 1;
+	),
+
+	TP_printk("mt_mod %px, (NULL), SNULL, %lu, %lu,",
+		  __entry->mm,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_mt_store,
+	TP_PROTO(struct mm_struct *mm, struct vm_area_struct *vma),
+
+	TP_ARGS(mm, vma),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+			__field(struct vm_area_struct*, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		= mm;
+			__entry->vma		= vma;
+			__entry->vm_start	= vma->vm_start;
+			__entry->vm_end		= vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %px, (%px), STORE, %lu, %lu,",
+		  __entry->mm, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+	),
+
+	TP_fast_assign(
+			__entry->mm		= mm;
+	),
+
+	TP_printk("mt_mod %px, DESTROY\n",
+		  __entry->mm
+	)
+);
+
 #endif
 
 /* This part must be outside protection */
diff --git a/init/main.c b/init/main.c
index 32b2a8affafd1..506bcdbeb02d8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -114,6 +114,7 @@ static int kernel_init(void *);
 
 extern void init_IRQ(void);
 extern void radix_tree_init(void);
+extern void maple_tree_init(void);
 
 /*
  * Debug helper: via this flag we know that we are in 'early bootup code'
@@ -923,6 +924,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
 	radix_tree_init();
+	maple_tree_init();
 
 	/*
 	 * Set up housekeeping before setting up workqueues to allow the unbound
diff --git a/kernel/fork.c b/kernel/fork.c
index 6d266388d3804..8c7273b0d4b77 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -588,6 +588,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		rb_link = &tmp->vm_rb.rb_right;
 		rb_parent = &tmp->vm_rb;
 
+		/* Link the vma into the MT */
+		vma_store(mm, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
@@ -1004,6 +1007,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 {
 	mm->mmap = NULL;
 	mm->mm_rb = RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
 	mm->vmacache_seqnum = 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3a613c85f9ede..27229044a0702 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -28,6 +29,7 @@
  */
 struct mm_struct init_mm = {
 	.mm_rb		= RB_ROOT,
+	.mm_mt		= MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
diff --git a/mm/mmap.c b/mm/mmap.c
index 5c8b4485860de..bf0de273161e1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -373,7 +373,71 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
 
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt = &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma = mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+	rcu_read_lock();
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma != vma_mt) ||
+		    (vma->vm_start != vma_mt->vm_start) ||
+		    (vma->vm_end != vma_mt->vm_end) ||
+		    (vma->vm_start != mas.index) ||
+		    (vma->vm_end - 1 != mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next = %px %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end != mas.last + 1) {
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
+			if (vma_mt->vm_start != mas.index) {
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
+		}
+		VM_BUG_ON(vma != vma_mt);
+		vma = vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+
+	rcu_read_unlock();
+	mt_validate(&mm->mm_mt);
+}
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ignore)
 {
 	struct rb_node *nd;
@@ -428,6 +492,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
 
@@ -606,6 +671,7 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
 	unsigned long nr_pages = 0;
+	unsigned long nr_mt_pages = 0;
 	struct vm_area_struct *vma;
 
 	/* Find first overlaping mapping */
@@ -627,6 +693,13 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		nr_pages += overlap_len >> PAGE_SHIFT;
 	}
 
+	mt_for_each(&mm->mm_mt, vma, addr, end) {
+		nr_mt_pages +=
+			(min(end, vma->vm_end) - vma->vm_start) >> PAGE_SHIFT;
+	}
+
+	VM_BUG_ON_MM(nr_pages != nr_mt_pages, mm);
+
 	return nr_pages;
 }
 
@@ -673,11 +746,40 @@ static void __vma_link_file(struct vm_area_struct *vma)
 	}
 }
 
+/*
+ * vma_mt_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ */
+static inline void vma_mt_szero(struct mm_struct *mm, unsigned long start,
+		unsigned long end)
+{
+	trace_vma_mt_szero(mm, start, end);
+	mtree_store_range(&mm->mm_mt, start, end - 1, NULL, GFP_KERNEL);
+}
+
+/*
+ * vma_mt_store() - Store a given vm_area_struct in the maple tree.
+ *
+ * @mm: The struct_mm
+ * @vma: The vm_area_struct to store in the maple tree.
+ */
+static inline void vma_mt_store(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	trace_vma_mt_store(mm, vma);
+	mtree_store_range(&mm->mm_mt, vma->vm_start, vma->vm_end - 1, vma,
+		GFP_KERNEL);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
 	struct rb_node *rb_parent)
 {
+	vma_mt_store(mm, vma);
 	__vma_link_list(mm, vma, prev);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
@@ -750,6 +852,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	long adjust_next = 0;
 	int remove_next = 0;
 
+	validate_mm(mm);
+	validate_mm_mt(mm);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter = NULL, *importer = NULL;
 
@@ -875,17 +980,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	}
 
 	if (start != vma->vm_start) {
+		unsigned long old_start = vma->vm_start;
 		vma->vm_start = start;
+		if (old_start < start)
+			vma_mt_szero(mm, old_start, start);
 		start_changed = true;
 	}
 	if (end != vma->vm_end) {
+		unsigned long old_end = vma->vm_end;
 		vma->vm_end = end;
+		if (old_end > end)
+			vma_mt_szero(mm, end, old_end);
 		end_changed = true;
 	}
+
+	if (end_changed || start_changed)
+		vma_mt_store(mm, vma);
+
 	vma->vm_pgoff = pgoff;
 	if (adjust_next) {
 		next->vm_start += adjust_next;
 		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
+		vma_mt_store(mm, next);
 	}
 
 	if (file) {
@@ -899,6 +1015,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next != 3)
 			__vma_unlink(mm, next, next);
@@ -1018,6 +1136,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		uprobe_mmap(insert);
 
 	validate_mm(mm);
+	validate_mm_mt(mm);
 
 	return 0;
 }
@@ -1165,6 +1284,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	struct vm_area_struct *area, *next;
 	int err;
 
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1240,6 +1360,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
 
 	return NULL;
 }
@@ -1733,6 +1854,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged = 0;
 
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1894,6 +2016,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_set_page_prot(vma);
 
+	validate_mm_mt(mm);
 	return addr;
 
 unmap_and_free_vma:
@@ -1913,6 +2036,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
 
@@ -1929,12 +2053,26 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
 
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
 
+
+	/* Maple tree is self contained. */
+	rcu_read_lock();
+	if (mas_get_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length)) {
+		rcu_read_unlock();
+		return -ENOMEM;
+	}
+	rcu_read_unlock();
+	gap = mas.index;
+	gap += (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -2016,20 +2154,34 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap != gap_start);
 	return gap_start;
 }
 
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
 
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
 
+	rcu_read_lock();
+	if (mas_get_empty_area_rev(&mas, info->low_limit, info->high_limit,
+				length)) {
+		rcu_read_unlock();
+		return -ENOMEM;
+	}
+	rcu_read_unlock();
+	gap = (mas.index + info->align_mask) & ~info->align_mask;
+	gap -= info->align_offset & info->align_mask;
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2115,6 +2267,32 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap != gap_end) {
+		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
+				mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+				info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+				mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+				info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu => %px (%px)\n", mas.index,
+				find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv = mm->mmap;
+
+			while (dv) {
+				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv = dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap != gap_end);
+	}
+
 	return gap_end;
 }
 
@@ -2327,7 +2505,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
 
 /*
@@ -2408,6 +2585,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	unsigned long gap_addr;
 	int error = 0;
 
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
 
@@ -2484,6 +2662,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2498,6 +2677,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct vm_area_struct *prev;
 	int error = 0;
 
+	validate_mm(mm);
 	address &= PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2551,6 +2731,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start = address;
 				vma->vm_pgoff -= grow;
+				/* Overwrite old entry in mtree. */
+				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2692,6 +2874,7 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	insertion_point = (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev = NULL;
+	vma_mt_szero(mm, vma->vm_start, end);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		mm->map_count--;
@@ -2730,6 +2913,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
 
 	if (vma->vm_ops && vma->vm_ops->split) {
 		err = vma->vm_ops->split(vma, addr);
@@ -2782,6 +2966,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
 
@@ -3070,6 +3255,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	pgoff_t pgoff = addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
 
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) != 0)
@@ -3127,6 +3313,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm += (len >> PAGE_SHIFT);
 	vma->vm_flags |= VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
 }
 
@@ -3231,6 +3418,9 @@ void exit_mmap(struct mm_struct *mm)
 		vma = remove_vma(vma);
 		cond_resched();
 	}
+
+	trace_exit_mmap(mm);
+	mtree_destroy(&mm->mm_mt);
 	vm_unacct_memory(nr_accounted);
 }
 
@@ -3242,10 +3432,25 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start = vma->vm_start;
+	struct vm_area_struct *overlap = NULL;
 
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		return -ENOMEM;
+
+	overlap = mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu => %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3285,7 +3490,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma = true;
+	unsigned long index = addr;
 
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3297,6 +3504,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx);
@@ -3340,6 +3549,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks = false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
 
 out_free_mempol:
@@ -3347,6 +3557,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
 
@@ -3471,6 +3682,7 @@ static struct vm_area_struct *__install_special_mapping(
 	int ret;
 	struct vm_area_struct *vma;
 
+	validate_mm_mt(mm);
 	vma = vm_area_alloc(mm);
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3492,10 +3704,12 @@ static struct vm_area_struct *__install_special_mapping(
 
 	perf_event_mmap(vma);
 
+	validate_mm_mt(mm);
 	return vma;
 
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
 
-- 
2.28.0

