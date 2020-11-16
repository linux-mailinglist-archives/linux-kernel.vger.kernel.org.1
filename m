Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7A2B4647
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgKPOr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:47:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbgKPOr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:47:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjm2D034365;
        Mon, 16 Nov 2020 14:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=4ZSSgwSAfIpKVSBOl5YuRgyMV0OuLicBRbtyQsXk7rQ=;
 b=kf78/06PAKLUmbKUkKSD59qn7Ew+lpdos2O8ryytPH2p4t8yEc1qQwvOZDT4yI+Tx1BF
 OJQJ7UFfC2Zbpw07lnodmd+SPlC42J2vzI5TOBq//V/00G50GmA3O8WGBEy6eE1F2OWg
 Y2b7vJqFoF8b4evx7SSvdLwUlls45xG5Aq3OJ9NyS5N4o2BxIE1QxREbK2peHJhcH7nk
 Tfv6D7tPHY++BaYfXPZrbMlhyaY3sU5/Mc2ErPli+XNhYemDn9OXdEFCHLMgxUKro66c
 m1Y9Fv6tlg6C1/ODOTgHOcBTw1Rm2JLkJVrSmGab3TYHPAZ25VzRoQbtzWLsikwISklZ wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vmwawh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:47:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjOjl051600;
        Mon, 16 Nov 2020 14:47:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34ts0phbra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:47:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGEl4iu006027;
        Mon, 16 Nov 2020 14:47:04 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:47:04 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 14/21] x86/pti: Execute IDT handlers on the kernel stack
Date:   Mon, 16 Nov 2020 15:47:50 +0100
Message-Id: <20201116144757.1920077-15-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

After an interrupt/exception in userland, the kernel is entered
and it switches the stack to the PTI stack which is mapped both in
the kernel and in the user page-table. When executing the interrupt
function, switch to the kernel stack (which is mapped only in the
kernel page-table) so that no kernel data leak to the userland
through the stack.

For now, only changes IDT handlers which have no argument other
than the pt_regs registers.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/idtentry.h | 43 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/mce/core.c  |  2 +-
 arch/x86/kernel/traps.c         |  4 +--
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 4b4aca2b1420..3595a31947b3 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -10,10 +10,49 @@
 #include <linux/hardirq.h>
 
 #include <asm/irq_stack.h>
+#include <asm/pti.h>
 
 bool idtentry_enter_nmi(struct pt_regs *regs);
 void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
 
+/*
+ * The CALL_ON_STACK_* macro call the specified function either directly
+ * if no stack is provided, or on the specified stack.
+ */
+#define CALL_ON_STACK_1(stack, func, arg1)				\
+	((stack) ?							\
+	 asm_call_on_stack_1(stack,					\
+		(void (*)(void))(func), (void *)(arg1)) :		\
+	 func(arg1))
+
+/*
+ * Functions to return the top of the kernel stack if we are using the
+ * user page-table (and thus not running with the kernel stack). If we
+ * are using the kernel page-table (and so already using the kernel
+ * stack) when it returns NULL.
+ */
+static __always_inline void *pti_kernel_stack(struct pt_regs *regs)
+{
+	unsigned long stack;
+
+	if (pti_enabled() && user_mode(regs)) {
+		stack = (unsigned long)task_top_of_kernel_stack(current);
+		return (void *)(stack - 8);
+	} else {
+		return NULL;
+	}
+}
+
+/*
+ * Wrappers to run an IDT handler on the kernel stack if we are not
+ * already using this stack.
+ */
+static __always_inline
+void run_idt(void (*func)(struct pt_regs *), struct pt_regs *regs)
+{
+	CALL_ON_STACK_1(pti_kernel_stack(regs), func, regs);
+}
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -55,7 +94,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
-	__##func (regs);						\
+	run_idt(__##func, regs);					\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
@@ -271,7 +310,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	instrumentation_begin();					\
 	__irq_enter_raw();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	__##func (regs);						\
+	run_idt(__##func, regs);					\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..9407c3cd9355 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2035,7 +2035,7 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 	unsigned long dr7;
 
 	dr7 = local_db_save();
-	exc_machine_check_user(regs);
+	run_idt(exc_machine_check_user, regs);
 	local_db_restore(dr7);
 }
 #else
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 09b22a611d99..5161385b3670 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -257,7 +257,7 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 
 	state = irqentry_enter(regs);
 	instrumentation_begin();
-	handle_invalid_op(regs);
+	run_idt(handle_invalid_op, regs);
 	instrumentation_end();
 	irqentry_exit(regs, state);
 }
@@ -647,7 +647,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		instrumentation_begin();
-		do_int3_user(regs);
+		run_idt(do_int3_user, regs);
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-- 
2.18.4

