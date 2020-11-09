Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7468D2AB6AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgKILXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:23:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57234 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgKILXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:23:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BDmN3007878;
        Mon, 9 Nov 2020 11:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=dKQ466ogBF9iT/YuvPk6WnvLNXJ9RBbRcizvTSCI/IU=;
 b=pdOWMqOymvIGHp67JjKBcZHvQIPtY4z2yw+r8RQPrBMgvoST/NBDDRwCPZHhNSALQwDj
 YZ092lLtp5BlG8UzPeYEs3sdSQnQOpRiOGqa5jT48lDiQxCGQMNQIf9z2tytjOmrY4FQ
 kTsugqwDH8wnx1rEM+ha/nCm5bjKSDLx0WwbGvwfdV3h3xzDpvOdDZm6oajH8EMKRpaR
 esVHSdVa4dEs7+1eLAMbySval0Ys8+a/XWr2xpIC7PF19RlNiYQrL90zYo+DDcdg+BPL
 JqcSIJJ4YxiiC7mZ8jbOaqOiuI80cdeCqYi/kHdkwKSlhV3Nb3IC/v92kYEOHv++tGel hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34nkhknd5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL8GU177484;
        Mon, 9 Nov 2020 11:22:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34p55ku2sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:30 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9BMSAD029242;
        Mon, 9 Nov 2020 11:22:28 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:28 -0800
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
Subject: [RFC][PATCH 19/24] x86/pti: Execute page fault handler on the kernel stack
Date:   Mon,  9 Nov 2020 12:23:14 +0100
Message-Id: <20201109112319.264511-20-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
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

