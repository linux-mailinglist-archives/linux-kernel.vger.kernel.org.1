Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B148F29D367
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgJ1Vnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:43:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgJ1Vna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8ioTgi5/iOyyIcZobX5xUeNFHRYeCVw+XsAdMQ3PTEk=; b=e+U793XHytukNR2+6VOm8Gmih+
        tRl+wOC2iqM9iyZPDTDixUraoYrLQuwmKK1aPEAttYXZhUj58HG2Y4rwRIP4IxuGDAUg2eCS9qeGq
        NnFziU9OZaDAuq6Wh2Bl6x37lrM1YowEAVyA38ITJsT8QPv8/y00O89//o9vdwYayzbbUhS2B9zHp
        n/8DcPN4pKxfK4f9h7NWCf21VEVPBpv9Hxdh/hDGo9Ab7pOn4SAaB/NQsRZ/LQB7XcDYKRxThGV1y
        Ax4Wv3SFjCqbHglmMNHLY+N5yrDh9LgpVFVkRQl8GxeIN0+wSPPsZEPWSRDYWWPksm3nTAMnoKOeJ
        nYCjINkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXjON-0005Kq-SI; Wed, 28 Oct 2020 11:13:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 560A93060F2;
        Wed, 28 Oct 2020 12:13:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D758E20B285AA; Wed, 28 Oct 2020 12:13:21 +0100 (CET)
Message-ID: <20201028111221.526249871@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 12:07:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [PATCH v3 5/6] irq_work: Provide irq_work_queue_remote()
References: <20201028110707.971887448@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the traditional irq_work relies on the ability to self-IPI, it
makes sense to provide an unconditional irq_work_queue_remote()
interface.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irq_work.h |   17 ++++--
 kernel/irq_work.c        |  129 ++++++++++++++++++++++++++++-------------------
 kernel/rcu/tree.c        |    5 +
 3 files changed, 94 insertions(+), 57 deletions(-)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -46,22 +46,29 @@ static inline bool irq_work_is_busy(stru
 	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
 }
 
+#ifdef CONFIG_IRQ_WORK
+
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
 
 void irq_work_tick(void);
 void irq_work_sync(struct irq_work *work);
 
-#ifdef CONFIG_IRQ_WORK
 #include <asm/irq_work.h>
 
 void irq_work_run(void);
 bool irq_work_needs_cpu(void);
-void irq_work_single(void *arg);
-#else
-static inline bool irq_work_needs_cpu(void) { return false; }
+
+#else /* !CONFIG_IRQ_WORK */
+
 static inline void irq_work_run(void) { }
-static inline void irq_work_single(void *arg) { }
+static inline bool irq_work_needs_cpu(void) { return false; }
+
+#endif /* CONFIG_IRQ_WORK */
+
+#ifdef CONFIG_SMP
+extern int irq_work_queue_remote(int cpu, struct irq_work *work);
+extern void irq_work_single(void *arg);
 #endif
 
 #endif /* _LINUX_IRQ_WORK_H */
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -20,10 +20,7 @@
 #include <linux/smp.h>
 #include <asm/processor.h>
 
