Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373AC2ABF30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbgKIOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:49:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38972 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgKIOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:49:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EXnct091766;
        Mon, 9 Nov 2020 14:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=wP2gJB4OxhA1mKQ9+pr/vu739u+po6A7PjH7uf9WfEY=;
 b=Tb3yp66PJfNRwPPlviJepFGMemwVZEQU8ldKO1G5zcow8Fj/IMCkskHEthpSDgKb44d7
 Q43A5jJg4OyJ+H9t04hcYz2wh23jZdKgyU0M4E65qoPyVNevM2/PYpT19XY2Sq+kIa4W
 U6p6js/DvYMmCnM432lNLYuHf+4q1HhHg4l/aNJqyhm7bEWCsmS19u5rhzVr10284eCm
 c/4tg+E2savRtPc4X/SvjxDNMc8ONmKvStfM+pGG8/Cse+JXfWnx8mNwUkiq66wevGBD
 wJAxzxYAMs/YwWNpEuSw3EoQQSvLWrVxuOvYhpPdvtpQurk7B3v75pQeGVPb8oYFe3Dv hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34nh3ape8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:43:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ee6lZ155096;
        Mon, 9 Nov 2020 14:43:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34p5gvbbsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:23 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9EhL3p013508;
        Mon, 9 Nov 2020 14:43:21 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:21 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 15/24] x86/pti: Execute syscall functions on the kernel stack
Date:   Mon,  9 Nov 2020 15:44:16 +0100
Message-Id: <20201109144425.270789-16-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090102
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

