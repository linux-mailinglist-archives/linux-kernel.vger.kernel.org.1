Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107802B4657
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgKPOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:48:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34478 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbgKPOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:48:26 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiAxd131259;
        Mon, 16 Nov 2020 14:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=sOl1NrqxnkQBFnwPcq/gtOcrZaMFHISy5WUH367/Sjo=;
 b=LjW15mGAM+VZsIm9udkIhhsOKKMYTWuQqLk1Mx7b3Pav+WGPSGNDU4S2E1bhO8M22S6T
 DxFyY03gpz1MfIhTq9DqxsYtcjmLnWrbqm0hpaHBgiL/U7BzrlCssM1e2SSQc0JDrdXD
 wjiklOf+rca7CbSgOgt/+xzc6gP0Cjj1s8j5Mm2biKorii4lwHxFcGdpaYsjm2RKaWrC
 2v1kZ4Ajl/FRHQH10DPqdrecerSbb82h1YIvt6Vkr9YLCbJ+cjdF5wJygHqdQ4v3Pze+
 x2q4tS/ekJ50ZFI+tqUNSej/Ytbr5S8S1gnNB4eoI+Zy9fXh7eT1O76WyLozlJHj8Izh Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34t4ranhr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:48:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjQiu051832;
        Mon, 16 Nov 2020 14:48:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34ts0phcnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:48:05 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGEm3vc016122;
        Mon, 16 Nov 2020 14:48:04 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:48:02 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 21/21] x86/pti: Use a different stack canary with the user and kernel page-table
Date:   Mon, 16 Nov 2020 15:47:57 +0100
Message-Id: <20201116144757.1920077-22-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using stack protector requires the stack canary to be mapped into
the current page-table. Now that the page-table switch between the
user and kernel page-table is deferred to C code, stack protector can
be used while the user page-table is active and so the stack canary
is mapped into the user page-table.

To prevent leaking the stack canary used with the kernel page-table,
use a different canary with the user and kernel page-table. The stack
canary is changed when switching the page-table.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/entry-common.h   | 56 ++++++++++++++++++++++++++-
 arch/x86/include/asm/stackprotector.h | 35 +++++++++++------
 arch/x86/kernel/sev-es.c              | 18 +++++++++
 include/linux/sched.h                 |  8 ++++
 kernel/fork.c                         |  3 ++
 5 files changed, 107 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index e01735a181b8..5b4d0e3237a3 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -96,6 +96,52 @@ static __always_inline void arch_exit_to_user_mode(void)
 #define PTI_USER_PGTABLE_AND_PCID_MASK  \
 	(PTI_USER_PCID_MASK | PTI_USER_PGTABLE_MASK)
 
+/*
+ * Functions to set the stack canary to the kernel or user value:
+ *
+ * The kernel stack canary should be used when running with the kernel
+ * page-table, and the user stack canary should be used when running
+ * with the user page-table. Also the kernel stack canary should not
+ * leak to the user page-table.
+ *
+ * So the stack canary should be set to the kernel value when entering
+ * the kernel from userspace *after* switching to the kernel page-table.
+ * And the stack canary should be set to the user value when returning
+ * to userspace *before* switching to the user page-table.
+ *
+ * In both cases, there is a window (between the page-table switch and
+ * the stack canary setting) where we will be running with the kernel
+ * page-table and the user stack canary. This window should be as small
+ * as possible and, ideally, it should:
+ * - not call functions which require the stack protector to be used;
+ * - have interrupt disabled to prevent interrupt handlers from being
+ *   processed with the user stack canary (but there is nothing we can
+ *   do for NMIs).
+ */
+static __always_inline void set_stack_canary_kernel(void)
+{
+	this_cpu_write(fixed_percpu_data.stack_canary,
+		       current->stack_canary);
+}
+
+static __always_inline void set_stack_canary_user(void)
+{
+	this_cpu_write(fixed_percpu_data.stack_canary,
+		       current->stack_canary_user);
+}
+
+static __always_inline void switch_to_kernel_stack_canary(unsigned long cr3)
+{
+	if (cr3 & PTI_USER_PGTABLE_MASK)
+		set_stack_canary_kernel();
+}
+
+static __always_inline void restore_stack_canary(unsigned long cr3)
+{
+	if (cr3 & PTI_USER_PGTABLE_MASK)
+		set_stack_canary_user();
+}
+
 static __always_inline void write_kernel_cr3(unsigned long cr3)
 {
 	if (static_cpu_has(X86_FEATURE_PCID))
@@ -155,8 +201,10 @@ static __always_inline unsigned long save_and_switch_to_kernel_cr3(void)
 		return 0;
 
 	cr3 = __native_read_cr3();
-	if (cr3 & PTI_USER_PGTABLE_MASK)
+	if (cr3 & PTI_USER_PGTABLE_MASK) {
 		switch_to_kernel_cr3(cr3);
+		set_stack_canary_kernel();
+	}
 
 	return cr3;
 }
