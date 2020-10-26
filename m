Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90A299A84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406431AbgJZXcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:32:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53228 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406383AbgJZXce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:32:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNOXtI164630;
        Mon, 26 Oct 2020 23:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=U1OygKUfzTUuRhvJDIovMFDGg9UvTWMzc5vmJoO2XFE=;
 b=dqSr5EI3UkmWNBK6aax3TP5Gs3NsBzy/7q5ErGrsrCwaYbjnuFiYSR5v0khFVDcnsOv9
 vLmZFyTM4QrxmKCbhAY76BRrjNRyov0MqpzpaLFTZ/o15UQnN349ixhJZyYth79a+/6b
 ZPOaqkl39lvnNKBC8fCX84DRb7rbGT4yIZQW/mq4UniBK2f5fAzXEHvK9WQ5MZ+bVML+
 mRraayBwBQzaWregAyZVrfyS/onAOCaIHVZonDXBCaIF916LlKyx6QO6NzDURxuW6VAT
 CeVt0ht3Isf6FO+bYutf1s3yQ2T9uD1JedVQZTvhWbS/4f9+1lC29C4dk5IKKKjwbKD1 Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34dgm3vuf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 23:32:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNQHii032642;
        Mon, 26 Oct 2020 23:32:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34cx1q29yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 23:32:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09QNWEb2004684;
        Mon, 26 Oct 2020 23:32:14 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:32:05 -0700
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
Subject: [RFC PATCH v2 1/4] hugetlbfs: revert use of i_mmap_rwsem for pmd sharing and more sync
Date:   Mon, 26 Oct 2020 16:31:47 -0700
Message-Id: <20201026233150.371577-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201026233150.371577-1-mike.kravetz@oracle.com>
References: <20201026233150.371577-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i_mmap_rwsem is being used for synchronization of huge pmd sharing.
This required changing the locking order such that i_mmap_rwsem needed
to be taken before a page lock.  This can be accommodated in hugetlbfs
specific code, but becomes problematic in the areas of page migration
and memory failure where it is hard to get around the normal locking
order.

In subsequent patches, a new rw semaphore will be added to the hugetlbfs
inode for this type of synchronization.  This patch will revert use of
i_mmap_rwsem for pmd sharing and fault/truncate synchronization.

