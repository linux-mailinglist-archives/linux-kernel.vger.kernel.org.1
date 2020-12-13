Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE12D8F8B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 19:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgLMSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 13:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgLMSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 13:52:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC5C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 10:51:54 -0800 (PST)
Date:   Sun, 13 Dec 2020 16:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607885512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cb63+pcCZ0UBCDs4jII6/LXSBYg803k53I3PI9QhoTg=;
        b=SI2vuMgJz+6kYoj2SZKIxBTNIU4byZihZWCQn3Kck//6v5zK0eZ3wIgwZeCPRzWipmLlci
        ckeSS1DlRO+PXfLmGPhV9hYjzGtmeUzkUyXwlGi7lvp4eATGgMLSn3Kp/nt9pI6bQsgwcT
        WgdatHx08rjIrVnWPK/4N3LCRGkbjgeK6v//1T2yYFkkvVwbBwHHXxdnOKF+r8zsDgv+gb
        /qdPx7Wv/crbrKYc7OAmUoJFfREL7QeCGyf6wqwLkJ935fuWCQh7CDC1GX7B2IYpDV0RPW
        V1wZALKR88DFC9enoqH3KhsIOwXUOTNbMRw3nB+ICBmdwgUqb5tKZ1x8jSCc+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607885512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cb63+pcCZ0UBCDs4jII6/LXSBYg803k53I3PI9QhoTg=;
        b=siEdbqlBKIXioB/g50XDD/5SQGph3UOdQRPksLIrZAu3vCSEnIO759zpjA8uD8Zrhbsb9G
        P8eHq+MOusXBQaCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.10
Message-ID: <160787544257.29236.9507174976469921731.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-12-13

up to:  0d07c0ec4381: x86/kprobes: Fix optprobe to detect INT3 padding correctly

A set of x86 and membarrier fixes:

  - Correct a few problems in the x86 and the generic membarrier
    implementation. Small corrections for assumptions about visibility
    which have turned out not to be true.

  - Make the PAT bits for memory encryption correct vs. 4K and 2M/1G page
    table entries as they are at a different location.

  - Fix a concurrency issue in the the local bandwidth readout of resource
    control leading to incorrect values

  - Fix the ordering of allocating a vector for an interrupt. The order
    missed to respect the provided cpumask when the first attempt of
    allocating node local in the mask fails. It then tries the node instead
    of trying the full provided mask first. This leads to erroneous error
    messages and breaking the (user) supplied affinity request. Reorder it.

  - Make the INT3 padding detection in optprobe work correctly.

Thanks,

	tglx

------------------>
Andy Lutomirski (4):
      x86/membarrier: Get rid of a dubious optimization
      membarrier: Add an actual barrier before rseq_preempt()
      membarrier: Explicitly sync remote cores when SYNC_CORE is requested
      membarrier: Execute SYNC_CORE on the calling thread

Arvind Sankar (1):
      x86/mm/mem_encrypt: Fix definition of PMD_FLAGS_DEC_WP

Masami Hiramatsu (1):
      x86/kprobes: Fix optprobe to detect INT3 padding correctly

Thomas Gleixner (1):
      x86/apic/vector: Fix ordering in vector assignment

Xiaochen Shen (1):
      x86/resctrl: Fix incorrect local bandwidth when mba_sc is enabled


 arch/x86/include/asm/pgtable_types.h  |  1 +
 arch/x86/include/asm/sync_core.h      |  9 ++--
 arch/x86/kernel/apic/vector.c         | 24 ++++++-----
 arch/x86/kernel/cpu/resctrl/monitor.c |  6 +--
 arch/x86/kernel/kprobes/opt.c         | 22 +++++++++-
 arch/x86/mm/mem_encrypt_identity.c    |  4 +-
 arch/x86/mm/tlb.c                     | 10 ++++-
 kernel/sched/membarrier.c             | 77 +++++++++++++++++++++++++++--------
 8 files changed, 111 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 816b31c68550..394757ee030a 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -155,6 +155,7 @@ enum page_cache_mode {
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
+#define _PAGE_LARGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT_LARGE)
 
 #define _PAGE_NOCACHE		(cachemode2protval(_PAGE_CACHE_MODE_UC))
 #define _PAGE_CACHE_WP		(cachemode2protval(_PAGE_CACHE_MODE_WP))
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 0fd4a9dfb29c..ab7382f92aff 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -98,12 +98,13 @@ static inline void sync_core_before_usermode(void)
 	/* With PTI, we unconditionally serialize before running user code. */
 	if (static_cpu_has(X86_FEATURE_PTI))
 		return;
+
 	/*
-	 * Return from interrupt and NMI is done through iret, which is core
-	 * serializing.
+	 * Even if we're in an interrupt, we might reschedule before returning,
+	 * in which case we could switch to a different thread in the same mm
+	 * and return using SYSRET or SYSEXIT.  Instead of trying to keep
+	 * track of our need to sync the core, just sync right away.
 	 */
-	if (in_irq() || in_nmi())
-		return;
 	sync_core();
 }
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 1eac53632786..758bbf25ef74 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -273,20 +273,24 @@ static int assign_irq_vector_any_locked(struct irq_data *irqd)
 	const struct cpumask *affmsk = irq_data_get_affinity_mask(irqd);
 	int node = irq_data_get_node(irqd);
 
