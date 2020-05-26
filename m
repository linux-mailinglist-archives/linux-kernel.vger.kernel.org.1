Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE951A8FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 02:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634662AbgDOAqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 20:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634612AbgDOAoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:44:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33800C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:21 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d11so15027869pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cAwP4DzUuf5VHff+YKu20Hh4r1VV5Kda1ek+KjVBiQk=;
        b=oTm1n6FCHj0nL6+CoRLV4NM7aW/x8ERDAqPVC1smRP4aXzil3yJG9OeT9jb8CdQz4u
         9jCLZ3xxqqyh7GDSa8Hb+lpuf23/8Daymy+jZQqvdECerInJMvHzQc2FR3GRe7pNqd6Z
         txm2Jm3NZ3xa4OpmTh5BDBG32N5EHpIR3iGNBrRwrAy238yPsa2ZoA9C9XrI5fNwAemG
         NF7Vb84MoYEPP0HDLGhvy7s9oyhOBdc4GzUV78i1sydrEBvE3tJ1zhR5eZxP2bAylxC1
         s2IS9P1m3eVpRLyJEGPp6agMgK9jUMYXYv2nw4WCHgmEczlfJrM6N0eUaDIm6ZWHC1IY
         qNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cAwP4DzUuf5VHff+YKu20Hh4r1VV5Kda1ek+KjVBiQk=;
        b=hufGl4ls72s3AH78ekbGgpxPxkaOcfFz8cvo5hIVHdFuzMDH9PDLvMyMmcqptPPSuM
         /+mmJFitfNbrbRWLBMLWRUEbZkt756Xyz9kFOVtviMYQouTY8DSnbiQlm8VErPk5A1SR
         Moy7e6UM8r9wI3vberm6r2OG61n7mS06yTYkrMv2J6PVGjxLnORrq3fVIWwO3eTZI9sb
         DHy7lGu9xaS54x3EeAb8snThvgenIr/LI2EEahx7jyHotMg+6s3UYpiKxBtLSJ1vF/D5
         TeNEZqvM6HIvvFh4ofIRLhX5BOe+LX/Lt4nKFCbLi9K8ya49UBL4wUFrCzjwish/nnzd
         cbiA==
X-Gm-Message-State: AGi0PuZNVdE4d/B15KtLEsN2EEjiOCxyXEWZzHcl8Kjn4Htdf0ss+hlZ
        JKxyWqGdfzATVmtdh2p/O1xwQSLx9R8=
X-Google-Smtp-Source: APiQypISMDL05HIKThGP7CXqGNS8VI/Yg75IM81/T7oRZfwU86024QspKFtLtRq4h5yIzf1ku8AWl6KW2Ew=
X-Received: by 2002:a17:90b:1993:: with SMTP id mv19mr2998042pjb.88.1586911460622;
 Tue, 14 Apr 2020 17:44:20 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:53 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-11-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 10/10] mmap locking API: rename mmap_sem to mmap_lock
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the mmap_sem field to mmap_lock. Any new uses of this lock
should now go through the new mmap locking api. The mmap_lock is
still implemented as a rwsem, though this could change in the future.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/ia64/mm/fault.c                  |  4 ++--
 arch/x86/events/core.c                |  4 ++--
 arch/x86/kernel/tboot.c               |  2 +-
 arch/x86/mm/fault.c                   |  2 +-
 drivers/firmware/efi/efi.c            |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c |  2 +-
 fs/userfaultfd.c                      |  6 +++---
 include/linux/mm_types.h              |  2 +-
 include/linux/mmap_lock.h             | 28 +++++++++++++--------------
 mm/gup.c                              |  2 +-
 mm/hmm.c                              |  2 +-
 mm/init-mm.c                          |  2 +-
 mm/memory.c                           |  4 ++--
 mm/mmap.c                             |  4 ++--
 mm/mmu_notifier.c                     | 18 ++++++++---------
 mm/pagewalk.c                         | 15 +++++++-------
 mm/util.c                             |  4 ++--
 17 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 693f00b117e1..9b95050c2048 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -70,8 +70,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	mask = ((((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
 		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT));
 
-	/* mmap_sem is performance critical.... */
-	prefetchw(&mm->mmap_sem);
+	/* mmap_lock is performance critical.... */
+	prefetchw(&mm->mmap_lock);
 
 	/*
 	 * If we're in an interrupt or have no user context, we must not take the fault..
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a619763e96e1..eda117ca1c43 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2179,10 +2179,10 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	 * userspace with CR4.PCE clear while another task is still
 	 * doing on_each_cpu_mask() to propagate CR4.PCE.
 	 *
-	 * For now, this can't happen because all callers hold mmap_sem
+	 * For now, this can't happen because all callers hold mmap_lock
 	 * for write.  If this changes, we'll need a different solution.
 	 */
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
 		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4b79335624b1..4792e8778b28 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
-	.mmap_sem       = MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
+	.mmap_lock      = MMAP_LOCK_INITIALIZER(init_mm.mmap_lock),
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
 };
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 181f66b9049f..35f530f9dfc0 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1522,7 +1522,7 @@ dotraplinkage void
 do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		unsigned long address)
 {
-	prefetchw(&current->mm->mmap_sem);
+	prefetchw(&current->mm->mmap_lock);
 	trace_page_fault_entries(regs, hw_error_code, address);
 
 	if (unlikely(kmmio_fault(regs, address)))
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4bac9d7a48a6..b124fdbc1492 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -54,7 +54,7 @@ struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
-	.mmap_sem		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_sem),
+	.mmap_lock		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_lock),
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index dc9ef302f517..701f3995f621 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
 	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
 	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
 
