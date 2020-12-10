Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E222D64A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbgLJRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:06:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403868AbgLJRFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:05:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnUSO044426;
        Thu, 10 Dec 2020 17:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=a7MHu0vlzISTqpYsIhZrWM4h3MCCswGgg4L6YlFbqk8=;
 b=bZuSMB+W2mp7w53oYR4cYNdOr3fg5l7TDQbzXr3X+HEFYPUEcAl5uFFrqOjIV56uDNcg
 7MFM2z6yFaoyloHxnj0ZNVSS0DWD6K05REZZSptHI0ekFRD+cnES1tKpHpkRrvSoeHwS
 ZtuouvvnD140XY1j9xMyoxMe3hFixKNFX7A67vqa1ofsAJyKd+rfxjh8fjVi9pVH/tPw
 Kx/SfWQySNaGOOB5ilsGXDQBAnLgZDvyGiKcFx3tUZjq7yJHK1BbzBzpkWTfCzegL5pf
 W3TuiWuHnLP00T2JD54UGyQrbXeh8q7fgnq1smeQFuR/m2lwlo5JIQ7u8GUD4Sax9E5X wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35825meh20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:04:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwj7D046099;
        Thu, 10 Dec 2020 17:04:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 358m41xb5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:51 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4oKI017467;
        Thu, 10 Dec 2020 17:04:50 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:50 -0800
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
Subject: [PATCH 14/28] mm/mmap: Change do_brk_flags() to expand existing VMA and add do_brk_munmap()
Date:   Thu, 10 Dec 2020 12:03:48 -0500
Message-Id: <20201210170402.3468568-15-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=2 mlxscore=0 mlxlogscore=999
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

Avoid allocating a new VMA when it is not necessary.  Expand or contract
the existing VMA instead.  This avoids unnecessary tree manipulations
and allocations.

Once the VMA is known, use it directly when populating to avoid
unnecessary lookup work.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 285 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 219 insertions(+), 66 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4b173883472dd..ec2e92b03f9d1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -51,7 +51,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
-
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmap.h>
 
@@ -184,18 +183,22 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 	return next;
 }
 
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long flags,
-		struct list_head *uf);
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
-	unsigned long retval;
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next = NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded = false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -235,37 +238,41 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
 
-	/*
-	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
-	 */
-	if (brk <= mm->brk) {
+	mas_set(&mas, newbrk);
+	brkvma = mas_walk(&mas);
+	if (brkvma) { // munmap necessary, there is something at newbrk.
+		/*
+		 * Always allow shrinking brk.
+		 * do_brk_munmap() may downgrade mmap_lock to read.
+		 */
 		int ret;
-
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must to be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk = brk;
-		ret = __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk = origbrk;
-			goto out;
-		} else if (ret == 1) {
+		mas.last = oldbrk - 1;
+		ret = do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret == 1)  {
 			downgraded = true;
-		}
-		goto success;
-	}
+			goto success;
+		} else if (!ret)
+			goto success;
 
+		mm->brk = origbrk;
+		goto out;
+	}
+	next = mas_next(&mas, ULONG_MAX);
 	/* Check against existing mmap mappings. */
-	next = find_vma(mm, oldbrk);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
 
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	brkvma = mas_prev(&mas, mm->start_brk);
+	if (do_brk_flags(&mas, &brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk = brk;
 
 success:
@@ -276,13 +283,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
-		mm_populate(oldbrk, newbrk - oldbrk);
+		mm_populate_vma(brkvma, oldbrk, newbrk);
 	return brk;
 
 out:
-	retval = origbrk;
 	mmap_write_unlock(mm);
-	return retval;
+	return origbrk;
 }
 
 #if defined(CONFIG_DEBUG_MAPLE_TREE)
@@ -367,16 +373,16 @@ static void validate_mm(struct mm_struct *mm)
 	validate_mm_mt(mm);
 
 	while (vma) {
+#ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma = vma->anon_vma;
 		struct anon_vma_chain *avc;
-
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				anon_vma_interval_tree_verify(avc);
 			anon_vma_unlock_read(anon_vma);
 		}
-
+#endif
 		highest_address = vm_end_gap(vma);
 		vma = vma->vm_next;
 		i++;
@@ -538,7 +544,21 @@ static void __vma_link_file(struct vm_area_struct *vma)
 		flush_dcache_mmap_unlock(mapping);
 	}
 }
