Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97412B4659
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgKPOsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:48:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKPOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:48:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEi63H182831;
        Mon, 16 Nov 2020 14:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=dKQ466ogBF9iT/YuvPk6WnvLNXJ9RBbRcizvTSCI/IU=;
 b=kQbSo56e8ge8i+4y01C2z6F9WAwrQ/aZEUhe1LO5fMYPr6ozftDvcKBFFbQZ2OkfX0+v
 mihmnJsgh83n0ia1LudY3KbqsudqI4Mf0lYrKYoBJmtvMadKbSeZkYGt4RyGPQ9xWRiP
 5RA1P1PoFw0lIXj6LcshYQlxLmt7QsrTv1NKN8k3ot8op4vOhphPqAMPpsR5cygaiNyD
 sz37XZ6Kejzl3P/Ab6G1j2IKunBq4ubif6Iy223S34GiCspGSOzjoJ3xfFzUWMpYXWqS
 kqVFSdPJeFOaUDCZMBRzkeA4uc61xybB/f5oIf2wH5tqiiU4iXVa3VaBr420Cutomk3Q ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34t76kncup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:47:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiScg029591;
        Mon, 16 Nov 2020 14:47:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34ts5us1vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:47:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGElNrb015153;
        Mon, 16 Nov 2020 14:47:24 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:47:23 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 17/21] x86/pti: Execute page fault handler on the kernel stack
Date:   Mon, 16 Nov 2020 15:47:53 +0100
Message-Id: <20201116144757.1920077-18-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
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

