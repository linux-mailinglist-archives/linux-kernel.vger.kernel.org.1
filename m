Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58A628D6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbgJMXNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:13:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54016 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbgJMXN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:13:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DN8VxJ074625;
        Tue, 13 Oct 2020 23:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=OZoMsHfUK8QgQdS+fheU1g5294UzOhI48vnFXfVgihQ=;
 b=GI4bG/CSqGMjA8UbrvJ7RvaQsx/F8NkStuE/bRJn5LS2P1Dj5r6K0ov/T/bK7FYrF4gL
 uhqfgE4kjVdqFuA8jmEZ3eAna//7p7HaZpN8Gt1aOx8oJxbLnBYsKU0YNmA1KML/Qcnm
 FnWmd6Q0qPvJuuWee3nDC4Fcx7U5I94Sp7d9ybkO+yHtr936IG+Do+V7ufr2ElQ9d1ap
 b8+kcyidASOUIVEX+iPV9qewalOFUr5psWwBd07wupJyfyKFy7OgTFe8LMKz8JPVCg5e
 VCEEcteTpAd0Q8FfZjcQ3dCePgx/d/C5KTicEmq2eGuB78byTx75mdLXpVucJ1nxjEH+ 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3434wkmtu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 23:13:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DN5F5G023460;
        Tue, 13 Oct 2020 23:11:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 343puykkrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 23:11:12 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09DNBBdq028224;
        Tue, 13 Oct 2020 23:11:11 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 16:11:11 -0700
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
Subject: [RFC PATCH 2/3] hugetlbfs: introduce hinode_rwsem for pmd sharing synchronization
Date:   Tue, 13 Oct 2020 16:10:59 -0700
Message-Id: <20201013231100.71013-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201013231100.71013-1-mike.kravetz@oracle.com>
References: <20201013231100.71013-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to pmd sharing, the huge PTE pointer returned by huge_pte_alloc
may not be valid.  This can happen if a call to huge_pmd_unshare for
the same pmd is made in another thread.

To address this issue, add a rw_semaphore (hinode_rwsem) to the hugetlbfs
inode.
- hinode_rwsem is taken in read mode before calling huge_pte_alloc, and
  held until finished with the returned pte pointer.
- hinode_rwsem is held in write mode whenever huge_pmd_unshare is called.

In the locking hierarchy, hinode_rwsem must be taken before a page lock.

In an effort to minimize performance impacts, hinode_rwsem is not taken
if the caller knows the target can not possibly be part of a shared pmd.
lockdep_assert calls are added to huge_pmd_share and huge_pmd_unshare to
help catch callers not using the proper locking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  8 ++++
 include/linux/hugetlb.h | 66 +++++++++++++++++++++++++++++--
 mm/hugetlb.c            | 86 +++++++++++++++++++++++++++++------------
 mm/memory-failure.c     | 15 ++++++-
 mm/migrate.c            | 15 +++++++
 mm/rmap.c               |  3 +-
 mm/userfaultfd.c        |  9 ++++-
 7 files changed, 171 insertions(+), 31 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3a1246aeedc4..d6bb675d4872 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -499,13 +499,17 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * Getting here in a truncate operation is a bug.
 			 */
 			if (unlikely(page_mapped(page))) {
+				struct hugetlbfs_inode_info *info =
+					HUGETLBFS_I(inode);
 				BUG_ON(truncate_op);
 
+				down_write(&info->hinode_rwsem);
 				i_mmap_lock_write(mapping);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h));
 				i_mmap_unlock_write(mapping);
+				up_write(&info->hinode_rwsem);
 			}
 
 			lock_page(page);
@@ -562,15 +566,18 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	pgoff_t pgoff;
 	struct address_space *mapping = inode->i_mapping;
 	struct hstate *h = hstate_inode(inode);
+	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
+	down_write(&info->hinode_rwsem);
 	i_size_write(inode, offset);
 	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
 	i_mmap_unlock_write(mapping);
+	up_write(&info->hinode_rwsem);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 	return 0;
 }
@@ -829,6 +836,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_mapping->private_data = resv_map;
 		info->seals = F_SEAL_SEAL;
+		init_rwsem(&info->hinode_rwsem);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bf79a5601091..10322fdcf3d9 100644
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
@@ -414,6 +416,7 @@ struct hugetlbfs_inode_info {
 	struct shared_policy policy;
 	struct inode vfs_inode;
 	unsigned int seals;
+	struct rw_semaphore hinode_rwsem;
 };
 
 static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
