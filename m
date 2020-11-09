Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91A82AB6AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgKILXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:23:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44916 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgKILXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:23:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BDrJV109844;
        Mon, 9 Nov 2020 11:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=e3RqeI34JI/cQCUfvJ7qYay9adrF4lZ/AYIFC9PXrJE=;
 b=sg4zBF9+QJLUkHCiOgsvW2/DcSZXq7s9H4ycLilUbKOAs1OAG+2nFYuiMbm/COZMqiNb
 pLoCJHzjqfGv3jDFMKvgmqooACwj1VUyR/MFaSuJiPwrLuMO/1FDT0slhTi3sWBLmbOZ
 x0yPFyo3EwHrz7gaSs0cpA7IIl+FOuTsj6JfUx8FYchG9RwFEVdof3w3umt+yUnSLh+Q
 W2do9xhAhB9EsPTO2Prau0GHiLaPhfnL0fjoSvwh3Yz4fB87lpi25XqgNp9umAuuDz4F
 KYjHz1XRQYYrXg/+9gSWshjfzldv3fJgEsa3NWnojoJwhuintL2xuo+L5vfWHjjMT2b5 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3ankr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL1MZ109419;
        Mon, 9 Nov 2020 11:22:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34p5bqd154-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:25 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9BMOCo016115;
        Mon, 9 Nov 2020 11:22:24 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:24 -0800
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
Subject: [RFC][PATCH 18/24] x86/pti: Execute system vector handlers on the kernel stack
Date:   Mon,  9 Nov 2020 12:23:13 +0100
Message-Id: <20201109112319.264511-19-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
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

