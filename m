Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB502B4644
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgKPOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:47:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56054 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgKPOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:47:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjbPE034277;
        Mon, 16 Nov 2020 14:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=2EBmytMCHjHJfGitFZo/Hxec1iwHbVcdNqowhvn1ZAE=;
 b=GB9am0Zmj6+40DYpQnudsbnP4zUFqYrfiXMNspvMypuhH/uldXlU8eI2yFQ/KYtEm2Hc
 5HoHQXRdoDJNtN2tr3LesdBgvRE8eKFfitxBb28kAjaXZY7etMZDM2GnOZ2B7+kGJe7K
 MB9ovjflbdM1TrlEv8RyMPRUnvWn7beB2RO1JvZN7OWKUFZixHsvD/W9KW0hJIgEgXWM
 +gNGmZTvDln8s5+UNDmv4u5hxy+38Z1RTotE+jJp8YULR64yF+ylyD9FmeNPdsvmGzfb
 PEO2Z6GDgVSUW7R8sXw4gT8gOAjg0a5bo+Ce6qmRZX855z3Odxxq2XahXBkSitYu2Vc1 Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vmwaw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:47:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjVWj056120;
        Mon, 16 Nov 2020 14:47:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34usps3tex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:47:00 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGEkxkX025156;
        Mon, 16 Nov 2020 14:46:59 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:46:59 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 13/21] x86/pti: Execute syscall functions on the kernel stack
Date:   Mon, 16 Nov 2020 15:47:49 +0100
Message-Id: <20201116144757.1920077-14-alexandre.chartre@oracle.com>
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
index 7ee15a12c115..1aba02ecb806 100644
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

