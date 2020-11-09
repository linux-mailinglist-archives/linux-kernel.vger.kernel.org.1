Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF042AB6AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgKILWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:22:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgKILWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:22:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BETHU023357;
        Mon, 9 Nov 2020 11:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=4ZSSgwSAfIpKVSBOl5YuRgyMV0OuLicBRbtyQsXk7rQ=;
 b=lAtyFO1+M3fa1l8I3uD4Yd3eh8hbcuEAJ1Wxc4zJLlyREqwuZ0bvIb8zvaLL/cDa5j1h
 kZV/o+phHP1qS2OhaRATUHkWeBm3hRz51zhG/Mxelbi1WKB3vocfOfTxSKSqRVkod5jQ
 8eA0pf5LmMZJ/lpWGQ/WBSgy1XJAldpQf92bVaPDxTwwTvNni+c811fVt2fx/cyUaB//
 sxT1hgVnFdolSCgy19v21ESPloVVaDADEuaojhyeTOkrboXquckcIOaqZ6ujyZ7YgLuT
 2OnTnHCUHiXincuDsSx7th6yTTFyzir270w2DJwUSwopKvomsw0MhF9KlWW2YhZQ7K5x kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhknd4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL14a109393;
        Mon, 9 Nov 2020 11:22:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34p5bqd10j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BMG5O015171;
        Mon, 9 Nov 2020 11:22:16 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:16 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     "tglx@linutronix.de"@aserv0122.oracle.com,
        "mingo@redhat.com"@aserv0122.oracle.com,
        "bp@alien8.de"@aserv0122.oracle.com,
        "hpa@zytor.com"@aserv0122.oracle.com,
        "x86@kernel.org"@aserv0122.oracle.com,
        "dave.hansen@linux.intel.com"@aserv0122.oracle.com,
        "luto@kernel.org"@aserv0122.oracle.com,
        "peterz@infradead.org"@aserv0122.oracle.com,
        "linux-kernel@vger.kernel.org"@aserv0122.oracle.com,
        "thomas.lendacky@amd.com"@aserv0122.oracle.com,
        "jroedel@suse.de"@aserv0122.oracle.com
Cc:     "konrad.wilk@oracle.com"@aserv0122.oracle.com,
        "jan.setjeeilers@oracle.com"@aserv0122.oracle.com,
        "junaids@google.com"@aserv0122.oracle.com,
        "oweisse@google.com"@aserv0122.oracle.com,
        "rppt@linux.vnet.ibm.com"@aserv0122.oracle.com,
        "graf@amazon.de"@aserv0122.oracle.com,
        "mgross@linux.intel.com"@aserv0122.oracle.com,
        "kuzuno@gmail.com"@aserv0122.oracle.com,
        "alexandre.chartre@oracle.com"@aserv0122.oracle.com
Subject: [RFC][PATCH 16/24] x86/pti: Execute IDT handlers on the kernel stack
Date:   Mon,  9 Nov 2020 12:23:11 +0100
Message-Id: <20201109112319.264511-17-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
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

