Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA92ABF10
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbgKIOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:44:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35228 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbgKIOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:44:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EZBJL084167;
        Mon, 9 Nov 2020 14:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=4S8SgdDR3pFNDkoUDRIY1QDyIkmivlrOJFce4B1D2Gw=;
 b=BOw2UsNLZ/qUfJ+Evhp0zLlgVouu4AbwKc46Ay7g0Q1RCNG0shWexAynh2e8zO/MD4Mp
 HwQmsYuM3HhF86ez7adRfEeBrZPHHQ6Xycbken1ADHZ3li6koyMSM6iTQuJ8EcIftYmh
 cKBVoBZivtrsV2hwaiaY53qA+u5cl+9gy23q4lHjOHB2uV7Q7fN6t1P+Fy9l7Ic59dNb
 3QShgZA1/+ivgW8ljbloE6RjPhK+RlCKnar5hvUDLYXwp/Xnc9oyw8MDMVWkEZHt4uk9
 0CgmbGwW+1INrZHSLPDoBSSxOtNPjzHsGZnesvYdzBuSj06OJ785OVHuwc3DbSZBc+f5 mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34p72ecdw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:42:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ef2MX139201;
        Mon, 9 Nov 2020 14:42:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34p5bqka6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:42:39 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9Egccs031256;
        Mon, 9 Nov 2020 14:42:38 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:42:37 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 05/24] x86/entry: Implement ret_from_fork body with C code
Date:   Mon,  9 Nov 2020 15:44:06 +0100
Message-Id: <20201109144425.270789-6-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret_from_fork is a mix of assembly code and calls to C functions.
Re-implement ret_from_fork so that it calls a single C function.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/common.c   | 18 ++++++++++++++++++
 arch/x86/entry/entry_64.S | 28 +++++-----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index d222212908ad..7ee15a12c115 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -35,6 +35,24 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
+__visible noinstr void return_from_fork(struct pt_regs *regs,
+					struct task_struct *prev,
+					void (*kfunc)(void *), void *kargs)
+{
+	schedule_tail(prev);
+	if (kfunc) {
+		/* kernel thread */
+		kfunc(kargs);
+		/*
+		 * A kernel thread is allowed to return here after
+		 * successfully calling kernel_execve(). Exit to
+		 * userspace to complete the execve() syscall.
+		 */
+		regs->ax = 0;
+	}
+	syscall_exit_to_user_mode(regs);
+}
+
 static __always_inline void run_syscall(sys_call_ptr_t sysfunc,
 					struct pt_regs *regs)
 {
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 274384644b5e..73e9cd47dc83 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -276,31 +276,13 @@ SYM_FUNC_END(__switch_to_asm)
  */
 .pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
-	UNWIND_HINT_EMPTY
-	movq	%rax, %rdi
-	call	schedule_tail			/* rdi: 'prev' task parameter */
-
-	testq	%rbx, %rbx			/* from kernel_thread? */
-	jnz	1f				/* kernel threads are uncommon */
-
-2:
 	UNWIND_HINT_REGS
-	movq	%rsp, %rdi
-	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
+	movq	%rsp, %rdi			/* pt_regs */
+	movq	%rax, %rsi			/* 'prev' task parameter */
+	movq	%rbx, %rdx			/* kernel thread func */
+	movq	%r12, %rcx			/* kernel thread arg */
+	call	return_from_fork		/* returns with IRQs disabled */
 	jmp	swapgs_restore_regs_and_return_to_usermode
-
-1:
-	/* kernel thread */
-	UNWIND_HINT_EMPTY
-	movq	%r12, %rdi
-	CALL_NOSPEC rbx
-	/*
-	 * A kernel thread is allowed to return here after successfully
-	 * calling kernel_execve().  Exit to userspace to complete the execve()
-	 * syscall.
-	 */
-	movq	$0, RAX(%rsp)
-	jmp	2b
 SYM_CODE_END(ret_from_fork)
 .popsection
 
-- 
2.18.4