The following commits are reverted:
commit 0bf7b64e6e51 ("hugetlb: add lockdep check for i_mmap_rwsem held in
			huge_pmd_share")
commit 34ae204f1851 ("hugetlbfs: remove call to huge_pte_alloc without
			i_mmap_rwsem")
commit 1139d336fff4 ("mm/hugetlb.c: fix pages per hugetlb calculation")
commit 87bf91d39bb5 ("hugetlbfs: Use i_mmap_rwsem to address page
			fault/truncate race")
commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
			synchronization")

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  30 ++----
 include/linux/fs.h      |  15 ---
 include/linux/hugetlb.h |  16 +---
 mm/hugetlb.c            | 197 ++++++----------------------------------
 mm/memory-failure.c     |  29 +-----
 mm/migrate.c            |  25 +----
 mm/rmap.c               |  18 +---
 mm/userfaultfd.c        |  11 +--
 8 files changed, 49 insertions(+), 292 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b5c109703daa..3a1246aeedc4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -444,9 +444,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserv
  *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() holds i_mmap_rwsem and prevents
- *	page faults in the truncated range by checking i_size.  i_size is
- *	modified while holding i_mmap_rwsem.
+ *	in this routine.  hugetlb_no_page() prevents page faults in the
+ *	truncated range.  It checks i_size before allocation, and again after
+ *	with the page table lock for the page held.  The same lock must be
+ *	acquired to unmap a page.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserv map
@@ -486,15 +487,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			index = page->index;
 			hash = hugetlb_fault_mutex_hash(mapping, index);
-			if (!truncate_op) {
-				/*
-				 * Only need to hold the fault mutex in the
-				 * hole punch case.  This prevents races with
-				 * page faults.  Races are not possible in the
-				 * case of truncation.
-				 */
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
-			}
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 			/*
 			 * If page is mapped, it was faulted in after being
@@ -508,9 +501,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			if (unlikely(page_mapped(page))) {
 				BUG_ON(truncate_op);
 
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h));
@@ -537,8 +528,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			unlock_page(page);
-			if (!truncate_op)
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
@@ -576,8 +566,8 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
+	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
 	i_mmap_unlock_write(mapping);
@@ -699,11 +689,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
-		/*
-		 * fault mutex taken here, protects against fault path
-		 * and hole punch.  inode_lock previously taken protects
-		 * against truncation.
-		 */
+		/* mutex taken here, fault path and hole punch */
 		hash = hugetlb_fault_mutex_hash(mapping, index);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21cc971fd960..8123f281c275 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -493,11 +493,6 @@ static inline void i_mmap_lock_write(struct address_space *mapping)
 	down_write(&mapping->i_mmap_rwsem);
 }
 
-static inline int i_mmap_trylock_write(struct address_space *mapping)
-{
-	return down_write_trylock(&mapping->i_mmap_rwsem);
-}
-
 static inline void i_mmap_unlock_write(struct address_space *mapping)
 {
 	up_write(&mapping->i_mmap_rwsem);
@@ -513,16 +508,6 @@ static inline void i_mmap_unlock_read(struct address_space *mapping)
 	up_read(&mapping->i_mmap_rwsem);
 }
 
-static inline void i_mmap_assert_locked(struct address_space *mapping)
-{
-	lockdep_assert_held(&mapping->i_mmap_rwsem);
-}
-
-static inline void i_mmap_assert_write_locked(struct address_space *mapping)
-{
-	lockdep_assert_held_write(&mapping->i_mmap_rwsem);
-}
-
 /*
  * Might pages of this file be mapped into userspace?
  */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..bf79a5601091 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -154,8 +154,6 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
 
-struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
-
 extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages;
 
@@ -165,8 +163,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
-int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-				unsigned long *addr, pte_t *ptep);
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
@@ -199,15 +196,8 @@ static inline unsigned long hugetlb_total_pages(void)
 	return 0;
 }
 
-static inline struct address_space *hugetlb_page_mapping_lock_write(
-							struct page *hpage)
-{
-	return NULL;
-}
-
-static inline int huge_pmd_unshare(struct mm_struct *mm,
-					struct vm_area_struct *vma,
-					unsigned long *addr, pte_t *ptep)
+static inline int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr,
+					pte_t *ptep)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fe76f8fd5a73..9a316b6d0b51 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1568,106 +1568,6 @@ int PageHeadHuge(struct page *page_head)
 	return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
 }
 
