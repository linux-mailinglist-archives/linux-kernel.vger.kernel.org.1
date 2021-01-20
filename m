Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E982FD8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392475AbhATTBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:01:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730136AbhATRhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:37:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6C4F221F8;
        Wed, 20 Jan 2021 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611164185;
        bh=7hVoGKHfkQYPCcmWTeMSVBvC5VODyPKgv0dL+I7dBDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LtQGF09RSAVoEM52i4Rr/JQ5aKNlbPGpESd9PLoQt949V1e/n3WC5f1qK0I14PWKs
         87KqjHZO2vx3814rleHrCZCiABXgF17mpVf5t8g3CdEf6umm7x3WWNdicE+b/xp6XW
         zyAO0ObVffkYY1e82zvNbiDBtHQmX1k0x++M/7YsVWIH30ioMRBhWbhCU4k9FNac9X
         2NtDuvr3aU/cNRRWvxFil2Wb3mAKnkGpmQGqFdlgtZuEDen5KJ4WuER9wfJT9vQ6Qk
         AyNZaPKM3j4H0qfYbS1fEWx7IYsNOYtmOgzgFYhpk6YuLZAOMpEj0RH9r2RGLa9Z7Q
         A/eXIkUaFoCvw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com
Subject: [PATCH v4 1/8] mm: Cleanup faultaround and finish_fault() codepaths
Date:   Wed, 20 Jan 2021 17:36:05 +0000
Message-Id: <20210120173612.20913-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120173612.20913-1-will@kernel.org>
References: <20210120173612.20913-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

alloc_set_pte() has two users with different requirements: in the
faultaround code, it called from an atomic context and PTE page table
has to be preallocated. finish_fault() can sleep and allocate page table
as needed.

PTL locking rules are also strange, hard to follow and overkill for
finish_fault().

Let's untangle the mess. alloc_set_pte() has gone now. All locking is
explicit.

The price is some code duplication to handle huge pages in faultaround
path, but it should be fine, having overall improvement in readability.

Link: https://lore.kernel.org/r/20201229132819.najtavneutnf7ajp@box
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[will: s/from from/from/ in comment; spotted by willy]
Signed-off-by: Will Deacon <will@kernel.org>
---
 fs/xfs/xfs_file.c       |   6 +-
 include/linux/mm.h      |  12 ++-
 include/linux/pgtable.h |  11 +++
 mm/filemap.c            | 177 ++++++++++++++++++++++++++---------
 mm/memory.c             | 199 ++++++++++++----------------------------
 5 files changed, 213 insertions(+), 192 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b0f93f73837..111fe73bb8a7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1319,17 +1319,19 @@ xfs_filemap_pfn_mkwrite(
 	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
 }
 
