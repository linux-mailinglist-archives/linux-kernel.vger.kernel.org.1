Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9262ABF16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgKIOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:44:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35524 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732185AbgKIOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:44:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EZPv9084317;
        Mon, 9 Nov 2020 14:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=RNiFgm5wmKtt5qAPKRPYWBpa//S0liRcZ5bm9H3fkNo=;
 b=FN0fVtTCDvUK8jBJNNcLRvCFStHZ8WCbduj32eP2y+c7ETxyDk/Xzc1WtYYq9dvtFgNu
 Ki5O1XGCzeTa6OsE24XMXcg0tPrgNDtUErce1A4ofJRBWoOZr2DIfbTtqotJcSDOiU+c
 ptOMNTbI1PzOhRGDPz70/z4FB7NSMCY7s0qEdGvWTkOa1UxU2vh9VlyjT7mTjkT4dDEr
 qLDvE3cImd0kqMBb5rbJaIXO9pDAE4XgUcNDr2km6AnoAuWeyxjMAgC4VRuWrzDH6e5g
 O2JSON2CXmynnrFr+lh77YCPeGWjQk1bJpDb7C5b5tOmO79N85OKOeO6efQ4nSustR2I Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34p72ece4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:44:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EenFi174623;
        Mon, 9 Nov 2020 14:44:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34p5fxs2u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:44:00 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9EhxBG013971;
        Mon, 9 Nov 2020 14:43:59 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:58 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 24/24] x86/pti: Defer CR3 switch to C code for non-IST and syscall entries
Date:   Mon,  9 Nov 2020 15:44:25 +0100
Message-Id: <20201109144425.270789-25-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With PTI, syscall/interrupt/exception entries switch the CR3 register
to change the page-table in assembly code. Move the CR3 register switch
inside the C code of syscall/interrupt/exception entry handlers.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/common.c             | 15 ++++++++++++---
 arch/x86/entry/entry_64.S           | 23 +++++------------------
 arch/x86/entry/entry_64_compat.S    | 22 ----------------------
 arch/x86/include/asm/entry-common.h | 14 ++++++++++++++
 arch/x86/include/asm/idtentry.h     | 25 ++++++++++++++++++++-----
 arch/x86/kernel/cpu/mce/core.c      |  2 ++
 arch/x86/kernel/nmi.c               |  2 ++
 arch/x86/kernel/traps.c             |  6 ++++++
 arch/x86/mm/fault.c                 |  9 +++++++--
 9 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ead6a4c72e6a..3f4788dbbde7 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -51,6 +51,7 @@ __visible noinstr void return_from_fork(struct pt_regs *regs,
 		regs->ax = 0;
 	}
 	syscall_exit_to_user_mode(regs);
