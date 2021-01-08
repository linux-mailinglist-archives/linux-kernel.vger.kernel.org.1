Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942EC2EF214
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbhAHMMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:12:43 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:3006 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbhAHMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1610107963; x=1641643963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sCmtiYdRn7BXombLxI5FsxdzgDAD/rewaP23VjpXHfM=;
  b=JQtoC2Ghbo3j2kDSTN40fBCs+knEhndriI8Tp7WioZwEzPV80dQHUY7K
   GljmLft7CswU3HAlKL1XGwieWAaC0X4aArcoFE+fDJ05C6mJkfITmb025
   cfg+646jPJKrF9zQab39uxeBlR55YtOfalOeUOVJa4WNNXAxqdA8haP2h
   A=;
X-IronPort-AV: E=Sophos;i="5.79,330,1602547200"; 
   d="scan'208";a="102228155"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 08 Jan 2021 12:11:31 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 799BD2824B3;
        Fri,  8 Jan 2021 12:11:26 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:09 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:09 +0000
Received: from localhost (10.85.0.12) by mail-relay.amazon.com (10.43.61.169)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 8 Jan
 2021 12:11:08 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v4 2/5] x86/mm: Refactor cond_ibpb() to support other use cases
Date:   Fri, 8 Jan 2021 23:10:53 +1100
Message-ID: <20210108121056.21940-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108121056.21940-1-sblbir@amazon.com>
References: <20210108121056.21940-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cond_ibpb() has the necessary bits required to track the previous mm in
switch_mm_irqs_off(). This can be reused for other use cases like L1D
flushing on context switch.

[ tglx: Moved comment, added a separate define for state (re)initialization ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200510014803.12190-4-sblbir@amazon.com
Link: https://lore.kernel.org/r/20200729001103.6450-3-sblbir@amazon.com
---
 arch/x86/include/asm/tlbflush.h |  2 +-
 arch/x86/mm/tlb.c               | 53 ++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e0b660..a927d40664df 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -83,7 +83,7 @@ struct tlb_state {
 	/* Last user mm for optimizing IBPB */
 	union {
 		struct mm_struct	*last_user_mm;
-		unsigned long		last_user_mm_ibpb;
+		unsigned long		last_user_mm_spec;
 	};
 
 	u16 loaded_mm_asid;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 569ac1d57f55..7320348b5a61 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -42,10 +42,14 @@
  */
 
 /*
- * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
- * stored in cpu_tlb_state.last_user_mm_ibpb.
+ * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
+
+/* Bits to set when tlbstate and flush is (re)initialized */
+#define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
 
 /*
  * The x86 feature is called PCID (Process Context IDentifier). It is similar
@@ -316,20 +320,29 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
+	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
-	return (unsigned long)next->mm | ibpb;
+	return (unsigned long)next->mm | spec_bits;
 }
 
-static void cond_ibpb(struct task_struct *next)
+static void cond_mitigation(struct task_struct *next)
 {
+	unsigned long prev_mm, next_mm;
+
 	if (!next || !next->mm)
 		return;
 
+	next_mm = mm_mangle_tif_spec_bits(next);
+	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
+
 	/*
+	 * Avoid user/user BTB poisoning by flushing the branch predictor
+	 * when switching between processes. This stops one process from
+	 * doing Spectre-v2 attacks on another.
+	 *
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
 	 * same process. Using the mm pointer instead of mm->context.ctx_id
@@ -339,8 +352,6 @@ static void cond_ibpb(struct task_struct *next)
 	 * exposed data is not really interesting.
 	 */
 	if (static_branch_likely(&switch_mm_cond_ibpb)) {
-		unsigned long prev_mm, next_mm;
-
 		/*
 		 * This is a bit more complex than the always mode because
 		 * it has to handle two cases:
@@ -370,20 +381,14 @@ static void cond_ibpb(struct task_struct *next)
 		 * Optimize this with reasonably small overhead for the
 		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
 		 * pointer of the incoming task which is stored in
-		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
-		 */
-		next_mm = mm_mangle_tif_spec_ib(next);
-		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
-
-		/*
+		 * cpu_tlbstate.last_user_mm_spec for comparison.
+		 *
 		 * Issue IBPB only if the mm's are different and one or
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm != prev_mm &&
 		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
-
-		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
 	}
 
 	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
@@ -392,11 +397,12 @@ static void cond_ibpb(struct task_struct *next)
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if (this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) !=
+					(unsigned long)next->mm)
 			indirect_branch_prediction_barrier();
-			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
-		}
 	}
+
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -524,11 +530,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		need_flush = true;
 	} else {
 		/*
-		 * Avoid user/user BTB poisoning by flushing the branch
-		 * predictor when switching between processes. This stops
-		 * one process from doing Spectre-v2 attacks on another.
+		 * Apply process to process speculation vulnerability
+		 * mitigations if applicable.
 		 */
-		cond_ibpb(tsk);
+		cond_mitigation(tsk);
 
 		/*
 		 * Stop remote flushes for the previous mm.
@@ -636,7 +641,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
-- 
2.17.1