@@ -439,6 +442,51 @@ static inline struct hstate *hstate_inode(struct inode *i)
 {
 	return HUGETLBFS_SB(i->i_sb)->hstate;
 }
+
+static inline bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+{
+	unsigned long base = addr & PUD_MASK;
+	unsigned long end = base + PUD_SIZE;
+
+	/* check on proper vm_flags and page table alignment */
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
+		return true;
+	return false;
+}
+
+static inline void hinode_lock_read(struct address_space *mapping,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+	if (!mapping)
+		return;
+	if (vma && !vma_shareable(vma, addr))
+		return;
+
+	down_read(&HUGETLBFS_I(mapping->host)->hinode_rwsem);
+}
+
+static inline void hinode_unlock_read(struct address_space *mapping,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+	if (!mapping)
+		return;
+	if (vma && !vma_shareable(vma, addr))
+		return;
+
+	up_read(&HUGETLBFS_I(mapping->host)->hinode_rwsem);
+}
+
+static inline void hinode_assert_locked(struct address_space *mapping)
+{
+	lockdep_assert_held(&HUGETLBFS_I(mapping->host)->hinode_rwsem);
+}
+
+static inline void hinode_assert_write_locked(struct address_space *mapping)
+{
+	lockdep_assert_held_write(&HUGETLBFS_I(mapping->host)->hinode_rwsem);
+}
 #else /* !CONFIG_HUGETLBFS */
 
 #define is_file_hugepages(file)			false
@@ -913,6 +961,18 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
+
+static inline void hinode_lock_read(struct address_space *mapping,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+}
+
+static inline void hinode_unlock_read(struct address_space *mapping,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9a316b6d0b51..940c037418f8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3728,6 +3728,18 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					vma->vm_start,
 					vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
+	} else {
+		/*
+		 * For shared mappings hinode_rwsem must be held to call
+		 * huge_pte_alloc, otherwise the returned ptep could go
+		 * away if part of a shared pmd and another thread calls
+		 * huge_pmd_unshare.
+		 *
+		 * Note: As an optimization We could check at each PUD_SIZE
+		 * boundary to see if sharing is possible before taking
+		 * hinode_rwsem.
+		 */
+		hinode_lock_read(vma->vm_file->f_mapping, NULL, 0UL);
 	}
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
@@ -3805,6 +3817,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 	if (cow)
 		mmu_notifier_invalidate_range_end(&range);
+	else
+		hinode_unlock_read(vma->vm_file->f_mapping, NULL, 0UL);
 
 	return ret;
 }
