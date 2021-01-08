Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0512EF212
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbhAHMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:12:31 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:15811 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbhAHMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1610107948; x=1641643948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pHBVI62Ud1xJYxCHQrRJms9eh/gAvhP0VLBMc3fNVgw=;
  b=ZZaZvftYlYZKDNOIsqSLyNXv2L9XDXLg2pX1G0oVk6RwKXN5BvisUtoV
   Ej3EpBbTf4exZK940qsUPjMm2Lj2k9te0z2USKybIoswK0b6+sK3FxIQY
   gPB9E3s1LCMXbhiagEmRv9sQGE5RRbSkWMXyRSaivEUyKJYGoYy0SzHXY
   Q=;
X-IronPort-AV: E=Sophos;i="5.79,330,1602547200"; 
   d="scan'208";a="110540370"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Jan 2021 12:11:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id B8C90120D73;
        Fri,  8 Jan 2021 12:11:14 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:13 +0000
Received: from localhost (10.85.0.12) by mail-relay.amazon.com (10.43.61.169)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 8 Jan
 2021 12:11:12 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v4 4/5] prctl: Hook L1D flushing in via prctl
Date:   Fri, 8 Jan 2021 23:10:55 +1100
Message-ID: <20210108121056.21940-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108121056.21940-1-sblbir@amazon.com>
References: <20210108121056.21940-1-sblbir@amazon.com>
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
 arch/Kconfig                         |  4 ++
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/nospec-branch.h |  2 +
 arch/x86/include/asm/thread_info.h   |  3 --
 arch/x86/kernel/cpu/bugs.c           | 71 ++++++++++++++++++++++++++++
 arch/x86/mm/tlb.c                    | 29 ++++++++++--
 include/linux/sched.h                | 10 ++++
 include/uapi/linux/prctl.h           |  1 +
 8 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 7091f7187951..0a0701e0a1ed 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -327,6 +327,10 @@ config ARCH_32BIT_OFF_T
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
index bd4993b276fd..2bb53bfaea02 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,7 @@ config X86
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index cb9ad6b73973..cd60934c6075 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -253,6 +253,8 @@ DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
+DECLARE_STATIC_KEY_FALSE(l1d_flush_enabled);
+
 #include <asm/segment.h>
 
 /**
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 33b637442b9e..054dc0f58ac4 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -219,9 +219,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 			   current_thread_info()->status & TS_COMPAT)
 #endif
 
-extern int enable_l1d_flush_for_task(struct task_struct *tsk);
-extern int disable_l1d_flush_for_task(struct task_struct *tsk);
-
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..e07d2a1d5eb2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -76,6 +76,20 @@ EXPORT_SYMBOL_GPL(mds_user_clear);
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
 
+/*
+ * Controls whether l1d flush based mitigations are enabled,
+ * based on hw features and admin setting via boot parameter
+ * defaults to false
+ */
+DEFINE_STATIC_KEY_FALSE(l1d_flush_enabled);
+
+enum l1d_flush_mitigations {
+	L1D_FLUSH_OFF = 0,
+	L1D_FLUSH_ON,
+};
+
+static enum l1d_flush_mitigations l1d_flush_mitigation __initdata = L1D_FLUSH_OFF;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -150,6 +164,10 @@ void __init check_bugs(void)
 	if (!direct_gbpages)
 		set_memory_4k((unsigned long)__va(0), 1);
 #endif
+	if (!l1d_flush_mitigation || !boot_cpu_has_bug(X86_BUG_L1TF) ||
+		!boot_cpu_has(X86_FEATURE_FLUSH_L1D))
+		return;
+	static_branch_enable(&l1d_flush_enabled);
 }
 
 void
@@ -379,6 +397,15 @@ static void __init taa_select_mitigation(void)
 	pr_info("%s\n", taa_strings[taa_mitigation]);
 }
 
+static int __init l1d_flush_parse_cmdline(char *str)
+{
+	if (!strcmp(str, "on"))
+		l1d_flush_mitigation = L1D_FLUSH_ON;
+
+	return 0;
+}
+early_param("l1d_flush", l1d_flush_parse_cmdline);
+
 static int __init tsx_async_abort_parse_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TAA))
@@ -1215,6 +1242,35 @@ static void task_update_spec_tif(struct task_struct *tsk)
 		speculation_ctrl_update_current();
 }
 
+static inline int enable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
+	return 0;
+}
+
+static inline int disable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	clear_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
+	return 0;
+}
+
+static int l1d_flush_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+
+	if (!static_branch_unlikely(&l1d_flush_enabled))
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
@@ -1324,6 +1380,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_L1D_FLUSH:
+		return l1d_flush_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1340,6 +1398,17 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 }
 #endif
 
+static int l1d_flush_prctl_get(struct task_struct *task)
+{
+	if (!static_branch_unlikely(&l1d_flush_enabled))
+		return PR_SPEC_FORCE_DISABLE;
+
+	if (test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH))
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	else
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1390,6 +1459,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_L1D_FLUSH:
+		return l1d_flush_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f67c5bd58158..aa9286b83f8f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -323,6 +323,28 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
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
+static void  l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
+				struct task_struct *next)
+{
+	if (prev_mm & LAST_USER_MM_L1D_FLUSH)
+		l1d_flush_hw();
+
+	if ((next_mm & LAST_USER_MM_L1D_FLUSH) && this_cpu_read(cpu_info.smt_active)) {
+		clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
+		next->l1d_flush_kill.func = l1d_flush_kill;
+		task_work_add(next, &next->l1d_flush_kill, TWA_RESUME);
+	}
+}
+
 static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
@@ -410,9 +432,10 @@ static void cond_mitigation(struct task_struct *next)
 	 * Flush only if SMT is disabled as per the contract, which is checked
 	 * when the feature is enabled.
 	 */
-	if (!this_cpu_read(cpu_info.smt_active) &&
-		(prev_mm & LAST_USER_MM_L1D_FLUSH))
-		l1d_flush_hw();
+	if (static_branch_unlikely(&l1d_flush_enabled)) {
+		if (unlikely((prev_mm | next_mm) & LAST_USER_MM_L1D_FLUSH))
+			l1d_flush_evaluate(prev_mm, next_mm, next);
+	}
 
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e5ad6d354b7b..77e9d32d70ca 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1376,6 +1376,16 @@ struct task_struct {
 	unsigned long			getblk_bh_state;
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
index 90deb41c8a34..44adcae6641c 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
-- 
2.17.1

