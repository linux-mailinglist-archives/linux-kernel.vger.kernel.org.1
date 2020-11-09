Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55F2AB6AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgKILXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:23:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41034 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbgKILXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:23:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BFuNb114316;
        Mon, 9 Nov 2020 11:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=RRND8vwCyLglLYQJMzwbQiEDAiTyWUouQaXnoVUx7c4=;
 b=Z1zx0GzaGmrytj2vg/GjbNxtMFMn/Ot8mtC+HVuGNuefA9bQ6xpm9lonA4WIlOw8M9zW
 TieZY7KZlwUbmGcZNbuI7KS6ZxiKny1yIh1nnPRNdw1F111GWsTcmF3yxqqCTn4V73v3
 SLnBtYr6DWYZnbDcz0F2rGvZa2ZWmYE4f9otzB48O4+6c7eo00At+dbRh39148EjNWk6
 Qo0U/QadXCOpTuWewuqoPRZai7eKOFWB9RoceQGQO9v3hsKlKm75IYkKIZUSyiMr5IYO
 uykD/WzhiYrbmHVo+7kHP6+NTdCH31p5zyG2Z5AZ9DXbJaV8NxXe8zHhSp/ztAbX/Kl7 Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72ebk5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL85Q177446;
        Mon, 9 Nov 2020 11:22:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34p55ku2we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9BMbHe016272;
        Mon, 9 Nov 2020 11:22:37 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:36 -0800
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
Subject: [RFC][PATCH 21/24] x86/entry: Disable stack-protector for IST entry C handlers
Date:   Mon,  9 Nov 2020 12:23:16 +0100
Message-Id: <20201109112319.264511-22-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
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