-/*
- * Find address_space associated with hugetlbfs page.
- * Upon entry page is locked and page 'was' mapped although mapped state
- * could change.  If necessary, use anon_vma to find vma and associated
- * address space.  The returned mapping may be stale, but it can not be
- * invalid as page lock (which is held) is required to destroy mapping.
- */
-static struct address_space *_get_hugetlb_page_mapping(struct page *hpage)
-{
-	struct anon_vma *anon_vma;
-	pgoff_t pgoff_start, pgoff_end;
-	struct anon_vma_chain *avc;
-	struct address_space *mapping = page_mapping(hpage);
-
-	/* Simple file based mapping */
-	if (mapping)
-		return mapping;
-
-	/*
-	 * Even anonymous hugetlbfs mappings are associated with an
-	 * underlying hugetlbfs file (see hugetlb_file_setup in mmap
-	 * code).  Find a vma associated with the anonymous vma, and
-	 * use the file pointer to get address_space.
-	 */
-	anon_vma = page_lock_anon_vma_read(hpage);
-	if (!anon_vma)
-		return mapping;  /* NULL */
-
-	/* Use first found vma */
-	pgoff_start = page_to_pgoff(hpage);
-	pgoff_end = pgoff_start + pages_per_huge_page(page_hstate(hpage)) - 1;
-	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
-					pgoff_start, pgoff_end) {
-		struct vm_area_struct *vma = avc->vma;
-
-		mapping = vma->vm_file->f_mapping;
-		break;
-	}
-
-	anon_vma_unlock_read(anon_vma);
-	return mapping;
-}
-
-/*
- * Find and lock address space (mapping) in write mode.
- *
- * Upon entry, the page is locked which allows us to find the mapping
- * even in the case of an anon page.  However, locking order dictates
- * the i_mmap_rwsem be acquired BEFORE the page lock.  This is hugetlbfs
- * specific.  So, we first try to lock the sema while still holding the
- * page lock.  If this works, great!  If not, then we need to drop the
- * page lock and then acquire i_mmap_rwsem and reacquire page lock.  Of
- * course, need to revalidate state along the way.
- */
-struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
-{
-	struct address_space *mapping, *mapping2;
-
-	mapping = _get_hugetlb_page_mapping(hpage);
-retry:
-	if (!mapping)
-		return mapping;
-
-	/*
-	 * If no contention, take lock and return
-	 */
-	if (i_mmap_trylock_write(mapping))
-		return mapping;
-
-	/*
-	 * Must drop page lock and wait on mapping sema.
-	 * Note:  Once page lock is dropped, mapping could become invalid.
-	 * As a hack, increase map count until we lock page again.
-	 */
-	atomic_inc(&hpage->_mapcount);
-	unlock_page(hpage);
-	i_mmap_lock_write(mapping);
-	lock_page(hpage);
-	atomic_add_negative(-1, &hpage->_mapcount);
-
-	/* verify page is still mapped */
-	if (!page_mapped(hpage)) {
-		i_mmap_unlock_write(mapping);
-		return NULL;
-	}
-
-	/*
-	 * Get address space again and verify it is the same one
-	 * we locked.  If not, drop lock and retry.
-	 */
-	mapping2 = _get_hugetlb_page_mapping(hpage);
-	if (mapping2 != mapping) {
-		i_mmap_unlock_write(mapping);
-		mapping = mapping2;
-		goto retry;
-	}
-
-	return mapping;
-}
-
 pgoff_t __basepage_index(struct page *page)
 {
 	struct page *page_head = compound_head(page);
@@ -3818,7 +3718,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	int cow;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	struct address_space *mapping = vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
 
@@ -3829,14 +3728,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					vma->vm_start,
 					vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
-	} else {
-		/*
-		 * For shared mappings i_mmap_rwsem must be held to call
-		 * huge_pte_alloc, otherwise the returned ptep could go
-		 * away if part of a shared pmd and another thread calls
-		 * huge_pmd_unshare.
-		 */
-		i_mmap_lock_read(mapping);
 	}
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
@@ -3914,8 +3805,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 	if (cow)
 		mmu_notifier_invalidate_range_end(&range);
-	else
-		i_mmap_unlock_read(mapping);
 
 	return ret;
 }
