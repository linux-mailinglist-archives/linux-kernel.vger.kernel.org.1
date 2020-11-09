Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE92AB6BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgKILYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:24:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59060 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgKILYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:24:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BNvUG030764;
        Mon, 9 Nov 2020 11:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=wP2gJB4OxhA1mKQ9+pr/vu739u+po6A7PjH7uf9WfEY=;
 b=Vw6YVUPItMeoA1E8OpBGBNM6c0O57c7Reb6UEkt8vQsLs+5a7eUsN0LxBBxRPstcthrh
 y1QH4PAsTvSx7UwMGUpzn2Cq1wvFn5VTmHkXusik/R5C/TaHPgF8Hc4VZkE7Fy2P1AGO
 Roi1ENuyZ3F6VbAIzX5iYpY4Dom6yS4uue7ITrJoPLsv4gv+EcBeqw/vKaKSoB7b3uJt
 ZziYIyCu5inqd23bSnDo1VHrcllNS8ztG8XtngkHgugtmQrWIvEiXpcxgWeqn10m5y99
 iNvZr3kBGPC5R76JNlUXS2sylErqZyScFtRavI3B75+WYz/rFEIXmIq3fDJzlxF5/Fdo DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkndfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:24:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BKm2b147527;
        Mon, 9 Nov 2020 11:22:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34p5fxjw57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:14 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9BMCbL016085;
        Mon, 9 Nov 2020 11:22:12 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:12 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     "tglx@linutronix.de"@aserv0121.oracle.com,
        "mingo@redhat.com"@aserv0121.oracle.com,
        "bp@alien8.de"@aserv0121.oracle.com,
        "hpa@zytor.com"@aserv0121.oracle.com,
        "x86@kernel.org"@aserv0121.oracle.com,
        "dave.hansen@linux.intel.com"@aserv0121.oracle.com,
        "luto@kernel.org"@aserv0121.oracle.com,
        "peterz@infradead.org"@aserv0121.oracle.com,
        "linux-kernel@vger.kernel.org"@aserv0121.oracle.com,
        "thomas.lendacky@amd.com"@aserv0121.oracle.com,
        "jroedel@suse.de"@aserv0121.oracle.com
Cc:     "konrad.wilk@oracle.com"@aserv0121.oracle.com,
        "jan.setjeeilers@oracle.com"@aserv0121.oracle.com,
        "junaids@google.com"@aserv0121.oracle.com,
        "oweisse@google.com"@aserv0121.oracle.com,
        "rppt@linux.vnet.ibm.com"@aserv0121.oracle.com,
        "graf@amazon.de"@aserv0121.oracle.com,
        "mgross@linux.intel.com"@aserv0121.oracle.com,
        "kuzuno@gmail.com"@aserv0121.oracle.com,
        "alexandre.chartre@oracle.com"@aserv0121.oracle.com
Subject: [RFC][PATCH 15/24] x86/pti: Execute syscall functions on the kernel stack
Date:   Mon,  9 Nov 2020 12:23:10 +0100
Message-Id: <20201109112319.264511-16-alexandre.chartre@oracle.com>
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
 definitions=main-2011090075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a syscall, the kernel is entered and it switches the stack
to the PTI stack which is mapped both in the kernel and in the
user page-table. When executing the syscall function, switch to
the kernel stack (which is mapped only in the kernel page-table)
so that no kernel data leak to the userland through the stack.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/common.c          | 11 ++++++++++-
 arch/x86/entry/entry_64.S        |  1 +
 arch/x86/include/asm/irq_stack.h |  3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 54d0931801e1..ead6a4c72e6a 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -56,10 +56,19 @@ __visible noinstr void return_from_fork(struct pt_regs *regs,
 static __always_inline void run_syscall(sys_call_ptr_t sysfunc,
 					struct pt_regs *regs)
 {
+	unsigned long stack;
+
 	if (!sysfunc)
 		return;
 
-	regs->ax = sysfunc(regs);
+	if (!pti_enabled()) {
+		regs->ax = sysfunc(regs);
+		return;
+	}
+
+	stack = (unsigned long)task_top_of_kernel_stack(current);
+	regs->ax = asm_call_syscall_on_stack((void *)(stack - 8),
+					     sysfunc, regs);
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 29beab46bedd..6b88a0eb8975 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -771,6 +771,7 @@ SYM_FUNC_START(asm_call_on_stack_2)
 SYM_FUNC_START(asm_call_on_stack_3)
 SYM_INNER_LABEL(asm_call_sysvec_on_stack, SYM_L_GLOBAL)
 SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
+SYM_INNER_LABEL(asm_call_syscall_on_stack, SYM_L_GLOBAL)
 	/*
 	 * Save the frame pointer unconditionally. This allows the ORC
 	 * unwinder to handle the stack switch.
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 359427216336..108d9da7c01c 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -5,6 +5,7 @@
 #include <linux/ptrace.h>
 
 #include <asm/processor.h>
+#include <asm/syscall.h>
 
 #ifdef CONFIG_X86_64
 static __always_inline bool irqstack_active(void)
@@ -25,6 +26,8 @@ void asm_call_sysvec_on_stack(void *sp, void (*func)(struct pt_regs *regs),
 			      struct pt_regs *regs);
 void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
 			   struct irq_desc *desc);
+long asm_call_syscall_on_stack(void *sp, sys_call_ptr_t func,
+			       struct pt_regs *regs);
 
 static __always_inline void __run_on_irqstack(void (*func)(void))
 {
-- 
2.18.4

