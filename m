Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A462ABF0C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgKIOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:44:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34562 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbgKIOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:43:59 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EXw3N091847;
        Mon, 9 Nov 2020 14:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=dKQ466ogBF9iT/YuvPk6WnvLNXJ9RBbRcizvTSCI/IU=;
 b=0VMqyKvA7z4Kl6o7Ep5SZrtVW3t3trWY+vcFEdxz8Dn8wvLgdqpVEznV2NxPh/+BINxF
 vb56yD4qgOEgixtaNSa0bubI5aLjz7wUhfE7g+y/O4aTKNTUaZ6iZ3oin3HG/uUcm5bl
 7mMXMm+aHeAUfnlRZzwpcmFRRZnwh4qfNXDATif85ln+8qilcpc5i5zLJeM6Cr0Z2G2b
 6fNHCnN26OgZDUeMU7c9pPs3QFUby5SePeOIfL9TAN3pThYOAXUOiLeRLRMRkP9fPPct
 QcURKREFIqUQ33+tOylY7E3KoyUmv2aaULNaOsG4pbBpkU6XivGO/8fKWECXUHJ+kV5p 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3apeas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:43:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ef98T016378;
        Mon, 9 Nov 2020 14:43:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34p55m19ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:40 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9EhcuN031916;
        Mon, 9 Nov 2020 14:43:38 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:37 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 19/24] x86/pti: Execute page fault handler on the kernel stack
Date:   Mon,  9 Nov 2020 15:44:20 +0100
Message-Id: <20201109144425.270789-20-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
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

After a page fault from userland, the kernel is entered and it switches
the stack to the PTI stack which is mapped both in the kernel and in
the user page-table. When executing the page fault handler, switch
to the kernel stack (which is mapped only in the kernel page-table)
so that no kernel data leak to the userland through the stack.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/idtentry.h | 17 +++++++++++++++++
 arch/x86/mm/fault.c             |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 0c5d9f027112..a6725afaaec0 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -31,6 +31,13 @@ void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
 		(void (*)(void))(func), (void *)(arg1), (void *)(arg2)) : \
 	 func(arg1, arg2))
 
+#define CALL_ON_STACK_3(stack, func, arg1, arg2, arg3)			\
+	((stack) ?							\
+	 asm_call_on_stack_3(stack,					\
+		(void (*)(void))(func), (void *)(arg1), (void *)(arg2),	\
+					(void *)(arg3)) :		\
+	 func(arg1, arg2, arg3))
+
 /*
  * Functions to return the top of the kernel stack if we are using the
  * user page-table (and thus not running with the kernel stack). If we
@@ -66,6 +73,16 @@ void run_idt_errcode(void (*func)(struct pt_regs *, unsigned long),
 	CALL_ON_STACK_2(pti_kernel_stack(regs), func, regs, error_code);
 }
 
+static __always_inline
+void run_idt_pagefault(void (*func)(struct pt_regs *, unsigned long,
+				    unsigned long),
+		       struct pt_regs *regs, unsigned long error_code,
+		       unsigned long address)
+{
+	CALL_ON_STACK_3(pti_kernel_stack(regs),
+			func, regs, error_code, address);
+}
+
 static __always_inline
 void run_sysvec(void (*func)(struct pt_regs *regs), struct pt_regs *regs)
 {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 82bf37a5c9ec..b9d03603d95d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1482,7 +1482,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	state = irqentry_enter(regs);
 
 	instrumentation_begin();
-	handle_page_fault(regs, error_code, address);
+	run_idt_pagefault(handle_page_fault, regs, error_code, address);
 	instrumentation_end();
 
 	irqentry_exit(regs, state);
-- 
2.18.4

