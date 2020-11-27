Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362502C6043
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404938AbgK0HAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:00:06 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:5454 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389454AbgK0HAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606460402; x=1637996402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QQ4UGvVqiLpmPBI3y2pgedsgWExuRX2cpnTdk9uJCzo=;
  b=W0zoSV5QVI8DYdb1dKtRxzGSAnOR3pqcF/TSQ7sdnBgGwOglucIf02V7
   u9HEfqV5s2s+P0VQ8aoejMLNFWidWiXEYXSz1LGfOpv+6+D+yhJQ71ua6
   ZbT3epn9OB9vnwbIrpOlju7jk9zrmSVYXmdcsLkoUt8TLUm6G1cKdiEFo
   A=;
X-IronPort-AV: E=Sophos;i="5.78,373,1599523200"; 
   d="scan'208";a="98359495"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 27 Nov 2020 06:59:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 726CB221C4A;
        Fri, 27 Nov 2020 06:59:58 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 06:59:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 06:59:57 +0000
Received: from localhost (10.85.0.203) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 06:59:57 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v3 4/5] prctl: Hook L1D flushing in via prctl
Date:   Fri, 27 Nov 2020 17:59:37 +1100
Message-ID: <20201127065938.8200-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201127065938.8200-1-sblbir@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing PR_GET/SET_SPECULATION_CTRL API to expose the L1D
flush capability. For L1D flushing PR_SPEC_FORCE_DISABLE and
PR_SPEC_DISABLE_NOEXEC are not supported.

Enabling L1D flush does not check if the task is running on
an SMT enabled core, rather a check is done at runtime (at the
time of flush), if the task runs on a non SMT enabled core
then the task is sent a SIGBUS (this is done prior to the task
executing on the core, so no data is leaked). This is better
than the other alternatives of

a. Ensuring strict affinity of the task (hard to enforce
without further changes in the scheduler)
b. Silently skipping flush for tasks that move to SMT enabled
cores.

An arch config ARCH_HAS_PARANOID_L1D_FLUSH has been added
and struct task carries a callback_head for arch's that support
this config (currently on x86), this callback head is used
to schedule task work (SIGBUS delivery).

There is also no seccomp integration for the feature.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/Kconfig               |  4 +++
 arch/x86/Kconfig           |  1 +
 arch/x86/kernel/cpu/bugs.c | 54 ++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/tlb.c          | 30 ++++++++++++++++++++-
 include/linux/sched.h      | 10 +++++++
 include/uapi/linux/prctl.h |  1 +
 6 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..d4a0501ac7fc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -311,6 +311,10 @@ config ARCH_32BIT_OFF_T
 	  still support 32-bit off_t. This option is enabled for all such
 	  architectures explicitly.
 
+config ARCH_HAS_PARANOID_L1D_FLUSH
+	bool
+	default n
+
 config HAVE_ASM_MODVERSIONS
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..4f6caa6dae16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -101,6 +101,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 581fb7223ad0..dece79e4d1e9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -296,6 +296,13 @@ enum taa_mitigations {
 	TAA_MITIGATION_TSX_DISABLED,
 };
 
+enum l1d_flush_out_mitigations {
+	L1D_FLUSH_OUT_OFF,
+	L1D_FLUSH_OUT_ON,
+};
+
+static enum l1d_flush_out_mitigations l1d_flush_out_mitigation __ro_after_init = L1D_FLUSH_OUT_ON;
+
 /* Default mitigation for TAA-affected CPUs */
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
 static bool taa_nosmt __ro_after_init;
@@ -379,6 +386,18 @@ static void __init taa_select_mitigation(void)
 	pr_info("%s\n", taa_strings[taa_mitigation]);
 }
 
+static int __init l1d_flush_out_parse_cmdline(char *str)
+{
+	if (!boot_cpu_has_bug(X86_BUG_L1TF))
+		return 0;
+
+	if (!strcmp(str, "off"))
+		l1d_flush_out_mitigation = L1D_FLUSH_OUT_OFF;
+
+	return 0;
+}
+early_param("l1d_flush_out", l1d_flush_out_parse_cmdline);
+
 static int __init tsx_async_abort_parse_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TAA))
@@ -1215,6 +1234,23 @@ static void task_update_spec_tif(struct task_struct *tsk)
 		speculation_ctrl_update_current();
 }
 
+static int l1d_flush_out_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+
+	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
+		return -EPERM;
+
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		return enable_l1d_flush_for_task(task);
+	case PR_SPEC_DISABLE:
+		return disable_l1d_flush_for_task(task);
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
@@ -1324,6 +1360,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1340,6 +1378,20 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 }
 #endif
 
+static int l1d_flush_out_prctl_get(struct task_struct *task)
+{
+	int ret;
+
+	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
+		return PR_SPEC_FORCE_DISABLE;
+
+	ret = test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+	if (ret)
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	else
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1390,6 +1442,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1531d98396a0..bdc399b86bc7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -315,6 +315,16 @@ EXPORT_SYMBOL_GPL(leave_mm);
 
 int enable_l1d_flush_for_task(struct task_struct *tsk)
 {
+	/*
+	 * Do not enable L1D_FLUSH_OUT if
+	 * b. The CPU is not affected by the L1TF bug
+	 * c. The CPU does not have L1D FLUSH feature support
+	 */
+
+	if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
+			!boot_cpu_has(X86_FEATURE_FLUSH_L1D))
+		return -EINVAL;
+
 	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
 	return 0;
 }
@@ -335,13 +345,31 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
+/*
+ * Sent to a task that opts into L1D flushing via the prctl interface
+ * but ends up running on an SMT enabled core.
+ */
+static void l1d_flush_kill(struct callback_head *ch)
+{
+	force_sig(SIGBUS);
+}
+
 static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
+	unsigned long next_mm;
 
 	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
-	return (unsigned long)next->mm | spec_bits;
+	next_mm = (unsigned long)next->mm | spec_bits;
+
+	if ((next_mm & LAST_USER_MM_L1D_FLUSH) && this_cpu_read(cpu_info.smt_active)) {
+		clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
+		next->l1d_flush_kill.func = l1d_flush_kill;
+		task_work_add(next, &next->l1d_flush_kill, true);
+	}
+
+	return next_mm;
 }
 
 static void cond_mitigation(struct task_struct *next)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 76cd21fa5501..f8c5b6833f14 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1348,6 +1348,16 @@ struct task_struct {
 	struct callback_head		mce_kill_me;
 #endif
 
+#ifdef CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH
+	/*
+	 * If L1D flush is supported on mm context switch
+	 * then we use this callback head to queue kill work
+	 * to kill tasks that are not running on SMT disabled
+	 * cores
+	 */
+	struct callback_head		l1d_flush_kill;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 7f0827705c9a..c334e6a02e5f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH_OUT		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
-- 
2.17.1

