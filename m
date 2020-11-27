Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42FF2C6044
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404994AbgK0HAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:00:19 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:42269 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404946AbgK0HAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606460417; x=1637996417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qcYBOe+mQpNh34gLjSuH+yKuIDI2V1CzJHFtgHRl6Go=;
  b=TcrX+KKWuCk5uiyKQzNkaJuKy0WmYUfsbIQGk6EUpVTYs4b46LF0E5fQ
   tDhO7cYYTEjA2H41Uk3eGrK7Z2P6+63qlU7lBDdJZgnu0FZj4VseBFJDk
   xEiqkxvrcYgEWy7pyvWzPiRql8hGgJD0lRV+0TLkPj9zhj9HwGwRVGQg4
   M=;
X-IronPort-AV: E=Sophos;i="5.78,373,1599523200"; 
   d="scan'208";a="91359407"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 Nov 2020 07:00:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 30169A2156;
        Fri, 27 Nov 2020 07:00:03 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 06:59:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 06:59:56 +0000
Received: from localhost (10.85.0.203) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 27 Nov
 2020 06:59:54 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v3 3/5] x86/mm: Optionally flush L1D on context switch
Date:   Fri, 27 Nov 2020 17:59:36 +1100
Message-ID: <20201127065938.8200-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201127065938.8200-1-sblbir@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a mechanism to selectively flush the L1D cache. The goal is to
allow tasks that want to save sensitive information, found by the recent
snoop assisted data sampling vulnerabilites, to flush their L1D on being
switched out.  This protects their data from being snooped or leaked via
side channels after the task has context switched out.

There are two scenarios we might want to protect against, a task leaving
the CPU with data still in L1D (which is the main concern of this patch),
the second scenario is a malicious task coming in (not so well trusted)
for which we want to clean up the cache before it starts. Only the case
for the former is addressed.

A new thread_info flag TIF_SPEC_L1D_FLUSH is added to track tasks which
opt-into L1D flushing. cpu_tlbstate.last_user_mm_spec is used to convert
the TIF flags into mm state (per cpu via last_user_mm_spec) in
cond_mitigation(), which then used to do decide when to flush the
L1D cache.

A new helper inline function l1d_flush_hw() has been introduced.
Currently it returns an error code if hardware flushing is not
supported.  The caller currently does not check the return value, in the
context of these patches, the routine is called only when HW assisted
flushing is available.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200729001103.6450-4-sblbir@amazon.com
---
 arch/x86/include/asm/cacheflush.h  |  8 ++++++++
 arch/x86/include/asm/thread_info.h |  9 +++++++--
 arch/x86/mm/tlb.c                  | 30 +++++++++++++++++++++++++++---
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index b192d917a6d0..554eaf697f3f 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -10,4 +10,12 @@
 
 void clflush_cache_range(void *addr, unsigned int size);
 
+static inline int l1d_flush_hw(void)
+{
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 44733a4bfc42..36a11cfb1061 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,7 +84,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
+#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -96,6 +96,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
@@ -113,7 +114,7 @@ struct thread_info {
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
+#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -124,6 +125,7 @@ struct thread_info {
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
@@ -228,6 +230,9 @@ static inline int arch_within_stack_frames(const void * const stack,
 			   current_thread_info()->status & TS_COMPAT)
 #endif
 
+extern int enable_l1d_flush_for_task(struct task_struct *tsk);
+extern int disable_l1d_flush_for_task(struct task_struct *tsk);
+
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ca021e039451..1531d98396a0 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,11 +8,13 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/sched/smt.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 
 #include "mm_internal.h"
@@ -42,14 +44,15 @@
  */
 
 /*
- * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
  * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
-#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
+#define LAST_USER_MM_L1D_FLUSH	0x2UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)
 
 /* Bits to set when tlbstate and flush is (re)initialized */
-#define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
+#define LAST_USER_MM_INIT	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)
 
 /*
  * The x86 feature is called PCID (Process Context IDentifier). It is similar
@@ -310,6 +313,18 @@ void leave_mm(int cpu)
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
+int enable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
+	return 0;
+}
+
+int disable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	clear_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
+	return 0;
+}
+
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -325,6 +340,7 @@ static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
+	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
 	return (unsigned long)next->mm | spec_bits;
 }
 
@@ -402,6 +418,14 @@ static void cond_mitigation(struct task_struct *next)
 			indirect_branch_prediction_barrier();
 	}
 
+	/*
+	 * Flush only if SMT is disabled as per the contract, which is checked
+	 * when the feature is enabled.
+	 */
+	if (sched_smt_active() && !this_cpu_read(cpu_info.smt_active) &&
+		(prev_mm & LAST_USER_MM_L1D_FLUSH))
+		l1d_flush_hw();
+
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
-- 
2.17.1

