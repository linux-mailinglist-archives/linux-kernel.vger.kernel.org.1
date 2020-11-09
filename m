Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EDB2ABF13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbgKIOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:44:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35368 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbgKIOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:44:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EZC30084198;
        Mon, 9 Nov 2020 14:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=tDP56HUESyFbMXkaNeBtkxDMsDRg3NOC8eBiNOHS25c=;
 b=0SdAf+SaGtEnpOE/S9XGmKw9IoH1aHemYvmchtqXhl7qz/B327O6cJWf9XyzN8kF3uJB
 vawjVAev02ybL6qJybcMvay9KQWwz0X48+/Vi345IWeRiyqtGU0AYXouiGI0i8Qjb2Tz
 xWlKRBmAC885d8cuqhmIO8Yo1tgzZgLUFgIj+BeYm+yAMjXEcf9hhrCN7+vjOCIT4fa/
 OUPDH+4+MzMeMw2/hmkbm+Y/hw3c7p9iKG84qH+lvSye280oyR43S57R+2bWTBQNEXpF
 P/pnxmFnNVOCd2maUHxTA0G1OdXYhcUxopVZahwxZpSwixccHd5+TERmKz4p5UUcGrB1 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34p72ece47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:43:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Eelsu174364;
        Mon, 9 Nov 2020 14:43:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34p5fxs2ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:52 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9EhoFa032065;
        Mon, 9 Nov 2020 14:43:50 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:50 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 22/24] x86/entry: Defer paranoid entry/exit to C code
Date:   Mon,  9 Nov 2020 15:44:23 +0100
Message-Id: <20201109144425.270789-23-alexandre.chartre@oracle.com>
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

IST entries from the kernel use paranoid entry and exit
assembly functions to ensure the CR3 and GS registers are
updated with correct values for the kernel. Move the update
of the CR3 and GS registers inside the C code of IST handlers.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S      | 72 ++++++++++------------------------
 arch/x86/kernel/cpu/mce/core.c |  3 ++
 arch/x86/kernel/nmi.c          | 18 +++++++--
 arch/x86/kernel/sev-es.c       | 20 +++++++++-
 arch/x86/kernel/traps.c        | 30 ++++++++++++--
 5 files changed, 83 insertions(+), 60 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6b88a0eb8975..9ea8187d4405 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -462,16 +462,16 @@ SYM_CODE_START(\asmsym)
 	/* Entry from kernel */
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
-	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
-	call	paranoid_entry
-
+	cld
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
 	call	\cfunc
 
-	jmp	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -507,12 +507,9 @@ SYM_CODE_START(\asmsym)
 	 */
 	ist_entry_user safe_stack_\cfunc, has_error_code=1
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
-	call	paranoid_entry
-
+	cld
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	/*
@@ -538,7 +535,7 @@ SYM_CODE_START(\asmsym)
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
 	 * so it is definitly mapped even with PTI enabled.
 	 */
-	jmp	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -555,8 +552,9 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ASM_CLAC
 
-	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
-	call	paranoid_entry
+	cld
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
@@ -564,7 +562,7 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
-	jmp	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -1119,10 +1117,6 @@ SYM_CODE_END(error_return)
 /*
  * Runs on exception stack.  Xen PV does not go through this path at all,
  * so we can use real assembly here.
- *
- * Registers:
- *	%r14: Used to save/restore the CR3 of the interrupted context
- *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
 SYM_CODE_START(asm_exc_nmi)
 	/*
@@ -1173,7 +1167,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 * We also must not push anything to the stack before switching
 	 * stacks lest we corrupt the "NMI executing" variable.
 	 */
-	ist_entry_user exc_nmi
+	ist_entry_user exc_nmi_user
 
 	/* NMI from kernel */
 
@@ -1346,9 +1340,7 @@ repeat_nmi:
 	 *
 	 * RSP is pointing to "outermost RIP".  gsbase is unknown, but, if
 	 * we're repeating an NMI, gsbase has the same value that it had on
-	 * the first iteration.  paranoid_entry will load the kernel
-	 * gsbase if needed before we call exc_nmi().  "NMI executing"
-	 * is zero.
+	 * the first iteration.  "NMI executing" is zero.
 	 */
 	movq	$1, 10*8(%rsp)		/* Set "NMI executing". */
 
@@ -1372,44 +1364,20 @@ end_repeat_nmi:
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 
 	/*
-	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
-	 * as we should not be calling schedule in NMI context.
-	 * Even with normal interrupts enabled. An NMI should not be
-	 * setting NEED_RESCHED or anything that normal interrupts and
+	 * We should not be calling schedule in NMI context. Even with
+	 * normal interrupts enabled. An NMI should not be setting
+	 * NEED_RESCHED or anything that normal interrupts and
 	 * exceptions might do.
 	 */
-	call	paranoid_entry
+	cld
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
 	call	exc_nmi
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
-
-	/*
-	 * The above invocation of paranoid_entry stored the GSBASE
-	 * related information in R/EBX depending on the availability
-	 * of FSGSBASE.
-	 *
-	 * If FSGSBASE is enabled, restore the saved GSBASE value
-	 * unconditionally, otherwise take the conditional SWAPGS path.
-	 */
-	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
-
-	wrgsbase	%rbx
-	jmp	nmi_restore
-
-nmi_no_fsgsbase:
-	/* EBX == 0 -> invoke SWAPGS */
-	testl	%ebx, %ebx
-	jnz	nmi_restore
-
-nmi_swapgs:
-	SWAPGS_UNSAFE_STACK
-
-nmi_restore:
 	POP_REGS
 
 	/*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9407c3cd9355..827088f981c6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2022,11 +2022,14 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 /* MCE hit kernel mode */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