-	if (node == NUMA_NO_NODE)
-		goto all;
-	/* Try the intersection of @affmsk and node mask */
-	cpumask_and(vector_searchmask, cpumask_of_node(node), affmsk);
-	if (!assign_vector_locked(irqd, vector_searchmask))
-		return 0;
-	/* Try the node mask */
-	if (!assign_vector_locked(irqd, cpumask_of_node(node)))
-		return 0;
-all:
+	if (node != NUMA_NO_NODE) {
+		/* Try the intersection of @affmsk and node mask */
+		cpumask_and(vector_searchmask, cpumask_of_node(node), affmsk);
+		if (!assign_vector_locked(irqd, vector_searchmask))
+			return 0;
+	}
+
 	/* Try the full affinity mask */
 	cpumask_and(vector_searchmask, affmsk, cpu_online_mask);
 	if (!assign_vector_locked(irqd, vector_searchmask))
 		return 0;
+
+	if (node != NUMA_NO_NODE) {
+		/* Try the node mask */
+		if (!assign_vector_locked(irqd, cpumask_of_node(node)))
+			return 0;
+	}
+
 	/* Try the full online mask */
 	return assign_vector_locked(irqd, cpu_online_mask);
 }
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 54dffe574e67..a98519a3a2e6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -279,7 +279,6 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 		return;
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
-	m->chunks += chunks;
 	cur_bw = (chunks * r->mon_scale) >> 20;
 
 	if (m->delta_comp)
@@ -450,15 +449,14 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
+		__mon_event_count(rmid, &rr);
 
 		/*
 		 * Call the MBA software controller only for the
 		 * control groups and when user has enabled
 		 * the software controller explicitly.
 		 */
-		if (!is_mba_sc(NULL))
-			__mon_event_count(rmid, &rr);
-		else
+		if (is_mba_sc(NULL))
 			mbm_bw_count(rmid, &rr);
 	}
 }
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 041f0b50bc27..08eb23074f92 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -272,6 +272,19 @@ static int insn_is_indirect_jump(struct insn *insn)
 	return ret;
 }
 
+static bool is_padding_int3(unsigned long addr, unsigned long eaddr)
+{
+	unsigned char ops;
+
+	for (; addr < eaddr; addr++) {
+		if (get_kernel_nofault(ops, (void *)addr) < 0 ||
+		    ops != INT3_INSN_OPCODE)
+			return false;
+	}
+
+	return true;
+}
+
 /* Decode whole function to ensure any instructions don't jump into target */
 static int can_optimize(unsigned long paddr)
 {
@@ -310,9 +323,14 @@ static int can_optimize(unsigned long paddr)
 			return 0;
 		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
 		insn_get_length(&insn);
-		/* Another subsystem puts a breakpoint */
+		/*
+		 * In the case of detecting unknown breakpoint, this could be
+		 * a padding INT3 between functions. Let's check that all the
+		 * rest of the bytes are also INT3.
+		 */
 		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
-			return 0;
+			return is_padding_int3(addr, paddr - offset + size) ? 1 : 0;
+
 		/* Recover address */
 		insn.kaddr = (void *)addr;
 		insn.next_byte = (void *)(addr + insn.length);
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 733b983f3a89..6c5eb6f3f14f 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -45,8 +45,8 @@
 #define PMD_FLAGS_LARGE		(__PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL)
 
 #define PMD_FLAGS_DEC		PMD_FLAGS_LARGE
-#define PMD_FLAGS_DEC_WP	((PMD_FLAGS_DEC & ~_PAGE_CACHE_MASK) | \
-				 (_PAGE_PAT | _PAGE_PWT))
+#define PMD_FLAGS_DEC_WP	((PMD_FLAGS_DEC & ~_PAGE_LARGE_CACHE_MASK) | \
+				 (_PAGE_PAT_LARGE | _PAGE_PWT))
 
 #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 11666ba19b62..569ac1d57f55 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -474,8 +474,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	/*
 	 * The membarrier system call requires a full memory barrier and
 	 * core serialization before returning to user-space, after
