Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E72B4640
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgKPOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:46:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37134 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgKPOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:46:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEi5xN182803;
        Mon, 16 Nov 2020 14:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=NqYAtGUsRpznGmvP3IrcpJ35Lu8QH+UzxHx+wAvsNkk=;
 b=IGSlkBM3A4J3GLGQJQvQF60EKHOEBqmf+VS9NqJfoUT+Uh9tqGV2uH1hWhZpTWO/T0dH
 nNbMquEppPv+WudT/KAzJZeNTywKkP54F6kfk9IAP894i89P4c1UwjfHNLefzWYjqvyJ
 hkJCpad4cbHvG5BsaA3rfRf2X0s8zuBJSiOY//ae/JtEEJXxxDZ0NFu4X3cMcPEYU7K0
 bfkKGOAtioT8Yif7wvaC11fo8eZxzvO+IVwDv/z9lkPdzCB2Phyi96fr3W47CzQIDguV
 DtJj91JeANak7w9kVJFPJPyBp7UqEWf6I0XR/XF/FeMwueYwClBsyQDL/mMfyxiNgmiR aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34t76kncp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:46:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjVQY056088;
        Mon, 16 Nov 2020 14:46:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34usps3t0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:46:34 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGEkWfh014721;
        Mon, 16 Nov 2020 14:46:32 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:46:31 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 08/21] x86/pti: Introduce per-task PTI trampoline stack
Date:   Mon, 16 Nov 2020 15:47:44 +0100
Message-Id: <20201116144757.1920077-9-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=966 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=941
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
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

