Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5EE2AB6A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgKILWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:22:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44752 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgKILWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:22:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BDxH6109908;
        Mon, 9 Nov 2020 11:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=yaLERP1ZONbUoAOi2reTY/cZLxINvvkKekxAkfeDOB4=;
 b=G7QTmV43RcbvdGGhQRBw07PcnMbhjkqEjybg+/i+UHecEgo267MJEDb96yHUW4mitJZA
 ZF1OsEjQbddixgo2u7Glj/l0Sm31JqTcYF9ZrILFdbym2j/31iih4JQVwArwHXSYX/Y+
 Fx1WJd2/1LAJl1fuPiRsT4ozSWYQiC3svtriUl0mrFYT+3E0NNp/FzkaOpiCX7BQN8+j
 pdpddxxKoqHBCKtoXslXf8cRXVcSEnBLlN1ehxXYQo2+3Bt7SphYa8JSTRr/WRHaiu2o
 cBjjm+1qT1KNwXXq0Sv+Jg7+k8ZZZUGN4FM3QRUkmG7KSAWX2Eepg36XUyHgOKK6wmia Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3ankqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL0iI109368;
        Mon, 9 Nov 2020 11:22:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34p5bqd0un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BM83O021611;
        Mon, 9 Nov 2020 11:22:08 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:07 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     "tglx@linutronix.de"@userv0122.oracle.com,
        "mingo@redhat.com"@userv0122.oracle.com,
        "bp@alien8.de"@userv0122.oracle.com,
        "hpa@zytor.com"@userv0122.oracle.com,
        "x86@kernel.org"@userv0122.oracle.com,
        "dave.hansen@linux.intel.com"@userv0122.oracle.com,
        "luto@kernel.org"@userv0122.oracle.com,
        "peterz@infradead.org"@userv0122.oracle.com,
        "linux-kernel@vger.kernel.org"@userv0122.oracle.com,
        "thomas.lendacky@amd.com"@userv0122.oracle.com,
        "jroedel@suse.de"@userv0122.oracle.com
Cc:     "konrad.wilk@oracle.com"@userv0122.oracle.com,
        "jan.setjeeilers@oracle.com"@userv0122.oracle.com,
        "junaids@google.com"@userv0122.oracle.com,
        "oweisse@google.com"@userv0122.oracle.com,
        "rppt@linux.vnet.ibm.com"@userv0122.oracle.com,
        "graf@amazon.de"@userv0122.oracle.com,
        "mgross@linux.intel.com"@userv0122.oracle.com,
        "kuzuno@gmail.com"@userv0122.oracle.com,
        "alexandre.chartre@oracle.com"@userv0122.oracle.com
Subject: [RFC][PATCH 14/24] x86/pti: Use PTI stack instead of trampoline stack
Date:   Mon,  9 Nov 2020 12:23:09 +0100
Message-Id: <20201109112319.264511-15-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When entering the kernel from userland, use the per-task PTI stack
instead of the per-cpu trampoline stack. Like the trampoline stack,
the PTI stack is mapped both in the kernel and in the user page-table.
Using a per-task stack which is mapped into the kernel and the user
page-table instead of a per-cpu stack will allow executing more code
before switching to the kernel stack and to the kernel page-table.

Additional changes will be made to later to switch to the kernel stack
(which is only mapped in the kernel page-table).

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S        | 42 +++++++++-----------------------
 arch/x86/include/asm/pti.h       |  8 ++++++
 arch/x86/include/asm/switch_to.h |  7 +++++-
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 458af12ed9a1..29beab46bedd 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -194,19 +194,9 @@ syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
 	POP_REGS pop_rdi=0 skip_r11rcx=1
 