-static void
+static vm_fault_t
 xfs_filemap_map_pages(
 	struct vm_fault		*vmf,
 	pgoff_t			start_pgoff,
 	pgoff_t			end_pgoff)
 {
 	struct inode		*inode = file_inode(vmf->vma->vm_file);
+	vm_fault_t ret;
 
 	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-	filemap_map_pages(vmf, start_pgoff, end_pgoff);
+	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
 	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
+	return ret;
 }
 
 static const struct vm_operations_struct xfs_file_vm_ops = {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..4572a9bc5862 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -542,8 +542,8 @@ struct vm_fault {
 					 * is not NULL, otherwise pmd.
 					 */
 	pgtable_t prealloc_pte;		/* Pre-allocated pte page table.
-					 * vm_ops->map_pages() calls
-					 * alloc_set_pte() from atomic context.
+					 * vm_ops->map_pages() sets up a page
+					 * table from atomic context.
 					 * do_fault_around() pre-allocates
 					 * page table to avoid allocation from
 					 * atomic context.
@@ -578,7 +578,7 @@ struct vm_operations_struct {
 	vm_fault_t (*fault)(struct vm_fault *vmf);
 	vm_fault_t (*huge_fault)(struct vm_fault *vmf,
 			enum page_entry_size pe_size);
-	void (*map_pages)(struct vm_fault *vmf,
+	vm_fault_t (*map_pages)(struct vm_fault *vmf,
 			pgoff_t start_pgoff, pgoff_t end_pgoff);
 	unsigned long (*pagesize)(struct vm_area_struct * area);
 
@@ -988,7 +988,9 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 	return pte;
 }
 
-vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page);
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
+void do_set_pte(struct vm_fault *vmf, struct page *page);
+
 vm_fault_t finish_fault(struct vm_fault *vmf);
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #endif
@@ -2622,7 +2624,7 @@ extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
 extern vm_fault_t filemap_fault(struct vm_fault *vmf);
-extern void filemap_map_pages(struct vm_fault *vmf,
+extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8fcdfa52eb4b..36eb748f3c97 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1314,6 +1314,17 @@ static inline int pmd_trans_unstable(pmd_t *pmd)
 #endif
 }
 
+/*
+ * the ordering of these checks is important for pmds with _page_devmap set.
+ * if we check pmd_trans_unstable() first we will trip the bad_pmd() check
+ * inside of pmd_none_or_trans_huge_or_clear_bad(). this will end up correctly
+ * returning 1 but not before it spams dmesg with the pmd_clear_bad() output.
+ */
+static inline int pmd_devmap_trans_unstable(pmd_t *pmd)
+{
+	return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
+}
+
 #ifndef CONFIG_NUMA_BALANCING
 /*
  * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
diff --git a/mm/filemap.c b/mm/filemap.c
index 5c9d564317a5..c1f2dc89b8a7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -42,6 +42,7 @@
 #include <linux/psi.h>
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
+#include <asm/pgalloc.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -2911,74 +2912,164 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
-void filemap_map_pages(struct vm_fault *vmf,
-		pgoff_t start_pgoff, pgoff_t end_pgoff)
+static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct mm_struct *mm = vmf->vma->vm_mm;
+
+	/* Huge page is mapped? No need to proceed. */
+	if (pmd_trans_huge(*vmf->pmd)) {
+		unlock_page(page);
+		put_page(page);
+		return true;
+	}
+
+	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
+	    vm_fault_t ret = do_set_pmd(vmf, page);
+	    if (!ret) {
+		    /* The page is mapped successfully, reference consumed. */
+		    unlock_page(page);
+		    return true;
+	    }
+	}
+
+	if (pmd_none(*vmf->pmd)) {
+		vmf->ptl = pmd_lock(mm, vmf->pmd);
+		if (likely(pmd_none(*vmf->pmd))) {
+			mm_inc_nr_ptes(mm);
+			pmd_populate(mm, vmf->pmd, vmf->prealloc_pte);
+			vmf->prealloc_pte = NULL;
+		}
+		spin_unlock(vmf->ptl);
+	}
+
+	/* See comment in handle_pte_fault() */
+	if (pmd_devmap_trans_unstable(vmf->pmd)) {
+		unlock_page(page);
+		put_page(page);
+		return true;
+	}
+
+	return false;
+}
+
+static struct page *next_uptodate_page(struct page *page,
+				       struct address_space *mapping,
+				       struct xa_state *xas, pgoff_t end_pgoff)
+{
+	unsigned long max_idx;
+
+	do {
+		if (!page)
+			return NULL;
+		if (xas_retry(xas, page))
+			continue;
+		if (xa_is_value(page))
+			continue;
+		if (PageLocked(page))
+			continue;
+		if (!page_cache_get_speculative(page))
+			continue;
+		/* Has the page moved or been split? */
+		if (unlikely(page != xas_reload(xas)))
+			goto skip;
+		if (!PageUptodate(page) || PageReadahead(page))
+			goto skip;
+		if (PageHWPoison(page))
+			goto skip;
+		if (!trylock_page(page))
+			goto skip;
+		if (page->mapping != mapping)
+			goto unlock;
+		if (!PageUptodate(page))
+			goto unlock;
+		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+		if (xas->xa_index >= max_idx)
+			goto unlock;
+		return page;
+unlock:
+		unlock_page(page);
+skip:
+		put_page(page);
+	} while ((page = xas_next_entry(xas, end_pgoff)) != NULL);
+
+	return NULL;
+}
+
+static inline struct page *first_map_page(struct address_space *mapping,
+					  struct xa_state *xas,
+					  pgoff_t end_pgoff)
+{
+	return next_uptodate_page(xas_find(xas, end_pgoff),
+				  mapping, xas, end_pgoff);
+}
+
+static inline struct page *next_map_page(struct address_space *mapping,
+					 struct xa_state *xas,
+					 pgoff_t end_pgoff)
+{
+	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
+				  mapping, xas, end_pgoff);
+}
+
+vm_fault_t filemap_map_pages(struct vm_fault *vmf,
+			     pgoff_t start_pgoff, pgoff_t end_pgoff)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	pgoff_t last_pgoff = start_pgoff;
-	unsigned long max_idx;
+	unsigned long address = vmf->address;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
+	vm_fault_t ret = 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, head, end_pgoff) {
-		if (xas_retry(&xas, head))
-			continue;
-		if (xa_is_value(head))
-			goto next;
+	head = first_map_page(mapping, &xas, end_pgoff);
+	if (!head)
+		goto out;
 
-		/*
-		 * Check for a locked page first, as a speculative
-		 * reference may adversely influence page migration.
-		 */
-		if (PageLocked(head))
-			goto next;
-		if (!page_cache_get_speculative(head))
-			goto next;
+	if (filemap_map_pmd(vmf, head)) {
+		ret = VM_FAULT_NOPAGE;
+		goto out;
+	}
 
-		/* Has the page moved or been split? */
-		if (unlikely(head != xas_reload(&xas)))
-			goto skip;
+	vmf->address = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address, &vmf->ptl);
+	do {
 		page = find_subpage(head, xas.xa_index);
-
-		if (!PageUptodate(head) ||
-				PageReadahead(page) ||
-				PageHWPoison(page))
-			goto skip;
-		if (!trylock_page(head))
-			goto skip;
-
-		if (head->mapping != mapping || !PageUptodate(head))
-			goto unlock;
-
-		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
-		if (xas.xa_index >= max_idx)
+		if (PageHWPoison(page))
 			goto unlock;
 
 		if (mmap_miss > 0)
 			mmap_miss--;
 
 		vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
-		if (vmf->pte)
-			vmf->pte += xas.xa_index - last_pgoff;
+		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
-		if (alloc_set_pte(vmf, page))
+
+		if (!pte_none(*vmf->pte))
 			goto unlock;
+
+		do_set_pte(vmf, page);
+		/* no need to invalidate: a not-present page won't be cached */
+		update_mmu_cache(vma, vmf->address, vmf->pte);
 		unlock_page(head);
-		goto next;
+
+		/* The fault is handled */
+		if (vmf->address == address)
+			ret = VM_FAULT_NOPAGE;
+		continue;
 unlock:
 		unlock_page(head);
-skip:
 		put_page(head);
-next:
-		/* Huge page is mapped? No need to proceed. */
-		if (pmd_trans_huge(*vmf->pmd))
-			break;
-	}
+	} while ((head = next_map_page(mapping, &xas, end_pgoff)) != NULL);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+out:
 	rcu_read_unlock();
