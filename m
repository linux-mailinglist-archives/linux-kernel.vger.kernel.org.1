Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B22B464C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgKPOrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:47:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56324 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgKPOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:47:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjhNV034338;
        Mon, 16 Nov 2020 14:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=e3RqeI34JI/cQCUfvJ7qYay9adrF4lZ/AYIFC9PXrJE=;
 b=k+wrcO9b1m0VI/XL0sJjVzw419pLUdtm4i4o6pWBFfCamHPa+PIKChYfPRUn6tnLqd5E
 TQx09YKYjv4c2cJPdHjBUphdUjtlvRClozhQvC9C5jzqIl1WBALK9wqsoHwDtr5iLuDb
 OsKrqXM4qd2/K/qqqiLSS5yqHx3CZd0wpEu6dL44Og1XdPLVAysVr05hFzhy/gh2YOlW
 RuH32DFydXokMOhZiPaHE8FhC2l9TesQCV9hBD75pSKsQZHWD9skNI1mm7HqcO5W8M9f
 RG31xqAfhjZgJTmLgkhCO/j+BVJbETZahj1nT5tGGKV1n2IhIMFmKgAkgLG/qd3Nfi0i fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34t7vmwaxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:47:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiSkA029534;
        Mon, 16 Nov 2020 14:47:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34ts5us1sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:47:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGElHKS024371;
        Mon, 16 Nov 2020 14:47:17 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:47:16 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 16/21] x86/pti: Execute system vector handlers on the kernel stack
Date:   Mon, 16 Nov 2020 15:47:52 +0100
Message-Id: <20201116144757.1920077-17-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an interrupt/exception in userland, the kernel is entered
and it switches the stack to the PTI stack which is mapped both in
the kernel and in the user page-table. When executing the interrupt
function, switch to the kernel stack (which is mapped only in the
kernel page-table) so that no kernel data leak to the userland
through the stack.

Changes system vector handlers to execute on the kernel stack.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/idtentry.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a82e31b45442..0c5d9f027112 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -66,6 +66,17 @@ void run_idt_errcode(void (*func)(struct pt_regs *, unsigned long),
 	CALL_ON_STACK_2(pti_kernel_stack(regs), func, regs, error_code);
 }
 
+static __always_inline
+void run_sysvec(void (*func)(struct pt_regs *regs), struct pt_regs *regs)
+{
+	void *stack = pti_kernel_stack(regs);
+
+	if (stack)
+		asm_call_on_stack_1(stack, (void (*)(void))func, regs);
+	else
+		run_sysvec_on_irqstack_cond(func, regs);
+}
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -295,7 +306,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_sysvec_on_irqstack_cond(__##func, regs);			\
+	run_sysvec(__##func, regs);					\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
-- 
2.18.4

