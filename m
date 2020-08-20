Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15A24B06B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 09:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHTHu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:50:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11A6C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=j/08wSCJpTna7yfh/SN5CHyoDW6Gr4of7pEQMGt+gn4=; b=Ti1UJVgrIzkDKV1fiLQnHSHCBK
        gcDzUq2eI1DWqYcZq9ASsEVfijvUgoC4iYnbcTu3G1v74BOxHtkM8JHuylGLrGaEqu8E4dF55FUGB
        fdGGa6c9DJGe75mgqlbg2TjtdRbQRbdHy4+6h5RFfnmIVIs2VQduh2gutc91Pn0HkJeinyoIDFQvC
        ms/uD4Z/gy7MIQqr0rAIvTNjYMJatbPnRca9cbw6m6nfhQdvYW8J8GpcY47DcEPkTpKGdzvO0b31+
        4ANHH/0VHMFFnsdnnLgfs2g5uECcl6/cEgcbTEWYy8cKLF9kqgIPoWcvfED43Cs2+c/HZJn0IFJcC
        Vg2zimEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8fKU-0000Mc-UO; Thu, 20 Aug 2020 07:49:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73640305B23;
        Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5A74228B7E842; Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Message-ID: <20200820074640.460668349@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 09:30:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH 3/9] cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic
References: <20200820073031.886217423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows moving the leave_mm() call into generic code before
rcu_idle_enter(). Gets rid of more trace_*_rcuidle() users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/mmu.h  |    1 +
 arch/x86/mm/tlb.c           |   13 ++-----------
 drivers/cpuidle/cpuidle.c   |    4 ++++
 drivers/idle/intel_idle.c   |   16 ----------------
 include/linux/cpuidle.h     |   13 +++++++------
 include/linux/mmu_context.h |    5 +++++
 6 files changed, 19 insertions(+), 33 deletions(-)

--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -59,5 +59,6 @@ typedef struct {
 	}
 
 void leave_mm(int cpu);
+#define leave_mm leave_mm
 
 #endif /* _ASM_X86_MMU_H */
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -555,21 +555,12 @@ void switch_mm_irqs_off(struct mm_struct
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
 		load_new_mm_cr3(next->pgd, new_asid, true);
 
-		/*
-		 * NB: This gets called via leave_mm() in the idle path
-		 * where RCU functions differently.  Tracing normally
-		 * uses RCU, so we need to use the _rcuidle variant.
-		 *
-		 * (There is no good reason for this.  The idle code should
-		 *  be rearranged to call this before rcu_idle_enter().)
-		 */
-		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
+		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
 		/* The new ASID is already up to date. */
 		load_new_mm_cr3(next->pgd, new_asid, false);
 
-		/* See above wrt _rcuidle. */
-		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
+		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
 	/* Make sure we write CR3 before loaded_mm. */
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/tick.h>
+#include <linux/mmu_context.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -230,6 +231,9 @@ int cpuidle_enter_state(struct cpuidle_d
 		broadcast = false;
 	}
 
+	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
+		leave_mm(dev->cpu);
+
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
 
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -90,14 +90,6 @@ static unsigned int mwait_substates __in
 #define CPUIDLE_FLAG_ALWAYS_ENABLE	BIT(15)
 
 /*
- * Set this flag for states where the HW flushes the TLB for us
- * and so we don't need cross-calls to keep it consistent.
- * If this flag is set, SW flushes the TLB, so even if the
- * HW doesn't do the flushing, this flag is safe to use.
- */
-#define CPUIDLE_FLAG_TLB_FLUSHED	BIT(16)
-
-/*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
  * 0x00 means "MWAIT(C1)", 0x10 means "MWAIT(C2)" etc.
@@ -131,14 +123,6 @@ static __cpuidle int intel_idle(struct c
 	unsigned long eax = flg2MWAIT(state->flags);
 	unsigned long ecx = 1; /* break on interrupt flag */
 	bool tick;
-	int cpu = smp_processor_id();
-
-	/*
-	 * leave_mm() to avoid costly and often unnecessary wakeups
-	 * for flushing the user TLB's associated with the active mm.
-	 */
-	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
-		leave_mm(cpu);
 
 	if (!static_cpu_has(X86_FEATURE_ARAT)) {
 		/*
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -75,12 +75,13 @@ struct cpuidle_state {
 };
 
 /* Idle State Flags */
-#define CPUIDLE_FLAG_NONE       (0x00)
-#define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
-#define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
-#define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
-#define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
-#define CPUIDLE_FLAG_OFF	BIT(4) /* disable this state by default */
+#define CPUIDLE_FLAG_NONE       	(0x00)
+#define CPUIDLE_FLAG_POLLING		BIT(0) /* polling state */
+#define CPUIDLE_FLAG_COUPLED		BIT(1) /* state applies to multiple cpus */
+#define CPUIDLE_FLAG_TIMER_STOP 	BIT(2) /* timer is stopped on this state */
+#define CPUIDLE_FLAG_UNUSABLE		BIT(3) /* avoid using this state */
+#define CPUIDLE_FLAG_OFF		BIT(4) /* disable this state by default */
+#define CPUIDLE_FLAG_TLB_FLUSHED	BIT(5) /* idle-state flushes TLBs */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -3,10 +3,15 @@
 #define _LINUX_MMU_CONTEXT_H
 
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 
 /* Architectures that care about IRQ state in switch_mm can override this. */
 #ifndef switch_mm_irqs_off
 # define switch_mm_irqs_off switch_mm
 #endif
 
+#ifndef leave_mm
+static inline void leave_mm(int cpu) { }
+#endif
+
 #endif


