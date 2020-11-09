Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801CD2ABF09
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgKIOnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:43:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34100 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbgKIOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:43:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EXvLP091841;
        Mon, 9 Nov 2020 14:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=9TWWjwkfu9F/ySTYsJtJ2LuvzQvQq+BpJk4zFNHutzs=;
 b=NIr+HGu9ZhOT/qqkNr0lk6QRQO+T02cQQn1j/TVknueQZ08l3SQRemacdvuZhbF0JE6d
 sXb4FTimBOGTkaRLhl7UfEdORSpMGCVR/XUSQ+28GQ/r66BmU7h7QX/UtzqjlqaJ5Ssg
 63OBpP5V+V/zciLz7OX5qKiuLN2nTJA5L3G5izDk5i0bo9AEVzSjAt4MT3z7hxe2HoRc
 AS7t8LLvYwdu+yHIIAxD0tpm0bUaOwWk9UufamxVzedUx3TnDbZdvlP+Fkr4+4ZPJx31
 CesRexaDybYdoN9hPi6o0Ipmh3hjWCOY79Ri+ItL9AD/p4WuohQJ77BhogzehNIdZiuX ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3ape7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:43:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Ef2W4139153;
        Mon, 9 Nov 2020 14:43:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34p5bqkare-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:14 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9EhDWS031652;
        Mon, 9 Nov 2020 14:43:13 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:12 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 13/24] x86/pti: Extend PTI user mappings
Date:   Mon,  9 Nov 2020 15:44:14 +0100
Message-Id: <20201109144425.270789-14-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=16 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=7 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090102
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