+	vmf->address = address;
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
+	return ret;
 }
 EXPORT_SYMBOL(filemap_map_pages);
 
diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..3e2fc2950ad7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3503,7 +3503,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (pte_alloc(vma->vm_mm, vmf->pmd))
 		return VM_FAULT_OOM;
 
-	/* See the comment in pte_alloc_one_map() */
+	/* See comment in handle_pte_fault() */
 	if (unlikely(pmd_trans_unstable(vmf->pmd)))
 		return 0;
 
@@ -3643,66 +3643,6 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-/*
- * The ordering of these checks is important for pmds with _PAGE_DEVMAP set.
- * If we check pmd_trans_unstable() first we will trip the bad_pmd() check
- * inside of pmd_none_or_trans_huge_or_clear_bad(). This will end up correctly
- * returning 1 but not before it spams dmesg with the pmd_clear_bad() output.
- */
-static int pmd_devmap_trans_unstable(pmd_t *pmd)
-{
-	return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
-}
-
-static vm_fault_t pte_alloc_one_map(struct vm_fault *vmf)
-{
-	struct vm_area_struct *vma = vmf->vma;
-
-	if (!pmd_none(*vmf->pmd))
-		goto map_pte;
-	if (vmf->prealloc_pte) {
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_none(*vmf->pmd))) {
-			spin_unlock(vmf->ptl);
-			goto map_pte;
-		}
-
-		mm_inc_nr_ptes(vma->vm_mm);
-		pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
-		spin_unlock(vmf->ptl);
-		vmf->prealloc_pte = NULL;
-	} else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
-		return VM_FAULT_OOM;
-	}
-map_pte:
-	/*
-	 * If a huge pmd materialized under us just retry later.  Use
-	 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead of
-	 * pmd_trans_huge() to ensure the pmd didn't become pmd_trans_huge
-	 * under us and then back to pmd_none, as a result of MADV_DONTNEED
-	 * running immediately after a huge pmd fault in a different thread of
-	 * this mm, in turn leading to a misleading pmd_trans_huge() retval.
-	 * All we have to ensure is that it is a regular pmd that we can walk
-	 * with pte_offset_map() and we can do that through an atomic read in
-	 * C, which is what pmd_trans_unstable() provides.
-	 */
-	if (pmd_devmap_trans_unstable(vmf->pmd))
-		return VM_FAULT_NOPAGE;
-
-	/*
-	 * At this point we know that our vmf->pmd points to a page of ptes
-	 * and it cannot become pmd_none(), pmd_devmap() or pmd_trans_huge()
-	 * for the duration of the fault.  If a racing MADV_DONTNEED runs and
-	 * we zap the ptes pointed to by our vmf->pmd, the vmf->ptl will still
-	 * be valid and we will re-check to make sure the vmf->pte isn't
-	 * pte_none() under vmf->ptl protection when we return to
-	 * alloc_set_pte().
-	 */
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
-	return 0;
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void deposit_prealloc_pte(struct vm_fault *vmf)
 {
@@ -3717,7 +3657,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 	vmf->prealloc_pte = NULL;
 }
 
