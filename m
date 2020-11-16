Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD92B463B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgKPOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:46:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32888 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgKPOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:46:33 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiMPi143581;
        Mon, 16 Nov 2020 14:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=z79mz5KcrOqspHqDF8yaRs9hKE0J10yMlcY85TFnu+o=;
 b=Xew/hRF758acFuWdYk39xUzJxgOJjn4P+1NJc/6367IcvchiOLJH9BXRbRHtS8wyFYpC
 5ODnzJ37NWwdY0nBvllHEzwYKNi99saYK08Vf9+iTzXBk84OThuqjQTmdkZUX1jRr6bR
 6XgMNq3+IORPkuPgulv2ekvXcpl+8UrztXFPldBEzhzQyIyybbZo9YzfIKv6eSZAP7H7
 jXvSLUWz7B7cghVM3NMhUzsdbKZWOkgsxKRbqcdKofvdAg9V0PQJecd0ESqYTudmcCMj
 UB9+Z4YfN2dv93/es8simK39gnaIP0Edm85MNJS1VQfbWVGLWIINl6tPdhBbQOT4vu4V 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34t4ranhbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:46:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiTs5029734;
        Mon, 16 Nov 2020 14:46:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34ts5us0k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:46:03 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGEk1il005484;
        Mon, 16 Nov 2020 14:46:01 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:46:00 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 03/21] x86/entry: Consolidate IST entry from userspace
Date:   Mon, 16 Nov 2020 15:47:39 +0100
Message-Id: <20201116144757.1920077-4-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most IST entries (NMI, MCE, DEBUG, VC but not DF) handle an entry from
userspace the same way: they switch from the IST stack to the kernel
stack, call the handler and then return to userspace. However, NMI,
MCE/DEBUG and VC implement this same behavior using different code paths,
so consolidate this code into a single assembly macro.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S | 137 +++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 62 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c42948aca0a8..51df9f1871c6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -316,6 +316,72 @@ SYM_CODE_END(ret_from_fork)
 #endif
 .endm
 
+/*
+ * Macro to handle an IDT entry defined with the IST mechanism. It should
+ * be invoked at the beginning of the IDT handler with a pointer to the C
+ * function (cfunc_user) to invoke if the IDT was entered from userspace.
+ *
+ * If the IDT was entered from userspace, the macro will switch from the
+ * IST stack to the regular task stack, call the provided function and
+ * return to userland.
+ *
+ * If IDT was entered from the kernel, the macro will just return.
+ */
+.macro ist_entry_user cfunc_user has_error_code=0
+	UNWIND_HINT_IRET_REGS
+	ASM_CLAC
+
+	/* only process entry from userspace */
+	.if \has_error_code == 1
+		testb	$3, CS-ORIG_RAX(%rsp)
+		jz	.List_entry_from_kernel_\@
+	.else
+		testb	$3, CS-RIP(%rsp)
+		jz	.List_entry_from_kernel_\@
+		pushq	$-1	/* ORIG_RAX: no syscall to restart */
+	.endif
+
+	/* Use %rdx as a temp variable */
+	pushq	%rdx
+
+	/*
+	 * Switch from the IST stack to the regular task stack and
+	 * use the provided entry point.
+	 */
+	swapgs
+	cld
+	FENCE_SWAPGS_USER_ENTRY
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
+	movq	%rsp, %rdx
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+	UNWIND_HINT_IRET_REGS base=%rdx offset=8
+	pushq	6*8(%rdx)	/* pt_regs->ss */
+	pushq	5*8(%rdx)	/* pt_regs->rsp */
+	pushq	4*8(%rdx)	/* pt_regs->flags */
+	pushq	3*8(%rdx)	/* pt_regs->cs */
+	pushq	2*8(%rdx)	/* pt_regs->rip */
+	UNWIND_HINT_IRET_REGS
+	pushq   1*8(%rdx)	/* pt_regs->orig_ax */
+	PUSH_AND_CLEAR_REGS rdx=(%rdx)
+	ENCODE_FRAME_POINTER
+
+	/*
+	 * At this point we no longer need to worry about stack damage
+	 * due to nesting -- we're on the normal thread stack and we're
+	 * done with the IST stack.
+	 */
+
+	mov	%rsp, %rdi
+	.if \has_error_code == 1
+		movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
+		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+	.endif
+	call	\cfunc_user
+	jmp	swapgs_restore_regs_and_return_to_usermode
+
+.List_entry_from_kernel_\@:
+.endm
+
 /**
  * idtentry_body - Macro to emit code calling the C function
  * @cfunc:		C function to be called
@@ -417,18 +483,15 @@ SYM_CODE_END(\asmsym)
  */
 .macro idtentry_mce_db vector asmsym cfunc
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS
-	ASM_CLAC
-
-	pushq	$-1			/* ORIG_RAX: no syscall to restart */
-
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
 	 * a normal entry.
 	 */
