Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777B62EE68E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbhAGUFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbhAGUFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610049857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KFSjyvM+6BgG+NEGG//AxaoKw0CEQS11//I25/s2sk=;
        b=bI3Yk8A9A5fMRIjd/0Gp77G9wp4395uT8jNUCPV/GAiqQWPMb2wHqIBEfZLmQkoAB+rCJ+
        kiyuFaOz6Vq6g4b0yfpCl/2pC4OSvnAYyi/eVE2fnrr2E3449hKElkGOlT3q4uR/VED0wq
        vr1h0M+P6kBIe+o/NRsKNpSzeu8Fw6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-2grhLNAiPKWLcZF6CN9ZFA-1; Thu, 07 Jan 2021 15:04:13 -0500
X-MC-Unique: 2grhLNAiPKWLcZF6CN9ZFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49ABF612B1;
        Thu,  7 Jan 2021 20:04:10 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47B146268E;
        Thu,  7 Jan 2021 20:04:03 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
Date:   Thu,  7 Jan 2021 15:04:02 -0500
Message-Id: <20210107200402.31095-3-aarcange@redhat.com>
In-Reply-To: <20210107200402.31095-1-aarcange@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: the "Fixes" tag used here is to optimize the backporting, but
09854ba94c6aad7886996bfbee2530b3d8a7f4f4 is completely
correct. Despite being correct it happened to uncover some implicit
assumption some other code made on a very specific behavior in
do_wp_page that had to be altered by such commit.

The page_mapcount is always guaranteed == 1 for an exclusive anon
page, so when it was used to decide if an exclusive page under
wrprotection could be reused (as in wp_page_reuse), the outcome would
always come true.

The page_mapcount had to be replaced with the page_count because it
couldn't account for GUP pins, so after that change, for the first
time, wp_page_copy can now be called also for exclusive anon pages
that are underway wrprotection.

Even then everything is still fine for all cases that wrprotect with
the mmap_write_lock since the COW faults cannot run concurrently in
such case.

However there are two cases that could wrprotecting exclusive anon
pages with only the mmap_read_lock: soft dirty clear_refs_write and
UFFDIO_WRITEPROTECT. Both of them would benefit from keeping their
wrprotection runtime scalable and to keep using the mmap_read_lock
without having to switch to the mmap_write_lock.

To stick to the mmap_read_lock, for both UFFDIO_WRITEPROTECT and
clear_refs_write we need to handle the new reality that there can be
COWs (as in wp_page_copy) happening on exclusive anon pages that are
under wrprotection, but with the respective TLB flush still deferred.

An example of the problematic UFFDIO_USERFAULTFD runtime is shown
below.

 CPU0			CPU 1		CPU 2
 ------			--------	-------
 userfaultfd_wrprotect(mode_wp = true)
 PT lock
 atomic set _PAGE_UFFD_WP and clear _PAGE_WRITE
 PT unlock

			do_page_fault FAULT_FLAG_WRITE
					userfaultfd_wrprotect(mode_wp = false)
					PT lock
					ATOMIC clear _PAGE_UFFD_WP <- problem
					/* _PAGE_WRITE not set */
					PT unlock
					XXXXXXXXXXXXXX BUG RACE window open here

			PT lock
			FAULT_FLAG_WRITE is set by CPU
			_PAGE_WRITE is still clear in pte
			PT unlock

			wp_page_copy
			cow_user_page runs with stale TLB

 deferred tlb flush <- too late
 XXXXXXXXXXXXXX BUG RACE window close here

userfaultfd_wrprotect(mode_wp = true) is never a problem because as
long as the uffd-wp flag is set in the pte/hugepmd the page fault is
guaranteed to reach a dead end in handle_userfault(). The window for
uffd-wp not to be set while the pte has been wrprotected but the TLB
flush is still pending, is opened when userfaultfd_wrprotect(mode_wp =
false) releases the PT-lock as shown above and it closes when the
first deferred TLB flush runs. If do_wp_page->wp_copy_page runs within
such window, some userland writes can get lost in the copy and they
can end up in the original page that gets discarded.

The softy dirty runtime is similar and it would be like below:

 CPU0			CPU 1			CPU 2
 ------			--------		-------
						instantiate writable TLB
 clear_refs_write
 PT lock
 pte_wrprotect
 PT unlock
			do_page_fault FAULT_FLAG_WRITE
			PT lock
			FAULT_FLAG_WRITE is set by CPU
			_PAGE_WRITE is still clear in pte
			PT unlock

			wp_page_copy
			cow_user_page...
						writes through the TLB
			...cow_user_page

So to handle this race a wrprotect_tlb_flush_pending atomic counter is
added to the vma.

This counter needs to be elevated while holding the mmap_read_lock
before taking the PT lock to wrprotect the pagetable and it can only
be decreased after the deferred TLB flush is complete.

