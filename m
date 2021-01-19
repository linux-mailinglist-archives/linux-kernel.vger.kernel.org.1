Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2FB2FBF88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbhASSzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390431AbhASS1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:27:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C86892388E;
        Tue, 19 Jan 2021 17:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611078062;
        bh=aR0zZuYtP0niTyCDTasWnxw5vYy4R+RIxCykasEXdGg=;
        h=From:To:Cc:Subject:Date:From;
        b=CqW2Cylk34362atGoLHnhyRFZ3dN4BLz0RriiwQcwLOc1wk54JSxHnHe1CmEfROA2
         r9efOgEsxgHtqNtn70J7BeE8KVV9RNqrvlR1BTIfkLFjS6WLsLF/AWrgKc6OWD8RDd
         QdrD9oOJ00LVb5YvdooX5ssqHxaB3cYZElVtdQ+eMdbJkc3N8fV5gRzgUBgwxQjsmk
         XnWog363VCpRreLhlqxj4+odgMW5Rf7R5bLWwzlmzslgsk/8t1U1yXsqTKbRqZVqYW
         ZgJbAcw1fWdSrcA4LV5fFau9NAzPwNShWVpULCLL5QwmF7KyfWR4YsrakDYOK7/oHj
         TR3G/QpFTdujQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>,
        Stas Sergeev <stsp@list.ru>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
Date:   Tue, 19 Jan 2021 09:40:55 -0800
Message-Id: <f3086de0babcab36f69949b5780bde851f719bc8.1611078018.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation was rather buggy.  It unconditionally marked PTEs
read-only, even for VM_SHARED mappings.  I'm not sure whether this is
actually a problem, but it certainly seems unwise.  More importantly, it
released the mmap lock before flushing the TLB, which could allow a racing
CoW operation to falsely believe that the underlying memory was not
writable.

I can't find any users at all of this mechanism, so just remove it.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Linux-MM <linux-mm@kvack.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Stas Sergeev <stsp@list.ru>
Cc: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

Changes from v1:
 - Get rid of the whole screen_bitmap and the fault code, too.

 arch/x86/include/asm/vm86.h      |  1 -
 arch/x86/include/uapi/asm/vm86.h |  4 +--
 arch/x86/kernel/vm86_32.c        | 62 ++++++++------------------------
 arch/x86/mm/fault.c              | 30 ----------------
 4 files changed, 16 insertions(+), 81 deletions(-)

diff --git a/arch/x86/include/asm/vm86.h b/arch/x86/include/asm/vm86.h
index 26efbec94448..9e8ac5073ecb 100644
--- a/arch/x86/include/asm/vm86.h
+++ b/arch/x86/include/asm/vm86.h
@@ -36,7 +36,6 @@ struct vm86 {
 	unsigned long saved_sp0;
 
 	unsigned long flags;
-	unsigned long screen_bitmap;
 	unsigned long cpu_type;
 	struct revectored_struct int_revectored;
 	struct revectored_struct int21_revectored;
diff --git a/arch/x86/include/uapi/asm/vm86.h b/arch/x86/include/uapi/asm/vm86.h
index d2ee4e307ef8..18909b8050bc 100644
--- a/arch/x86/include/uapi/asm/vm86.h
+++ b/arch/x86/include/uapi/asm/vm86.h
@@ -97,7 +97,7 @@ struct revectored_struct {
 struct vm86_struct {
 	struct vm86_regs regs;
 	unsigned long flags;
-	unsigned long screen_bitmap;
+	unsigned long screen_bitmap;		/* unused, preserved by vm86() */
 	unsigned long cpu_type;
 	struct revectored_struct int_revectored;
 	struct revectored_struct int21_revectored;
@@ -106,7 +106,7 @@ struct vm86_struct {
 /*
  * flags masks
  */
-#define VM86_SCREEN_BITMAP	0x0001
+#define VM86_SCREEN_BITMAP	0x0001        /* no longer supported */
 
 struct vm86plus_info_struct {
 	unsigned long force_return_for_pic:1;
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 764573de3996..e5a7a10a0164 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -134,7 +134,11 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	unsafe_put_user(regs->ds, &user->regs.ds, Efault_end);
 	unsafe_put_user(regs->fs, &user->regs.fs, Efault_end);
 	unsafe_put_user(regs->gs, &user->regs.gs, Efault_end);
-	unsafe_put_user(vm86->screen_bitmap, &user->screen_bitmap, Efault_end);
+
+	/*
+	 * Don't write screen_bitmap in case some user had a value there
+	 * and expected it to remain unchanged.
+	 */
 
 	user_access_end();
 
@@ -160,49 +164,6 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	do_exit(SIGSEGV);
 }
 
-static void mark_screen_rdonly(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-	spinlock_t *ptl;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int i;
-
-	mmap_write_lock(mm);
-	pgd = pgd_offset(mm, 0xA0000);
-	if (pgd_none_or_clear_bad(pgd))
-		goto out;
-	p4d = p4d_offset(pgd, 0xA0000);
-	if (p4d_none_or_clear_bad(p4d))
-		goto out;
-	pud = pud_offset(p4d, 0xA0000);
-	if (pud_none_or_clear_bad(pud))
-		goto out;
-	pmd = pmd_offset(pud, 0xA0000);
-
-	if (pmd_trans_huge(*pmd)) {
-		vma = find_vma(mm, 0xA0000);
-		split_huge_pmd(vma, pmd, 0xA0000);
-	}
-	if (pmd_none_or_clear_bad(pmd))
-		goto out;
-	pte = pte_offset_map_lock(mm, pmd, 0xA0000, &ptl);
-	for (i = 0; i < 32; i++) {
-		if (pte_present(*pte))
-			set_pte(pte, pte_wrprotect(*pte));
-		pte++;
-	}
-	pte_unmap_unlock(pte, ptl);
-out:
-	mmap_write_unlock(mm);
-	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT, false);
-}
-
-
-
 static int do_vm86_irq_handling(int subfunction, int irqnumber);
 static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus);
 
@@ -282,6 +243,15 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 			offsetof(struct vm86_struct, int_revectored)))
 		return -EFAULT;
 
