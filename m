Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75A82AB6BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgKILYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:24:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42632 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgKILYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:24:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BFWoi114228;
        Mon, 9 Nov 2020 11:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=NqYAtGUsRpznGmvP3IrcpJ35Lu8QH+UzxHx+wAvsNkk=;
 b=as0iU9irqfO78CRDYf7Q0pkagee5BifJLsmQwH6sKhzHlsZt5GMGMg1iw51CPT5mW6bj
 +93sXbh9VQdqgp1w1lMk5qG0xuvY8H67Id30wNjDgh5VETCJGuMJyfLed4lOttTwWPsc
 EOMK9llz1Nzy5sZsoH9RpmQzvou5isyz7xXAzjlaTvzokjM220oobOMfRXzt9tlWhIyh
 YQdWKtI1zpV0zAZ49vPW+8HK91pWzbawxJPU7jzhsKDpwvFD8hSPTaVtqrgaDttwuSCr
 02B8iqDstQtsqSN3Z6grbbezWpOoMslbPWhnUe7sjYRBflf4DZIOu3SPJIPBv3OOshQz jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72ebk9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:23:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL8G6177484;
        Mon, 9 Nov 2020 11:21:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34p55ku1wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:21:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9BLpYu015911;
        Mon, 9 Nov 2020 11:21:51 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:21:51 -0800
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
Subject: [RFC][PATCH 10/24] x86/pti: Introduce per-task PTI trampoline stack
Date:   Mon,  9 Nov 2020 12:23:05 +0100
Message-Id: <20201109112319.264511-11-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=946 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=960 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Double the size of the kernel stack when using PTI. The entire stack
is mapped into the kernel address space, and the top half of the stack
(the PTI stack) is also mapped into the user address space.

The PTI stack will be used as a per-task trampoline stack instead of
the current per-cpu trampoline stack. This will allow running more
code on the trampoline stack, in particular code that schedules the
task out.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/page_64_types.h | 36 +++++++++++++++++++++++++++-
 arch/x86/include/asm/processor.h     |  3 +++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 3f49dac03617..733accc20fdb 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -12,7 +12,41 @@
 #define KASAN_STACK_ORDER 0
 #endif
 
-#define THREAD_SIZE_ORDER	(2 + KASAN_STACK_ORDER)
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+/*
+ * PTI doubles the size of the stack. The entire stack is mapped into
+ * the kernel address space. However, only the top half of the stack is
+ * mapped into the user address space.
+ *
+ * On syscall or interrupt, user mode enters the kernel with the user
+ * page-table, and the stack pointer is switched to the top of the
+ * stack (which is mapped in the user address space and in the kernel).
+ * The syscall/interrupt handler will then later decide when to switch
+ * to the kernel address space, and to switch to the top of the kernel
+ * stack which is only mapped in the kernel.
+ *
+ *   +-------------+
+ *   |             | ^                       ^
+ *   | kernel-only | | KERNEL_STACK_SIZE     |
+ *   |    stack    | |                       |
+ *   |             | V                       |
+ *   +-------------+ <- top of kernel stack  | THREAD_SIZE
+ *   |             | ^                       |
+ *   | kernel and  | | KERNEL_STACK_SIZE     |
+ *   | PTI stack   | |                       |
+ *   |             | V                       v
+ *   +-------------+ <- top of stack
+ */
+#define PTI_STACK_ORDER 1
+#else
+#define PTI_STACK_ORDER 0
+#endif
+
+#define KERNEL_STACK_ORDER 2
+#define KERNEL_STACK_SIZE (PAGE_SIZE << KERNEL_STACK_ORDER)
+
+#define THREAD_SIZE_ORDER	\
+	(KERNEL_STACK_ORDER + PTI_STACK_ORDER + KASAN_STACK_ORDER)
 #define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
 
 #define EXCEPTION_STACK_ORDER (0 + KASAN_STACK_ORDER)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 82a08b585818..47b1b806535b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -769,6 +769,9 @@ static inline void spin_lock_prefetch(const void *x)
 
 #define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1))
 
+#define task_top_of_kernel_stack(task) \
+	((void *)(((unsigned long)task_stack_page(task)) + KERNEL_STACK_SIZE))
+
 #define task_pt_regs(task) \
 ({									\
 	unsigned long __ptr = (unsigned long)task_stack_page(task);	\
-- 
2.18.4