-	might_lock_read(&current->mm->mmap_sem);
+	might_lock_read(&current->mm->mmap_lock);
 
 	if (userptr->mm != current->mm)
 		return -EPERM;
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 81ae8315f1e6..2d1be141757a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -234,7 +234,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 
@@ -286,7 +286,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -405,7 +405,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_sem so we can only check that
 	 * the mmap_sem is held, if PF_DUMPCORE was not set.
 	 */
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba8..d13b90399c16 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -436,7 +436,7 @@ struct mm_struct {
 		spinlock_t page_table_lock; /* Protects page tables and some
 					     * counters
 					     */
-		struct rw_semaphore mmap_sem;
+		struct rw_semaphore mmap_lock;
 
 		struct list_head mmlist; /* List of maybe swapped mm's.	These
 					  * are globally strung together off
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 07efa379664a..fc156433216d 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -5,63 +5,63 @@
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
-	init_rwsem(&mm->mmap_sem);
+	init_rwsem(&mm->mmap_lock);
 }
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
-	down_write(&mm->mmap_sem);
+	down_write(&mm->mmap_lock);
 }
 
 static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
-	down_write_nested(&mm->mmap_sem, subclass);
+	down_write_nested(&mm->mmap_lock, subclass);
 }
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
-	return down_write_killable(&mm->mmap_sem);
+	return down_write_killable(&mm->mmap_lock);
 }
 
 static inline bool mmap_write_trylock(struct mm_struct *mm)
 {
-	return down_write_trylock(&mm->mmap_sem) != 0;
+	return down_write_trylock(&mm->mmap_lock) != 0;
 }
 
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
-	up_write(&mm->mmap_sem);
+	up_write(&mm->mmap_lock);
 }
 
 static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
 {
-	downgrade_write(&mm->mmap_sem);
+	downgrade_write(&mm->mmap_lock);
 }
 
 static inline void mmap_read_lock(struct mm_struct *mm)
 {
-	down_read(&mm->mmap_sem);
+	down_read(&mm->mmap_lock);
 }
 
 static inline int mmap_read_lock_killable(struct mm_struct *mm)
 {
-	return down_read_killable(&mm->mmap_sem);
+	return down_read_killable(&mm->mmap_lock);
 }
 
 static inline bool mmap_read_trylock(struct mm_struct *mm)
 {
-	return down_read_trylock(&mm->mmap_sem) != 0;
+	return down_read_trylock(&mm->mmap_lock) != 0;
 }
 
 static inline void mmap_read_unlock(struct mm_struct *mm)
 {
-	up_read(&mm->mmap_sem);
+	up_read(&mm->mmap_lock);
 }
 
 static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 {
-	if (down_read_trylock(&mm->mmap_sem)) {
-		rwsem_release(&mm->mmap_sem.dep_map, _RET_IP_);
+	if (down_read_trylock(&mm->mmap_lock)) {
+		rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
 		return true;
 	}
 	return false;
@@ -69,7 +69,7 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
-	up_read_non_owner(&mm->mmap_sem);
+	up_read_non_owner(&mm->mmap_lock);
 }
 
 #endif /* _LINUX_MMAP_LOCK_H */
diff --git a/mm/gup.c b/mm/gup.c
index dd8f045b047b..e2fdf296a1a8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1403,7 +1403,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	VM_BUG_ON(end   & ~PAGE_MASK);
 	VM_BUG_ON_VMA(start < vma->vm_start, vma);
 	VM_BUG_ON_VMA(end   > vma->vm_end, vma);
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK;
 	if (vma->vm_flags & VM_LOCKONFAULT)
diff --git a/mm/hmm.c b/mm/hmm.c
index 280585833adf..8660aec6aafa 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -581,7 +581,7 @@ long hmm_range_fault(struct hmm_range *range)
 	struct mm_struct *mm = range->notifier->mm;
 	int ret;
 
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	do {
 		/* If range is no longer valid force retry. */
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3c128bd6a30c..2b16924419b4 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -31,7 +31,7 @@ struct mm_struct init_mm = {
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
-	.mmap_sem	= MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
+	.mmap_lock	= MMAP_LOCK_INITIALIZER(init_mm.mmap_lock),
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
diff --git a/mm/memory.c b/mm/memory.c
index 66baf5142e6b..8ae378527248 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1214,7 +1214,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		next = pud_addr_end(addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
-				lockdep_assert_held(&tlb->mm->mmap_sem);
+				lockdep_assert_held(&tlb->mm->mmap_lock);
 				split_huge_pud(vma, pud, addr);
 			} else if (zap_huge_pud(tlb, vma, pud, addr))
 				goto next;
@@ -4811,7 +4811,7 @@ void __might_fault(const char *file, int line)
 	__might_sleep(file, line, 0);
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
-		might_lock_read(&current->mm->mmap_sem);
+		might_lock_read(&current->mm->mmap_lock);
 #endif
 }
 EXPORT_SYMBOL(__might_fault);
diff --git a/mm/mmap.c b/mm/mmap.c
index 79597ec2366d..5b3b94ad20e2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3474,7 +3474,7 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
 		 * The LSB of head.next can't change from under us
 		 * because we hold the mm_all_locks_mutex.
 		 */
-		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_sem);
+		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_lock);
 		/*
 		 * We can safely modify head.next after taking the
 		 * anon_vma->root->rwsem. If some other vma in this mm shares
@@ -3504,7 +3504,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
 		 */
 		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
 			BUG();