@@ -3848,7 +3862,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			continue;
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, &address, ptep)) {
+		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
 			spin_unlock(ptl);
 			/*
 			 * We just unmapped a page of PMDs by clearing a PUD.
@@ -4253,13 +4267,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
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
+			hinode_unlock_read(mapping, vma, address);
+
 			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
+
+			hinode_lock_read(mapping, vma, address);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
@@ -4424,6 +4442,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
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
@@ -4431,20 +4454,32 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
-	} else {
-		ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
-		if (!ptep)
-			return VM_FAULT_OOM;
 	}
 
+	/*
+	 * Acquire hinode_sema before calling huge_pte_alloc and hold
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
+	 *
+	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * is OK, as huge_pte_alloc will return the same value unless
+	 * something has changed.
+	 */
 	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
+	hinode_lock_read(mapping, vma, address);
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
 
@@ -4532,6 +4567,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+	hinode_unlock_read(mapping, vma, address);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -4872,6 +4908,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	struct hugetlbfs_inode_info *hinfo =
+				HUGETLBFS_I(vma->vm_file->f_inode);
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -4886,6 +4924,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	flush_cache_range(vma, range.start, range.end);
 
 	mmu_notifier_invalidate_range_start(&range);
+	down_write(&hinfo->hinode_rwsem);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (; address < end; address += huge_page_size(h)) {
 		spinlock_t *ptl;
@@ -4893,7 +4932,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, &address, ptep)) {
+		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
@@ -4948,6 +4987,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * See Documentation/vm/mmu_notifier.rst
 	 */
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	up_write(&hinfo->hinode_rwsem);
 	mmu_notifier_invalidate_range_end(&range);
 
 	return pages << h->order;
@@ -5166,19 +5206,6 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
-{
-	unsigned long base = addr & PUD_MASK;
-	unsigned long end = base + PUD_SIZE;
-
-	/*
-	 * check on proper vm_flags and page table alignment
-	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
-		return true;
-	return false;
-}
-
 /*
  * Determine if start,end range within vma could be mapped by shared pmd.
  * If yes, adjust start and end to cover range associated with possible
@@ -5212,6 +5239,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
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
@@ -5227,6 +5258,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 
 	if (!vma_shareable(vma, addr))
 		return (pte_t *)pmd_alloc(mm, pud, addr);
+	hinode_assert_locked(mapping);
 
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
@@ -5269,12 +5301,13 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
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
@@ -5284,6 +5317,8 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 	if (page_count(virt_to_page(ptep)) == 1)
 		return 0;
 
+	hinode_assert_write_locked(vma->vm_file->f_mapping);
+
 	pud_clear(pud);
 	put_page(virt_to_page(ptep));
 	mm_dec_nr_pmds(mm);
@@ -5297,7 +5332,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	return NULL;
 }
 
-int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long *addr, pte_t *ptep)
 {
 	return 0;
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0c4f8cbc772e..fd6ee4d941a0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1054,7 +1054,20 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(hpage, ttu);
+	if (PageHuge(hpage) && !PageAnon(hpage) && mapping) {
+		struct hugetlbfs_inode_info *hinode_info =
+			HUGETLBFS_I(mapping->host);
+		/*
+		 * For hugetlb pages, try_to_unmap could potentially call
+		 * huge_pmd_unshare.  Because of this, take hinode_rwsem
+		 * in write mode before calling.
+		 */
+		down_write(&hinode_info->hinode_rwsem);
+		unmap_success = try_to_unmap(hpage, ttu);
+		up_write(&hinode_info->hinode_rwsem);
+	} else {
+		unmap_success = try_to_unmap(hpage, ttu);
+	}
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(hpage));
diff --git a/mm/migrate.c b/mm/migrate.c
index 05c3c2e569df..f068727293c2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1327,9 +1327,24 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
+		struct address_space *mapping = NULL;
+		struct hugetlbfs_inode_info *hinode_info;
+		/*
+		 * try_to_unmap could potentially call huge_pmd_unshare.
+		 * Take hinode_rwsem if sharing is possible.
+		 */
+		if (!PageAnon(hpage)) {
+			mapping = page_mapping(hpage);
+			if (mapping) {
+				hinode_info = HUGETLBFS_I(mapping->host);
+				down_write(&hinode_info->hinode_rwsem);
+			}
+		}
 		try_to_unmap(hpage,
 			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
 		page_was_mapped = 1;
+		if (mapping)
+			up_write(&hinode_info->hinode_rwsem);
 	}
 
 	if (!page_mapped(hpage))
diff --git a/mm/rmap.c b/mm/rmap.c
index 8ef12940e357..9e65c9c95449 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -22,6 +22,7 @@
  *
  * inode->i_mutex	(while writing or truncating, not reading or faulting)
  *   mm->mmap_lock
+ *   hugetlbfs inode->hinode_rwsem (hugetlbfs specific)
  *     page->flags PG_locked (lock_page)
  *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
  *         mapping->i_mmap_rwsem
@@ -1455,7 +1456,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		address = pvmw.address;
 
 		if (PageHuge(page)) {
-			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
+			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
 				/*
 				 * huge_pmd_unshare unmapped an entire PMD
 				 * page.  There is no way of knowing exactly
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ab9e0496d601..3ca789934f6f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -278,10 +278,14 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via hugetlb_fault_mutex
+		 * Serialize via hinode_rwsem hugetlb_fault_mutex.
+		 * hinode_rwsem ensures the dst_pte remains valid even
+		 * in the case of shared pmds.  fault mutex prevents
+		 * races with other faulting threads.
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
+		hinode_lock_read(mapping, dst_vma, dst_addr);
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -289,6 +293,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			hinode_unlock_read(mapping, dst_vma, dst_addr);
 			goto out_unlock;
 		}
 
@@ -296,6 +301,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pteval = huge_ptep_get(dst_pte);
 		if (!huge_pte_none(dst_pteval)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			hinode_unlock_read(mapping, dst_vma, dst_addr);
 			goto out_unlock;
 		}
 
@@ -303,6 +309,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 						dst_addr, src_addr, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		hinode_unlock_read(mapping, dst_vma, dst_addr);
 		vm_alloc_shared = vm_shared;
 
 		cond_resched();
-- 
2.25.4

