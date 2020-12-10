Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3492D6480
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404028AbgLJRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:08:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403969AbgLJRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGo0ZO119784;
        Thu, 10 Dec 2020 17:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=SfQtyHf2T3dyzg3Dz0p0LN08Afkzl2AM1L3LtoLqzCg=;
 b=Nag/dSma6kKY9KY4G3C799UJ2vevn+6RrgLLWgzLioP6eZmEX4FlQNBg7K68bjemMnEE
 oabU/2LKZACBUnrDvA01ETRawimegG5wQYtupOAkIRONZTJUvA/aNMPv1vgVxG1rI4WR
 MdV40iPzZ0TJmZhaVcz5+IMZgFxO7lkZghfiy2gnQgPUyRJndVZoIZW3xiwlpahpTpe3
 kIyvJACkEHMfeUPcDaCcqzG/LlruaJL/ZEEqLUpuGiTR2HFor9pttvusxB9yCuvrILNU
 n2HMdVCU78tff6r/QYjj3bColX0ZunYT23JHzF1FCd2crDUn/5mvXMZiYL3OJbzleOED vA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3581mr6fwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:06:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGvKNJ162461;
        Thu, 10 Dec 2020 17:04:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 358ksrr5g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:54 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4rFE017583;
        Thu, 10 Dec 2020 17:04:53 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:53 -0800
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
Subject: [PATCH 17/28] mm/mmap: Change mmap_region to use maple tree state
Date:   Thu, 10 Dec 2020 12:03:51 -0500
Message-Id: <20201210170402.3468568-18-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/maple_tree.c |   1 +
 mm/mmap.c        | 221 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 190 insertions(+), 32 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e5a58f4833e45..1b678ef90c05c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3525,6 +3525,7 @@ static inline void *_mas_store(struct ma_state *mas, void *entry, bool overwrite
 	if (ret > 2)
 		return NULL;
 spanning_store:
+
 	return content;
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 21342ab85b752..f94a5c17252f2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -492,9 +492,10 @@ munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
 		 struct vm_area_struct **pprev, struct list_head *uf)
 {
 	// Needs optimization.
-	while (range_has_overlap(mm, start, start + len, pprev))
+	while (range_has_overlap(mm, start, start + len, pprev)) {
 		if (do_munmap(mm, start, len, uf))
 			return -ENOMEM;
+	}
 	return 0;
 }
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
@@ -602,6 +603,26 @@ void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
 	vma_mt_store(mm, vma);
 }
 
+static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
+			 struct ma_state *mas, struct vm_area_struct *prev)
+{
+	struct address_space *mapping = NULL;
+
+	if (vma->vm_file) {
+		mapping = vma->vm_file->f_mapping;
+		i_mmap_lock_write(mapping);
+	}
+
+	vma_mas_store(vma, mas);
+	__vma_link_list(mm, vma, prev);
+	__vma_link_file(vma);
+
+	if (mapping)
+		i_mmap_unlock_write(mapping);
+
+	mm->map_count++;
+	validate_mm(mm);
+}
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev)
 {
@@ -638,6 +659,98 @@ static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	mm->map_count++;
 }
 
+inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct address_space *mapping = NULL;
+	struct rb_root_cached *root = NULL;
+	struct anon_vma *anon_vma = vma->anon_vma;
+	struct file *file = vma->vm_file;
+	bool remove_next = false;
+	int error;
+
+	if (next && (vma != next) && (end == next->vm_end)) {
+		remove_next = true;
+		if (next->anon_vma && !vma->anon_vma) {
+			vma->anon_vma = next->anon_vma;
+			error = anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping = file->f_mapping;
+		root = &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+	}
+
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	if (file) {
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	}
+
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_mas_store(vma, mas);
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* Expanding over the next vma */
+	if (remove_next) {
+		/* Remove from mm linked list - also updates highest_vm_end */
+		__vma_unlink_list(mm, next);
+
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+
+	} else if (!next) {
+		mm->highest_vm_end = vm_end_gap(vma);
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
+	if (remove_next) {
+		if (file) {
+			uprobe_munmap(next, next->vm_start, next->vm_end);
+			fput(file);
+		}
+		if (next->anon_vma)
+			anon_vma_merge(vma, next);
+		mm->map_count--;
+		mpol_put(vma_policy(next));
+		vm_area_free(next);
+	}
+
+	validate_mm(mm);
+	return 0;
+}
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1624,9 +1737,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	unsigned long end = addr + len;
+	unsigned long merge_start = addr, merge_end = end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
 
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1636,16 +1755,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages = count_vma_pages_range(mm, addr, addr + len);
+		nr_pages = count_vma_pages_range(mm, addr, end);
 
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
 
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
 		return -ENOMEM;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -1656,14 +1776,46 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma = vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX);
