Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653512D64C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393043AbgLJSUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:20:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35888 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403882AbgLJRGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:06:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnWiZ044450;
        Thu, 10 Dec 2020 17:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=hbuvI7byU98IiJk9fTtddon3h3Qo/emtM7teTBps45w=;
 b=j0uAWl49i40wLoU/Mj9M1oT3ZGY/GehQtV3v/fxkkVAPUvkwP4Zj++ovrhMJ1eCTxaX/
 Ue1EL+OBYL5eFLFHUDkt4aNHtrpnkLXzMcQI0LO1BGHEdIy6nAXFzj1tIBs4yAWXDVn0
 xBUO2ltelGFLtiktJbomvRtFX2lpReuWYTuLPDmQjKtcNfQ0TOrZDg0vy7bw5XlR2qpK
 nNGTtcoW9t185133yX2xkecm3MJxM+3yaK7LrVRHZoLm74m4GOtNTOGC9MjiDakNwWRP
 GEBxTHRfPDRG9/EInnEDfSwKqYX77t/k+bRziurMaR/IGPPZ88ZnIBcx/WLhQdtU7pDC Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825meh1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:04:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGw0I2033161;
        Thu, 10 Dec 2020 17:04:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 358m52gbck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:49 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAH4lFV009024;
        Thu, 10 Dec 2020 17:04:47 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:47 -0800
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
Subject: [PATCH 12/28] mm: Remove rb tree.
Date:   Thu, 10 Dec 2020 12:03:46 -0500
Message-Id: <20201210170402.3468568-13-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=2
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the RB tree and start using the maple tree for vm_area_struct
tracking.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/tboot.c    |   1 -
 drivers/firmware/efi/efi.c |   1 -
 include/linux/mm.h         |   4 -
 include/linux/mm_types.h   |  27 +-
 kernel/fork.c              |   8 -
 mm/init-mm.c               |   2 -
 mm/mmap.c                  | 520 ++++++++-----------------------------
 mm/util.c                  |   8 +
 8 files changed, 125 insertions(+), 446 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index e872d2848627f..02cdf3eeefc8a 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -89,7 +89,6 @@ void __init tboot_probe(void)
 
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm = {
-	.mm_rb          = RB_ROOT,
 	.mm_mt          = MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 24418ef1f2795..2ce13339533b3 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -54,7 +54,6 @@ static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
 static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
 
 struct mm_struct efi_mm = {
-	.mm_rb			= RB_ROOT,
 	.mm_mt			= MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 78d5bc3bbf345..1bfa2ee41187d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2467,8 +2467,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* maple_tree */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
 
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
@@ -2524,8 +2522,6 @@ extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
-extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
-	struct rb_node **, struct rb_node *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f2c725e1052f8..fa3cf29f01f21 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -274,7 +274,6 @@ typedef unsigned long vm_flags_t;
  * map parts of them.
  */
 struct vm_region {
-	struct rb_node	vm_rb;		/* link in global region tree */
 	vm_flags_t	vm_flags;	/* VMA vm_flags */
 	unsigned long	vm_start;	/* start address of region */
 	unsigned long	vm_end;		/* region initialised to here */
@@ -312,19 +311,6 @@ struct vm_area_struct {
 
 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next, *vm_prev;
-
-	struct rb_node vm_rb;
-
-	/*
-	 * Largest free memory gap in bytes to the left of this VMA.
-	 * Either between this VMA and vma->vm_prev, or between one of the
-	 * VMAs below us in the VMA rbtree and its ->vm_prev. This helps
-	 * get_unmapped_area find a free area of the right size.
-	 */
-	unsigned long rb_subtree_gap;
-
-	/* Second cache line starts here. */
-
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
 
 	/*
@@ -334,6 +320,12 @@ struct vm_area_struct {
 	pgprot_t vm_page_prot;
 	unsigned long vm_flags;		/* Flags, see mm.h. */
 
+	/* Information about our backing store: */
+	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
+					 * units
+					 */
+	/* Second cache line starts here. */
+	struct file *vm_file;		/* File we map to (can be NULL). */
 	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree.
@@ -352,16 +344,14 @@ struct vm_area_struct {
 	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
 					  * page_table_lock */
 	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+	/* Third cache line starts here. */
 
 	/* Function pointers to deal with this struct. */
 	const struct vm_operations_struct *vm_ops;
 
-	/* Information about our backing store: */
-	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
-					   units */
-	struct file * vm_file;		/* File we map to (can be NULL). */
 	void * vm_private_data;		/* was vm_pte (shared mem) */
 
+
 #ifdef CONFIG_SWAP
 	atomic_long_t swap_readahead_info;
 #endif
@@ -390,7 +380,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
diff --git a/kernel/fork.c b/kernel/fork.c
index 62eba2679216b..5e4de4b860439 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -470,7 +470,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
-	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge = 0;
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
@@ -497,8 +496,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mm->exec_vm = oldmm->exec_vm;
 	mm->stack_vm = oldmm->stack_vm;
 
-	rb_link = &mm->mm_rb.rb_node;
-	rb_parent = NULL;
 	pprev = &mm->mmap;
 	retval = ksm_fork(mm, oldmm);
 	if (retval)
@@ -591,10 +588,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		tmp->vm_prev = prev;
 		prev = tmp;
 
-		__vma_link_rb(mm, tmp, rb_link, rb_parent);
-		rb_link = &tmp->vm_rb.rb_right;
-		rb_parent = &tmp->vm_rb;
-
 		/* Link the vma into the MT */
 		mas.index = tmp->vm_start;
 		mas.last = tmp->vm_end - 1;
@@ -1017,7 +1010,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
 	mm->mmap = NULL;
-	mm->mm_rb = RB_ROOT;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
 	mm->vmacache_seqnum = 0;
 	atomic_set(&mm->mm_users, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 27229044a0702..49d803fc4cdea 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
-#include <linux/rbtree.h>
 #include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
@@ -28,7 +27,6 @@
  * and size this cpu_bitmask to NR_CPUS.
  */
 struct mm_struct init_mm = {
-	.mm_rb		= RB_ROOT,
 	.mm_mt		= MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
diff --git a/mm/mmap.c b/mm/mmap.c
index 071303779f906..4b173883472dd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -38,7 +38,6 @@
 #include <linux/audit.h>
 #include <linux/khugepaged.h>
 #include <linux/uprobes.h>
-#include <linux/rbtree_augmented.h>
 #include <linux/notifier.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -286,93 +285,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return retval;
 }
 
-static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
-{
-	unsigned long gap, prev_end;
-
-	/*
-	 * Note: in the rare case of a VM_GROWSDOWN above a VM_GROWSUP, we
-	 * allow two stack_guard_gaps between them here, and when choosing
-	 * an unmapped area; whereas when expanding we only require one.
-	 * That's a little inconsistent, but keeps the code here simpler.
-	 */
-	gap = vm_start_gap(vma);
-	if (vma->vm_prev) {
-		prev_end = vm_end_gap(vma->vm_prev);
-		if (gap > prev_end)
-			gap -= prev_end;
-		else
-			gap = 0;
-	}
-	return gap;
-}
-
-#ifdef CONFIG_DEBUG_VM_RB
-static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
-{
-	unsigned long max = vma_compute_gap(vma), subtree_gap;
-	if (vma->vm_rb.rb_left) {
-		subtree_gap = rb_entry(vma->vm_rb.rb_left,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max = subtree_gap;
-	}
-	if (vma->vm_rb.rb_right) {
-		subtree_gap = rb_entry(vma->vm_rb.rb_right,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max = subtree_gap;
-	}
-	return max;
-}
-
-static int browse_rb(struct mm_struct *mm)
-{
-	struct rb_root *root = &mm->mm_rb;
-	int i = 0, j, bug = 0;
-	struct rb_node *nd, *pn = NULL;
-	unsigned long prev = 0, pend = 0;
-
-	for (nd = rb_first(root); nd; nd = rb_next(nd)) {
-		struct vm_area_struct *vma;
-		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
-		if (vma->vm_start < prev) {
-			pr_emerg("vm_start %lx < prev %lx\n",
-				  vma->vm_start, prev);
-			bug = 1;
-		}
-		if (vma->vm_start < pend) {
-			pr_emerg("vm_start %lx < pend %lx\n",
-				  vma->vm_start, pend);
-			bug = 1;
-		}
-		if (vma->vm_start > vma->vm_end) {
-			pr_emerg("vm_start %lx > vm_end %lx\n",
-				  vma->vm_start, vma->vm_end);
-			bug = 1;
-		}
-		spin_lock(&mm->page_table_lock);
-		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma)) {
-			pr_emerg("free gap %lx, correct %lx\n",
-			       vma->rb_subtree_gap,
-			       vma_compute_subtree_gap(vma));
-			bug = 1;
-		}
-		spin_unlock(&mm->page_table_lock);
-		i++;
-		pn = nd;
-		prev = vma->vm_start;
-		pend = vma->vm_end;
-	}
-	j = 0;
-	for (nd = pn; nd; nd = rb_prev(nd))
-		j++;
-	if (i != j) {
-		pr_emerg("backwards %d, forwards %d\n", j, i);
-		bug = 1;
-	}
-	return bug ? -1 : i;
-}
 #if defined(CONFIG_DEBUG_MAPLE_TREE)
 extern void mt_validate(struct maple_tree *mt);
 extern void mt_dump(const struct maple_tree *mt);
@@ -401,17 +313,25 @@ static void validate_mm_mt(struct mm_struct *mm)
 			dump_stack();
 #ifdef CONFIG_DEBUG_VM
 			dump_vma(vma_mt);
-			pr_emerg("and next in rb\n");
+			pr_emerg("and vm_next\n");
 			dump_vma(vma->vm_next);
-#endif
+#endif // CONFIG_DEBUG_VM
 			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+			if (vma->vm_prev) {
+				pr_emerg("ll prev: %px %lu - %lu\n",
+					 vma->vm_prev, vma->vm_prev->vm_start,
+					 vma->vm_prev->vm_end);
+			}
+			pr_emerg("ll vma: %px %lu - %lu\n", vma,
 				 vma->vm_start, vma->vm_end);
-			pr_emerg("rb->next = %px %lu - %lu\n", vma->vm_next,
-					vma->vm_next->vm_start, vma->vm_next->vm_end);
+			if (vma->vm_next) {
+				pr_emerg("ll next: %px %lu - %lu\n",
+					 vma->vm_next, vma->vm_next->vm_start,
+					 vma->vm_next->vm_end);
+			}
 
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end != mas.last + 1) {
@@ -437,20 +357,6 @@ static void validate_mm_mt(struct mm_struct *mm)
 	rcu_read_unlock();
 	mt_validate(&mm->mm_mt);
 }
-#endif
-static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ignore)
-{
-	struct rb_node *nd;
-
-	for (nd = rb_first(root); nd; nd = rb_next(nd)) {
-		struct vm_area_struct *vma;
-		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
-		VM_BUG_ON_VMA(vma != ignore &&
-			vma->rb_subtree_gap != vma_compute_subtree_gap(vma),
-			vma);
-	}
-}
-
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
@@ -458,6 +364,8 @@ static void validate_mm(struct mm_struct *mm)
 	unsigned long highest_address = 0;
 	struct vm_area_struct *vma = mm->mmap;
 
+	validate_mm_mt(mm);
+
 	while (vma) {
 		struct anon_vma *anon_vma = vma->anon_vma;
 		struct anon_vma_chain *avc;
@@ -482,80 +390,12 @@ static void validate_mm(struct mm_struct *mm)
 			  mm->highest_vm_end, highest_address);
 		bug = 1;
 	}
-	i = browse_rb(mm);
-	if (i != mm->map_count) {
-		if (i != -1)
-			pr_emerg("map_count %d rb %d\n", mm->map_count, i);
-		bug = 1;
-	}
 	VM_BUG_ON_MM(bug, mm);
 }
-#else
-#define validate_mm_rb(root, ignore) do { } while (0)
+#else // !CONFIG_DEBUG_MAPLE_TREE
 #define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
-#endif
-
-RB_DECLARE_CALLBACKS_MAX(static, vma_gap_callbacks,
-			 struct vm_area_struct, vm_rb,
-			 unsigned long, rb_subtree_gap, vma_compute_gap)
-
-/*
- * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
- * vma->vm_prev->vm_end values changed, without modifying the vma's position
- * in the rbtree.
- */
-static void vma_gap_update(struct vm_area_struct *vma)
-{
-	/*
-	 * As it turns out, RB_DECLARE_CALLBACKS_MAX() already created
-	 * a callback function that does exactly what we want.
-	 */
-	vma_gap_callbacks_propagate(&vma->vm_rb, NULL);
-}
-
-static inline void vma_rb_insert(struct vm_area_struct *vma,
-				 struct rb_root *root)
-{
-	/* All rb_subtree_gap values must be consistent prior to insertion */
-	validate_mm_rb(root, NULL);
-
-	rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
-}
-
-static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
-{
-	/*
-	 * Note rb_erase_augmented is a fairly large inline function,
-	 * so make sure we instantiate it only once with our desired
-	 * augmented rbtree callbacks.
-	 */
-	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
-}
-
-static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
-						struct rb_root *root,
-						struct vm_area_struct *ignore)
-{
-	/*
-	 * All rb_subtree_gap values must be consistent prior to erase,
-	 * with the possible exception of
-	 *
-	 * a. the "next" vma being erased if next->vm_start was reduced in
-	 *    __vma_adjust() -> __vma_unlink()
-	 * b. the vma being erased in detach_vmas_to_be_unmapped() ->
-	 *    vma_rb_erase()
-	 */
-	validate_mm_rb(root, ignore);
-
-	__vma_rb_erase(vma, root);
-}
-
-static __always_inline void vma_rb_erase(struct vm_area_struct *vma,
-					 struct rb_root *root)
-{
-	vma_rb_erase_ignore(vma, root, vma);
-}
+#endif // CONFIG_DEBUG_MAPLE_TREE
 
 /*
  * vma has some anon_vma assigned, and is already inserted on that
@@ -589,38 +429,26 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static int find_vma_links(struct mm_struct *mm, unsigned long addr,
-		unsigned long end, struct vm_area_struct **pprev,
-		struct rb_node ***rb_link, struct rb_node **rb_parent)
+/* Private
+ * range_has_overlap() - Check the @start - @end range for overlapping VMAs and
+ * sets up a pointer to the previous VMA
+ *
+ * @mm - the mm struct
+ * @start - the start address of the range
+ * @end - the end address of the range
+ * @pprev - the pointer to the pointer of the previous VMA
+ *
+ * Returns: True if there is an overlapping VMA, false otherwise
+ */
+static bool range_has_overlap(struct mm_struct *mm, unsigned long start,
+			      unsigned long end, struct vm_area_struct **pprev)
 {
-	struct rb_node **__rb_link, *__rb_parent, *rb_prev;
-
-	__rb_link = &mm->mm_rb.rb_node;
-	rb_prev = __rb_parent = NULL;
-
-	while (*__rb_link) {
-		struct vm_area_struct *vma_tmp;
-
-		__rb_parent = *__rb_link;
-		vma_tmp = rb_entry(__rb_parent, struct vm_area_struct, vm_rb);
-
-		if (vma_tmp->vm_end > addr) {
-			/* Fail if an existing vma overlaps the area */
-			if (vma_tmp->vm_start < end)
-				return -ENOMEM;
-			__rb_link = &__rb_parent->rb_left;
-		} else {
-			rb_prev = __rb_parent;
-			__rb_link = &__rb_parent->rb_right;
-		}
-	}
+	struct vm_area_struct *existing;
 
-	*pprev = NULL;
-	if (rb_prev)
-		*pprev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-	*rb_link = __rb_link;
-	*rb_parent = __rb_parent;
-	return 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	existing = mas_find(&mas, end - 1);
+	*pprev = mas_prev(&mas, 0);
+	return existing ? true : false;
 }
 
 /*
@@ -647,8 +475,6 @@ static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
  * @start: The start of the range.
  * @len: The length of the range.
  * @pprev: pointer to the pointer that will be set to previous vm_area_struct
- * @rb_link: the rb_node
- * @rb_parent: the parent rb_node
  *
  * Find all the vm_area_struct that overlap from @start to
  * @end and munmap them.  Set @pprev to the previous vm_area_struct.
@@ -657,76 +483,43 @@ static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
  */
 static inline int
 munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
-		 struct vm_area_struct **pprev, struct rb_node ***link,
-		 struct rb_node **parent, struct list_head *uf)
+		 struct vm_area_struct **pprev, struct list_head *uf)
 {
-
-	while (find_vma_links(mm, start, start + len, pprev, link, parent))
+	// Needs optimization.
+	while (range_has_overlap(mm, start, start + len, pprev))
 		if (do_munmap(mm, start, len, uf))
 			return -ENOMEM;
-
 	return 0;
 }
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
 	unsigned long nr_pages = 0;
