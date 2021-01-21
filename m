Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BEF2FE35F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbhAUHEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:04:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbhAUHAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:00:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3F94239EC;
        Thu, 21 Jan 2021 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212236;
        bh=b0w19n0rpBEAseMsWwLhUaB96Evm+Eiflrjscrr+DpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F24xUrj8x/onRaypbYwNtSdoJj6tmWEFpoXpKv8to2py2s7fntPjjE2dkew1PSo77
         BkEtf6pDeCYSykrO71cJbAfZ6vKacwGLaBnrm7dENOx81/XR1gV/ERvjoLWd42AEed
         6Cvl012JZftVHXMkS8hkUgWImfhgdcLzknqhCQjHP8H4r1bGT35/sLRIiE7qw6Dnj7
         1oLWja23Ii0pBuh1fjmwiUIyW9rykjcTrNEioSLNdgAlJ/CYJZs9CS8Ex8I6kGn0/g
         Hdnn7GGyxMJxBBT9T+SrYOQJuOB4sqH4c53z+mQ3AT/G0OZkmzixb8k46f3v2csY6V
         FmqA282jUqOTA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 18/29] csky: Sync riscv mm/fault.c for easy maintenance
Date:   Thu, 21 Jan 2021 14:53:38 +0800
Message-Id: <20210121065349.3188251-18-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Sync arch/riscv/mm/fault.c into arch/csky for easy maintenance.
Here are the patches related to the modification:

cac4d1d "riscv/mm/fault: Move no context handling to no_context()"
ac416a7 "riscv/mm/fault: Move vmalloc fault handling to vmalloc_fault()"
6c11ffb "riscv/mm/fault: Move fault error handling to mm_fault_error()"
afb8c6f "riscv/mm/fault: Move access error check to function"
bda281d "riscv/mm/fault: Simplify fault error handling"
a51271d "riscv/mm/fault: Move bad area handling to bad_area()"

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/bug.h |   2 +
 arch/csky/mm/fault.c        | 342 ++++++++++++++++++++----------------
 2 files changed, 189 insertions(+), 155 deletions(-)

diff --git a/arch/csky/include/asm/bug.h b/arch/csky/include/asm/bug.h
index 33ebd16b9c78..8fbe7d89bf67 100644
--- a/arch/csky/include/asm/bug.h
+++ b/arch/csky/include/asm/bug.h
@@ -21,6 +21,8 @@ do {					\
 struct pt_regs;
 
 void die(struct pt_regs *regs, const char *str);
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr);
+
 void show_regs(struct pt_regs *regs);
 void show_code(struct pt_regs *regs);
 
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index cd8c7304c7e9..c7b67976bac4 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -1,29 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
-#include <linux/signal.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/mman.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/version.h>
-#include <linux/vt_kern.h>
 #include <linux/extable.h>
-#include <linux/uaccess.h>
-#include <linux/perf_event.h>
 #include <linux/kprobes.h>
-
-#include <asm/hardirq.h>
-#include <asm/mmu_context.h>
-#include <asm/traps.h>
-#include <asm/page.h>
+#include <linux/mmu_context.h>
+#include <linux/perf_event.h>
 
 int fixup_exception(struct pt_regs *regs)
 {
@@ -70,76 +51,169 @@ static inline void csky_cmpxchg_fixup(struct pt_regs *regs)
 }
 #endif
 
