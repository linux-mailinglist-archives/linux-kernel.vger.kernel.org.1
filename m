Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FDF2F3539
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392924AbhALQOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54530 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392854AbhALQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9eV6086597;
        Tue, 12 Jan 2021 16:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Aw1n4w5RhTK97Ln+iV5xDHtv1dFg/00BiCEehGwOvGc=;
 b=inrJ6Z3sRUcfL3/0gP5KLTTViucMUfYqYn0n+s2eapOrcU8XpDY45cdhaUuGgujclAO3
 YwleyBXP+zkd/QvE7UJvZGhjoHFzqt1UGOBg64MSzlqxA2QaR3RBWdCh0rMxn02YyK6W
 k1cEg4t1f7LTzqVV8wCKcLLgDaJ7aJXWxmPjeospXnwSy6n4Bjt9u8Zzjii6p8ZwxWjM
 mForoqLxwIZKg55gapjaNEWWhbdnCTSvn9iNPTXEXdFpXPmq1tBcbPBDSa/rZsCxcFHS
 /PYUda7iCoCy3gESQDYIMwpSHTe8767xFxJasiwPJ6qZ6fcQ0a2SNH3yKAycUNysHrVY MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 360kg1q4uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAbVF100512;
        Tue, 12 Jan 2021 16:13:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 360keh7j64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGDMc8019462;
        Tue, 12 Jan 2021 16:13:22 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:22 -0800
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
Subject: [PATCH v2 17/70] mm/mmap: Change mmap_region to use maple tree state
Date:   Tue, 12 Jan 2021 11:11:47 -0500
Message-Id: <20210112161240.2024684-18-Liam.Howlett@Oracle.com>
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/maple_tree.c |   1 +
 mm/mmap.c        | 227 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 195 insertions(+), 33 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c24c6f154c857..522f5fdfe5078 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3566,6 +3566,7 @@ static inline void *_mas_store(struct ma_state *mas, void *entry, bool overwrite
 	if (ret > 2)
 		return NULL;
 spanning_store:
+
 	return content;
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 6be58594afb3d..d3dfea031c0d5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -500,9 +500,10 @@ munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
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
@@ -613,6 +614,27 @@ static inline void vma_mt_store(struct mm_struct *mm, struct vm_area_struct *vma
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
+
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev)
 {
@@ -649,6 +671,98 @@ static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
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
@@ -1635,9 +1749,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
@@ -1647,16 +1767,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
@@ -1667,14 +1788,46 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
@@ -1687,7 +1840,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	vma->vm_start = addr;
-	vma->vm_end = addr + len;
+	vma->vm_end = end;
 	vma->vm_flags = vm_flags;
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
@@ -1728,18 +1881,25 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
-				/* Update vm_flags to pick up the change. */
+				vma = prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr = vma->vm_start;
 				vm_flags = vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1749,7 +1909,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev and the maple tree data  should
+		 * Bug: If addr is changed, prev and the maple tree data should
 		 * be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr != vma->vm_start);
@@ -1773,7 +1933,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto free_vma;
 	}
 
-	vma_link(mm, vma, prev);
+	mas.index = mas.last = addr;
+	mas_walk(&mas);
+	vma_mas_link(mm, vma, &mas, prev);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -1783,14 +1945,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
@@ -2080,14 +2242,17 @@ struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
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
 
@@ -2616,16 +2781,13 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
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
@@ -2635,7 +2797,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	 */
 	if (start > vma->vm_start) {
 		int error;
-
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
-- 
2.28.0