This way the page fault can trivially serialize against pending TLB
flushes using a new helper: sync_wrprotect_tlb_flush_pending().

Testing with the userfaultfd selftest is showing 100% reproducible mm
corruption with writes getting lost, before this commit.

$ ./userfaultfd anon 100 100
nr_pages: 25600, nr_pages_per_cpu: 3200
bounces: 99, mode: rnd racing read, userfaults: 773 missing (215+205+58+114+72+85+18+6), 9011 wp (1714+1714+886+1227+1009+1278+646+537)
[..]
bounces: 72, mode: poll, userfaults: 720 missing (187+148+102+49+92+103+24+15), 9885 wp (1452+1175+1104+1667+1101+1365+913+1108)
bounces: 71, mode: rnd racing ver read, page_nr 25241 memory corruption 6 7

After the commit the userland memory corruption is gone as expected.

Cc: stable@kernel.org
Reported-by: Nadav Amit <namit@vmware.com>
Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 fs/proc/task_mmu.c       | 17 +++++++++-
 include/linux/mm.h       | 46 +++++++++++++++++++++++++++
 include/linux/mm_types.h |  5 +++
 kernel/fork.c            |  1 +
 mm/memory.c              | 69 ++++++++++++++++++++++++++++++++++++++++
 mm/mprotect.c            |  4 +++
 6 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index a127262ba517..e75cb135db02 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1235,8 +1235,20 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		}
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
-				if (!(vma->vm_flags & VM_SOFTDIRTY))
+				struct vm_area_struct *tmp;
+				if (!(vma->vm_flags & VM_SOFTDIRTY)) {
+					inc_wrprotect_tlb_flush_pending(vma);
 					continue;
+				}
+
+				/*
+				 * Rollback wrprotect_tlb_flush_pending before
+				 * releasing the mmap_lock.
+				 */
+				for (vma = mm->mmap; vma != tmp;
+				     vma = vma->vm_next)
+					dec_wrprotect_tlb_flush_pending(vma);
+
 				mmap_read_unlock(mm);
 				if (mmap_write_lock_killable(mm)) {
 					count = -EINTR;
@@ -1245,6 +1257,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				for (vma = mm->mmap; vma; vma = vma->vm_next) {
 					vma->vm_flags &= ~VM_SOFTDIRTY;
 					vma_set_page_prot(vma);
+					inc_wrprotect_tlb_flush_pending(vma);
 				}
 				mmap_write_downgrade(mm);
 				break;
@@ -1260,6 +1273,8 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
+			for (vma = mm->mmap; vma; vma = vma->vm_next)
+				dec_wrprotect_tlb_flush_pending(vma);
 			dec_tlb_flush_pending(mm);
 		}
 		mmap_read_unlock(mm);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..caa1d9a71cb2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3177,5 +3177,51 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
+/*
+ * NOTE: the mmap_lock must be hold and it cannot be released at any
+ * time in between inc_wrprotect_tlb_flush_pending() and
+ * dec_wrprotect_tlb_flush_pending().
+ *
+ * This counter has to be elevated before taking the PT-lock to
+ * wrprotect pagetables, if the TLB isn't flushed before the
+ * PT-unlock.
+ *
+ * The only reader is the page fault so this has to be elevated (in
+ * addition of the mm->tlb_flush_pending) only when the mmap_read_lock
+ * is taken instead of the mmap_write_lock (otherwise the page fault
+ * couldn't run concurrently in the first place).
+ *
+ * This doesn't need to be elevated when clearing pagetables even if
+ * only holding the mmap_read_lock (as in MADV_DONTNEED). The page
+ * fault doesn't risk to access the data of the page that is still
+ * under tlb-gather deferred flushing, if the pagetable is none,
+ * because the pagetable doesn't point to it anymore.
+ *
+ * This counter is read more specifically by the page fault when it
+ * has to issue a COW that doesn't result in page re-use because of
+ * the lack of stability of the page_count (vs speculative pagecache
+ * lookups) or because of a GUP pin exist on an exclusive and writable
+ * anon page.
+ *
+ * If this counter is elevated and the pageteable is wrprotected (as
+ * in !pte/pmd_write) and present, it means the page may be still
+ * modified by userland through a stale TLB entry that was
+ * instantiated before the wrprotection. In such case the COW fault,
+ * if it decides not to re-use the page, will have to either wait this
+ * counter to return zero, or it needs to flush the TLB before
+ * proceeding copying the page.
+ */
+static inline void inc_wrprotect_tlb_flush_pending(struct vm_area_struct *vma)
+{
+	atomic_inc(&vma->wrprotect_tlb_flush_pending);
+	VM_WARN_ON_ONCE(atomic_read(&vma->wrprotect_tlb_flush_pending) <= 0);
+}
+
+static inline void dec_wrprotect_tlb_flush_pending(struct vm_area_struct *vma)
+{
+	atomic_dec(&vma->wrprotect_tlb_flush_pending);
+	VM_WARN_ON_ONCE(atomic_read(&vma->wrprotect_tlb_flush_pending) < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 07d9acb5b19c..e3f412c43c30 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -369,6 +369,11 @@ struct vm_area_struct {
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+	/*
+	 * When elevated, it indicates that a deferred TLB flush may
+	 * be pending after a pagetable write protection on this vma.
+	 */
+	atomic_t wrprotect_tlb_flush_pending;
 } __randomize_layout;
 
 struct core_thread {
diff --git a/kernel/fork.c b/kernel/fork.c
index 37720a6d04ea..7a658c608f3a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -365,6 +365,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		new->vm_next = new->vm_prev = NULL;
+		VM_WARN_ON_ONCE(atomic_read(&new->wrprotect_tlb_flush_pending));
 	}
 	return new;
 }
diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..e8e407443119 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2809,6 +2809,73 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	count_vm_event(PGREUSE);
 }
 