+static inline void no_context(struct pt_regs *regs, unsigned long addr)
+{
+	current->thread.trap_no = trap_no(regs);
+
+	/* Are we prepared to handle this kernel fault? */
+	if (fixup_exception(regs))
+		return;
+
+	/*
+	 * Oops. The kernel tried to access some bad page. We'll have to
+	 * terminate things with extreme prejudice.
+	 */
+	bust_spinlocks(1);
+	pr_alert("Unable to handle kernel paging request at virtual "
+		 "addr 0x%08lx, pc: 0x%08lx\n", addr, regs->pc);
+	die(regs, "Oops");
+	do_exit(SIGKILL);
+}
+
+static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
+{
+	current->thread.trap_no = trap_no(regs);
+
+	if (fault & VM_FAULT_OOM) {
+		/*
+		 * We ran out of memory, call the OOM killer, and return the userspace
+		 * (which will retry the fault, or kill us if we got oom-killed).
+		 */
+		if (!user_mode(regs)) {
+			no_context(regs, addr);
+			return;
+		}
+		pagefault_out_of_memory();
+		return;
+	} else if (fault & VM_FAULT_SIGBUS) {
+		/* Kernel mode? Handle exceptions or die */
+		if (!user_mode(regs)) {
+			no_context(regs, addr);
+			return;
+		}
+		do_trap(regs, SIGBUS, BUS_ADRERR, addr);
+		return;
+	}
+	BUG();
+}
+
+static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
+{
+	/*
+	 * Something tried to access memory that isn't in our memory map.
+	 * Fix it, but check if it's kernel or user first.
+	 */
+	mmap_read_unlock(mm);
+	/* User mode accesses just cause a SIGSEGV */
+	if (user_mode(regs)) {
+		do_trap(regs, SIGSEGV, code, addr);
+		return;
+	}
+
+	no_context(regs, addr);
+}
+
+static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
+{
+	pgd_t *pgd, *pgd_k;
+	pud_t *pud, *pud_k;
+	pmd_t *pmd, *pmd_k;
+	pte_t *pte_k;
+	int offset;
+
+	/* User mode accesses just cause a SIGSEGV */
+	if (user_mode(regs)) {
+		do_trap(regs, SIGSEGV, code, addr);
+		return;
+	}
+
+	/*
+	 * Synchronize this task's top level page-table
+	 * with the 'reference' page table.
+	 *
+	 * Do _not_ use "tsk" here. We might be inside
+	 * an interrupt in the middle of a task switch..
+	 */
+	offset = pgd_index(addr);
+
+	pgd = get_pgd() + offset;
+	pgd_k = init_mm.pgd + offset;
+
+	if (!pgd_present(*pgd_k)) {
+		no_context(regs, addr);
+		return;
+	}
+	set_pgd(pgd, *pgd_k);
+
+	pud = (pud_t *)pgd;
+	pud_k = (pud_t *)pgd_k;
+	if (!pud_present(*pud_k)) {
+		no_context(regs, addr);
+		return;
+	}
+
+	pmd = pmd_offset(pud, addr);
+	pmd_k = pmd_offset(pud_k, addr);
+	if (!pmd_present(*pmd_k)) {
+		no_context(regs, addr);
+		return;
+	}
+	set_pmd(pmd, *pmd_k);
+
+	pte_k = pte_offset_kernel(pmd_k, addr);
+	if (!pte_present(*pte_k)) {
+		no_context(regs, addr);
+		return;
+	}
+
+	flush_tlb_one(addr);
+}
+
+static inline bool access_error(struct pt_regs *regs, struct vm_area_struct *vma)
+{
+	if (is_write(regs)) {
+		if (!(vma->vm_flags & VM_WRITE))
+			return true;
+	} else {
+		if (unlikely(!vma_is_accessible(vma)))
+			return true;
+	}
+	return false;
+}
+
 /*
- * This routine handles page faults. It determines the address,
- * and the problem, and then passes it off to one of the appropriate
- * routines.
+ * This routine handles page faults.  It determines the address and the
+ * problem, and then passes it off to one of the appropriate routines.
  */
 asmlinkage void do_page_fault(struct pt_regs *regs)
 {
-	struct vm_area_struct *vma = NULL;
-	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->mm;
+	struct task_struct *tsk;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	unsigned long addr = read_mmu_entryhi() & PAGE_MASK;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
-	int si_code;
-	int fault;
-	unsigned long address = read_mmu_entryhi() & PAGE_MASK;
+	int code = SEGV_MAPERR;
+	vm_fault_t fault;
+
+	tsk = current;
+	mm = tsk->mm;
 
 	csky_cmpxchg_fixup(regs);
 
 	if (kprobe_page_fault(regs, tsk->thread.trap_no))
 		return;
 
-	si_code = SEGV_MAPERR;
-
 	/*
-	 * We fault-in kernel-space virtual memory on-demand. The
-	 * 'reference' page table is init_mm.pgd.
+	 * Fault-in kernel-space virtual memory on-demand.
+	 * The 'reference' page table is init_mm.pgd.
 	 *
 	 * NOTE! We MUST NOT take any locks for this case. We may
 	 * be in an interrupt or a critical region, and should
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
-	if (unlikely(address >= VMALLOC_START) &&
-	    unlikely(address <= VMALLOC_END)) {
-		/*
-		 * Synchronize this task's top level page-table
-		 * with the 'reference' page table.
-		 *
-		 * Do _not_ use "tsk" here. We might be inside
-		 * an interrupt in the middle of a task switch..
-		 */
-		int offset = pgd_index(address);
-		pgd_t *pgd, *pgd_k;
-		pud_t *pud, *pud_k;
-		pmd_t *pmd, *pmd_k;
-		pte_t *pte_k;
-
-		pgd = get_pgd() + offset;
-		pgd_k = init_mm.pgd + offset;
-
-		if (!pgd_present(*pgd_k))
-			goto no_context;
-		set_pgd(pgd, *pgd_k);
-
-		pud = (pud_t *)pgd;
-		pud_k = (pud_t *)pgd_k;
-		if (!pud_present(*pud_k))
-			goto no_context;
-
-		pmd = pmd_offset(pud, address);
-		pmd_k = pmd_offset(pud_k, address);
-		if (!pmd_present(*pmd_k))
-			goto no_context;
-		set_pmd(pmd, *pmd_k);
-
-		pte_k = pte_offset_kernel(pmd_k, address);
-		if (!pte_present(*pte_k))
-			goto no_context;
-
-		flush_tlb_one(address);
-
+	if (unlikely((addr >= VMALLOC_START) && (addr <= VMALLOC_END))) {
+		vmalloc_fault(regs, code, addr);
 		return;
 	}
 
@@ -148,60 +222,65 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		local_irq_enable();
 
 	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
+	 * If we're in an interrupt, have no user context, or are running
+	 * in an atomic region, then we must not take the fault.
 	 */
-	if (unlikely(faulthandler_disabled() || !mm))
-		goto bad_area_nosemaphore;
+	if (unlikely(faulthandler_disabled() || !mm)) {
+		no_context(regs, addr);
+		return;
+	}
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
 	if (is_write(regs))
 		flags |= FAULT_FLAG_WRITE;
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
+	vma = find_vma(mm, addr);
+	if (unlikely(!vma)) {
+		bad_area(regs, mm, code, addr);
+		return;
+	}
+	if (likely(vma->vm_start <= addr))
 		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
+		bad_area(regs, mm, code, addr);
+		return;
+	}
+	if (unlikely(expand_stack(vma, addr))) {
+		bad_area(regs, mm, code, addr);
+		return;
+	}
+
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
-	 * we can handle it..
+	 * we can handle it.
 	 */
 good_area:
-	si_code = SEGV_ACCERR;
+	code = SEGV_ACCERR;
 
-	if (is_write(regs)) {
-		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;
-	} else {
-		if (unlikely(!vma_is_accessible(vma)))
-			goto bad_area;
+	if (unlikely(access_error(regs, vma))) {
+		bad_area(regs, mm, code, addr);
+		return;
 	}
 
 	/*
-	 * If for any reason at all we couldn't handle the fault,
+	 * If for any reason at all we could not handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
-	if (unlikely(fault & VM_FAULT_ERROR)) {
-		if (fault & VM_FAULT_OOM)
-			goto out_of_memory;
-		else if (fault & VM_FAULT_SIGBUS)
-			goto do_sigbus;
-		else if (fault & VM_FAULT_SIGSEGV)
-			goto bad_area;
-		BUG();
-	}
+	fault = handle_mm_fault(vma, addr, flags, regs);
+
+	/*
+	 * If we need to retry but a fatal signal is pending, handle the
+	 * signal first. We do not need to release the mmap_lock because it
+	 * would already be released in __lock_page_or_retry in mm/filemap.c.
+	 */
+	if (fault_signal_pending(fault, regs))
+		return;
 
 	if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLOW_RETRY))) {
 		flags |= FAULT_FLAG_TRIED;
@@ -215,57 +294,10 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	}
 
 	mmap_read_unlock(mm);
-	return;
-
-	/*
-	 * Something tried to access memory that isn't in our memory map..
-	 * Fix it, but check if it's kernel or user first..
-	 */
-bad_area:
-	mmap_read_unlock(mm);
 
-bad_area_nosemaphore:
-	/* User mode accesses just cause a SIGSEGV */
-	if (user_mode(regs)) {
-		tsk->thread.trap_no = trap_no(regs);
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
+	if (unlikely(fault & VM_FAULT_ERROR)) {
+		mm_fault_error(regs, addr, fault);
 		return;
 	}
-
-no_context:
-	tsk->thread.trap_no = trap_no(regs);
-
-	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs))
-		return;
-
-	/*
-	 * Oops. The kernel tried to access some bad page. We'll have to
-	 * terminate things with extreme prejudice.
-	 */
-	bust_spinlocks(1);
-	pr_alert("Unable to handle kernel paging request at virtual "
-		 "address 0x%08lx, pc: 0x%08lx\n", address, regs->pc);
-	die(regs, "Oops");
-
-out_of_memory:
-	tsk->thread.trap_no = trap_no(regs);
-
-	/*
-	 * We ran out of memory, call the OOM killer, and return the userspace
-	 * (which will retry the fault, or kill us if we got oom-killed).
-	 */
-	pagefault_out_of_memory();
 	return;
-
-do_sigbus:
-	tsk->thread.trap_no = trap_no(regs);
-
-	mmap_read_unlock(mm);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!user_mode(regs))
-		goto no_context;
-
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
-- 
2.17.1

