Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2722FE462
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbhAUHwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:52:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbhAUG6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 234AB23998;
        Thu, 21 Jan 2021 06:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212216;
        bh=LeVWtt4SpmCYttwYKuH3bmjG5TqgahD0w0VEKE8mR28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h79/qqPTINHaJd0TKDfXWm3Z+UtdETL730q+HJFOo2gWOetvd8fJJVwkkj8WTmhhO
         95CI+bFdnyXcU1Spjtr3oIyYeqnoYyQi2QdkqIe3LUP34d3zOVV5GlpQWxrpdMtq83
         i9bZ9rPAbpU3ukZsv1fCNzvO4q0Z5x8Ozc69xAS57HPd+MPrKwg0Swjqi6vcFt551U
         3+bbgYDoZIipHtHEWPm5QO96pRX6Pk3+NhemW6/uRAIhAPGwO89J14GV4OJgUociZQ
         WFISLbMc92mx2G1SCIcOjEHOxD2vHIOs+QNZpPV1CaTQ+UyFvdb0BRofd0lDuiPLNr
         PEjW5aGvY8fuQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 10/29] csky: Remove prologue of page fault handler in entry.S
Date:   Thu, 21 Jan 2021 14:53:30 +0800
Message-Id: <20210121065349.3188251-10-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There is a prologue on page fault handler which marking pages dirty
and/or accessed in page attributes, but all of these have been
handled in handle_pte_fault.

 - Add flush_tlb_one in vmalloc page fault instead of prologue.
 - Using cmxchg_fixup C codes in do_page_fault instead of ASM one.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/atomic.S |  20 +-------
 arch/csky/kernel/entry.S  | 104 +-------------------------------------
 arch/csky/kernel/traps.c  |  10 ++--
 arch/csky/mm/fault.c      |  45 +++++++++++++++--
 4 files changed, 48 insertions(+), 131 deletions(-)

diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
index f03db1d8d060..e73e548f7855 100644
--- a/arch/csky/kernel/atomic.S
+++ b/arch/csky/kernel/atomic.S
@@ -40,11 +40,11 @@ ENTRY(csky_cmpxchg)
 2:
 	sync.is
 #else
-1:
+GLOBAL(csky_cmpxchg_ldw)
 	ldw	a3, (a2)
 	cmpne	a0, a3
 	bt16	3f
-2:
+GLOBAL(csky_cmpxchg_stw)
 	stw	a1, (a2)
 3:
 #endif
@@ -59,19 +59,3 @@ ENTRY(csky_cmpxchg)
 	KSPTOUSP
 	rte
 END(csky_cmpxchg)
-
-#ifndef CONFIG_CPU_HAS_LDSTEX
-/*
- * Called from tlbmodified exception
- */
-ENTRY(csky_cmpxchg_fixup)
-	mfcr	a0, epc
-	lrw	a1, 2b
-	cmpne	a1, a0
-	bt	1f
-	subi	a1, (2b - 1b)
-	stw	a1, (sp, LSAVE_PC)
-1:
-	rts
-END(csky_cmpxchg_fixup)
-#endif
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index d5f6d04b21a8..185fea477a8d 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -13,10 +13,6 @@
 #include <asm/page.h>
 #include <asm/thread_info.h>
 
-#define PTE_INDX_MSK    0xffc
-#define PTE_INDX_SHIFT  10
-#define _PGDIR_SHIFT    22
-
 .macro	zero_fp
 #ifdef CONFIG_STACKTRACE
 	movi	r8, 0
@@ -41,111 +37,15 @@
 #endif
 .endm
 
-.macro tlbop_begin name, val0, val1, val2
-ENTRY(csky_\name)
-	mtcr    a3, ss2
-	mtcr    r6, ss3
-	mtcr    a2, ss4
-
-	RD_PGDR	r6
-	RD_MEH	a3
-	WR_MEH	a3
-#ifdef CONFIG_CPU_HAS_TLBI
-	tlbi.vaas a3
-	sync.is
-
-	btsti	a3, 31
-	bf	1f
-	RD_PGDR_K r6
-1:
-#else
-	bgeni	a2, 31
-	WR_MCIR	a2
-	bgeni	a2, 25
-	WR_MCIR	a2
-#endif
-	bclri   r6, 0
-	lrw	a2, PAGE_OFFSET
-	add	r6, a2
-	lrw	a2, va_pa_offset
-	ld.w	a2, (a2, 0)
-	subu	r6, a2
-
-	mov     a2, a3
-	lsri    a2, _PGDIR_SHIFT
-	lsli    a2, 2
-	addu    r6, a2
-	ldw     r6, (r6)
-
-	lrw	a2, PAGE_OFFSET
-	add	r6, a2
-	lrw	a2, va_pa_offset
-	ld.w	a2, (a2, 0)
-	subu	r6, a2
-
-	lsri    a3, PTE_INDX_SHIFT
-	lrw     a2, PTE_INDX_MSK
-	and     a3, a2
-	addu    r6, a3
-	ldw     a3, (r6)
-
-	movi	a2, (_PAGE_PRESENT | \val0)
-	and     a3, a2
-	cmpne   a3, a2
-	bt	\name
-
-	/* First read/write the page, just update the flags */
-	ldw     a3, (r6)
-	bgeni   a2, PAGE_VALID_BIT
-	bseti   a2, PAGE_ACCESSED_BIT
-	bseti   a2, \val1
-	bseti   a2, \val2
-	or      a3, a2
-	stw     a3, (r6)
-
-	/* Some cpu tlb-hardrefill bypass the cache */
-#ifdef CONFIG_CPU_NEED_TLBSYNC
-	movi	a2, 0x22
-	bseti	a2, 6
-	mtcr	r6, cr22
-	mtcr	a2, cr17
-	sync
-#endif
-
-	mfcr    a3, ss2
-	mfcr    r6, ss3
-	mfcr    a2, ss4
-	rte
-\name:
-	mfcr    a3, ss2
-	mfcr    r6, ss3
-	mfcr    a2, ss4
+.text
+ENTRY(csky_pagefault)
 	SAVE_ALL 0