@@ -3959,7 +3848,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			continue;
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+		if (huge_pmd_unshare(mm, &address, ptep)) {
 			spin_unlock(ptl);
 			/*
 			 * We just unmapped a page of PMDs by clearing a PUD.
@@ -4335,17 +4224,16 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	/*
-	 * We can not race with truncation due to holding i_mmap_rwsem.
-	 * i_size is modified when holding i_mmap_rwsem, so check here
-	 * once for faults beyond end of file.
+	 * Use page lock to guard against racing truncation
+	 * before we get page_table_lock.
 	 */
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto out;
-
 retry:
 	page = find_lock_page(mapping, idx);
 	if (!page) {
+		size = i_size_read(mapping->host) >> huge_page_shift(h);
+		if (idx >= size)
+			goto out;
+
 		/*
 		 * Check for page in userfault range
 		 */
@@ -4365,15 +4253,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			};
 
 			/*
-			 * hugetlb_fault_mutex and i_mmap_rwsem must be
-			 * dropped before handling userfault.  Reacquire
-			 * after handling fault to make calling code simpler.
+			 * hugetlb_fault_mutex must be dropped before
+			 * handling userfault.  Reacquire after handling
+			 * fault to make calling code simpler.
 			 */
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
-			i_mmap_lock_read(mapping);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
@@ -4451,6 +4337,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto backout;
+
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
 		goto backout;
@@ -4534,11 +4424,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
-		/*
-		 * Since we hold no locks, ptep could be stale.  That is
-		 * OK as we are only making decisions based on content and
-		 * not actually modifying content here.
-		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
@@ -4546,33 +4431,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
+	} else {
+		ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
+		if (!ptep)
+			return VM_FAULT_OOM;
 	}
 
-	/*
-	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This serves two purposes:
-	 * 1) It prevents huge_pmd_unshare from being called elsewhere
-	 *    and making the ptep no longer valid.
-	 * 2) It synchronizes us with i_size modifications during truncation.
-	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
-	 * is OK, as huge_pte_alloc will return the same value unless
-	 * something has changed.
-	 */
 	mapping = vma->vm_file->f_mapping;
-	i_mmap_lock_read(mapping);
-	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
-	if (!ptep) {
-		i_mmap_unlock_read(mapping);
-		return VM_FAULT_OOM;
-	}
+	idx = vma_hugecache_offset(h, vma, haddr);
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
-	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -4660,7 +4532,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -5022,7 +4893,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+		if (huge_pmd_unshare(mm, &address, ptep)) {
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
@@ -5337,18 +5208,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
  * !shared pmd case because we can allocate the pmd later as well, it makes the
- * code much cleaner.
- *
- * This routine must be called with i_mmap_rwsem held in at least read mode if
- * sharing is possible.  For hugetlbfs, this prevents removal of any page
- * table entries associated with the address space.  This is important as we
- * are setting up sharing based on existing page table entries (mappings).
- *
- * NOTE: This routine is only called from huge_pte_alloc.  Some callers of
- * huge_pte_alloc know that sharing is not possible and do not take
- * i_mmap_rwsem as a performance optimization.  This is handled by the
- * if !vma_shareable check at the beginning of the routine. i_mmap_rwsem is
- * only required for subsequent processing.
+ * code much cleaner. pmd allocation is essential for the shared case because
+ * pud has to be populated inside the same i_mmap_rwsem section - otherwise
+ * racing tasks could either miss the sharing (see huge_pte_offset) or select a
+ * bad pmd for sharing.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
@@ -5365,7 +5228,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	if (!vma_shareable(vma, addr))
 		return (pte_t *)pmd_alloc(mm, pud, addr);
 
-	i_mmap_assert_locked(mapping);
+	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -5395,6 +5258,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_read(mapping);
 	return pte;
 }
 
@@ -5405,19 +5269,17 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
  */
-int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-					unsigned long *addr, pte_t *ptep)
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 {
 	pgd_t *pgd = pgd_offset(mm, *addr);
 	p4d_t *p4d = p4d_offset(pgd, *addr);
 	pud_t *pud = pud_offset(p4d, *addr);
 
-	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	BUG_ON(page_count(virt_to_page(ptep)) == 0);
 	if (page_count(virt_to_page(ptep)) == 1)
 		return 0;
@@ -5435,8 +5297,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	return NULL;
 }
 
-int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-				unsigned long *addr, pte_t *ptep)
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 {
 	return 0;
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c0bb186bba62..0c4f8cbc772e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -992,7 +992,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
-	bool unmap_success = true;
+	bool unmap_success;
 	int kill = 1, forcekill;
 	struct page *hpage = *hpagep;
 	bool mlocked = PageMlocked(hpage);
@@ -1054,32 +1054,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	if (!PageHuge(hpage)) {
-		unmap_success = try_to_unmap(hpage, ttu);
-	} else {
-		/*
-		 * For hugetlb pages, try_to_unmap could potentially call
-		 * huge_pmd_unshare.  Because of this, take semaphore in
-		 * write mode here and set TTU_RMAP_LOCKED to indicate we
-		 * have taken the lock at this higer level.
-		 *
-		 * Note that the call to hugetlb_page_mapping_lock_write
-		 * is necessary even if mapping is already set.  It handles
-		 * ugliness of potentially having to drop page lock to obtain
-		 * i_mmap_rwsem.
-		 */
-		mapping = hugetlb_page_mapping_lock_write(hpage);
-
-		if (mapping) {
-			unmap_success = try_to_unmap(hpage,
-						     ttu|TTU_RMAP_LOCKED);
-			i_mmap_unlock_write(mapping);
-		} else {
-			pr_info("Memory failure: %#lx: could not find mapping for mapped huge page\n",
-				pfn);
-			unmap_success = false;
-		}
-	}
+	unmap_success = try_to_unmap(hpage, ttu);
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(hpage));
diff --git a/mm/migrate.c b/mm/migrate.c
index 5ca5842df5db..05c3c2e569df 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1280,7 +1280,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	int page_was_mapped = 0;
 	struct page *new_hpage;
 	struct anon_vma *anon_vma = NULL;
