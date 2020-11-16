Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83B2B4642
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgKPOrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:47:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55968 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgKPOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:47:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjoBI034380;
        Mon, 16 Nov 2020 14:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=yaLERP1ZONbUoAOi2reTY/cZLxINvvkKekxAkfeDOB4=;
 b=rU3LnYn6cGua3A5CvtFTaE7D0znvpwGGAacmThiJR9GNuIY7GsmZzEAKcjRuP50rsc/E
 h/jqY589Tu42El+QYxuceKnN3EM895G3LwDAHQYS3H/mnZel9OwjY5Of/cMOQygbKdv0
 RwDZJVZ7Hgs0AuqbcVlwhROjMc+m8pom8X+6CK7WLgn8a9sQea4Ltvx57e0T62Hqrd1D
 5iKWYYFTyfZ6zGf3h4leXSI7gxAplKD8OLxy59ILF/vG5L/Vm/G/CQ9lxdJXYnkGfy49
 v+wqWWPZ/ZP7KagLMUAdmup4iK+F4iIk1IxsOpatnhiQRtnPqHRvNm3yWkYr55oZyB0o nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vmwavp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:46:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjWAs056303;
        Mon, 16 Nov 2020 14:46:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34usps3tbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:46:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGEksGm025116;
        Mon, 16 Nov 2020 14:46:54 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:46:54 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of trampoline stack
Date:   Mon, 16 Nov 2020 15:47:48 +0100
Message-Id: <20201116144757.1920077-13-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
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

