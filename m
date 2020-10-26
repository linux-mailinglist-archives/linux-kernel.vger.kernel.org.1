Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B48299A97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406582AbgJZXeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:34:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36584 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406557AbgJZXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:34:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNP0Sj157925;
        Mon, 26 Oct 2020 23:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=udlAx6H8y9KY9avW4yuaW3elKliU/TPSV0SPEU/aktw=;
 b=NTsaKpZyfDr13pUntpNTQnOvtx04uxgMfbLSb2KBJ3A8Py8eJMx5qG+L8m0KYNT4Pmt1
 6CpHcIJFQf2/l0rhWmGg/m6YBCdE/0zRryByuwGSzq4D8sL/0OOcI6sYVY2h4nBH+eE+
 15ft/82F7njt+wjGsQba3dkLhQV18CLJ/MnhKQ4ADIvvQB8kwCiGWFzx1+08WzoOy+EF
 8pJEYYcKBsPXx1bjWZ+GAm250tqju05/HHCsMocX4fZkMU2syWeSkN+5qrPwn1jOCYDU
 9L1bLuguMOgBZf2xe/a1UcowuJUYoXLnUVJN0tT6LPVw/9EqyK9bTCmia1Z5YEOPilo2 Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7kq8hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 23:34:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNPx32110473;
        Mon, 26 Oct 2020 23:32:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx5wfqn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 23:32:18 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09QNWHIQ004719;
        Mon, 26 Oct 2020 23:32:17 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:32:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v2 3/4] hugetlbfs: use hinode_rwsem for pmd sharing synchronization
Date:   Mon, 26 Oct 2020 16:31:49 -0700
Message-Id: <20201026233150.371577-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201026233150.371577-1-mike.kravetz@oracle.com>
References: <20201026233150.371577-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to pmd sharing, the huge PTE pointer returned by huge_pte_alloc
may not be valid.  This can happen if a call to huge_pmd_unshare for
the same pmd is made in another thread.

Use the hinode_rwsem to address this issue:
- hinode_rwsem is taken in read mode before calling huge_pte_alloc, and
  held until finished with the returned pte pointer.
- hinode_rwsem is held in write mode whenever huge_pmd_unshare is called.

In the locking hierarchy, hinode_rwsem must be taken before a page lock.

Use the routines hinode_lock_read/write while passing vma and addr if
possible to only take the semaphore if pmd sharing is possible.  Also,
add lockdep_assert calls to huge_pmd_share/unshare to help catch callers
not using the proper locking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 11 +++++-
 include/linux/hugetlb.h |  8 ++--
 mm/hugetlb.c            | 83 ++++++++++++++++++++++++++++++++++-------
 mm/memory-failure.c     | 15 +++++++-
 mm/memory.c             |  5 +++
 mm/migrate.c            | 15 ++++++++
 mm/rmap.c               |  2 +-
 mm/userfaultfd.c        | 14 ++++++-
 8 files changed, 132 insertions(+), 21 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0460b43240b9..084a688d9f2e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -510,13 +510,18 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * Getting here in a truncate operation is a bug.
 			 */
 			if (unlikely(page_mapped(page))) {
-				BUG_ON(truncate_op);
+				bool hinode_locked;
 
+				BUG_ON(truncate_op);
+				hinode_locked =
+					hinode_lock_write(inode, NULL, 0UL);
 				i_mmap_lock_write(mapping);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h));
 				i_mmap_unlock_write(mapping);
+				if (hinode_locked)
+					hinode_unlock_write(inode);
 			}
 
 			lock_page(page);
@@ -573,15 +578,19 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	pgoff_t pgoff;
 	struct address_space *mapping = inode->i_mapping;
 	struct hstate *h = hstate_inode(inode);
+	bool hinode_locked;
 
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
+	hinode_locked = hinode_lock_write(inode, NULL, 0UL);
 	i_size_write(inode, offset);
 	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
 	i_mmap_unlock_write(mapping);
+	if (hinode_locked)
+		hinode_unlock_write(inode);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 	return 0;
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d3939a866855..f1d9730c8bd5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -163,7 +163,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
-int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep);
+int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long *addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
@@ -196,8 +197,9 @@ static inline unsigned long hugetlb_total_pages(void)
 	return 0;
 }
 
-static inline int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr,
-					pte_t *ptep)
+static inline int huge_pmd_unshare(struct mm_struct *mm,
+				struct vm_area_struct *vma,
+				unsigned long *addr, pte_t *ptep)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7b38c91f457b..4debacb5339c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3720,6 +3720,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	unsigned long sz = huge_page_size(h);
 	struct mmu_notifier_range range;
 	int ret = 0;