-.endm
-.macro tlbop_end is_write
 	zero_fp
 	context_tracking
-	RD_MEH	a2
 	psrset  ee, ie
 	mov     a0, sp
-	movi    a1, \is_write
 	jbsr    do_page_fault
 	jmpi    ret_from_exception
-.endm
-
-.text
-
-tlbop_begin tlbinvalidl, _PAGE_READ, PAGE_VALID_BIT, PAGE_ACCESSED_BIT
-tlbop_end 0
-
-tlbop_begin tlbinvalids, _PAGE_WRITE, PAGE_DIRTY_BIT, PAGE_MODIFIED_BIT
-tlbop_end 1
-
-tlbop_begin tlbmodified, _PAGE_WRITE, PAGE_DIRTY_BIT, PAGE_MODIFIED_BIT
-#ifndef CONFIG_CPU_HAS_LDSTEX
-jbsr csky_cmpxchg_fixup
-#endif
-tlbop_end 1
 
 ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index 959a917c989d..e5fbf8653a21 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -39,9 +39,7 @@ asmlinkage void csky_cmpxchg(void);
 asmlinkage void csky_get_tls(void);
 asmlinkage void csky_irq(void);
 
-asmlinkage void csky_tlbinvalidl(void);
-asmlinkage void csky_tlbinvalids(void);
-asmlinkage void csky_tlbmodified(void);
+asmlinkage void csky_pagefault(void);
 
 /* Defined in head.S */
 asmlinkage void _start_smp_secondary(void);
@@ -66,9 +64,9 @@ void __init trap_init(void)
 	VEC_INIT(VEC_TRAP3, csky_get_tls);
 
 	/* setup MMU TLB exception */
-	VEC_INIT(VEC_TLBINVALIDL, csky_tlbinvalidl);
-	VEC_INIT(VEC_TLBINVALIDS, csky_tlbinvalids);
-	VEC_INIT(VEC_TLBMODIFIED, csky_tlbmodified);
+	VEC_INIT(VEC_TLBINVALIDL, csky_pagefault);
+	VEC_INIT(VEC_TLBINVALIDS, csky_pagefault);
+	VEC_INIT(VEC_TLBMODIFIED, csky_pagefault);
 
 #ifdef CONFIG_CPU_HAS_FPU
 	init_fpu();
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 94eac13b9c97..e888acf1c403 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -39,20 +39,52 @@ int fixup_exception(struct pt_regs *regs)
 	return 0;
 }
 
+static inline bool is_write(struct pt_regs *regs)
+{
+	switch (trap_no(regs)) {
+	case VEC_TLBINVALIDS:
+		return true;
+	case VEC_TLBMODIFIED:
+		return true;
+	}
+
+	return false;
+}
+
+#ifdef CONFIG_CPU_HAS_LDSTEX
+static inline void csky_cmpxchg_fixup(struct pt_regs *regs)
+{
+	return;
+}
+#else
+extern unsigned long csky_cmpxchg_ldw;
+extern unsigned long csky_cmpxchg_stw;
+static inline void csky_cmpxchg_fixup(struct pt_regs *regs)
+{
+	if (trap_no(regs) != VEC_TLBMODIFIED)
+		return;
+
+	if (instruction_pointer(regs) == csky_cmpxchg_stw)
+		instruction_pointer_set(regs, csky_cmpxchg_ldw);
+	return;
+}
+#endif
+
 /*
  * This routine handles page faults. It determines the address,
  * and the problem, and then passes it off to one of the appropriate
  * routines.
  */
-asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
-			      unsigned long mmu_meh)
+asmlinkage void do_page_fault(struct pt_regs *regs)
 {
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	int si_code;
 	int fault;
-	unsigned long address = mmu_meh & PAGE_MASK;
+	unsigned long address = read_mmu_entryhi() & PAGE_MASK;
+
+	csky_cmpxchg_fixup(regs);
 
 	if (kprobe_page_fault(regs, tsk->thread.trap_no))
 		return;
@@ -104,6 +136,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))
 			goto no_context;
+
+		flush_tlb_one(address);
+
 		return;
 	}
 
@@ -132,7 +167,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 good_area:
 	si_code = SEGV_ACCERR;
 
-	if (write) {
+	if (is_write(regs)) {
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
@@ -145,7 +180,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
+	fault = handle_mm_fault(vma, address, is_write(regs) ? FAULT_FLAG_WRITE : 0,
 				regs);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
-- 
2.17.1

