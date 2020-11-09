Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3462ABF1B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgKIOpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:45:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbgKIOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:45:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EjJXB108985;
        Mon, 9 Nov 2020 14:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=bTyNsUvosMk4VrqtrxoBFoqvlWZwj+bJ4nLrCCYAbPE=;
 b=GIS7XE8NpqOK4L/SrQsPR+i5jwmSYFS1RTA8U1IsAmhyWFg0NmZxwE338nKBjLfezokD
 MjZ9/OxDgBqDTXsFjiHhQMEbJYXiPACNEuJqdY4lC/fDLHNLxkVF8QPguLhdO1OgP/Zm
 9qFp+EI7Q/l1/bWysYIQZpOgczZxp3NylFBxO+QzOozVRNw/F1P0b0vkvtw9h+9decEF
 3VaPbOphF9O6luL0ZmPpLOBT3ah99SABCVo4DD1C9ODDvEQOZGwR6+b1o+CVxtSaNZ1c
 kuJHbm8HPOPePajRWQNy66C+aTgE2o/nttvXI4bFjmVAkmbDy4Zsbrk1tCl7Rs2oewV7 wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72ecedx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:45:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ee4Rs154634;
        Mon, 9 Nov 2020 14:43:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gvbbwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:31 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9EhUZv024092;
        Mon, 9 Nov 2020 14:43:30 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:29 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 17/24] x86/pti: Execute IDT handlers with error code on the kernel stack
Date:   Mon,  9 Nov 2020 15:44:18 +0100
Message-Id: <20201109144425.270789-18-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an interrupt/exception in userland, the kernel is entered
and it switches the stack to the PTI stack which is mapped both in
the kernel and in the user page-table. When executing the interrupt
function, switch to the kernel stack (which is mapped only in the
kernel page-table) so that no kernel data leak to the userland
through the stack.

Changes IDT handlers which have an error code.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/idtentry.h | 18 ++++++++++++++++--
 arch/x86/kernel/traps.c         |  2 +-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 3595a31947b3..a82e31b45442 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -25,6 +25,12 @@ void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
 		(void (*)(void))(func), (void *)(arg1)) :		\
 	 func(arg1))
 
+#define CALL_ON_STACK_2(stack, func, arg1, arg2)			\
+	((stack) ?							\
+	 asm_call_on_stack_2(stack,					\
+		(void (*)(void))(func), (void *)(arg1), (void *)(arg2)) : \
+	 func(arg1, arg2))
+
 /*
  * Functions to return the top of the kernel stack if we are using the
  * user page-table (and thus not running with the kernel stack). If we
@@ -53,6 +59,13 @@ void run_idt(void (*func)(struct pt_regs *), struct pt_regs *regs)
 	CALL_ON_STACK_1(pti_kernel_stack(regs), func, regs);
 }
 
+static __always_inline
+void run_idt_errcode(void (*func)(struct pt_regs *, unsigned long),
+		     struct pt_regs *regs, unsigned long error_code)
+{
+	CALL_ON_STACK_2(pti_kernel_stack(regs), func, regs, error_code);
+}
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -141,7 +154,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
-	__##func (regs, error_code);					\
+	run_idt_errcode(__##func, regs, error_code);			\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
@@ -239,7 +252,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	__##func (regs, (u8)error_code);				\
+	run_idt_errcode((void (*)(struct pt_regs *, unsigned long))__##func, \
+			regs, (u8)error_code);				\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 5161385b3670..9a51aa016fb3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -979,7 +979,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 /* User entry, runs on regular task stack */
 DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
-	exc_debug_user(regs, debug_read_clear_dr6());
+	run_idt_errcode(exc_debug_user, regs, debug_read_clear_dr6());
 }
 #else
 /* 32 bit does not have separate entry points. */
-- 
2.18.4

