Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67B32ABF11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbgKIOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:44:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48096 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732007AbgKIOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:44:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EhkMI194586;
        Mon, 9 Nov 2020 14:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=RRND8vwCyLglLYQJMzwbQiEDAiTyWUouQaXnoVUx7c4=;
 b=vwwiUHF700FRXCIumcpFn5KEPI1gTYbzVCRcRswXSHjV85rE3XYp+0raG/OOia1KAQpl
 pFksD4pyRW9hGsG0lIvEkclhq2JVTD/Eaw/lWbB09gwvxhu5kgVdFycvXo/yIdbMOHQO
 AKL+vk+U2rnAJoSxOVWK49xXzfaD5nNMxQ26hk1gSFYGqFjSoJXGRg+V1VLn88dcd7pb
 /TQiMgV6UCxiNIR2OAbdyOhQpCXfEpSNXoVGag+fUhVmIcLmrxRWJvnUaIqHe51GoXua
 sZT0fua8lKlYnLqBdsRE+n5q6hMGHwfhj7yCrnKvCW6chc405lQ6zU+FSgKdlp7WEXQo ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhkp7v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:43:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ee4kI154679;
        Mon, 9 Nov 2020 14:43:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34p5gvbc7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:47 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9Ehk0n013894;
        Mon, 9 Nov 2020 14:43:46 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:45 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 21/24] x86/entry: Disable stack-protector for IST entry C handlers
Date:   Mon,  9 Nov 2020 15:44:22 +0100
Message-Id: <20201109144425.270789-22-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stack-protector option adds a stack canary to functions vulnerable
to stack buffer overflow. The stack canary is defined through the GS
register. Add an attribute to disable the stack-protector option; it
will be used for C functions which can be called while the GS register
might not be properly configured yet.

The GS register is not properly configured for the kernel when we enter
the kernel from userspace. The assembly entry code sets the GS register
for the kernel using the swapgs instruction or the paranoid_entry function,
and so, currently, the GS register is correctly configured when assembly
entry code subsequently transfer control to C code.

Deferring the CR3 register switch from assembly to C code will require to
reimplement paranoid_entry in C and hence also defer the GS register setup
for IST entries to C code. To prepare this change, disable stack-protector
for IST entry C handlers where the GS register setup will eventually
happen.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/idtentry.h | 25 ++++++++++++++++++++-----
 arch/x86/kernel/nmi.c           |  2 +-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a6725afaaec0..647af7ea3bf1 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -94,6 +94,21 @@ void run_sysvec(void (*func)(struct pt_regs *regs), struct pt_regs *regs)
 		run_sysvec_on_irqstack_cond(func, regs);
 }
 
+/*
+ * Attribute to disable the stack-protector option. The option is
+ * disabled using the optimize attribute which clears all optimize
+ * options. So we need to specify the optimize option to disable but
+ * also optimize options we want to preserve.
+ *
+ * The stack-protector option adds a stack canary to functions
+ * vulnerable to stack buffer overflow. The stack canary is defined
+ * through the GS register. So the attribute is used to disable the
+ * stack-protector option for functions which can be called while the
+ * GS register might not be properly configured yet.
+ */
+#define no_stack_protector	\
+	__attribute__ ((optimize("-O2,-fno-stack-protector,-fno-omit-frame-pointer")))
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -410,7 +425,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * Maps to DEFINE_IDTENTRY_RAW
  */
 #define DEFINE_IDTENTRY_IST(func)					\
-	DEFINE_IDTENTRY_RAW(func)
+	no_stack_protector DEFINE_IDTENTRY_RAW(func)
 
 /**
  * DEFINE_IDTENTRY_NOIST - Emit code for NOIST entry points which
@@ -440,7 +455,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_DF(func)					\
-	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
+	no_stack_protector DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
 /**
  * DEFINE_IDTENTRY_VC_SAFE_STACK - Emit code for VMM communication handler
@@ -472,7 +487,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * VMM communication handler.
  */
 #define DEFINE_IDTENTRY_VC_SETUP_STACK(func)			\
-	__visible noinstr					\
+	no_stack_protector __visible noinstr			\
 	unsigned long setup_stack_##func(struct pt_regs *regs)
 
 /**
@@ -482,7 +497,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_VC(func)					\
-	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
+	no_stack_protector DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
 #else	/* CONFIG_X86_64 */
 
@@ -517,7 +532,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 
 /* C-Code mapping */
 #define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
-#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
+#define DEFINE_IDTENTRY_NMI		no_stack_protector DEFINE_IDTENTRY_RAW
 
 #ifdef CONFIG_X86_64
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index be0f654c3095..b6291b683be1 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -473,7 +473,7 @@ static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
 static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
-DEFINE_IDTENTRY_RAW(exc_nmi)
+DEFINE_IDTENTRY_NMI(exc_nmi)
 {
 	bool irq_state;
 
-- 
2.18.4