-	if (vma)
-		goto out;
 
+	if (vm_flags & VM_SPECIAL) {
+		prev = mas_prev(&mas, 0);
+		goto cannot_expand;
+	}
+
+	/* Attempt to expand an old mapping */
+
+	/* Check next */
+	next = mas_next(&mas, ULONG_MAX);
+	if (next && next->vm_start == end && vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX)) {
+		merge_end = next->vm_end;
+		vma = next;
+		vm_pgoff = next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	prev = mas_prev(&mas, 0);
+	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
+	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				NULL_VM_UFFD_CTX)) {
+		merge_start = prev->vm_start;
+		vma = prev;
+		vm_pgoff = prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma_merge(prev, vm_flags);
+		goto expanded;
+	}
+
+	mas_reset(&mas);
+	mas_set(&mas, addr);
+	mas.last = end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1676,7 +1828,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	vma->vm_start = addr;
-	vma->vm_end = addr + len;
+	vma->vm_end = end;
 	vma->vm_flags = vm_flags;
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
@@ -1706,17 +1858,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		/* If vm_flags changed after call_mmap(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
-		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
-			if (merge) {
+		if (unlikely(vm_flags != vma->vm_flags && prev &&
+			     prev->vm_end == addr && !vma_policy(prev) &&
+			     can_vma_merge_after(prev, vm_flags, NULL, file,
+						 pgoff, NULL_VM_UFFD_CTX))) {
+			merge_start = prev->vm_start;
+			vm_pgoff = prev->vm_pgoff;
+			if (!vma_expand(&mas, prev, merge_start, merge_end,
+					vm_pgoff, next)) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
 				 * and cause general protection fault ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
-				vma = merge;
+				vma = prev;
 				/* Update vm_flags and possible addr to pick up the change. We don't
 				 * warn here if addr changed as the vma is not linked by vma_link().
 				 */
@@ -1730,7 +1886,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev and the maple tree data  should
+		 * Bug: If addr is changed, prev and the maple tree data should
 		 * be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr != vma->vm_start);
@@ -1754,7 +1910,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto free_vma;
 	}
 
-	vma_link(mm, vma, prev);
+	mas.index = mas.last = addr;
+	mas_walk(&mas);
+	vma_mas_link(mm, vma, &mas, prev);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -1764,14 +1922,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			allow_write_access(file);
 	}
 	file = vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
 
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(current->mm))
+		    is_vm_hugetlb_page(vma) ||
+		    vma == get_gate_vma(current->mm))
 			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 		else
 			mm->locked_vm += (len >> PAGE_SHIFT);
@@ -2061,14 +2219,17 @@ struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
 					     unsigned long end_addr)
 {
 	struct vm_area_struct *vma;
-	unsigned long addr = start_addr;
+	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
 
 	/* Check the cache first. */
 	vma = vmacache_find(mm, start_addr);
 	if (likely(vma))
 		return vma;
 
-	vma = mt_find(&mm->mm_mt, &addr, end_addr - 1);
+	rcu_read_lock();
+	vma = mas_find(&mas, end_addr - 1);
+	rcu_read_unlock();
+
 	if (vma)
 		vmacache_update(start_addr, vma);
 
@@ -2597,16 +2758,13 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	arch_unmap(mm, start, end);
 
 	/* Find the first overlapping VMA */
-	vma = find_vma(mm, start);
+	vma = find_vma_intersection(mm, start, end);
 	if (!vma)
 		return 0;
+
 	prev = vma->vm_prev;
 	/* we have start < vma->vm_end  */
 
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >= end)
-		return 0;
-
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2616,7 +2774,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	 */
 	if (start > vma->vm_start) {
 		int error;
-
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
-- 
2.28.0

