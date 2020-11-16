Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A850E2B4652
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgKPOsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:48:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56766 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbgKPOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:48:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjrZY034397;
        Mon, 16 Nov 2020 14:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ZknG+0QUEMSiId+yH9esYH6gIAZlvrNiEkd8HoIxwEM=;
 b=HW/mrdqwgm01QPBE4HUlSlEgkx7FCKZdXngORDDbYyIggsL8dwQoYrtHictRb6qS95uQ
 rGLnUeV/LTvCQLllWJi6oq25rSpw0PUSCt6BPd3mfDoxi5lu9iNVCONZzBVYYj/N9Jnc
 Fl/K10aXnkVN7wzAU+D7tdWTfP6cJa3/hzpSsflt3b/kHh5xlaVGTHfnt3qkg7ZvF0O1
 SmgTxapAkALCUmScU9DZNRmWxio2UOclCjipX5eFQ1k9oMcUro4mMCryTmCbvPsopR4+
 JJRySPagn0O4GZFwN4pjMAISxNhkT7azTAIb+UEVNuIZMFz6WQvttOs+ttyYJmkN66/M vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34t7vmwb0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:47:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiUEx029957;
        Mon, 16 Nov 2020 14:47:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34ts5us25c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:47:46 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGEli66006375;
        Mon, 16 Nov 2020 14:47:44 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:47:44 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 19/21] x86/pti: Defer CR3 switch to C code for IST entries
Date:   Mon, 16 Nov 2020 15:47:55 +0100
Message-Id: <20201116144757.1920077-20-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IST entries from the kernel use paranoid entry and exit
assembly functions to ensure the CR3 and GS registers are
updated with correct values for the kernel. Move the update
of the CR3 inside the C code of IST handlers.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S      | 34 ++--------------------------------
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 arch/x86/kernel/nmi.c          | 18 +++++++++++++++---
 arch/x86/kernel/sev-es.c       | 13 ++++++++++++-
 arch/x86/kernel/traps.c        | 30 ++++++++++++++++++++++++++----
 5 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6b88a0eb8975..1715bc0cefff 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -900,23 +900,6 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
-	/*
-	 * Always stash CR3 in %r14.  This value will be restored,
-	 * verbatim, at exit.  Needed if paranoid_entry interrupted
-	 * another entry that already switched to the user CR3 value
-	 * but has not yet returned to userspace.
-	 *
-	 * This is also why CS (stashed in the "iret frame" by the
-	 * hardware at entry) can not be used: this may be a return
-	 * to kernel code, but with a user CR3 value.
-	 *
-	 * Switching CR3 does not depend on kernel GSBASE so it can
-	 * be done before switching to the kernel GSBASE. This is
-	 * required for FSGSBASE because the kernel GSBASE has to
-	 * be retrieved from a kernel internal table.
-	 */
-	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
-
 	/*
 	 * Handling GSBASE depends on the availability of FSGSBASE.
 	 *
@@ -956,9 +939,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	SWAPGS
 
 	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
+	 * Do an lfence prevent GS speculation.
 	 */
 	FENCE_SWAPGS_KERNEL_ENTRY
 
@@ -989,14 +970,10 @@ SYM_CODE_END(paranoid_entry)
 SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
 	/*
-	 * The order of operations is important. RESTORE_CR3 requires
-	 * kernel GSBASE.
-	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
 	 * exceptions go through error_exit instead.
 	 */
-	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
 
 	/* Handle the three GSBASE cases */
 	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
@@ -1119,10 +1096,6 @@ SYM_CODE_END(error_return)
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
@@ -1173,7 +1146,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 * We also must not push anything to the stack before switching
 	 * stacks lest we corrupt the "NMI executing" variable.
 	 */
-	ist_entry_user exc_nmi
+	ist_entry_user exc_nmi_user
 
 	/* NMI from kernel */
 
@@ -1385,9 +1358,6 @@ end_repeat_nmi:
 	movq	$-1, %rsi
 	call	exc_nmi
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
-
 	/*
 	 * The above invocation of paranoid_entry stored the GSBASE
 	 * related information in R/EBX depending on the availability
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9407c3cd9355..31ac01c1155d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2022,11 +2022,14 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 /* MCE hit kernel mode */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
+	unsigned long saved_cr3;
 	unsigned long dr7;
 