-		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_sem);
+		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_lock);
 	}
 }
 
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index cfd0a03bf5cc..6717278d6d49 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -599,7 +599,7 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 }
 
 /*
- * Same as mmu_notifier_register but here the caller must hold the mmap_sem in
+ * Same as mmu_notifier_register but here the caller must hold the mmap_lock in
  * write mode. A NULL mn signals the notifier is being registered for itree
  * mode.
  */
@@ -609,7 +609,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	struct mmu_notifier_subscriptions *subscriptions = NULL;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
 	if (IS_ENABLED(CONFIG_LOCKDEP)) {
@@ -623,7 +623,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 		/*
 		 * kmalloc cannot be called under mm_take_all_locks(), but we
 		 * know that mm->notifier_subscriptions can't change while we
-		 * hold the write side of the mmap_sem.
+		 * hold the write side of the mmap_lock.
 		 */
 		subscriptions = kzalloc(
 			sizeof(struct mmu_notifier_subscriptions), GFP_KERNEL);
@@ -655,7 +655,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	 * readers.  acquire can only be used while holding the mmgrab or
 	 * mmget, and is safe because once created the
 	 * mmu_notifier_subscriptions is not freed until the mm is destroyed.
-	 * As above, users holding the mmap_sem or one of the
+	 * As above, users holding the mmap_lock or one of the
 	 * mm_take_all_locks() do not need to use acquire semantics.
 	 */
 	if (subscriptions)
@@ -689,7 +689,7 @@ EXPORT_SYMBOL_GPL(__mmu_notifier_register);
  * @mn: The notifier to attach
  * @mm: The mm to attach the notifier to
  *
- * Must not hold mmap_sem nor any other VM related lock when calling
+ * Must not hold mmap_lock nor any other VM related lock when calling
  * this registration function. Must also ensure mm_users can't go down
  * to zero while this runs to avoid races with mmu_notifier_release,
  * so mm has to be current->mm or the mm should be pinned safely such
@@ -750,7 +750,7 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  * are the same.
  *
  * Each call to mmu_notifier_get() must be paired with a call to
- * mmu_notifier_put(). The caller must hold the write side of mm->mmap_sem.
+ * mmu_notifier_put(). The caller must hold the write side of mm->mmap_lock.
  *
  * While the caller has a mmu_notifier get the mm pointer will remain valid,
  * and can be converted to an active mm pointer via mmget_not_zero().
@@ -761,7 +761,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
 	struct mmu_notifier *subscription;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 
 	if (mm->notifier_subscriptions) {
 		subscription = find_get_mmu_notifier(mm, ops);
@@ -983,7 +983,7 @@ int mmu_interval_notifier_insert(struct mmu_interval_notifier *interval_sub,
 	struct mmu_notifier_subscriptions *subscriptions;
 	int ret;
 
-	might_lock(&mm->mmap_sem);
+	might_lock(&mm->mmap_lock);
 
 	subscriptions = smp_load_acquire(&mm->notifier_subscriptions);
 	if (!subscriptions || !subscriptions->has_itree) {
@@ -1006,7 +1006,7 @@ int mmu_interval_notifier_insert_locked(
 		mm->notifier_subscriptions;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 
 	if (!subscriptions || !subscriptions->has_itree) {
 		ret = __mmu_notifier_register(NULL, mm);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 928df1638c30..d669a3146c0f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -373,8 +373,9 @@ static int __walk_page_range(unsigned long start, unsigned long end,
  * caller-specific data to callbacks, @private should be helpful.
  *
  * Locking:
- *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_sem,
- *   because these function traverse vma list and/or access to vma's data.
+ *   Callers of walk_page_range() and walk_page_vma() should hold
+ *   @mm->mmap_lock, because these function traverse the vma list
+ *   and/or access the vma's data.
  */
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
@@ -395,7 +396,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	if (!walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	lockdep_assert_held(&walk.mm->mmap_lock);
 
 	vma = find_vma(walk.mm, start);
 	do {
@@ -453,7 +454,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	if (start >= end || !walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	lockdep_assert_held(&walk.mm->mmap_lock);
 
 	return __walk_page_range(start, end, &walk);
 }
@@ -472,7 +473,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 	if (!walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	lockdep_assert_held(&walk.mm->mmap_lock);
 
 	err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
 	if (err > 0)
@@ -498,11 +499,11 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
  * Also see walk_page_range() for additional information.
  *
  * Locking:
- *   This function can't require that the struct mm_struct::mmap_sem is held,
+ *   This function can't require that the struct mm_struct::mmap_lock is held,
  *   since @mapping may be mapped by multiple processes. Instead
  *   @mapping->i_mmap_rwsem must be held. This might have implications in the
  *   callbacks, and it's up tho the caller to ensure that the
- *   struct mm_struct::mmap_sem is not needed.
+ *   struct mm_struct::mmap_lock is not needed.
  *
  *   Also this means that a caller can't rely on the struct
  *   vm_area_struct::vm_flags to be constant across a call,
diff --git a/mm/util.c b/mm/util.c
index ea2e15b21446..56c562f7ad19 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -425,7 +425,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
  * @bypass_rlim: %true if checking RLIMIT_MEMLOCK should be skipped
  *
  * Assumes @task and @mm are valid (i.e. at least one reference on each), and
- * that mmap_sem is held as writer.
+ * that mmap_lock is held as writer.
  *
  * Return:
  * * 0       on success
@@ -437,7 +437,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 	unsigned long locked_vm, limit;
 	int ret = 0;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 
 	locked_vm = mm->locked_vm;
 	if (inc) {
-- 
2.26.0.110.g2183baf09c-goog