-	unsigned long nr_mt_pages = 0;
 	struct vm_area_struct *vma;
+	unsigned long vm_start, vm_end;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
 
 	/* Find first overlaping mapping */
 	vma = find_vma_intersection(mm, addr, end);
 	if (!vma)
 		return 0;
 
-	nr_pages = (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
+	vm_start = vma->vm_start;
+	vm_end = vma->vm_end;
 
-	/* Iterate over the rest of the overlaps */
-	for (vma = vma->vm_next; vma; vma = vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	nr_pages = (min(end, vm_end) - max(addr, vm_start)) >> PAGE_SHIFT;
 
-		overlap_len = min(end, vma->vm_end) - vma->vm_start;
-		nr_pages += overlap_len >> PAGE_SHIFT;
-	}
-
-	mt_for_each(&mm->mm_mt, vma, addr, end) {
-		nr_mt_pages +=
-			(min(end, vma->vm_end) - vma->vm_start) >> PAGE_SHIFT;
+	/* Iterate over the rest of the overlaps */
+	mas.index = mas.last = vm_end;
+	mas_for_each(&mas, vma, end) {
+		vm_start = vma->vm_start;
+		vm_end = vma->vm_end;
+		nr_pages += (min(end, vm_end) - vm_start) >> PAGE_SHIFT;
 	}
 
-	VM_BUG_ON_MM(nr_pages != nr_mt_pages, mm);
-
 	return nr_pages;
 }
 
-void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct rb_node **rb_link, struct rb_node *rb_parent)
-{
-	/* Update tracking information for the gap following the new vma. */
-	if (vma->vm_next)
-		vma_gap_update(vma->vm_next);
-	else
-		mm->highest_vm_end = vm_end_gap(vma);
-
-	/*
-	 * vma->vm_prev wasn't known when we followed the rbtree to find the
-	 * correct insertion point for that vma. As a result, we could not
-	 * update the vma vm_rb parents rb_subtree_gap values on the way down.
-	 * So, we first insert the vma with a zero rb_subtree_gap value
-	 * (to be consistent with what we did on the way down), and then
-	 * immediately update the gap to the correct value. Finally we
-	 * rebalance the rbtree after all augmented values have been set.
-	 */
-	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
-	vma->rb_subtree_gap = 0;
-	vma_gap_update(vma);
-	vma_rb_insert(vma, &mm->mm_rb);
-}
-
 static void __vma_link_file(struct vm_area_struct *vma)
 {
 	struct file *file;
@@ -782,19 +575,9 @@ static inline void vma_mt_store(struct mm_struct *mm, struct vm_area_struct *vma
 	mtree_store_range(&mm->mm_mt, vma->vm_start, vma->vm_end - 1, vma,
 		GFP_KERNEL);
 }
-static void
-__vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-	struct vm_area_struct *prev, struct rb_node **rb_link,
-	struct rb_node *rb_parent)
-{
-	vma_mt_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
-	__vma_link_rb(mm, vma, rb_link, rb_parent);
-}
 
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev, struct rb_node **rb_link,
-			struct rb_node *rb_parent)
+			struct vm_area_struct *prev)
 {
 	struct address_space *mapping = NULL;
 
@@ -803,7 +586,8 @@ static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 		i_mmap_lock_write(mapping);
 	}
 
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_mt_store(mm, vma);
+	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
 
 	if (mapping)
