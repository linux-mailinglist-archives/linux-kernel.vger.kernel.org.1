Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD592AB6A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgKILWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:22:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:22:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BDwsP007954;
        Mon, 9 Nov 2020 11:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=9TWWjwkfu9F/ySTYsJtJ2LuvzQvQq+BpJk4zFNHutzs=;
 b=F18mH+LL4Sf9BISv9SS/UcUDAVYgUR3qKJOD9jhF0E2W3ChazsZFdjRWnPp/0MIZoxUD
 9HTD1PRr8WQN+gupTXS82BVkxTEPAes4hW+QQWyo1LIRHEXEjvhexyvpbRlHICy3H27v
 BAYAfXajLqtxrqOX1Rr9RT+xBbiQRG+N8S2zlwGLzyo3E2NjPe8SM3qQGFG6LXpgr3Bx
 lKscERY4h1JyvdNqrW82JFnMJXr2zhCSTYLAIT6pyQdSfAjJvEIPA1j1WWbmoIWO5pEH
 NxkwzZcFN4Sxsc4zodi0MWTYQoEfncyXBPoctpaZaJO9JImipbj/nj6v7BJQ0ewgg1eR hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhknd42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BK4kE116394;
        Mon, 9 Nov 2020 11:22:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34p5gv4x2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:05 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9BM4XH016043;
        Mon, 9 Nov 2020 11:22:04 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:03 -0800
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
Subject: [RFC][PATCH 13/24] x86/pti: Extend PTI user mappings
Date:   Mon,  9 Nov 2020 12:23:08 +0100
Message-Id: <20201109112319.264511-14-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend PTI user mappings so that more kernel entry code can be executed
with the user page-table. To do so, we need to map syscall and interrupt
entry code, per cpu offsets (__per_cpu_offset, which is used some in
entry code), the stack canary, and the PTI stack (which is defined per
task).

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S |  2 --
 arch/x86/mm/pti.c         | 14 ++++++++++++++
 kernel/fork.c             | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6e0b5b010e0b..458af12ed9a1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -274,7 +274,6 @@ SYM_FUNC_END(__switch_to_asm)
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
  */
-.pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_REGS
 	movq	%rsp, %rdi			/* pt_regs */
@@ -284,7 +283,6 @@ SYM_CODE_START(ret_from_fork)
 	call	return_from_fork		/* returns with IRQs disabled */
 	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(ret_from_fork)
-.popsection
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 71ca245d7b38..f4f3d9ae4449 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -465,6 +465,11 @@ static void __init pti_clone_user_shared(void)
 		 */
 		pti_clone_percpu_page(&per_cpu(cpu_tss_rw, cpu));
 
+		/*
+		 * Map fixed_percpu_data to get the stack canary.
+		 */
+		if (IS_ENABLED(CONFIG_STACKPROTECTOR))
+			pti_clone_percpu_page(&per_cpu(fixed_percpu_data, cpu));
 	}
 }
 
@@ -505,6 +510,15 @@ static void pti_clone_entry_text(void)
 	pti_clone_init_pgtable((unsigned long) __entry_text_start,
 			       (unsigned long) __entry_text_end,
 			       PTI_CLONE_PMD);
+
+       /*
+	* Syscall and interrupt entry code (which is in the noinstr
+	* section) will be entered with the user page-table, so that
+	* code has to be mapped in.
+	*/
+	pti_clone_init_pgtable((unsigned long) __noinstr_text_start,
+			       (unsigned long) __noinstr_text_end,
+			       PTI_CLONE_PMD);
 }
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 6d266388d380..31cd77dbdba3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -999,6 +999,25 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 #endif
 }
 
+static void mm_map_task(struct mm_struct *mm, struct task_struct *tsk)
+{
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	unsigned long addr;
+
+	if (!tsk || !static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	/*
+	 * Map the task stack after the kernel stack into the user
+	 * address space, so that this stack can be used when entering
+	 * syscall or interrupt from user mode.
+	 */
+	BUG_ON(!task_stack_page(tsk));
+	addr = (unsigned long)task_top_of_kernel_stack(tsk);
+	pti_clone_pgtable(mm, addr, addr + KERNEL_STACK_SIZE, PTI_CLONE_PTE);
+#endif
+}
+
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
@@ -1043,6 +1062,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
+	mm_map_task(mm, p);
+
 	mm->user_ns = get_user_ns(user_ns);
 	return mm;
 
@@ -1404,6 +1425,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	vmacache_flush(tsk);
 
 	if (clone_flags & CLONE_VM) {
+		mm_map_task(oldmm, tsk);
 		mmget(oldmm);
 		mm = oldmm;
 		goto good_mm;
-- 
2.18.4

