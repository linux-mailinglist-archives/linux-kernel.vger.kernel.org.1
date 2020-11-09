Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436602AB6B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgKILX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:23:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57596 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKILX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:23:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BDjMB007848;
        Mon, 9 Nov 2020 11:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ryvWaG1782WKgVsMLYPwWu2kVN8a7+9SPhrGbXw+dpw=;
 b=XAhZAOLoL/cWS9absXSXqvueiQap/8Q3kpTuEYTdwXJ818N/z66YEXdtRQeX6y6CRZq/
 8CMQADErKedm3gHzEsk61oRIK3jPJjXXG7oZ/WP1xfjQ+O7F9gzkq+B3/j9bA7yjXvVL
 Koi1SgW+Q67Tgqfz5wTe0VAf89FeAN8/UqL0QZaRzKAmg1gLFmKfJBSs2lByZ8kANETX
 QblnRY4B8jBKfpevsXPRkafVKYhMdddmEhlNHXcamDHcf6366lHWHegkfjVaxNHpOZlZ
 d1wjEWbtAfnSaFQDtjMc8ccAw72f5a+v5WdH4ytdLs3ISq+KvpdkQLgCMsGbMVjrj8X5 1A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34nkhknd63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BL7uT177430;
        Mon, 9 Nov 2020 11:22:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34p55ku311-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BMj1N022011;
        Mon, 9 Nov 2020 11:22:45 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:45 -0800
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
Subject: [RFC][PATCH 23/24] x86/entry: Remove paranoid_entry and paranoid_exit
Date:   Mon,  9 Nov 2020 12:23:18 +0100
Message-Id: <20201109112319.264511-24-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=626 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=640 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paranoid_entry and paranoid_exit assembly functions have been
replaced by the kernel_paranoid_entry() and kernel_paranoid_exit()
C functions. Now paranoid_entry/exit are not used anymore and can
be removed.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S | 131 --------------------------------------
 1 file changed, 131 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9ea8187d4405..797effbe65b6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -882,137 +882,6 @@ SYM_CODE_START(xen_failsafe_callback)
 SYM_CODE_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
-/*
- * Save all registers in pt_regs. Return GSBASE related information
- * in EBX depending on the availability of the FSGSBASE instructions:
- *
- * FSGSBASE	R/EBX
- *     N        0 -> SWAPGS on exit
- *              1 -> no SWAPGS on exit
- *
- *     Y        GSBASE value at entry, must be restored in paranoid_exit
- */
-SYM_CODE_START_LOCAL(paranoid_entry)
-	UNWIND_HINT_FUNC
-	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
-
-	/*
-	 * Always stash CR3 in %r14.  This value will be restored,
-	 * verbatim, at exit.  Needed if paranoid_entry interrupted
-	 * another entry that already switched to the user CR3 value
-	 * but has not yet returned to userspace.
-	 *
-	 * This is also why CS (stashed in the "iret frame" by the
-	 * hardware at entry) can not be used: this may be a return
-	 * to kernel code, but with a user CR3 value.
-	 *
-	 * Switching CR3 does not depend on kernel GSBASE so it can
-	 * be done before switching to the kernel GSBASE. This is
-	 * required for FSGSBASE because the kernel GSBASE has to
-	 * be retrieved from a kernel internal table.
-	 */
-	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
-
-	/*
-	 * Handling GSBASE depends on the availability of FSGSBASE.
-	 *
-	 * Without FSGSBASE the kernel enforces that negative GSBASE
-	 * values indicate kernel GSBASE. With FSGSBASE no assumptions
-	 * can be made about the GSBASE value when entering from user
-	 * space.
-	 */
-	ALTERNATIVE "jmp .Lparanoid_entry_checkgs", "", X86_FEATURE_FSGSBASE
-
-	/*
-	 * Read the current GSBASE and store it in %rbx unconditionally,
-	 * retrieve and set the current CPUs kernel GSBASE. The stored value
-	 * has to be restored in paranoid_exit unconditionally.
-	 *
-	 * The unconditional write to GS base below ensures that no subsequent
-	 * loads based on a mispredicted GS base can happen, therefore no LFENCE
-	 * is needed here.
-	 */
-	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
-	ret
-
-.Lparanoid_entry_checkgs:
-	/* EBX = 1 -> kernel GSBASE active, no restore required */
-	movl	$1, %ebx
-	/*
-	 * The kernel-enforced convention is a negative GSBASE indicates
-	 * a kernel value. No SWAPGS needed on entry and exit.
-	 */
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	jns	.Lparanoid_entry_swapgs
-	ret
-
-.Lparanoid_entry_swapgs:
-	SWAPGS
-
-	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
-	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
-
-	/* EBX = 0 -> SWAPGS required on exit */
-	xorl	%ebx, %ebx
-	ret
-SYM_CODE_END(paranoid_entry)
-
-/*
- * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from non-NMI IST interrupts that came
- * from kernel space.
- *
- * We may be returning to very strange contexts (e.g. very early
- * in syscall entry), so checking for preemption here would
- * be complicated.  Fortunately, there's no good reason to try
- * to handle preemption here.
- *
- * R/EBX contains the GSBASE related information depending on the
- * availability of the FSGSBASE instructions:
- *
- * FSGSBASE	R/EBX
- *     N        0 -> SWAPGS on exit
- *              1 -> no SWAPGS on exit
- *
- *     Y        User space GSBASE, must be restored unconditionally
- */
-SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS
-	/*
-	 * The order of operations is important. RESTORE_CR3 requires
-	 * kernel GSBASE.
-	 *
-	 * NB to anyone to try to optimize this code: this code does
-	 * not execute at all for exceptions from user mode. Those
-	 * exceptions go through error_exit instead.
-	 */
-	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
-
-	/* Handle the three GSBASE cases */
-	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
-
-	/* With FSGSBASE enabled, unconditionally restore GSBASE */
-	wrgsbase	%rbx
-	jmp		restore_regs_and_return_to_kernel
-
-.Lparanoid_exit_checkgs:
-	/* On non-FSGSBASE systems, conditionally do SWAPGS */
-	testl		%ebx, %ebx
-	jnz		restore_regs_and_return_to_kernel
-
-	/* We are returning to a context with user GSBASE */
-	SWAPGS_UNSAFE_STACK
-	jmp		restore_regs_and_return_to_kernel
-SYM_CODE_END(paranoid_exit)
-
 /*
  * Save all registers in pt_regs, and switch GS if needed.
  */
-- 
2.18.4