@@ -815,30 +599,19 @@ static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into the
- * mm's list and rbtree.  It has already been inserted into the interval tree.
+ * mm's list and the mm tree.  It has already been inserted into the interval tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
-	struct rb_node **rb_link, *rb_parent;
 
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
+	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
 		BUG();
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_mt_store(mm, vma);
+	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 }
 
-static __always_inline void __vma_unlink(struct mm_struct *mm,
-						struct vm_area_struct *vma,
-						struct vm_area_struct *ignore)
-{
-	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
-	__vma_unlink_list(mm, vma);
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-}
-
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -856,13 +629,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	struct rb_root_cached *root = NULL;
 	struct anon_vma *anon_vma = NULL;
 	struct file *file = vma->vm_file;
-	bool start_changed = false, end_changed = false;
+	bool vma_changed = false;
 	long adjust_next = 0;
 	int remove_next = 0;
 
-	validate_mm(mm);
-	validate_mm_mt(mm);
-
 	if (next && !insert) {
 		struct vm_area_struct *exporter = NULL, *importer = NULL;
 
@@ -988,21 +758,23 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	}
 
 	if (start != vma->vm_start) {
-		unsigned long old_start = vma->vm_start;
+		if (vma->vm_start < start)
+			vma_mt_szero(mm, vma->vm_start, start);
+		else
+			vma_changed = true;
 		vma->vm_start = start;
-		if (old_start < start)
-			vma_mt_szero(mm, old_start, start);
-		start_changed = true;
 	}
 	if (end != vma->vm_end) {
-		unsigned long old_end = vma->vm_end;
+		if (vma->vm_end > end)
+			vma_mt_szero(mm, end, vma->vm_end);
+		else
+			vma_changed = true;
 		vma->vm_end = end;
-		if (old_end > end)
-			vma_mt_szero(mm, end, old_end);
-		end_changed = true;
+		if (!next)
+			mm->highest_vm_end = vm_end_gap(vma);
 	}
 