-	testb	$3, CS-ORIG_RAX(%rsp)
-	jnz	.Lfrom_usermode_switch_stack_\@
+	ist_entry_user noist_\cfunc
 
+	/* Entry from kernel */
+
+	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 
@@ -440,10 +503,6 @@ SYM_CODE_START(\asmsym)
 
 	jmp	paranoid_exit
 
-	/* Switch to the regular task stack and use the noist entry point */
-.Lfrom_usermode_switch_stack_\@:
-	idtentry_body noist_\cfunc, has_error_code=0
-
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
 .endm
@@ -472,15 +531,11 @@ SYM_CODE_END(\asmsym)
  */
 .macro idtentry_vc vector asmsym cfunc
 SYM_CODE_START(\asmsym)
-	UNWIND_HINT_IRET_REGS
-	ASM_CLAC
-
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
 	 * a normal entry.
 	 */
-	testb	$3, CS-ORIG_RAX(%rsp)
-	jnz	.Lfrom_usermode_switch_stack_\@
+	ist_entry_user safe_stack_\cfunc, has_error_code=1
 
 	/*
 	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
@@ -517,10 +572,6 @@ SYM_CODE_START(\asmsym)
 	 */
 	jmp	paranoid_exit
 
-	/* Switch to the regular task stack */
-.Lfrom_usermode_switch_stack_\@:
-	idtentry_body safe_stack_\cfunc, has_error_code=1
-
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
 .endm
@@ -1113,8 +1164,6 @@ SYM_CODE_END(error_return)
  *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
 SYM_CODE_START(asm_exc_nmi)
-	UNWIND_HINT_IRET_REGS
-
 	/*
 	 * We allow breakpoints in NMIs. If a breakpoint occurs, then
 	 * the iretq it performs will take us out of NMI context.
@@ -1153,14 +1202,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 * other IST entries.
 	 */
 
-	ASM_CLAC
-
-	/* Use %rdx as our temp variable throughout */
-	pushq	%rdx
-
-	testb	$3, CS-RIP+8(%rsp)
-	jz	.Lnmi_from_kernel
-
 	/*
 	 * NMI from user mode.  We need to run on the thread stack, but we
 	 * can't go through the normal entry paths: NMIs are masked, and
@@ -1171,41 +1212,13 @@ SYM_CODE_START(asm_exc_nmi)
 	 * We also must not push anything to the stack before switching
 	 * stacks lest we corrupt the "NMI executing" variable.
 	 */
+	ist_entry_user exc_nmi
 
-	swapgs
-	cld
-	FENCE_SWAPGS_USER_ENTRY
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
-	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-	UNWIND_HINT_IRET_REGS base=%rdx offset=8
-	pushq	5*8(%rdx)	/* pt_regs->ss */
-	pushq	4*8(%rdx)	/* pt_regs->rsp */
-	pushq	3*8(%rdx)	/* pt_regs->flags */
-	pushq	2*8(%rdx)	/* pt_regs->cs */
-	pushq	1*8(%rdx)	/* pt_regs->rip */
-	UNWIND_HINT_IRET_REGS
-	pushq   $-1		/* pt_regs->orig_ax */
-	PUSH_AND_CLEAR_REGS rdx=(%rdx)
-	ENCODE_FRAME_POINTER
-
-	/*
-	 * At this point we no longer need to worry about stack damage
-	 * due to nesting -- we're on the normal thread stack and we're
-	 * done with the NMI stack.
-	 */
-
-	movq	%rsp, %rdi
-	movq	$-1, %rsi
-	call	exc_nmi
+	/* NMI from kernel */
 
-	/*
-	 * Return back to user mode.  We must *not* do the normal exit
-	 * work, because we don't want to enable interrupts.
-	 */
-	jmp	swapgs_restore_regs_and_return_to_usermode
+	/* Use %rdx as our temp variable throughout */
+	pushq	%rdx
 
-.Lnmi_from_kernel:
 	/*
 	 * Here's what our stack frame will look like:
 	 * +---------------------------------------------------------+
-- 
2.18.4

