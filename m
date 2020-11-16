Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D312B4655
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgKPOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:48:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56900 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbgKPOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:48:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjYv6034236;
        Mon, 16 Nov 2020 14:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=8aIFM+fL+yGS57Luev6i506IgnxC9JGFRXYGXuRKYiU=;
 b=WxMEnTqpwIofi7edXhIXzC4lLtCAc7QueSxnc5LYaP4FoQM7SgTQbGLQsCCS2kf6Gy2E
 TUwy2dLpna/enXsTxIrPiz1GfxA/AHkDaLcMYDXG4O4GPj6lFe61WVDy2Hl8kXVF4hHv
 Ngsqs90L1nLAoc1BMajqImQsj7Ru2i2S5MZfsEMFh0EosFuiXUJvrljk20EZbTgaaojo
 mgQNMwEETqIb/WlB9YflwdksVKLGEAnu+iyuq/keGf09F1l3GGSV/QZSiwU9mRHKD48U
 yXpGkcqrCt7LV7WT6NTWaOL/Pp2+PPzug4FhXqUpg7OdeHR/heJtacyEd654m/VelNEf RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34t7vmwb1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:47:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjD28164514;
        Mon, 16 Nov 2020 14:45:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34umcww2qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:45:57 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGEjuIJ023620;
        Mon, 16 Nov 2020 14:45:56 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:45:55 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 02/21] x86/entry: Update asm_call_on_stack to support more function arguments
Date:   Mon, 16 Nov 2020 15:47:38 +0100
Message-Id: <20201116144757.1920077-3-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
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

Update the asm_call_on_stack() function so that it can be invoked
with a function having up to three arguments instead of only one.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S        | 15 +++++++++++----
 arch/x86/include/asm/irq_stack.h |  8 ++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cad08703c4ad..c42948aca0a8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -759,9 +759,14 @@ SYM_CODE_END(.Lbad_gs)
 /*
  * rdi: New stack pointer points to the top word of the stack
  * rsi: Function pointer
- * rdx: Function argument (can be NULL if none)
+ * rdx: Function argument 1 (can be NULL if none)
+ * rcx: Function argument 2 (can be NULL if none)
+ * r8 : Function argument 3 (can be NULL if none)
  */
 SYM_FUNC_START(asm_call_on_stack)
+SYM_FUNC_START(asm_call_on_stack_1)
+SYM_FUNC_START(asm_call_on_stack_2)
+SYM_FUNC_START(asm_call_on_stack_3)
 SYM_INNER_LABEL(asm_call_sysvec_on_stack, SYM_L_GLOBAL)
 SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
 	/*
@@ -777,15 +782,17 @@ SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
 	 */
 	mov		%rsp, (%rdi)
 	mov		%rdi, %rsp
-	/* Move the argument to the right place */
+	mov		%rsi, %rax
+	/* Move arguments to the right place */
 	mov		%rdx, %rdi
-
+	mov		%rcx, %rsi
+	mov		%r8, %rdx
 1:
 	.pushsection .discard.instr_begin
 	.long 1b - .
 	.popsection
 
-	CALL_NOSPEC	rsi
+	CALL_NOSPEC	rax
 
 2:
 	.pushsection .discard.instr_end
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 775816965c6a..359427216336 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -13,6 +13,14 @@ static __always_inline bool irqstack_active(void)
 }
 
 void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
+
+void asm_call_on_stack_1(void *sp, void (*func)(void),
+			 void *arg1);
+void asm_call_on_stack_2(void *sp, void (*func)(void),
+			 void *arg1, void *arg2);
+void asm_call_on_stack_3(void *sp, void (*func)(void),
+			 void *arg1, void *arg2, void *arg3);
+
 void asm_call_sysvec_on_stack(void *sp, void (*func)(struct pt_regs *regs),
 			      struct pt_regs *regs);
 void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
-- 
2.18.4