-	if (end_changed || start_changed)
+	if (vma_changed)
 		vma_mt_store(mm, vma);
 
 	vma->vm_pgoff = pgoff;
@@ -1020,25 +792,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	}
 
 	if (remove_next) {
-		/*
-		 * vma_merge has merged next into vma, and needs
-		 * us to remove next before dropping the locks.
-		 * Since we have expanded over this vma, the maple tree will
-		 * have overwritten by storing the value
-		 */
-		if (remove_next != 3)
-			__vma_unlink(mm, next, next);
-		else
-			/*
-			 * vma is not before next if they've been
-			 * swapped.
-			 *
-			 * pre-swap() next->vm_start was reduced so
-			 * tell validate_mm_rb to ignore pre-swap()
-			 * "next" (which is stored in post-swap()
-			 * "vma").
-			 */
-			__vma_unlink(mm, next, vma);
+		__vma_unlink_list(mm, next);
+		/* Kill the cache */
+		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -1048,15 +804,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		 * (it may either follow vma or precede it).
 		 */
 		__insert_vm_struct(mm, insert);
-	} else {
-		if (start_changed)
-			vma_gap_update(vma);
-		if (end_changed) {
-			if (!next)
-				mm->highest_vm_end = vm_end_gap(vma);
-			else if (!adjust_next)
-				vma_gap_update(next);
-		}
 	}
 
 	if (anon_vma) {
@@ -1114,10 +861,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			remove_next = 1;
 			end = next->vm_end;
 			goto again;
-		}
-		else if (next)
-			vma_gap_update(next);
-		else {
+		} else if (!next) {
 			/*
 			 * If remove_next == 2 we obviously can't
 			 * reach this path.
@@ -1144,8 +888,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		uprobe_mmap(insert);
 
 	validate_mm(mm);
-	validate_mm_mt(mm);
-
 	return 0;
 }
 
@@ -1292,7 +1034,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	struct vm_area_struct *area, *next;
 	int err;
 
-	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1368,7 +1109,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
-	validate_mm_mt(mm);
 
 	return NULL;
 }
@@ -1539,6 +1279,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	vm_flags_t vm_flags;
 	int pkey = 0;
 
+	validate_mm(mm);
 	*populate = 0;
 
 	if (!len)
@@ -1859,10 +1600,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev, *merge;
 	int error;
-	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged = 0;
 
-	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1878,8 +1617,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+	/* Clear old maps, set up prev and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, uf))
 		return -ENOMEM;
 	/*
 	 * Private writable mapping: check memory availability
@@ -1965,8 +1704,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
+		 * Bug: If addr is changed, prev and the maple tree data  should
+		 * be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr != vma->vm_start);
 
@@ -1989,7 +1728,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto free_vma;
 	}
 
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_link(mm, vma, prev);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -2026,7 +1765,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_set_page_prot(vma);
 
-	validate_mm_mt(mm);
 	return addr;
 
 unmap_and_free_vma:
@@ -2046,7 +1784,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm_mt(mm);
 	return error;
 }
 
@@ -2064,7 +1801,6 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	unsigned long length, gap;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
-	validate_mm(current->mm);
 
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
@@ -2095,7 +1831,6 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	unsigned long length, gap;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
-	validate_mm_mt(current->mm);
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
@@ -2334,9 +2069,6 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
 
 	rcu_read_lock();
 	vma = mas_find(&mas, ULONG_MAX);
-	if (!vma)
-		mas_reset(&mas);
-
 	*pprev = mas_prev(&mas, 0);
 	rcu_read_unlock();
 	return vma;
@@ -2400,7 +2132,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	unsigned long gap_addr;
 	int error = 0;
 
-	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
 
@@ -2447,15 +2178,13 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 			error = acct_stack_growth(vma, size, grow);
 			if (!error) {
 				/*
-				 * vma_gap_update() doesn't support concurrent
-				 * updates, but we only hold a shared mmap_lock
-				 * lock here, so we need to protect against
-				 * concurrent vma expansions.
-				 * anon_vma_lock_write() doesn't help here, as
-				 * we don't guarantee that all growable vmas
-				 * in a mm share the same root anon vma.
-				 * So, we reuse mm->page_table_lock to guard
-				 * against concurrent vma expansions.
+				 * We only hold a shared mmap_lock lock here, so
+				 * we need to protect against concurrent vma
+				 * expansions.  anon_vma_lock_write() doesn't
+				 * help here, as we don't guarantee that all
+				 * growable vmas in a mm share the same root
+				 * anon vma.  So, we reuse mm->page_table_lock
+				 * to guard against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
@@ -2463,10 +2192,9 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
+				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (vma->vm_next)
-					vma_gap_update(vma->vm_next);
-				else
+				if (!vma->vm_next)
 					mm->highest_vm_end = vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
 
@@ -2477,7 +2205,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
-	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2492,7 +2219,6 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct vm_area_struct *prev;
 	int error = 0;
 
-	validate_mm(mm);
 	address &= PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2529,15 +2255,13 @@ int expand_downwards(struct vm_area_struct *vma,
 			error = acct_stack_growth(vma, size, grow);
 			if (!error) {
 				/*
-				 * vma_gap_update() doesn't support concurrent
-				 * updates, but we only hold a shared mmap_lock
-				 * lock here, so we need to protect against
-				 * concurrent vma expansions.
-				 * anon_vma_lock_write() doesn't help here, as
-				 * we don't guarantee that all growable vmas
-				 * in a mm share the same root anon vma.
-				 * So, we reuse mm->page_table_lock to guard
-				 * against concurrent vma expansions.
+				 * We only hold a shared mmap_lock lock here, so
+				 * we need to protect against concurrent vma
+				 * expansions.  anon_vma_lock_write() doesn't
+				 * help here, as we don't guarantee that all
+				 * growable vmas in a mm share the same root
+				 * anon vma.  So, we reuse mm->page_table_lock
+				 * to guard against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
@@ -2549,7 +2273,6 @@ int expand_downwards(struct vm_area_struct *vma,
 				/* Overwrite old entry in mtree. */
 				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
 
 				perf_event_mmap(vma);
@@ -2691,16 +2414,14 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
 	vma->vm_prev = NULL;
 	vma_mt_szero(mm, vma->vm_start, end);
 	do {
-		vma_rb_erase(vma, &mm->mm_rb);
 		mm->map_count--;
 		tail_vma = vma;
 		vma = vma->vm_next;
 	} while (vma && vma->vm_start < end);
 	*insertion_point = vma;
-	if (vma) {
+	if (vma)
 		vma->vm_prev = prev;
-		vma_gap_update(vma);
-	} else
+	else
 		mm->highest_vm_end = prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next = NULL;
 
@@ -2831,11 +2552,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (len == 0)
 		return -EINVAL;
 
-	/*
-	 * arch_unmap() might do unmaps itself.  It must be called
-	 * and finish any rbtree manipulation before this code
-	 * runs and also starts to manipulate the rbtree.
-	 */
+	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
 	/* Find the first overlapping VMA */
@@ -2843,7 +2560,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (!vma)
 		return 0;
 	prev = vma->vm_prev;
-	/* we have  start < vma->vm_end  */
+	/* we have start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
 	if (vma->vm_start >= end)
@@ -2903,7 +2620,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (mm->locked_vm)
 		unlock_range(vma, end);
 
-	/* Detach vmas from rbtree */
+	/* Detach vmas from the MM linked list and remove from the mm tree*/
 	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
 		downgrade = false;
 
@@ -3067,11 +2784,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
  *  anonymous maps.  eventually we may be able to do some
  *  brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long flags, struct list_head *uf)