+	struct kernel_entry_state entry_state;
 	unsigned long dr7;
 
+	kernel_paranoid_entry(&entry_state);
 	dr7 = local_db_save();
 	exc_machine_check_kernel(regs);
 	local_db_restore(dr7);
+	kernel_paranoid_exit(&entry_state);
 }
 
 /* The user mode variant. */
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index b6291b683be1..23c92ffd58fe 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -473,7 +473,7 @@ static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
 static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
-DEFINE_IDTENTRY_NMI(exc_nmi)
+static noinstr void handle_nmi(struct pt_regs *regs)
 {
 	bool irq_state;
 
@@ -529,9 +529,21 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 		write_cr2(this_cpu_read(nmi_cr2));
 	if (this_cpu_dec_return(nmi_state))
 		goto nmi_restart;
+}
+
+DEFINE_IDTENTRY_NMI(exc_nmi)
+{
+	struct kernel_entry_state entry_state;
+
+	kernel_paranoid_entry(&entry_state);
+	handle_nmi(regs);
+	kernel_paranoid_exit(&entry_state);
+}
 
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
+__visible noinstr void exc_nmi_user(struct pt_regs *regs)
+{
+	handle_nmi(regs);
+	mds_user_clear_cpu_buffers();
 }
 
 void stop_nmi(void)
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index bd977c917cd6..ef9a8b69c25c 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -1352,13 +1352,25 @@ DEFINE_IDTENTRY_VC_IST(exc_vmm_communication)
 struct exc_vc_frame {
 	/* pt_regs should be first */
 	struct pt_regs regs;
+	/* extra parameters for the handler */
+	struct kernel_entry_state entry_state;
 };
 
 DEFINE_IDTENTRY_VC_SETUP_STACK(exc_vmm_communication)
 {
+	struct kernel_entry_state entry_state;
 	struct exc_vc_frame *frame;
 	unsigned long sp;
 
+	/*
+	 * kernel_paranoid_entry() is called first to properly set
+	 * the GS register which is used to access per-cpu variables.
+	 *
+	 * vc_switch_off_ist() uses per-cpu variables so it has to be
+	 * called after kernel_paranoid_entry().
+	 */
+	kernel_paranoid_entry(&entry_state);
+
 	/*
 	 * Switch off the IST stack to make it free for nested exceptions.
 	 * The vc_switch_off_ist() function will switch back to the
@@ -1370,7 +1382,8 @@ DEFINE_IDTENTRY_VC_SETUP_STACK(exc_vmm_communication)
 	/*
 	 * Found a safe stack. Set it up as if the entry has happened on
 	 * that stack. This means that we need to have pt_regs at the top
-	 * of the stack.
+	 * of the stack, and we can use the bottom of the stack to pass
+	 * extra parameters (like the kernel entry state) to the handler.
 	 *
 	 * The effective stack switch happens in assembly code before
 	 * the #VC handler is called.
@@ -1379,16 +1392,21 @@ DEFINE_IDTENTRY_VC_SETUP_STACK(exc_vmm_communication)
 
 	frame = (struct exc_vc_frame *)sp;
 	frame->regs = *regs;
+	frame->entry_state = entry_state;
 
 	return sp;
 }
 
 DEFINE_IDTENTRY_VC(exc_vmm_communication)
 {
+	struct exc_vc_frame *frame = (struct exc_vc_frame *)regs;
+
 	if (likely(!on_vc_fallback_stack(regs)))
 		safe_stack_exc_vmm_communication(regs, error_code);
 	else
 		ist_exc_vmm_communication(regs, error_code);
+
+	kernel_paranoid_exit(&frame->entry_state);
 }
 
 bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9a51aa016fb3..1801791748b8 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -344,10 +344,10 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 DEFINE_IDTENTRY_DF(exc_double_fault)
 {
 	static const char str[] = "double fault";
-	struct task_struct *tsk = current;
-
+	struct task_struct *tsk;
+	struct kernel_entry_state entry_state;
 #ifdef CONFIG_VMAP_STACK
-	unsigned long address = read_cr2();
+	unsigned long address;
 #endif
 
 #ifdef CONFIG_X86_ESPFIX64
@@ -371,8 +371,12 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 		regs->cs == __KERNEL_CS &&
 		regs->ip == (unsigned long)native_irq_return_iret)
 	{
-		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 		unsigned long *p = (unsigned long *)regs->sp;
+		struct pt_regs *gpregs;
+
+		kernel_paranoid_entry(&entry_state);
+
+		gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 		/*
 		 * regs->sp points to the failing IRET frame on the
@@ -401,14 +405,28 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 		regs->ip = (unsigned long)asm_exc_general_protection;
 		regs->sp = (unsigned long)&gpregs->orig_ax;
 
+		kernel_paranoid_exit(&entry_state);
+
 		return;
 	}
 #endif
 
+	/*
+	 * Switch to the kernel page-table. We are on an IST stack, and
+	 * we are going to die so there is no need to switch to the kernel
+	 * stack even if we are coming from userspace.
+	 */
+	kernel_paranoid_entry(&entry_state);
+
+#ifdef CONFIG_VMAP_STACK
+	address = read_cr2();
+#endif
+
 	idtentry_enter_nmi(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
+	tsk = current;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = X86_TRAP_DF;
 
@@ -973,7 +991,11 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 /* IST stack entry */
 DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
+	struct kernel_entry_state entry_state;
+
+	kernel_paranoid_entry(&entry_state);
 	exc_debug_kernel(regs, debug_read_clear_dr6());
+	kernel_paranoid_exit(&entry_state);
 }
 
 /* User entry, runs on regular task stack */
-- 
2.18.4