-	 * storing to rq->curr. Writing to CR3 provides that full
-	 * memory barrier and core serializing instruction.
+	 * storing to rq->curr, when changing mm.  This is because
+	 * membarrier() sends IPIs to all CPUs that are in the target mm
+	 * to make them issue memory barriers.  However, if another CPU
+	 * switches to/from the target mm concurrently with
+	 * membarrier(), it can cause that CPU not to receive an IPI
+	 * when it really should issue a memory barrier.  Writing to CR3
+	 * provides that full memory barrier and core serializing
+	 * instruction.
 	 */
 	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index e23e74d52db5..9d8df34bea75 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -38,8 +38,33 @@ static void ipi_mb(void *info)
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
+static void ipi_sync_core(void *info)
+{
+	/*
+	 * The smp_mb() in membarrier after all the IPIs is supposed to
+	 * ensure that memory on remote CPUs that occur before the IPI
+	 * become visible to membarrier()'s caller -- see scenario B in
+	 * the big comment at the top of this file.
+	 *
+	 * A sync_core() would provide this guarantee, but
+	 * sync_core_before_usermode() might end up being deferred until
+	 * after membarrier()'s smp_mb().
+	 */
+	smp_mb();	/* IPIs should be serializing but paranoid. */
+
+	sync_core_before_usermode();
+}
+
 static void ipi_rseq(void *info)
 {
+	/*
+	 * Ensure that all stores done by the calling thread are visible
+	 * to the current task before the current task resumes.  We could
+	 * probably optimize this away on most architectures, but by the
+	 * time we've already sent an IPI, the cost of the extra smp_mb()
+	 * is negligible.
+	 */
+	smp_mb();
 	rseq_preempt(current);
 }
 
@@ -154,6 +179,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
 			return -EPERM;
+		ipi_func = ipi_sync_core;
 	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
 		if (!IS_ENABLED(CONFIG_RSEQ))
 			return -EINVAL;
@@ -168,7 +194,8 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 			return -EPERM;
 	}
 
-	if (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1)
+	if (flags != MEMBARRIER_FLAG_SYNC_CORE &&
+	    (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1))
 		return 0;
 
 	/*
@@ -187,8 +214,6 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 
 		if (cpu_id >= nr_cpu_ids || !cpu_online(cpu_id))
 			goto out;
-		if (cpu_id == raw_smp_processor_id())
-			goto out;
 		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu_id)->curr);
 		if (!p || p->mm != mm) {
@@ -203,16 +228,6 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		for_each_online_cpu(cpu) {
 			struct task_struct *p;
 
-			/*
-			 * Skipping the current CPU is OK even through we can be
-			 * migrated at any point. The current CPU, at the point
-			 * where we read raw_smp_processor_id(), is ensured to
-			 * be in program order with respect to the caller
-			 * thread. Therefore, we can skip this CPU from the
-			 * iteration.
-			 */
-			if (cpu == raw_smp_processor_id())
-				continue;
 			p = rcu_dereference(cpu_rq(cpu)->curr);
 			if (p && p->mm == mm)
 				__cpumask_set_cpu(cpu, tmpmask);
@@ -220,12 +235,38 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		rcu_read_unlock();
 	}
 
-	preempt_disable();
-	if (cpu_id >= 0)
+	if (cpu_id >= 0) {
+		/*
+		 * smp_call_function_single() will call ipi_func() if cpu_id
+		 * is the calling CPU.
+		 */
 		smp_call_function_single(cpu_id, ipi_func, NULL, 1);
-	else
-		smp_call_function_many(tmpmask, ipi_func, NULL, 1);
-	preempt_enable();
+	} else {
+		/*
+		 * For regular membarrier, we can save a few cycles by
+		 * skipping the current cpu -- we're about to do smp_mb()
+		 * below, and if we migrate to a different cpu, this cpu
+		 * and the new cpu will execute a full barrier in the
+		 * scheduler.
+		 *
+		 * For SYNC_CORE, we do need a barrier on the current cpu --
+		 * otherwise, if we are migrated and replaced by a different
+		 * task in the same mm just before, during, or after
+		 * membarrier, we will end up with some thread in the mm
+		 * running without a core sync.
+		 *
+		 * For RSEQ, don't rseq_preempt() the caller.  User code
+		 * is not supposed to issue syscalls at all from inside an
+		 * rseq critical section.
+		 */
+		if (flags != MEMBARRIER_FLAG_SYNC_CORE) {
+			preempt_disable();
+			smp_call_function_many(tmpmask, ipi_func, NULL, true);
+			preempt_enable();
+		} else {
+			on_each_cpu_mask(tmpmask, ipi_func, NULL, true);
+		}
+	}
 
 out:
 	if (cpu_id < 0)

