Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393552AB6B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgKILYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:24:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46000 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbgKILYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:24:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BE1Dj109992;
        Mon, 9 Nov 2020 11:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=4S8SgdDR3pFNDkoUDRIY1QDyIkmivlrOJFce4B1D2Gw=;
 b=EtwoYD9bOtiy8jCR0hQn7FQ7VXnvtZ0lOzQ4c0HfdFY+Zta2BOhPuNbUzwZS5uXC4Ccb
 5ZrReyHuR+Fqtj69JT/PJKLF6Ecwv4IoNJPQDiexUVorxdpq5Ss6WrozbnB/IiPiAKFn
 8evzuh1gpuOxsJauqmRD3tZBbGVhjMcsIs9ymWyEp5nhfQ0mdddvrXPCo5VijezSPtFy
 miwTUg/Ngrw5OZG3XpZGqLh3UmJFpvdEo5U4OJbHr4PsvTK65sDAtOjvtpOgu+t1KsCo
 ZXiFHNdmteiuntLAupX38HFlYCMLI97hAueTMiHUNclS7E46m2TsZ2hsRlwY8olgcNU4 og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3ankvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:23:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL8q8177456;
        Mon, 9 Nov 2020 11:21:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34p55ku1gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:21:31 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BLTkr021369;
        Mon, 9 Nov 2020 11:21:29 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:21:29 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     "tglx@linutronix.de"@userv0122.oracle.com,
        "mingo@redhat.com"@userv0122.oracle.com,
        "bp@alien8.de"@userv0122.oracle.com,
        "hpa@zytor.com"@userv0122.oracle.com,
        "x86@kernel.org"@userv0122.oracle.com,
        "dave.hansen@linux.intel.com"@userv0122.oracle.com,
        "luto@kernel.org"@userv0122.oracle.com,
        "peterz@infradead.org"@userv0122.oracle.com,
        "linux-kernel@vger.kernel.org"@userv0122.oracle.com,
        "thomas.lendacky@amd.com"@userv0122.oracle.com,
        "jroedel@suse.de"@userv0122.oracle.com
Cc:     "konrad.wilk@oracle.com"@userv0122.oracle.com,
        "jan.setjeeilers@oracle.com"@userv0122.oracle.com,
        "junaids@google.com"@userv0122.oracle.com,
        "oweisse@google.com"@userv0122.oracle.com,
        "rppt@linux.vnet.ibm.com"@userv0122.oracle.com,
        "graf@amazon.de"@userv0122.oracle.com,
        "mgross@linux.intel.com"@userv0122.oracle.com,
        "kuzuno@gmail.com"@userv0122.oracle.com,
        "alexandre.chartre@oracle.com"@userv0122.oracle.com
Subject: [RFC][PATCH 05/24] x86/entry: Implement ret_from_fork body with C code
Date:   Mon,  9 Nov 2020 12:23:00 +0100
Message-Id: <20201109112319.264511-6-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
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