+	bool hinode_locked;
 
 	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
@@ -3730,6 +3731,15 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_invalidate_range_start(&range);
 	}
 
+	/*
+	 * For shared mappings hinode_rwsem must be held to call
+	 * huge_pte_alloc, otherwise the returned ptep could go
+	 * away if part of a shared pmd and another thread calls
+	 * huge_pmd_unshare.
+	 *
+	 */
+	hinode_locked = hinode_lock_read(vma->vm_file->f_inode, vma, 0UL);
+
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
 		src_pte = huge_pte_offset(src, addr, sz);
@@ -3805,6 +3815,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 	if (cow)
 		mmu_notifier_invalidate_range_end(&range);
+	if (hinode_locked)
+		hinode_unlock_read(vma->vm_file->f_inode);
 
 	return ret;
 }
@@ -3848,7 +3860,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			continue;
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, &address, ptep)) {
+		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
 			spin_unlock(ptl);
 			/*
 			 * We just unmapped a page of PMDs by clearing a PUD.
@@ -4200,7 +4212,8 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep, unsigned int flags,
+			bool hinode_locked)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -4253,13 +4266,20 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			};
 
 			/*
-			 * hugetlb_fault_mutex must be dropped before
-			 * handling userfault.  Reacquire after handling
+			 * hugetlb_fault_mutex and inode mutex must be dropped
+			 * before handling userfault.  Reacquire after handling
 			 * fault to make calling code simpler.
 			 */
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			if (hinode_locked)
+				hinode_unlock_read(mapping->host);
+
 			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
+
+			if (hinode_locked)
+				(void)hinode_lock_read(mapping->host, vma,
+							address);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
@@ -4421,9 +4441,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct address_space *mapping;
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	bool hinode_locked;
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
+		/*
+		 * Since we hold no locks, ptep could be stale.  That is
+		 * OK as we are only making decisions based on content and
+		 * not actually modifying content here.
+		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
@@ -4431,26 +4457,39 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
-	} else {
-		ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
-		if (!ptep)
-			return VM_FAULT_OOM;
 	}
 
+	/*
+	 * Acquire hinode_rwsem before calling huge_pte_alloc and hold
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
+	 *
+	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * is OK, as huge_pte_alloc will return the same value unless
+	 * something has changed.
+	 */
 	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
+	hinode_locked = hinode_lock_read(mapping->host, vma, address);
+	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
+	if (!ptep) {
+		ret = VM_FAULT_OOM;
+		goto out_mutex;
+	}
+
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
+	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	entry = huge_ptep_get(ptep);
 	if (huge_pte_none(entry)) {
-		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep, flags);
+		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+					flags, hinode_locked);
 		goto out_mutex;
 	}
 
@@ -4532,6 +4571,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+	if (hinode_locked)
+		hinode_unlock_read(mapping->host);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -4872,6 +4913,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool hinode_locked;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -4886,6 +4928,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	flush_cache_range(vma, range.start, range.end);
 
 	mmu_notifier_invalidate_range_start(&range);
+	hinode_locked = hinode_lock_write(vma->vm_file->f_inode, vma,
+						range.start);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (; address < end; address += huge_page_size(h)) {
 		spinlock_t *ptl;
@@ -4893,7 +4937,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, &address, ptep)) {
+		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
@@ -4948,6 +4992,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * See Documentation/vm/mmu_notifier.rst
 	 */
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	if (hinode_locked)
+		hinode_unlock_write(vma->vm_file->f_inode);
 	mmu_notifier_invalidate_range_end(&range);
 
 	return pages << h->order;
@@ -5199,6 +5245,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * pud has to be populated inside the same i_mmap_rwsem section - otherwise
  * racing tasks could either miss the sharing (see huge_pte_offset) or select a
  * bad pmd for sharing.
+ *
+ * This should be called with hinode_rwsem held in read mode. Otherwise, it
+ * could race with huge_pmd_unshare and the pte_t pointer could become invalid
+ * before being returned to the caller.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
@@ -5214,6 +5264,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 
 	if (!vma_shareable(vma, addr))
 		return (pte_t *)pmd_alloc(mm, pud, addr);
+	hinode_assert_locked(mapping);
 
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
@@ -5256,12 +5307,13 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * called with page table lock held.
+ * Called with page table lock held and hinode_rwsem held in write mode.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
  */
-int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long *addr, pte_t *ptep)
 {
 	pgd_t *pgd = pgd_offset(mm, *addr);
 	p4d_t *p4d = p4d_offset(pgd, *addr);
@@ -5271,6 +5323,8 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 	if (page_count(virt_to_page(ptep)) == 1)
 		return 0;
 
+	hinode_assert_write_locked(vma->vm_file->f_mapping);
+
 	pud_clear(pud);
 	put_page(virt_to_page(ptep));
 	mm_dec_nr_pmds(mm);
@@ -5284,7 +5338,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	return NULL;
 }
 
