Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75702B72A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgKQXt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:49:56 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55635 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQXtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605656995; x=1637192995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9xGDVBBbLT1pX22cNFC3d08aBPn9fxPvX7a+OiRDlb8=;
  b=m6+iPwCOujtbAydh1vWMtH1ZP43tSkvFh9O+SD+orkWQO32sf+WGg92l
   Okikk9nbgo1zDOqatSRhuv3xVGFJIZjGFQbmtuv/Ara1kooc4mFbVYRdw
   HPbyDsppVsvOdvI/yGWzrG/2eJU7YGXgGPCxuHwEC9GeHe+Sv05V/arfa
   I=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="96392498"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 17 Nov 2020 23:49:47 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 9E5892217EE;
        Tue, 17 Nov 2020 23:49:46 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 23:49:46 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 23:49:46 +0000
Received: from localhost (10.143.193.228) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Nov 2020 23:49:45 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v1 1/3] x86/mm: change l1d flush runtime prctl behaviour
Date:   Wed, 18 Nov 2020 10:49:32 +1100
Message-ID: <20201117234934.25985-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117234934.25985-1-sblbir@amazon.com>
References: <20201117234934.25985-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detection of task affinities at API opt-in time is not the best
approach, the approach is to kill the task if it runs on a
SMT enable core. This is better than not flushing the L1D cache
when the task switches from a non-SMT core to an SMT enabled core.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
To be applied on top of tip commit id
b6724f118d44606fddde391ba7527526b3cad211

 arch/Kconfig          |  4 ++++
 arch/x86/Kconfig      |  1 +
 arch/x86/mm/tlb.c     | 37 +++++++++++++++++++++----------------
 include/linux/sched.h | 10 ++++++++++
 4 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 546869c3269d..2024486d28a2 100644
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
index 36357c806e8a..02ff6ff71002 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -103,6 +103,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 88e9ad5142e4..bdc399b86bc7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -315,31 +315,18 @@ EXPORT_SYMBOL_GPL(leave_mm);
 
 int enable_l1d_flush_for_task(struct task_struct *tsk)
 {
-	int cpu, ret = 0, i;
-
 	/*
 	 * Do not enable L1D_FLUSH_OUT if
 	 * b. The CPU is not affected by the L1TF bug
 	 * c. The CPU does not have L1D FLUSH feature support
-	 * c. The task's affinity is on cores with SMT on.
 	 */
 
 	if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
-			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
+			!boot_cpu_has(X86_FEATURE_FLUSH_L1D))
 		return -EINVAL;
 
-	cpu = get_cpu();
-
-	for_each_cpu(i, &tsk->cpus_mask) {
-		if (cpu_data(i).smt_active == true) {
-			put_cpu();
-			return -EINVAL;
-		}
-	}
-
 	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
-	put_cpu();
-	return ret;
+	return 0;
 }
 
 int disable_l1d_flush_for_task(struct task_struct *tsk)
@@ -358,13 +345,31 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
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
index 322ea9b827e1..c569c49715d7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1338,6 +1338,16 @@ struct task_struct {
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
-- 
2.17.1