+/*
+ * This synchronization helper, by the time it returns, has to enforce
+ * there cannot be stale writable TLB entries left, on any page mapped
+ * as wrprotected in the pagetables in this vma range.
+ *
+ * This is normally used only by the COW fault immediately before
+ * copying the page to make it proof against stale TLB entries (as the
+ * one pictured below in CPU 2).
+ *
+ *  CPU 0		CPU 1			CPU 2
+ *  -----		-----			-----
+ *						writable TLB instantiated
+ *			mmap_lock_read
+ *			inc_wrprotect_tlb_flush_pending()
+ *			PT_lock
+ *			wrprotect the pte
+ *			PT unlock
+ *  mmap_lock_read
+ *  PT_lock
+ *  vmf->orig_pte = pte
+ *  do_wp_page()
+ *  PT_unlock
+ *  wp_page_copy()
+ *  sync_wrprotect_tlb_flush_pending()
+ *  found wrprotect_tlb_flush_pending elevated
+ *  flush_tlb_page()
+ *						writable TLB invalidated [1]
+ *  kret of sync_wrprotect_tlb_flush_pending()
+ *  cow_user_page() [2]
+ *
+ * The whole objective of the wrprotect_tlb_flush_pending atomic
+ * counter is to enforce [1] happens before [2] in the above sequence.
+ *
+ * Without having to alter the caller of this helper, it'd also be
+ * possible to replace the flush_tlb_page with a wait for
+ * wrprotect_tlb_flush_pending counter to return zero using the same
+ * logic as above. In such case the point [1] would be replaced by
+ * dec_wrprotect_tlb_flush_pending() happening in CPU 1.
+ *
+ * In terms of memory ordering guarantees: all page payload reads of
+ * page mapped by a wrprotected pagetable, executed after this
+ * function returns, must not be allowed to be reordered before the
+ * read of the wrprotect_tlb_flush_pending atomic counter at the start
+ * of the function. So this function has to provide acquire semantics
+ * to those page payload reads.
+ */
+static __always_inline
+void sync_wrprotect_tlb_flush_pending(struct vm_area_struct *vma,
+				      unsigned long address)
+{
+	int val = atomic_read(&vma->wrprotect_tlb_flush_pending);
+	if (val) {
+		/*
+		 * flush_tlb_page() needs to deliver acquire semantics
+		 * implicitly. Archs using IPIs to flush remote TLBs
+		 * provide those with csd_lock_wait().
+		 */
+		flush_tlb_page(vma, address);
+	} else {
+		/*
+		 * Prevent the read of the wrprotect page payload to be
+		 * reordered before the above atomic_read().
+		 */
+		smp_rmb();
+	}
+}
+
 /*
  * Handle the case of a page which we actually need to copy to a new page.
  *
@@ -2849,6 +2916,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		if (!new_page)
 			goto oom;
 
+		sync_wrprotect_tlb_flush_pending(vma, vmf->address);
+
 		if (!cow_user_page(new_page, old_page, vmf)) {
 			/*
 			 * COW failed, if the fault was solved by other,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab709023e9aa..6b7a52662de8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -335,6 +335,8 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
 	inc_tlb_flush_pending(mm);
+	if (unlikely(cp_flags & MM_CP_UFFD_WP_ALL))
+		inc_wrprotect_tlb_flush_pending(vma);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
@@ -346,6 +348,8 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	/* Only flush the TLB if we actually modified any entries: */
 	if (pages)
 		flush_tlb_range(vma, start, end);
+	if (unlikely(cp_flags & MM_CP_UFFD_WP_ALL))
+		dec_wrprotect_tlb_flush_pending(vma);
 	dec_tlb_flush_pending(mm);
 
 	return pages;