-int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long *addr, pte_t *ptep)
 {
 	return 0;
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0c4f8cbc772e..593c109a3c80 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1054,7 +1054,20 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(hpage, ttu);
+	if (PageHuge(hpage) && !PageAnon(hpage) && mapping) {
+		bool hinode_locked;
+		/*
+		 * For hugetlb pages, try_to_unmap could potentially call
+		 * huge_pmd_unshare.  Because of this, take hinode_rwsem
+		 * in write mode before calling.
+		 */
+		hinode_locked = hinode_lock_write(mapping->host, NULL, 0UL);
+		unmap_success = try_to_unmap(hpage, ttu);
+		if (hinode_locked)
+			hinode_unlock_write(mapping->host);
+	} else {
+		unmap_success = try_to_unmap(hpage, ttu);
+	}
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(hpage));
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..315d92bb68ff 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1465,9 +1465,14 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			 * safe to do nothing in this case.
 			 */
 			if (vma->vm_file) {
+				bool hinode_locked;
+
+				hinode_locked = hinode_lock_write(vma->vm_file->f_inode, vma, 0UL);
 				i_mmap_lock_write(vma->vm_file->f_mapping);
 				__unmap_hugepage_range_final(tlb, vma, start, end, NULL);
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
+				if (hinode_locked)
+					hinode_unlock_write(vma->vm_file->f_inode);
 			}
 		} else
 			unmap_page_range(tlb, vma, start, end, details);
diff --git a/mm/migrate.c b/mm/migrate.c
index 05c3c2e569df..a5685565cf1a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1327,9 +1327,24 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
+		struct address_space *mapping = NULL;
+		bool hinode_locked = false;
+
+		/*
+		 * try_to_unmap could potentially call huge_pmd_unshare.
+		 * Take hinode_rwsem if sharing is possible.
+		 */
+		if (!PageAnon(hpage)) {
+			mapping = page_mapping(hpage);
+			if (mapping)
+				hinode_locked = hinode_lock_write(mapping->host,
+								NULL, 0UL);
+		}
 		try_to_unmap(hpage,
 			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
 		page_was_mapped = 1;
+		if (hinode_locked)
+			hinode_unlock_write(mapping->host);
 	}
 
 	if (!page_mapped(hpage))
diff --git a/mm/rmap.c b/mm/rmap.c
index b30d211bd999..9e65c9c95449 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1456,7 +1456,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		address = pvmw.address;
 
 		if (PageHuge(page)) {
-			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
+			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
 				/*
 				 * huge_pmd_unshare unmapped an entire PMD
 				 * page.  There is no way of knowing exactly
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ab9e0496d601..665efb24ba93 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -220,6 +220,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	pgoff_t idx;
 	u32 hash;
 	struct address_space *mapping;
+	bool hinode_locked;
 
 	/*
 	 * There is no default zero huge page for all huge page sizes as
@@ -278,10 +279,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via hugetlb_fault_mutex
+		 * Serialize via hinode_rwsem and hugetlb_fault_mutex.
+		 * hinode_rwsem ensures the dst_pte remains valid even
+		 * in the case of shared pmds.  fault mutex prevents
+		 * races with other faulting threads.
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
+		hinode_locked = hinode_lock_read(mapping->host, dst_vma,
+								dst_addr);
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -289,6 +295,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			if (hinode_locked)
+				hinode_unlock_read(mapping->host);
 			goto out_unlock;
 		}
 
@@ -296,6 +304,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pteval = huge_ptep_get(dst_pte);
 		if (!huge_pte_none(dst_pteval)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			if (hinode_locked)
+				hinode_unlock_read(mapping->host);
 			goto out_unlock;
 		}
 
@@ -303,6 +313,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 						dst_addr, src_addr, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		if (hinode_locked)
+			hinode_unlock_read(mapping->host);
 		vm_alloc_shared = vm_shared;
 
 		cond_resched();
-- 
2.25.4