+static int do_brk_flags(unsigned long addr, unsigned long len,
+			unsigned long flags, struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
-	struct rb_node **rb_link, *rb_parent;
 	pgoff_t pgoff = addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
@@ -3090,8 +2807,8 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	if (error)
 		return error;
 
-	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+	/* Clear old maps, set up prev and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, uf))
 		return -ENOMEM;
 
 	/* Check against address space limits *after* clearing old maps... */
@@ -3125,7 +2842,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	vma->vm_pgoff = pgoff;
 	vma->vm_flags = flags;
 	vma->vm_page_prot = vm_get_page_prot(flags);
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_link(mm, vma, prev);
 out:
 	perf_event_mmap(vma);
 	mm->total_vm += len >> PAGE_SHIFT;
@@ -3245,26 +2962,10 @@ void exit_mmap(struct mm_struct *mm)
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
-	struct rb_node **rb_link, *rb_parent;
-	unsigned long start = vma->vm_start;
-	struct vm_area_struct *overlap = NULL;
 
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
+	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
 		return -ENOMEM;
 
-	overlap = mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
-	if (overlap) {
-
-		pr_err("Found vma ending at %lu\n", start - 1);
-		pr_err("vma : %lu => %lu-%lu\n", (unsigned long)overlap,
-				overlap->vm_start, overlap->vm_end - 1);
-#if defined(CONFIG_DEBUG_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		BUG();
-	}
-
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3286,7 +2987,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
 	}
 
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_link(mm, vma, prev);
 	return 0;
 }
 
