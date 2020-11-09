Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92B2AB6AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgKILXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:23:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57164 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgKILW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:22:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BDwjj007960;
        Mon, 9 Nov 2020 11:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=bTyNsUvosMk4VrqtrxoBFoqvlWZwj+bJ4nLrCCYAbPE=;
 b=DguEevIHhz+ct/9o+P1lvI6HcN9iXr1Js6hX0DzY14bA7EPqcdYrAQO6TsatcImbph5o
 4LWFK26hh4DicasGKQi9/4pJh2QYDoeJ+gQoGA2lZVMvr1h1b9x09EGBXswwn0/zl8VV
 mPyWPcClp1PhjYmn5L1iyAJKNW3HRwa4ZjzgLdYs6ZrXCtNM3Y4C5tcPKAqeHN0tCchC
 GDJp95+WOBeZSDhyyVyZ7z+twUGqjA9mR+v35rNlB/qg+k90PpYs7zMHtU/yCwWgA67p
 n4tVo7PhJ5iXQQFRRO4fCH/ZVxi03wyOLA29mm/JPM7dtcS63KZT9FshAsBjTC4e46wL aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhknd53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BKlI4147296;
        Mon, 9 Nov 2020 11:22:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34p5fxjw9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:22 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9BMKSu029176;
        Mon, 9 Nov 2020 11:22:20 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:20 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     "tglx@linutronix.de"@userv0121.oracle.com,
        "mingo@redhat.com"@userv0121.oracle.com,
        "bp@alien8.de"@userv0121.oracle.com,
        "hpa@zytor.com"@userv0121.oracle.com,
        "x86@kernel.org"@userv0121.oracle.com,
        "dave.hansen@linux.intel.com"@userv0121.oracle.com,
        "luto@kernel.org"@userv0121.oracle.com,
        "peterz@infradead.org"@userv0121.oracle.com,
        "linux-kernel@vger.kernel.org"@userv0121.oracle.com,
        "thomas.lendacky@amd.com"@userv0121.oracle.com,
        "jroedel@suse.de"@userv0121.oracle.com
Cc:     "konrad.wilk@oracle.com"@userv0121.oracle.com,
        "jan.setjeeilers@oracle.com"@userv0121.oracle.com,
        "junaids@google.com"@userv0121.oracle.com,
        "oweisse@google.com"@userv0121.oracle.com,
        "rppt@linux.vnet.ibm.com"@userv0121.oracle.com,
        "graf@amazon.de"@userv0121.oracle.com,
        "mgross@linux.intel.com"@userv0121.oracle.com,
        "kuzuno@gmail.com"@userv0121.oracle.com,
        "alexandre.chartre@oracle.com"@userv0121.oracle.com
Subject: [RFC][PATCH 17/24] x86/pti: Execute IDT handlers with error code on the kernel stack
Date:   Mon,  9 Nov 2020 12:23:12 +0100
Message-Id: <20201109112319.264511-18-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
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