+	switch_to_user_cr3();
 }
 
 static __always_inline void run_syscall(sys_call_ptr_t sysfunc,
@@ -74,6 +75,7 @@ static __always_inline void run_syscall(sys_call_ptr_t sysfunc,
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
+	switch_to_kernel_cr3();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
@@ -91,12 +93,14 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
+	switch_to_user_cr3();
 }
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
 {
+	switch_to_kernel_cr3();
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
 		current_thread_info()->status |= TS_COMPAT;
 
@@ -131,11 +135,11 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 
 	do_syscall_32_irqs_on(regs, nr);
 	syscall_exit_to_user_mode(regs);
+	switch_to_user_cr3();
 }
 
-static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
+static noinstr bool __do_fast_syscall_32(struct pt_regs *regs, long nr)
 {
-	unsigned int nr = syscall_32_enter(regs);
 	int res;
 
 	/*
@@ -179,6 +183,9 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
 __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 {
+	unsigned int nr = syscall_32_enter(regs);
+	bool syscall_done;
+
 	/*
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
 	 * convention.  Adjust regs so it looks like we entered using int80.
@@ -194,7 +201,9 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	regs->ip = landing_pad;
 
 	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
-	if (!__do_fast_syscall_32(regs))
+	syscall_done = __do_fast_syscall_32(regs, nr);
+	switch_to_user_cr3();
+	if (!syscall_done)
 		return 0;
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 797effbe65b6..4be15a5ffe68 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -98,7 +98,6 @@ SYM_CODE_START(entry_SYSCALL_64)
 	swapgs
 	/* tss.sp2 is scratch space. */
 	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
@@ -192,18 +191,14 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 */
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
-	POP_REGS pop_rdi=0 skip_r11rcx=1
+	POP_REGS skip_r11rcx=1
 
 	/*
-	 * We are on the trampoline stack.  All regs except RDI are live.
 	 * We are on the trampoline stack.  All regs except RSP are live.
 	 * We can do future final exit work right here.
 	 */
 	STACKLEAK_ERASE_NOCLOBBER
 
-	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
-
-	popq	%rdi
 	movq	RSP-ORIG_RAX(%rsp), %rsp
 	USERGS_SYSRET64
 SYM_CODE_END(entry_SYSCALL_64)
@@ -321,7 +316,6 @@ SYM_CODE_END(ret_from_fork)
 	swapgs
 	cld
 	FENCE_SWAPGS_USER_ENTRY
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 	UNWIND_HINT_IRET_REGS base=%rdx offset=8
@@ -592,19 +586,15 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	ud2
 1:
 #endif
-	POP_REGS pop_rdi=0
+	POP_REGS
+	addq	$8, %rsp	/* skip regs->orig_ax */
 
 	/*
-	 * We are on the trampoline stack.  All regs except RDI are live.
+	 * We are on the trampoline stack.  All regs are live.
 	 * We can do future final exit work right here.
 	 */
 	STACKLEAK_ERASE_NOCLOBBER
 
-	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
-
-	/* Restore RDI. */
-	popq	%rdi
-	addq	$8, %rsp	/* skip regs->orig_ax */
 	SWAPGS
 	INTERRUPT_RETURN
 
@@ -899,8 +889,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 	SWAPGS
 	FENCE_SWAPGS_USER_ENTRY
-	/* We have user CR3.  Change to kernel CR3. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
 .Lerror_entry_from_usermode_after_swapgs:
 	/*
@@ -959,11 +947,10 @@ SYM_CODE_START_LOCAL(error_entry)
 .Lerror_bad_iret:
 	/*
 	 * We came from an IRET to user mode, so we have user
-	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
+	 * gsbase and CR3.  Switch to kernel gsbase.
 	 */
 	SWAPGS
 	FENCE_SWAPGS_USER_ENTRY
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
 	/*
 	 * Pretend that the exception came from user mode: set up pt_regs
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 541fdaf64045..a6fb5807bf42 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -51,10 +51,6 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	/* Interrupts are off on entry. */
 	SWAPGS
 
-	pushq	%rax
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-	popq	%rax
-
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
@@ -204,9 +200,6 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	/* Stash user ESP */
 	movl	%esp, %r8d
 
-	/* Use %rsp as scratch reg. User ESP is stashed in r8 */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
-
 	/* Switch to the kernel stack */
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
@@ -291,18 +284,6 @@ sysret32_from_system_call:
 	 * code.  We zero R8-R10 to avoid info leaks.
          */
 	movq	RSP-ORIG_RAX(%rsp), %rsp
-
-	/*
-	 * The original userspace %rsp (RSP-ORIG_RAX(%rsp)) is stored
-	 * on the process stack which is not mapped to userspace and
-	 * not readable after we SWITCH_TO_USER_CR3.  Delay the CR3
-	 * switch until after after the last reference to the process
-	 * stack.
-	 *
-	 * %r8/%r9 are zeroed before the sysret, thus safe to clobber.
-	 */
-	SWITCH_TO_USER_CR3_NOSTACK scratch_reg=%r8 scratch_reg2=%r9
-
 	xorl	%r8d, %r8d
 	xorl	%r9d, %r9d
 	xorl	%r10d, %r10d
@@ -357,9 +338,6 @@ SYM_CODE_START(entry_INT80_compat)
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 
-	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-
 	/* In the Xen PV case we already run on the thread stack. */
 	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
 
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index b75e9230c990..32e9f3159131 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -157,10 +157,24 @@ static __always_inline void switch_to_user_cr3(void)
 	native_write_cr3(cr3);
 }
 
+static __always_inline void kernel_pgtable_enter(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		switch_to_kernel_cr3();
+}
+
+static __always_inline void kernel_pgtable_exit(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		switch_to_user_cr3();
+}
+
 #else /* CONFIG_PAGE_TABLE_ISOLATION */
 
 static inline void switch_to_kernel_cr3(void) {}
 static inline void switch_to_user_cr3(void) {}
+static inline void kernel_pgtable_enter(struct pt_regs *regs) {};
+static inline void kernel_pgtable_exit(struct pt_regs *regs) {};
 
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 647af7ea3bf1..d8bfcd8a4db4 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -147,12 +147,15 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	kernel_pgtable_enter(regs);					\
+	state = irqentry_enter(regs);					\
 	instrumentation_begin();					\
 	run_idt(__##func, regs);					\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	kernel_pgtable_exit(regs);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -194,12 +197,15 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	kernel_pgtable_enter(regs);					\
+	state = irqentry_enter(regs);					\
 	instrumentation_begin();					\
 	run_idt_errcode(__##func, regs, error_code);			\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	kernel_pgtable_exit(regs);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
@@ -290,8 +296,10 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	kernel_pgtable_enter(regs);					\
+	state = irqentry_enter(regs);					\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
@@ -300,6 +308,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	kernel_pgtable_exit(regs);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
@@ -333,8 +342,10 @@ static void __##func(struct pt_regs *regs);				\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	kernel_pgtable_enter(regs);					\
+	state = irqentry_enter(regs);					\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
@@ -342,6 +353,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	kernel_pgtable_exit(regs);					\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -362,8 +374,10 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	kernel_pgtable_enter(regs);					\
+	state = irqentry_enter(regs);					\
 	instrumentation_begin();					\
 	__irq_enter_raw();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
@@ -371,6 +385,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	kernel_pgtable_exit(regs);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 827088f981c6..e1ae901c4925 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2037,9 +2037,11 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 {
 	unsigned long dr7;
 
+	switch_to_kernel_cr3();
 	dr7 = local_db_save();
 	run_idt(exc_machine_check_user, regs);
 	local_db_restore(dr7);
+	switch_to_user_cr3();
 }
 #else
 /* 32bit unified entry point */
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 23c92ffd58fe..063474f5b5fe 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -542,8 +542,10 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 
 __visible noinstr void exc_nmi_user(struct pt_regs *regs)
 {
+	switch_to_kernel_cr3();
 	handle_nmi(regs);
 	mds_user_clear_cpu_buffers();
+	switch_to_user_cr3();
 }
 
 void stop_nmi(void)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1801791748b8..6c78eeb60d19 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -255,11 +255,13 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	if (!user_mode(regs) && handle_bug(regs))
 		return;
 
+	kernel_pgtable_enter(regs);
 	state = irqentry_enter(regs);
 	instrumentation_begin();
 	run_idt(handle_invalid_op, regs);
 	instrumentation_end();
 	irqentry_exit(regs, state);
+	kernel_pgtable_exit(regs);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
@@ -663,11 +665,13 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	 * including NMI.
 	 */
 	if (user_mode(regs)) {
+		switch_to_kernel_cr3();
 		irqentry_enter_from_user_mode(regs);
 		instrumentation_begin();
 		run_idt(do_int3_user, regs);
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
+		switch_to_user_cr3();
 	} else {
 		bool irq_state = idtentry_enter_nmi(regs);
 		instrumentation_begin();
@@ -1001,7 +1005,9 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 /* User entry, runs on regular task stack */
 DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
+	switch_to_kernel_cr3();
 	run_idt_errcode(exc_debug_user, regs, debug_read_clear_dr6());
+	switch_to_user_cr3();
 }
 #else
 /* 32 bit does not have separate entry points. */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9d03603d95d..613a864840ab 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1440,9 +1440,11 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
-	unsigned long address = read_cr2();
+	unsigned long address;
 	irqentry_state_t state;
 
+	kernel_pgtable_enter(regs);
+	address = read_cr2();
 	prefetchw(&current->mm->mmap_lock);
 
 	/*
@@ -1466,8 +1468,10 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 * The async #PF handling code takes care of idtentry handling
 	 * itself.
 	 */
-	if (kvm_handle_async_pf(regs, (u32)address))
+	if (kvm_handle_async_pf(regs, (u32)address)) {
+		kernel_pgtable_exit(regs);
 		return;
+	}
 
 	/*
 	 * Entry handling for valid #PF from kernel mode is slightly
@@ -1486,4 +1490,5 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	instrumentation_end();
 
 	irqentry_exit(regs, state);
+	kernel_pgtable_exit(regs);
 }
-- 
2.18.4