-/* Private
+
+static inline int vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	mas->index = vma->vm_start;
+	mas->last = vma->vm_end - 1;
+	return mas_store_gfp(mas, vma, GFP_KERNEL);
+}
+
+static inline int vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	mas->index = vma->vm_start;
+	mas->last = vma->vm_end - 1;
+	return mas_store_gfp(mas, NULL, GFP_KERNEL);
+}
+/*
  * vma_mt_erase() - erase a VMA entry from the maple tree.
  *
  * @mm: The struct_mm
@@ -549,7 +569,7 @@ static inline void vma_mt_erase(struct mm_struct *mm, struct vm_area_struct *vma
 	trace_vma_mt_erase(mm, vma);
 	mtree_erase(&mm->mm_mt, vma->vm_start);
 }
-/* Private
+/*
  * vma_mt_szero() - Set a given range to zero.  Used when modifying a
  * vm_area_struct start or end.
  *
@@ -563,7 +583,7 @@ static inline void vma_mt_szero(struct mm_struct *mm, unsigned long start,
 	trace_vma_mt_szero(mm, start, end);
 	mtree_store_range(&mm->mm_mt, start, end - 1, NULL, GFP_KERNEL);
 }
-/* Private
+/*
  * vma_mt_store() - Store a given vm_area_struct in the maple tree.
  *
  * @mm: The struct_mm
@@ -576,6 +596,12 @@ static inline void vma_mt_store(struct mm_struct *mm, struct vm_area_struct *vma
 		GFP_KERNEL);
 }
 
+
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	vma_mt_store(mm, vma);
+}
+
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev)
 {
@@ -1809,7 +1835,6 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 
 	if (mas_get_empty_area(&mas, info->low_limit, info->high_limit - 1,
 				  length)) {
-		rcu_read_unlock();
 		return -ENOMEM;
 	}
 	gap = mas.index;
@@ -1838,7 +1863,6 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 
 	if (mas_get_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
 				length)) {
-		rcu_read_unlock();
 		return -ENOMEM;
 	}
 	gap = (mas.index + info->align_mask) & ~info->align_mask;
@@ -2025,8 +2049,7 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 EXPORT_SYMBOL(get_unmapped_area);
 
 /**
- * find_vma() - Find the VMA for a given address, or the next vma.  May return
- * NULL in the case of no vma at addr or above
+ * find_vma() - Find the VMA for a given address, or the next vma.
  * @mm The mm_struct to check
  * @addr: The address
  *
@@ -2036,13 +2059,16 @@ EXPORT_SYMBOL(get_unmapped_area);
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
 
 	/* Check the cache first. */
 	vma = vmacache_find(mm, addr);
 	if (likely(vma))
 		return vma;
 
-	vma = mt_find(&mm->mm_mt, &addr, ULONG_MAX);
+	rcu_read_lock();
+	vma = mas_find(&mas, end_addr - 1);
+	rcu_read_unlock();
 	if (vma)
 		vmacache_update(addr, vma);
 