@@ -167,6 +215,7 @@ static __always_inline void restore_cr3(unsigned long cr3)
 		return;
 
 	if (cr3 & PTI_USER_PGTABLE_MASK) {
+		set_stack_canary_user();
 		switch_to_user_cr3(cr3);
 	} else {
 		/*
@@ -182,6 +231,7 @@ static __always_inline void user_pagetable_enter(void)
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
 
+	set_stack_canary_user();
 	switch_to_user_cr3(__native_read_cr3());
 }
 
@@ -191,6 +241,7 @@ static __always_inline void user_pagetable_exit(void)
 		return;
 
 	switch_to_kernel_cr3(__native_read_cr3());
+	set_stack_canary_kernel();
 }
 
 static __always_inline void user_pagetable_return(struct pt_regs *regs)
@@ -218,6 +269,9 @@ static __always_inline void user_pagetable_exit(void) {};
 static __always_inline void user_pagetable_return(struct pt_regs *regs) {};
 static __always_inline void user_pagetable_escape(struct pt_regs *regs) {};
 
+static __always_inline void switch_to_kernel_stack_canary(unsigned long cr3) {}
+static __always_inline void restore_stack_canary(unsigned long cr3) {}
+
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 #endif /* MODULE */
 
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 7fb482f0f25b..be6c051bafe3 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -52,6 +52,25 @@
 #define GDT_STACK_CANARY_INIT						\
 	[GDT_ENTRY_STACK_CANARY] = GDT_ENTRY_INIT(0x4090, 0, 0x18),
 
+static __always_inline u64 boot_get_random_canary(void)
+{
+	u64 canary;
+	u64 tsc;
+
+	/*
+	 * We both use the random pool and the current TSC as a source
+	 * of randomness. The TSC only matters for very early init,
+	 * there it already has some randomness on most systems. Later
+	 * on during the bootup the random pool has true entropy too.
+	 */
+	get_random_bytes(&canary, sizeof(canary));
+	tsc = rdtsc();
+	canary += tsc + (tsc << 32UL);
+	canary &= CANARY_MASK;
+
+	return canary;
+}
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -66,23 +85,15 @@
 static __always_inline void boot_init_stack_canary(void)
 {
 	u64 canary;
-	u64 tsc;
 
 #ifdef CONFIG_X86_64
 	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
 #endif
-	/*
-	 * We both use the random pool and the current TSC as a source
-	 * of randomness. The TSC only matters for very early init,
-	 * there it already has some randomness on most systems. Later
-	 * on during the bootup the random pool has true entropy too.
-	 */
-	get_random_bytes(&canary, sizeof(canary));
-	tsc = rdtsc();
-	canary += tsc + (tsc << 32UL);
-	canary &= CANARY_MASK;
-
+	canary = boot_get_random_canary();
 	current->stack_canary = canary;
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	current->stack_canary_user = boot_get_random_canary();
+#endif
 #ifdef CONFIG_X86_64
 	this_cpu_write(fixed_percpu_data.stack_canary, canary);
 #else
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 59fc7c472525..614fbef497bd 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -1387,6 +1387,14 @@ DEFINE_IDTENTRY_VC_SETUP_STACK(exc_vmm_communication)
 	frame->regs = *regs;
 	frame->saved_cr3 = saved_cr3;
 
+	/*
+	 * save_and_switch_to_kernel_cr3() has switched the stack canary
+	 * to the kernel stack canary. However, depending on the saved
+	 * CR3 value, this function may have been entered with the user
+	 * stack canary. So restore the stack canary before returning.
+	 */
+	restore_stack_canary(saved_cr3);
+
 	return sp;
 }
 
@@ -1394,6 +1402,16 @@ DEFINE_IDTENTRY_VC(exc_vmm_communication)
 {
 	struct exc_vc_frame *frame = (struct exc_vc_frame *)regs;
 
+	/*
+	 * The VC setup stack function has switched to the kernel CR3
+	 * but not to the kernel stack canary. Switch to the kernel
+	 * stack canary now that we are using the kernel page-table.
+	 *
+	 * The original stack canary will be restored by the
+	 * restore_cr3() function.
+	 */
+	switch_to_kernel_stack_canary(frame->saved_cr3);
+
 	if (likely(!on_vc_fallback_stack(regs)))
 		safe_stack_exc_vmm_communication(regs, error_code);
 	else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..a0199c5d8ae1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -816,6 +816,14 @@ struct task_struct {
 #ifdef CONFIG_STACKPROTECTOR
 	/* Canary value for the -fstack-protector GCC feature: */
 	unsigned long			stack_canary;
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	/*
+	 * With PTI, stack_canary_user is used when we are in the
+	 * kernel but using the user page-table. Once we have switched
+	 * to the kernel page-table, stack_canary is used instead.
+	 */
+	unsigned long			stack_canary_user;
+#endif
 #endif
 	/*
 	 * Pointers to the (original) parent process, youngest child, younger sibling,
diff --git a/kernel/fork.c b/kernel/fork.c
index 31cd77dbdba3..70eaba4d8191 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -909,6 +909,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_STACKPROTECTOR
 	tsk->stack_canary = get_random_canary();
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	tsk->stack_canary_user = get_random_canary();
+#endif
 #endif
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
-- 
2.18.4

