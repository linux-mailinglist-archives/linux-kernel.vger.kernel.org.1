Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1852C2EF213
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbhAHMMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:12:40 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:16444 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHMMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1610107957; x=1641643957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TtMsrBc1ZJnjqlCYhrVzAba9J7WFSMO11PK8hVxjfr8=;
  b=VEWAFXWlOGIvYTAHQWOKYkya69TfY+XeIjcFOnCLCfr+8R2pkG4a29Rm
   ulMjegpn5EMIKpz2nuM1XqIVVZl2r/cQ8RtdEFqw19IkmqR5407rr2TNl
   cKlayveuWt/LhJxGVswK0J4wd706l04ryqZgQkK9dt7AWGbuUoXQUF6C2
   4=;
X-IronPort-AV: E=Sophos;i="5.79,330,1602547200"; 
   d="scan'208";a="110540366"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Jan 2021 12:11:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 3115DA1F20;
        Fri,  8 Jan 2021 12:11:12 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:11 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:11 +0000
Received: from localhost (10.85.0.12) by mail-relay.amazon.com (10.43.162.232)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 8 Jan
 2021 12:11:11 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v4 3/5] x86/mm: Optionally flush L1D on context switch
Date:   Fri, 8 Jan 2021 23:10:54 +1100
Message-ID: <20210108121056.21940-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108121056.21940-1-sblbir@amazon.com>
References: <20210108121056.21940-1-sblbir@amazon.com>
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
 arch/x86/mm/tlb.c                  | 16 ++++++++++++++--
 3 files changed, 29 insertions(+), 4 deletions(-)

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
index 0d751d5da702..33b637442b9e 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -81,7 +81,7 @@ struct thread_info {
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
+#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -93,6 +93,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
@@ -104,7 +105,7 @@ struct thread_info {
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
+#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -115,6 +116,7 @@ struct thread_info {
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
@@ -217,6 +219,9 @@ static inline int arch_within_stack_frames(const void * const stack,
 			   current_thread_info()->status & TS_COMPAT)
 #endif
 
+extern int enable_l1d_flush_for_task(struct task_struct *tsk);
+extern int disable_l1d_flush_for_task(struct task_struct *tsk);
+
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7320348b5a61..f67c5bd58158 100644
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
@@ -42,11 +44,12 @@
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
 #define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
@@ -325,6 +328,7 @@ static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
+	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
 	return (unsigned long)next->mm | spec_bits;
 }
 
@@ -402,6 +406,14 @@ static void cond_mitigation(struct task_struct *next)
 			indirect_branch_prediction_barrier();
 	}
 
+	/*
+	 * Flush only if SMT is disabled as per the contract, which is checked
+	 * when the feature is enabled.
+	 */
+	if (!this_cpu_read(cpu_info.smt_active) &&
+		(prev_mm & LAST_USER_MM_L1D_FLUSH))
+		l1d_flush_hw();
+
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
-- 
2.17.1