-#ifdef CONFIG_IRQ_WORK
-
-static DEFINE_PER_CPU(struct llist_head, raised_list);
-static DEFINE_PER_CPU(struct llist_head, lazy_list);
+#if defined(CONFIG_IRQ_WORK) || defined(CONFIG_SMP)
 
 /*
  * Claim the entry so that no one else will poke at it.
@@ -43,6 +40,82 @@ static bool irq_work_claim(struct irq_wo
 	return true;
 }
 
+void irq_work_single(void *arg)
+{
+	struct irq_work *work = arg;
+	int flags;
+
+	/*
+	 * Clear the PENDING bit, after this point the @work can be re-used.
+	 * The PENDING bit acts as a lock, and we own it, so we can clear it
+	 * without atomic ops.
+	 */
+	flags = atomic_read(&work->node.a_flags);
+	flags &= ~IRQ_WORK_PENDING;
+	atomic_set(&work->node.a_flags, flags);
+
+	/*
+	 * See irq_work_claim().
+	 */
+	smp_mb();
+
+	lockdep_irq_work_enter(flags);
+	work->func(work);
+	lockdep_irq_work_exit(flags);
+
+	/*
+	 * Clear the BUSY bit, if set, and return to the free state if no-one
+	 * else claimed it meanwhile.
+	 */
+	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
+}
+
+/*
+ * Synchronize against the irq_work @entry, ensures the entry is not
+ * currently in use.
+ */
+void irq_work_sync(struct irq_work *work)
+{
+	lockdep_assert_irqs_enabled();
+
+	while (irq_work_is_busy(work))
+		cpu_relax();
+}
+EXPORT_SYMBOL_GPL(irq_work_sync);
+
+#endif /* CONFIG_IRQ_WORK || CONFIG_SMP */
+
+#ifdef CONFIG_SMP
+
+static void __irq_work_queue_remote(int cpu, struct irq_work *work)
+{
+	/* Arch remote IPI send/receive backend aren't NMI safe */
+	WARN_ON_ONCE(in_nmi());
+	__smp_call_single_queue(cpu, &work->node.llist);
+}
+
+int irq_work_queue_remote(int cpu, struct irq_work *work)
+{
+	/*
+	 * Ensures preemption is disabled in the caller.
+	 */
+	WARN_ON_ONCE(cpu == smp_processor_id());
+
+	if (!irq_work_claim(work))
+		return -EBUSY;
+
+	__irq_work_queue_remote(cpu, work);
+
+	return 0;
+}
+
+#endif /* CONFIG_SMP */
+
+#ifdef CONFIG_IRQ_WORK
+
+static DEFINE_PER_CPU(struct llist_head, raised_list);
+static DEFINE_PER_CPU(struct llist_head, lazy_list);
+
 void __weak arch_irq_work_raise(void)
 {
 	/*
@@ -101,9 +174,7 @@ bool irq_work_queue_on(struct irq_work *
 
 	preempt_disable();
 	if (cpu != smp_processor_id()) {
-		/* Arch remote IPI send/receive backend aren't NMI safe */
-		WARN_ON_ONCE(in_nmi());
-		__smp_call_single_queue(cpu, &work->node.llist);
+		__irq_work_queue_remote(cpu, work);
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -131,36 +202,6 @@ bool irq_work_needs_cpu(void)
 	return true;
 }
 
-void irq_work_single(void *arg)
-{
-	struct irq_work *work = arg;
-	int flags;
-
-	/*
-	 * Clear the PENDING bit, after this point the @work can be re-used.
-	 * The PENDING bit acts as a lock, and we own it, so we can clear it
-	 * without atomic ops.
-	 */
-	flags = atomic_read(&work->node.a_flags);
-	flags &= ~IRQ_WORK_PENDING;
-	atomic_set(&work->node.a_flags, flags);
-
-	/*
-	 * See irq_work_claim().
-	 */
-	smp_mb();
-
-	lockdep_irq_work_enter(flags);
-	work->func(work);
-	lockdep_irq_work_exit(flags);
-
-	/*
-	 * Clear the BUSY bit, if set, and return to the free state if no-one
-	 * else claimed it meanwhile.
-	 */
-	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
-}
-
 static void irq_work_run_list(struct llist_head *list)
 {
 	struct irq_work *work, *tmp;
@@ -196,17 +237,5 @@ void irq_work_tick(void)
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
 
-/*
- * Synchronize against the irq_work @entry, ensures the entry is not
- * currently in use.
- */
-void irq_work_sync(struct irq_work *work)
-{
-	lockdep_assert_irqs_enabled();
-
-	while (irq_work_is_busy(work))
-		cpu_relax();
-}
-EXPORT_SYMBOL_GPL(irq_work_sync);
-
 #endif /* CONFIG_IRQ_WORK */
+
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1308,13 +1308,14 @@ static int rcu_implicit_dynticks_qs(stru
 			resched_cpu(rdp->cpu);
 			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 		}
-		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
-		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
+#ifdef CONFIG_IRQ_WORK
+		if (!rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
 		}
+#endif
 	}
 
 	return 0;