@@ -2780,16 +2806,102 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 }
 
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * bkr_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ *
+ * Returns: 0 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lock if
+ * possible.
+ */
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret = 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely(vma->vm_start >= newbrk)) { // remove entire mapping(s)
+		mas_set(mas, newbrk);
+		if (vma->vm_start != newbrk)
+			mas_reset(mas); // cause a re-walk for the first overlap.
+		ret = do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start = newbrk;
+	unmap.vm_end = oldbrk;
+	ret = userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret = 1;
+
+	// Change the oldbrk of vma to the newbrk of the munmap area
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	vma->vm_end = newbrk;
+	if (vma_mas_remove(&unmap, mas))
+		goto mas_store_fail;
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+
+	unmap_pages = vma_pages(&unmap);
+	if (unmap.vm_flags & VM_LOCKED) {
+		mm->locked_vm -= unmap_pages;
+		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
+	}
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
+	if (unmap.vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+
+mas_store_fail:
+	vma->vm_end = oldbrk;
+	anon_vma_interval_tree_post_update_vma(vma);
+	anon_vma_unlock_write(vma->anon_vma);
+	return -ENOMEM;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the flags
+ * do not match then create a new anonymous VMA.  Eventually we may be able to
+ * do some brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff = addr >> PAGE_SHIFT;
+	struct vm_area_struct *prev = NULL, *vma;
 	int error;
 	unsigned long mapped_addr;
 	validate_mm_mt(mm);
@@ -2807,11 +2919,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
 	if (error)
 		return error;
 
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
-
-	/* Check against address space limits *after* clearing old maps... */
+	/* Check against address space limits by the changed size */
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
@@ -2821,28 +2929,58 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	/* Can we just expand an old private anonymous mapping? */
-	vma = vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
-	if (vma)
-		goto out;
+	mas->last = addr + len - 1;
+	if (*brkvma) {
+		vma = *brkvma;
+		/* Expand the existing vma if possible; almost never a singular
+		 * list, so this will almost always fail. */
 
-	/*
-	 * create a vma struct for an anonymous mapping
-	 */
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+		if ((!vma->anon_vma ||
+		     list_is_singular(&vma->anon_vma_chain)) &&
+		     ((vma->vm_flags & ~VM_SOFTDIRTY) == flags)){
+			mas->index = vma->vm_start;
+
+			vma_adjust_trans_huge(vma, addr, addr + len, 0);
+			if (vma->anon_vma) {
+				anon_vma_lock_write(vma->anon_vma);
+				anon_vma_interval_tree_pre_update_vma(vma);
+			}
+			vma->vm_end = addr + len;
+			vma->vm_flags |= VM_SOFTDIRTY;
+			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+				goto mas_mod_fail;
+			if (vma->anon_vma) {
+				anon_vma_interval_tree_post_update_vma(vma);
+				anon_vma_unlock_write(vma->anon_vma);
+			}
+			khugepaged_enter_vma_merge(vma, flags);
+			goto out;
+		}
+		prev = vma;
 	}
+	mas->index = addr;
+	mas_walk(mas);
+
+	/* create a vma struct for an anonymous mapping */
+	vma = vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
 
 	vma_set_anonymous(vma);
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
-	vma->vm_pgoff = pgoff;
+	vma->vm_pgoff = addr >> PAGE_SHIFT;
 	vma->vm_flags = flags;
 	vma->vm_page_prot = vm_get_page_prot(flags);
-	vma_link(mm, vma, prev);
+	if (vma_mas_store(vma, mas))
+		goto mas_store_fail;
+
+	if (!prev)
+		prev = mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	*brkvma = vma;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm += len >> PAGE_SHIFT;
@@ -2852,15 +2990,29 @@ static int do_brk_flags(unsigned long addr, unsigned long len,
 	vma->vm_flags |= VM_SOFTDIRTY;
 	validate_mm_mt(mm);
 	return 0;
+
+mas_store_fail:
+	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_mod_fail:
+	vma->vm_end = addr;
+	anon_vma_interval_tree_post_update_vma(vma);
+	anon_vma_unlock_write(vma->anon_vma);
+	return -ENOMEM;
+
 }
 
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
-	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
 
 	len = PAGE_ALIGN(request);
 	if (len < request)
@@ -2871,10 +3023,11 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = do_brk_flags(addr, len, flags, &uf);
+	// This vma left intentionally blank.
+	mas_walk(&mas);
+	ret = do_brk_flags(&mas, &vma, addr, len, flags);
 	populate = ((mm->def_flags & VM_LOCKED) != 0);
 	mmap_write_unlock(mm);
-	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
-- 
2.28.0