-static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
@@ -3775,52 +3715,17 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	return ret;
 }
 #else
-static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
-	BUILD_BUG();
-	return 0;
+	return VM_FAULT_FALLBACK;
 }
 #endif
 
-/**
- * alloc_set_pte - setup new PTE entry for given page and add reverse page
- * mapping. If needed, the function allocates page table or use pre-allocated.
- *
- * @vmf: fault environment
- * @page: page to map
- *
- * Caller must take care of unlocking vmf->ptl, if vmf->pte is non-NULL on
- * return.
- *
- * Target users are page handler itself and implementations of
- * vm_ops->map_pages.
- *
- * Return: %0 on success, %VM_FAULT_ code in case of error.
- */
-vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
+void do_set_pte(struct vm_fault *vmf, struct page *page)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	pte_t entry;
-	vm_fault_t ret;
-
-	if (pmd_none(*vmf->pmd) && PageTransCompound(page)) {
-		ret = do_set_pmd(vmf, page);
-		if (ret != VM_FAULT_FALLBACK)
-			return ret;
-	}
-
-	if (!vmf->pte) {
-		ret = pte_alloc_one_map(vmf);
-		if (ret)
-			return ret;
-	}
-
-	/* Re-check under ptl */
-	if (unlikely(!pte_none(*vmf->pte))) {
-		update_mmu_tlb(vma, vmf->address, vmf->pte);
-		return VM_FAULT_NOPAGE;
-	}
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
@@ -3837,14 +3742,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
 		page_add_file_rmap(page, false);
 	}
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
-
-	/* no need to invalidate: a not-present page won't be cached */
-	update_mmu_cache(vma, vmf->address, vmf->pte);
-
-	return 0;
 }
 
