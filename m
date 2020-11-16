Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8942B462B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgKPOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:46:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgKPOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:46:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEk9EH034514;
        Mon, 16 Nov 2020 14:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=PbBHgdGI2tKASZAHqZepge/I1MAnUFPSZXHf3r3xu0s=;
 b=AsSaRCCPQytuApK46ah8xzx7ReNBBRj40YHQxjJtazd4ptcsUVzoWy60R0TTOHcsbNVH
 avzDPm4ZyrbF/12zw5FfuU1maxd/pAVBauwhJ6h8rgDF7W1AIB1b9kBO5pqGY0n3MJtM
 /gP/2STMYQznK2T7xUxvXf4pJaVAxGS3d0QQx8sOeMeaQiL3ThbuMtah5uM6/+70Se+n
 +yiSQN7K1WIFWlEvZA6xWobziFEJ/1tcUUhTrVFsxxB89HrLIyMOIOxeIFC+Q58uIkMQ
 XfA60vE96oKM+YEFn8GXlYgNqPdVTd4MbKb7PXsWfjkUF8qIdgj0WnI0lkpBBsHkrQAY nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34t7vmwanf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:46:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjCY3164463;
        Mon, 16 Nov 2020 14:46:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34umcww2wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:46:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGEk652014533;
        Mon, 16 Nov 2020 14:46:06 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:46:06 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 04/21] x86/sev-es: Define a setup stack function for the VC idtentry
Date:   Mon, 16 Nov 2020 15:47:40 +0100
Message-Id: <20201116144757.1920077-5-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
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

The #VC exception assembly entry code uses C code (vc_switch_off_ist)
to get and configure a stack, then return to assembly to switch to
that stack and finally invoked the C function exception handler.

To pave the way for deferring CR3 switch from assembly to C code,
define a setup stack function for the VC idtentry. This function is
used to get and configure the stack before invoking idtentry handler.

For now, the setup stack function is just a wrapper around the
the vc_switch_off_ist() function but it will eventually also
contain the C code to switch CR3. The vc_switch_off_ist() function
is also refactored to just return the stack pointer, and the stack
configuration is done in the setup stack function (so that the
stack can be also be used to propagate CR3 switch information to
the idtentry handler for switching CR3 back).

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S       |  8 +++-----
 arch/x86/include/asm/idtentry.h | 14 ++++++++++++++
 arch/x86/include/asm/traps.h    |  2 +-
 arch/x86/kernel/sev-es.c        | 34 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c         | 19 +++---------------
 5 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 51df9f1871c6..274384644b5e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -546,13 +546,11 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_REGS
 
 	/*
-	 * Switch off the IST stack to make it free for nested exceptions. The
-	 * vc_switch_off_ist() function will switch back to the interrupted
-	 * stack if it is safe to do so. If not it switches to the VC fall-back
-	 * stack.
+	 * Call the setup stack function. It configures and returns
+	 * the stack we should be using to run the exception handler.
 	 */
 	movq	%rsp, %rdi		/* pt_regs pointer */
-	call	vc_switch_off_ist
+	call	setup_stack_\cfunc
 	movq	%rax, %rsp		/* Switch to new stack */
 
 	UNWIND_HINT_REGS
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b2442eb0ac2f..4b4aca2b1420 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -318,6 +318,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  */
 #define DECLARE_IDTENTRY_VC(vector, func)				\
 	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func);			\
+	__visible noinstr unsigned long setup_stack_##func(struct pt_regs *regs);	\
 	__visible noinstr void ist_##func(struct pt_regs *regs, unsigned long error_code);	\
 	__visible noinstr void safe_stack_##func(struct pt_regs *regs, unsigned long error_code)
 
@@ -380,6 +381,19 @@ static __always_inline void __##func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_VC_IST(func)				\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(ist_##func)
 
+/**
+ * DEFINE_IDTENTRY_VC_SETUP_STACK - Emit code for setting up the stack to
+				    run the VMM communication handler
+ * @func:	Function name of the entry point
+ *
+ * The stack setup code is executed before the VMM communication handler.
+ * It configures and returns the stack to switch to before running the
+ * VMM communication handler.
+ */
+#define DEFINE_IDTENTRY_VC_SETUP_STACK(func)			\
+	__visible noinstr					\
+	unsigned long setup_stack_##func(struct pt_regs *regs)
+
 /**
  * DEFINE_IDTENTRY_VC - Emit code for VMM communication handler
  * @func:	Function name of the entry point
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7f7200021bd1..cfcc9d34d2a0 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -15,7 +15,7 @@ asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
 void __init trap_init(void);
-asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
+asmlinkage __visible noinstr unsigned long vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
 #ifdef CONFIG_X86_F00F_BUG
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 0bd1a0fc587e..bd977c917cd6 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -1349,6 +1349,40 @@ DEFINE_IDTENTRY_VC_IST(exc_vmm_communication)
 	instrumentation_end();
 }
 
+struct exc_vc_frame {
+	/* pt_regs should be first */
+	struct pt_regs regs;
+};
+
+DEFINE_IDTENTRY_VC_SETUP_STACK(exc_vmm_communication)
+{
+	struct exc_vc_frame *frame;
+	unsigned long sp;
+
+	/*
+	 * Switch off the IST stack to make it free for nested exceptions.
+	 * The vc_switch_off_ist() function will switch back to the
+	 * interrupted stack if it is safe to do so. If not it switches
+	 * to the VC fall-back stack.
+	 */
+	sp = vc_switch_off_ist(regs);
+
+	/*
+	 * Found a safe stack. Set it up as if the entry has happened on
+	 * that stack. This means that we need to have pt_regs at the top
+	 * of the stack.
+	 *
+	 * The effective stack switch happens in assembly code before
+	 * the #VC handler is called.
+	 */
+	sp = ALIGN_DOWN(sp, 8) - sizeof(*frame);
+
+	frame = (struct exc_vc_frame *)sp;
+	frame->regs = *regs;
+
+	return sp;
+}
+
 DEFINE_IDTENTRY_VC(exc_vmm_communication)
 {
 	if (likely(!on_vc_fallback_stack(regs)))
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e19df6cde35d..09b22a611d99 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -675,11 +675,10 @@ asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *regs)
+asmlinkage __visible noinstr unsigned long vc_switch_off_ist(struct pt_regs *regs)
 {
 	unsigned long sp, *stack;
 	struct stack_info info;
-	struct pt_regs *regs_ret;
 
 	/*
 	 * In the SYSCALL entry path the RSP value comes from user-space - don't
@@ -687,8 +686,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 */
 	if (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
 	    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack) {
-		sp = this_cpu_read(cpu_current_top_of_stack);
-		goto sync;
+		return this_cpu_read(cpu_current_top_of_stack);
 	}
 
 	/*
@@ -703,18 +701,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	    info.type >= STACK_TYPE_EXCEPTION_LAST)
 		sp = __this_cpu_ist_top_va(VC2);
 
-sync:
-	/*
-	 * Found a safe stack - switch to it as if the entry didn't happen via
-	 * IST stack. The code below only copies pt_regs, the real switch happens
-	 * in assembly code.
-	 */
-	sp = ALIGN_DOWN(sp, 8) - sizeof(*regs_ret);
-
-	regs_ret = (struct pt_regs *)sp;
-	*regs_ret = *regs;
-
-	return regs_ret;
+	return sp;
 }
 #endif
 
-- 
2.18.4