-	struct address_space *mapping = NULL;
 
 	/*
 	 * Migratability of hugepages depends on architectures and their size.
@@ -1328,36 +1327,18 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
-		/*
-		 * try_to_unmap could potentially call huge_pmd_unshare.
-		 * Because of this, take semaphore in write mode here and
-		 * set TTU_RMAP_LOCKED to let lower levels know we have
-		 * taken the lock.
-		 */
-		mapping = hugetlb_page_mapping_lock_write(hpage);
-		if (unlikely(!mapping))
-			goto unlock_put_anon;
-
 		try_to_unmap(hpage,
-			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS|
-			TTU_RMAP_LOCKED);
+			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
 		page_was_mapped = 1;
-		/*
-		 * Leave mapping locked until after subsequent call to
-		 * remove_migration_ptes()
-		 */
 	}
 
 	if (!page_mapped(hpage))
 		rc = move_to_new_page(new_hpage, hpage, mode);
 
-	if (page_was_mapped) {
+	if (page_was_mapped)
 		remove_migration_ptes(hpage,
-			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, true);
-		i_mmap_unlock_write(mapping);
-	}
+			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
 
-unlock_put_anon:
 	unlock_page(new_hpage);
 
 put_anon:
diff --git a/mm/rmap.c b/mm/rmap.c
index 1b84945d655c..8ef12940e357 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -22,7 +22,7 @@
  *
  * inode->i_mutex	(while writing or truncating, not reading or faulting)
  *   mm->mmap_lock
- *     page->flags PG_locked (lock_page)   * (see huegtlbfs below)
+ *     page->flags PG_locked (lock_page)
  *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
  *         mapping->i_mmap_rwsem
  *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
@@ -44,11 +44,6 @@
  * anon_vma->rwsem,mapping->i_mutex      (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
  *     pte map lock
- *
- * * hugetlbfs PageHuge() pages take locks in this order:
- *         mapping->i_mmap_rwsem
- *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
- *             page->flags PG_locked (lock_page)
  */
 
 #include <linux/mm.h>
@@ -1413,9 +1408,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		/*
 		 * If sharing is possible, start and end will be adjusted
 		 * accordingly.
-		 *
-		 * If called for a huge page, caller must hold i_mmap_rwsem
-		 * in write mode as it is possible to call huge_pmd_unshare.
 		 */
 		adjust_range_if_pmd_sharing_possible(vma, &range.start,
 						     &range.end);
@@ -1463,13 +1455,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		address = pvmw.address;
 
 		if (PageHuge(page)) {
-			/*
-			 * To call huge_pmd_unshare, i_mmap_rwsem must be
-			 * held in write mode.  Caller needs to explicitly
-			 * do this outside rmap routines.
-			 */
-			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
-			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
 				/*
 				 * huge_pmd_unshare unmapped an entire PMD
 				 * page.  There is no way of knowing exactly
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9a3d451402d7..ab9e0496d601 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -278,14 +278,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
-		 * i_mmap_rwsem ensures the dst_pte remains valid even
-		 * in the case of shared pmds.  fault mutex prevents
-		 * races with other faulting threads.
+		 * Serialize via hugetlb_fault_mutex
 		 */
-		mapping = dst_vma->vm_file->f_mapping;
-		i_mmap_lock_read(mapping);
 		idx = linear_page_index(dst_vma, dst_addr);
+		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -293,7 +289,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -301,7 +296,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pteval = huge_ptep_get(dst_pte);
 		if (!huge_pte_none(dst_pteval)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -309,7 +303,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 						dst_addr, src_addr, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 		vm_alloc_shared = vm_shared;
 
 		cond_resched();
-- 
2.25.4