-
 /**
  * finish_fault - finish page fault once we have prepared the page to fault
  *
@@ -3862,12 +3761,12 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
  */
 vm_fault_t finish_fault(struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
-	vm_fault_t ret = 0;
+	vm_fault_t ret;
 
 	/* Did we COW the page? */
-	if ((vmf->flags & FAULT_FLAG_WRITE) &&
-	    !(vmf->vma->vm_flags & VM_SHARED))
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
 		page = vmf->cow_page;
 	else
 		page = vmf->page;
@@ -3876,12 +3775,38 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	 * check even for read faults because we might have lost our CoWed
 	 * page
 	 */
-	if (!(vmf->vma->vm_flags & VM_SHARED))
-		ret = check_stable_address_space(vmf->vma->vm_mm);
-	if (!ret)
-		ret = alloc_set_pte(vmf, page);
-	if (vmf->pte)
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (!(vma->vm_flags & VM_SHARED)) {
+		ret = check_stable_address_space(vma->vm_mm);
+		if (ret)
+			return ret;
+	}
+
+	if (pmd_none(*vmf->pmd)) {
+		if (PageTransCompound(page)) {
+			ret = do_set_pmd(vmf, page);
+			if (ret != VM_FAULT_FALLBACK)
+				return ret;
+		}
+
+		if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
+			return VM_FAULT_OOM;
+	}
+
+	/* See comment in handle_pte_fault() */
+	if (pmd_devmap_trans_unstable(vmf->pmd))
+		return 0;
+
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				      vmf->address, &vmf->ptl);
+	ret = 0;
+	/* Re-check under ptl */
+	if (likely(pte_none(*vmf->pte)))
+		do_set_pte(vmf, page);
+	else
+		ret = VM_FAULT_NOPAGE;
+
+	update_mmu_tlb(vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 }
 
@@ -3951,13 +3876,12 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	pgoff_t start_pgoff = vmf->pgoff;
 	pgoff_t end_pgoff;
 	int off;
-	vm_fault_t ret = 0;
 
 	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
 	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
 
-	vmf->address = max(address & mask, vmf->vma->vm_start);
-	off = ((address - vmf->address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
+	address = max(address & mask, vmf->vma->vm_start);
+	off = ((vmf->address - address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
 	start_pgoff -= off;
 
 	/*
@@ -3965,7 +3889,7 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	 *  the vma or nr_pages from start_pgoff, depending what is nearest.
 	 */
 	end_pgoff = start_pgoff -
-		((vmf->address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)) +
+		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)) +
 		PTRS_PER_PTE - 1;
 	end_pgoff = min3(end_pgoff, vma_pages(vmf->vma) + vmf->vma->vm_pgoff - 1,
 			start_pgoff + nr_pages - 1);
@@ -3973,31 +3897,11 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	if (pmd_none(*vmf->pmd)) {
 		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
 		if (!vmf->prealloc_pte)
-			goto out;
+			return VM_FAULT_OOM;
 		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
-	vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
-
-	/* Huge page is mapped? Page fault is solved */
-	if (pmd_trans_huge(*vmf->pmd)) {
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
-	/* ->map_pages() haven't done anything useful. Cold page cache? */
-	if (!vmf->pte)
-		goto out;
-
-	/* check if the page fault is solved */
-	vmf->pte -= (vmf->address >> PAGE_SHIFT) - (address >> PAGE_SHIFT);
-	if (!pte_none(*vmf->pte))
-		ret = VM_FAULT_NOPAGE;
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
-out:
-	vmf->address = address;
-	vmf->pte = NULL;
-	return ret;
+	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
 }
 
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
@@ -4353,7 +4257,18 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 */
 		vmf->pte = NULL;
 	} else {
-		/* See comment in pte_alloc_one_map() */
+		/*
+		 * If a huge pmd materialized under us just retry later.  Use
+		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
+		 * of pmd_trans_huge() to ensure the pmd didn't become
+		 * pmd_trans_huge under us and then back to pmd_none, as a
+		 * result of MADV_DONTNEED running immediately after a huge pmd
+		 * fault in a different thread of this mm, in turn leading to a
+		 * misleading pmd_trans_huge() retval. All we have to ensure is
+		 * that it is a regular pmd that we can walk with
+		 * pte_offset_map() and we can do that through an atomic read
+		 * in C, which is what pmd_trans_unstable() provides.
+		 */
 		if (pmd_devmap_trans_unstable(vmf->pmd))
 			return 0;
 		/*
-- 
2.30.0.284.gd98b1dd5eaa7-goog

