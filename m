Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9EC2B465B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgKPOtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:49:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39240 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKPOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:49:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEi5ot182796;
        Mon, 16 Nov 2020 14:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=R1TqoZHvDh8qLTxJhAMo8ZAKxPrlOcPw3pPtAOyZy9k=;
 b=boUGVzLJ/pF9H2QMIIpw+ctpeukP97aozHTbvU3hpn/L5uCVuqqfyUGGVgX1Fc6uoMPz
 TTXylxn0Wep94tO5u+ZxpQc5eqn4fNFimnlqC/2N7rzCFfOyB0YttyGH99U5pV0aB1gU
 Jr71Ev5ASMlfufaCbO0fFpB4sR8wUvcrwx4Q5DfS4yYbB3rx7cV3acHmEcUC1dEvyNZg
 cOW5rbOd0txpbALnNszFeag3PJQvExOlgLmzVn5KSaEbXMYp40gfBuXDOv0zXh9ONRNX
 sJw6aIkKkDjH67nbE1XyE61omHPosDM9FJ2/cPkscPO3BeIstLg+QuMJ9lJy0/5L93gK qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34t76knd4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:48:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiTsP029734;
        Mon, 16 Nov 2020 14:46:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34ts5us1aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:46:50 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGEkn5Y024084;
        Mon, 16 Nov 2020 14:46:49 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:46:48 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 11/21] x86/pti: Extend PTI user mappings
Date:   Mon, 16 Nov 2020 15:47:47 +0100
Message-Id: <20201116144757.1920077-12-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=22 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=6 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
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
 arch/x86/mm/pti.c         | 19 +++++++++++++++++++
 kernel/fork.c             | 22 ++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

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
index 71ca245d7b38..e4c6cb4a4840 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -449,6 +449,7 @@ static void __init pti_clone_percpu_page(void *addr)
  */
 static void __init pti_clone_user_shared(void)
 {
+	unsigned long start, end;
 	unsigned int cpu;
 
 	pti_clone_p4d(CPU_ENTRY_AREA_BASE);
@@ -465,7 +466,16 @@ static void __init pti_clone_user_shared(void)
 		 */
 		pti_clone_percpu_page(&per_cpu(cpu_tss_rw, cpu));
 
+		/*
+		 * Map fixed_percpu_data to get the stack canary.
+		 */
+		if (IS_ENABLED(CONFIG_STACKPROTECTOR))
+			pti_clone_percpu_page(&per_cpu(fixed_percpu_data, cpu));
 	}
+
+	start = (unsigned long)__per_cpu_offset;
+	end = start + sizeof(__per_cpu_offset);
+	pti_clone_init_pgtable(start, end, PTI_CLONE_PTE);
 }
 
 #else /* CONFIG_X86_64 */
@@ -505,6 +515,15 @@ static void pti_clone_entry_text(void)
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

