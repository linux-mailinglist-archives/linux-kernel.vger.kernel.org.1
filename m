Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9172ABF05
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgKIOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:43:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbgKIOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:43:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EY9UH185597;
        Mon, 9 Nov 2020 14:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=p4R8nLWOs2vkO+6HlDcqNih14bw3ltF29xBzgLx3pDA=;
 b=My1l405s5D1hteip85F9WUFuhgUnWK5d4S0mgssEeEZvItgtPDhzswWEch1451MiYdup
 s277zZjveo3bKIiXxyoyWODBDYhqUQBysZDHHTQH/+wXk41NgZjMo7JRTjkNjOPTwNgV
 a0FW6KXBsEithCGKGIXSRY9Y3x06fgmA3J+i0aYnYx5fl2bQaPwbLgeWq99wQ79vxkd1
 VHYSlwhnEtv1LfVIywIeRC1GBS9GL+++LvhxyyxKmrbUY43u7m+glY540xwYwdfkaJw/
 1f1tcSFac6ocTpxXRGoZyzILJBF30BSp5mt9GtLM0DfTYL3XWQ80wdWwnWCM43GhE7BJ 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhkp7pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:42:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ee5Ri154730;
        Mon, 9 Nov 2020 14:42:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gvbb8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:42:49 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9Eglt3023745;
        Mon, 9 Nov 2020 14:42:47 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:42:46 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 07/24] x86/entry: Fill ESPFIX stack using C code
Date:   Mon,  9 Nov 2020 15:44:08 +0100
Message-Id: <20201109144425.270789-8-alexandre.chartre@oracle.com>
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
 definitions=main-2011090102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ESPFIX stack is filled using assembly code. Move this code to a C
function so that it is easier to read and modify.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S   | 62 ++++++++++++++++++-------------------
 arch/x86/kernel/espfix_64.c | 41 ++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 31 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 73e9cd47dc83..6e0b5b010e0b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -684,8 +684,10 @@ native_irq_return_ldt:
 	 * long (see ESPFIX_STACK_SIZE).  espfix_waddr points to the bottom
 	 * of the ESPFIX stack.
 	 *
-	 * We clobber RAX and RDI in this code.  We stash RDI on the
-	 * normal stack and RAX on the ESPFIX stack.
+	 * We call into C code to fill the ESPFIX stack. We stash registers
+	 * that the C function can clobber on the normal stack. The user RAX
+	 * is stashed first so that it is adjacent to the iret frame which
+	 * will be copied to the ESPFIX stack.
 	 *
 	 * The ESPFIX stack layout we set up looks like this:
 	 *
@@ -699,39 +701,37 @@ native_irq_return_ldt:
 	 * --- bottom of ESPFIX stack ---
 	 */
 
-	pushq	%rdi				/* Stash user RDI */
-	SWAPGS					/* to kernel GS */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi	/* to kernel CR3 */
-
-	movq	PER_CPU_VAR(espfix_waddr), %rdi
-	movq	%rax, (0*8)(%rdi)		/* user RAX */
-	movq	(1*8)(%rsp), %rax		/* user RIP */
-	movq	%rax, (1*8)(%rdi)
-	movq	(2*8)(%rsp), %rax		/* user CS */
-	movq	%rax, (2*8)(%rdi)
-	movq	(3*8)(%rsp), %rax		/* user RFLAGS */
-	movq	%rax, (3*8)(%rdi)
-	movq	(5*8)(%rsp), %rax		/* user SS */
-	movq	%rax, (5*8)(%rdi)
-	movq	(4*8)(%rsp), %rax		/* user RSP */
-	movq	%rax, (4*8)(%rdi)
-	/* Now RAX == RSP. */
-
-	andl	$0xffff0000, %eax		/* RAX = (RSP & 0xffff0000) */
+	/* save registers */
+	pushq	%rax
+	pushq	%rdi
+	pushq	%rsi
+	pushq	%rdx
+	pushq	%rcx
+	pushq	%r8
+	pushq	%r9
+	pushq	%r10
+	pushq	%r11
 
 	/*
-	 * espfix_stack[31:16] == 0.  The page tables are set up such that
-	 * (espfix_stack | (X & 0xffff0000)) points to a read-only alias of
-	 * espfix_waddr for any X.  That is, there are 65536 RO aliases of
-	 * the same page.  Set up RSP so that RSP[31:16] contains the
-	 * respective 16 bits of the /userspace/ RSP and RSP nonetheless
-	 * still points to an RO alias of the ESPFIX stack.
+	 * fill_espfix_stack will copy the iret+rax frame to the ESPFIX
+	 * stack and return with RAX containing a pointer to the ESPFIX
+	 * stack.
 	 */
-	orq	PER_CPU_VAR(espfix_stack), %rax
+	leaq	8*8(%rsp), %rdi		/* points to the iret+rax frame */
+	call	fill_espfix_stack
 
-	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
-	SWAPGS					/* to user GS */
-	popq	%rdi				/* Restore user RDI */
+	/*
+	 * RAX contains a pointer to the ESPFIX, so restore registers but
+	 * RAX. RAX will be restored from the ESPFIX stack.
+	 */
+	popq	%r11
+	popq	%r10
+	popq	%r9
+	popq	%r8
+	popq	%rcx
+	popq	%rdx
+	popq	%rsi
+	popq	%rdi
 
 	movq	%rax, %rsp
 	UNWIND_HINT_IRET_REGS offset=8
diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 4fe7af58cfe1..6a81c4bd1542 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -33,6 +33,7 @@
 #include <asm/pgalloc.h>
 #include <asm/setup.h>
 #include <asm/espfix.h>
+#include <asm/entry-common.h>
 
 /*
  * Note: we only need 6*8 = 48 bytes for the espfix stack, but round
@@ -205,3 +206,43 @@ void init_espfix_ap(int cpu)
 	per_cpu(espfix_waddr, cpu) = (unsigned long)stack_page
 				      + (addr & ~PAGE_MASK);
 }
+
+/*
+ * iret frame with an additional user_rax register.
+ */
+struct iret_rax_frame {
+	unsigned long user_rax;
+	unsigned long rip;
+	unsigned long cs;
+	unsigned long rflags;
+	unsigned long rsp;
+	unsigned long ss;
+};
+
+noinstr unsigned long fill_espfix_stack(struct iret_rax_frame *frame)
+{
+	struct iret_rax_frame *espfix_frame;
+	unsigned long rsp;
+
+	native_swapgs();
+	switch_to_kernel_cr3();
+
+	espfix_frame = (struct iret_rax_frame *)this_cpu_read(espfix_waddr);
+	*espfix_frame = *frame;
+
+	/*
+	 * espfix_stack[31:16] == 0.  The page tables are set up such that
+	 * (espfix_stack | (X & 0xffff0000)) points to a read-only alias of
+	 * espfix_waddr for any X.  That is, there are 65536 RO aliases of
+	 * the same page.  Set up RSP so that RSP[31:16] contains the
+	 * respective 16 bits of the /userspace/ RSP and RSP nonetheless
+	 * still points to an RO alias of the ESPFIX stack.
+	 */
+	rsp = ((unsigned long)espfix_frame) & 0xffff0000;
+	rsp |= this_cpu_read(espfix_stack);
+
+	switch_to_user_cr3();
+	native_swapgs();
+
+	return rsp;
+}
-- 
2.18.4