+	saved_cr3 = save_and_switch_to_kernel_cr3();
 	dr7 = local_db_save();
 	exc_machine_check_kernel(regs);
 	local_db_restore(dr7);
+	restore_cr3(saved_cr3);
 }
 
 /* The user mode variant. */
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index be0f654c3095..523d88c3fea1 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -473,7 +473,7 @@ static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
 static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
-DEFINE_IDTENTRY_RAW(exc_nmi)
+static noinstr void handle_nmi(struct pt_regs *regs)
 {
 	bool irq_state;
 
@@ -529,9 +529,21 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 		write_cr2(this_cpu_read(nmi_cr2));
 	if (this_cpu_dec_return(nmi_state))
 		goto nmi_restart;
+}
+
+DEFINE_IDTENTRY_NMI(exc_nmi)
+{
+	unsigned long saved_cr3;
 
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
+	saved_cr3 = save_and_switch_to_kernel_cr3();
+	handle_nmi(regs);
+	restore_cr3(saved_cr3);
+}
+
+__visible noinstr void exc_nmi_user(struct pt_regs *regs)
+{
+	handle_nmi(regs);
+	mds_user_clear_cpu_buffers();
 }
 
 void stop_nmi(void)
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index bd977c917cd6..59fc7c472525 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -1352,13 +1352,18 @@ DEFINE_IDTENTRY_VC_IST(exc_vmm_communication)
 struct exc_vc_frame {
 	/* pt_regs should be first */
 	struct pt_regs regs;
+	/* extra parameters for the handler */
+	unsigned long saved_cr3;
 };
 
 DEFINE_IDTENTRY_VC_SETUP_STACK(exc_vmm_communication)
 {
 	struct exc_vc_frame *frame;
+	unsigned long saved_cr3;
 	unsigned long sp;
 
+	saved_cr3 = save_and_switch_to_kernel_cr3();
+
 	/*
 	 * Switch off the IST stack to make it free for nested exceptions.
 	 * The vc_switch_off_ist() function will switch back to the
@@ -1370,7 +1375,8 @@ DEFINE_IDTENTRY_VC_SETUP_STACK(exc_vmm_communication)
 	/*
 	 * Found a safe stack. Set it up as if the entry has happened on
 	 * that stack. This means that we need to have pt_regs at the top
-	 * of the stack.
+	 * of the stack, and we can use the bottom of the stack to pass
+	 * extra parameters (like the saved cr3 value) to the handler.
 	 *
 	 * The effective stack switch happens in assembly code before
 	 * the #VC handler is called.
@@ -1379,16 +1385,21 @@ DEFINE_IDTENTRY_VC_SETUP_STACK(exc_vmm_communication)
 
 	frame = (struct exc_vc_frame *)sp;
 	frame->regs = *regs;
+	frame->saved_cr3 = saved_cr3;
 
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
+	restore_cr3(frame->saved_cr3);
 }
 
 bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9a51aa016fb3..14d2d6f15184 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -344,10 +344,10 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 DEFINE_IDTENTRY_DF(exc_double_fault)
 {
 	static const char str[] = "double fault";
-	struct task_struct *tsk = current;
-
+	struct task_struct *tsk;
+	unsigned long saved_cr3;
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
+		saved_cr3 = save_and_switch_to_kernel_cr3();
+
+		gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 		/*
 		 * regs->sp points to the failing IRET frame on the
@@ -401,14 +405,28 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 		regs->ip = (unsigned long)asm_exc_general_protection;
 		regs->sp = (unsigned long)&gpregs->orig_ax;
 
+		restore_cr3(saved_cr3);
+
 		return;
 	}
 #endif
 
+	/*
+	 * Switch to the kernel page-table. We are on an IST stack, and
+	 * we are going to die so there is no need to switch to the kernel
+	 * stack even if we are coming from userspace.
+	 */
+	saved_cr3 = save_and_switch_to_kernel_cr3();
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
+	unsigned long saved_cr3;
+
+	saved_cr3 = save_and_switch_to_kernel_cr3();
 	exc_debug_kernel(regs, debug_read_clear_dr6());
+	restore_cr3(saved_cr3);
 }
 
 /* User entry, runs on regular task stack */
-- 
2.18.4