+
+	/* VM86_SCREEN_BITMAP had numerous bugs and appears to have no users. */
+	if (v.flags & VM86_SCREEN_BITMAP) {
+		char comm[TASK_COMM_LEN];
+
+		pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no longer supported\n", get_task_comm(comm, current));
+		return -EINVAL;
+	}
+
 	memset(&vm86regs, 0, sizeof(vm86regs));
 
 	vm86regs.pt.bx = v.regs.ebx;
@@ -302,7 +272,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	vm86regs.gs = v.regs.gs;
 
 	vm86->flags = v.flags;
-	vm86->screen_bitmap = v.screen_bitmap;
 	vm86->cpu_type = v.cpu_type;
 
 	if (copy_from_user(&vm86->int_revectored,
@@ -370,9 +339,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	update_task_stack(tsk);
 	preempt_enable();
 
-	if (vm86->flags & VM86_SCREEN_BITMAP)
-		mark_screen_rdonly(tsk->mm);
-
 	memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
 	return regs->ax;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 82bf37a5c9ec..fd0dd60f6302 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -261,25 +261,6 @@ void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 	}
 }
 
-/*
- * Did it hit the DOS screen memory VA from vm86 mode?
- */
-static inline void
-check_v8086_mode(struct pt_regs *regs, unsigned long address,
-		 struct task_struct *tsk)
-{
-#ifdef CONFIG_VM86
-	unsigned long bit;
-
-	if (!v8086_mode(regs) || !tsk->thread.vm86)
-		return;
-
-	bit = (address - 0xA0000) >> PAGE_SHIFT;
-	if (bit < 32)
-		tsk->thread.vm86->screen_bitmap |= 1 << bit;
-#endif
-}
-
 static bool low_pfn(unsigned long pfn)
 {
 	return pfn < max_low_pfn;
@@ -334,15 +315,6 @@ KERN_ERR
 "******* Disabling USB legacy in the BIOS may also help.\n";
 #endif
 
-/*
- * No vm86 mode in 64-bit mode:
- */
-static inline void
-check_v8086_mode(struct pt_regs *regs, unsigned long address,
-		 struct task_struct *tsk)
-{
-}
-
 static int bad_address(void *p)
 {
 	unsigned long dummy;
@@ -1395,8 +1367,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 		mm_fault_error(regs, hw_error_code, address, fault);
 		return;
 	}
-
-	check_v8086_mode(regs, address, tsk);
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
 
-- 
2.29.2

