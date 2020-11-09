Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EBB2ABEFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgKIOmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:42:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33338 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbgKIOmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:42:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EY1D1091893;
        Mon, 9 Nov 2020 14:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=8aIFM+fL+yGS57Luev6i506IgnxC9JGFRXYGXuRKYiU=;
 b=kI/tmuxrKtrowH8TCMyl/s0Gq6foVPynWFMiHdlBTPNXZECF8Nmlg3tuBs58+MZ5ZSX9
 ikoqhUJebUaJYRGUQLM3HE7fJOFaHHuK7ORVUbajfCkz2QwGLdY/flqAsXKCmjWFW4un
 8fvDvN/3yuYhcrQ0u0Kc4pzPs/vNA+S4rXKYEEUkl0TXYat65xrLGY5SqJls4MEtHULJ
 XBmmS9+vk7l5GrVc2RWnYNOMxZ2f6PzFtXbcSCm137DCI/lwFvVME1Df4YN00d/Gs5Uc
 24Gyw3U4VXESA5ArLKflG/aeky5JFGt73GqnB9hLOzisKFsR+0AxLK3prz8wiid1tJXU kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3ape38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:42:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ef9rb016456;
        Mon, 9 Nov 2020 14:42:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34p55m18d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:42:27 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9EgP6F031209;
        Mon, 9 Nov 2020 14:42:25 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:42:25 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 02/24] x86/entry: Update asm_call_on_stack to support more function arguments
Date:   Mon,  9 Nov 2020 15:44:03 +0100
Message-Id: <20201109144425.270789-3-alexandre.chartre@oracle.com>
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