@@ -3302,9 +3003,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
-	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma = true;
-	unsigned long index = addr;
 
 	validate_mm_mt(mm);
 	/*
@@ -3316,10 +3015,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		faulted_in_anon_vma = false;
 	}
 
-	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
+	if (range_has_overlap(mm, addr, addr + len, &prev))
 		return NULL;	/* should never get here */
-	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
-		BUG();
+
 	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx);
@@ -3360,7 +3058,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev, rb_link, rb_parent);
+		vma_link(mm, new_vma, prev);
 		*need_rmap_locks = false;
 	}
 	validate_mm_mt(mm);
diff --git a/mm/util.c b/mm/util.c
index 4ddb6e186dd5c..48c79f2784eca 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -287,6 +287,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 	vma->vm_next = next;
 	if (next)
 		next->vm_prev = vma;
+	else
+		mm->highest_vm_end = vm_end_gap(vma);
 }
 
 void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
@@ -301,6 +303,12 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
 		mm->mmap = next;
 	if (next)
 		next->vm_prev = prev;
+	else {
+		if (prev)
+			mm->highest_vm_end = vm_end_gap(prev);
+		else
+			mm->highest_vm_end = 0;
+	}
 }
 
 /* Check if the vma is being used as a stack by this task */
-- 
2.28.0