-	/*
-	 * Now all regs are restored except RSP and RDI.
-	 * Save old stack pointer and switch to trampoline stack.
-	 */
-	movq	%rsp, %rdi
-	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
-	UNWIND_HINT_EMPTY
-
-	pushq	RSP-RDI(%rdi)	/* RSP */
-	pushq	(%rdi)		/* RDI */
-
 	/*
 	 * We are on the trampoline stack.  All regs except RDI are live.
+	 * We are on the trampoline stack.  All regs except RSP are live.
 	 * We can do future final exit work right here.
 	 */
 	STACKLEAK_ERASE_NOCLOBBER
@@ -214,7 +204,7 @@ syscall_return_via_sysret:
 	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
 
 	popq	%rdi
-	popq	%rsp
+	movq	RSP-ORIG_RAX(%rsp), %rsp
 	USERGS_SYSRET64
 SYM_CODE_END(entry_SYSCALL_64)
 
@@ -606,24 +596,6 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #endif
 	POP_REGS pop_rdi=0
 
-	/*
-	 * The stack is now user RDI, orig_ax, RIP, CS, EFLAGS, RSP, SS.
-	 * Save old stack pointer and switch to trampoline stack.
-	 */
-	movq	%rsp, %rdi
-	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
-	UNWIND_HINT_EMPTY
-
-	/* Copy the IRET frame to the trampoline stack. */
-	pushq	6*8(%rdi)	/* SS */
-	pushq	5*8(%rdi)	/* RSP */
-	pushq	4*8(%rdi)	/* EFLAGS */
-	pushq	3*8(%rdi)	/* CS */
-	pushq	2*8(%rdi)	/* RIP */
-
-	/* Push user RDI on the trampoline stack. */
-	pushq	(%rdi)
-
 	/*
 	 * We are on the trampoline stack.  All regs except RDI are live.
 	 * We can do future final exit work right here.
@@ -634,6 +606,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
+	addq	$8, %rsp	/* skip regs->orig_ax */
 	SWAPGS
 	INTERRUPT_RETURN
 
@@ -1062,6 +1035,15 @@ SYM_CODE_START_LOCAL(error_entry)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
 .Lerror_entry_from_usermode_after_swapgs:
+	/*
+	 * We are on the trampoline stack. With PTI, the trampoline
+	 * stack is a per-thread stack so we are all set and we can
+	 * return.
+	 *
+	 * Without PTI, the trampoline stack is a per-cpu stack and
+	 * we need to switch to the normal thread stack.
+	 */
+	ALTERNATIVE "", "ret", X86_FEATURE_PTI
 	/* Put us onto the real thread stack. */
 	popq	%r12				/* save return addr in %12 */
 	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 5484e69ff8d3..ed211fcc3a50 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -17,8 +17,16 @@ extern void pti_check_boottime_disable(void);
 extern void pti_finalize(void);
 extern void pti_clone_pgtable(struct mm_struct *mm, unsigned long start,
 			      unsigned long end, enum pti_clone_level level);
+static inline bool pti_enabled(void)
+{
+	return static_cpu_has(X86_FEATURE_PTI);
+}
 #else
 static inline void pti_check_boottime_disable(void) { }
+static inline bool pti_enabled(void)
+{
+	return false;
+}
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 9f69cc497f4b..457458228462 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_SWITCH_TO_H
 
 #include <linux/sched/task_stack.h>
+#include <asm/pti.h>
 
 struct task_struct; /* one of the stranger aspects of C forward declarations */
 
@@ -76,8 +77,12 @@ static inline void update_task_stack(struct task_struct *task)
 	 * doesn't work on x86-32 because sp1 and
 	 * cpu_current_top_of_stack have different values (because of
 	 * the non-zero stack-padding on 32bit).
+	 *
+	 * If PTI is enabled, sp0 points to the PTI stack (mapped in
+	 * the kernel and user page-table) which is used when entering
+	 * the kernel.
 	 */
-	if (static_cpu_has(X86_FEATURE_XENPV))
+	if (static_cpu_has(X86_FEATURE_XENPV) || pti_enabled())
 		load_sp0(task_top_of_stack(task));
 #endif
 }
-- 
2.18.4

