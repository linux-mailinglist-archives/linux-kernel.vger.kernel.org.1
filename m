Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A843023A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbhAYK1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 05:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbhAYKVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:21:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420B4C061794;
        Mon, 25 Jan 2021 01:54:14 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:54:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611568452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En+PvuTxJbTaSF56ABQ0NQAdfK6Gng9dHg0giYYwJFE=;
        b=GxGMLNJTLzBSohgS50rUkkbgTtdwGe2Xj/9xt8GaGsC/JvYFcuJmujjXDfell0RwilfUDr
        kOzJw/mDywtTh9BchdlnjsoTEFlfRbn3YvlgSoE8rB3uoWnMZ5G5QLKpBjn18QRtOG3zVU
        4hTIwAC9Ia5cj8xCaBYwiMn6+hDtqWm5ajNKPF5rGsSXrL02T2GA6l1JX2AZP6LfdWcl9R
        qJLmm8aYF+2sjkzNNMmxNTeZ87+RAe/Y6hk3UeBjnJe/QiZMMZVv7FUlxwb4sI5pdMjuvX
        yaqUk0qs6va7vuRCE1OAyB1H65VRzrxbw0rUH7X2yLX2HbBQvVJZ5AQN3y8tiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611568452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En+PvuTxJbTaSF56ABQ0NQAdfK6Gng9dHg0giYYwJFE=;
        b=tx0I+MKzUAKZuVs+7/M38+6CjW1DLBOtMFDSMheUlFHRVANB4J7DGg951SE5ApmebeYl5U
        OUIC9rzyEi7QTVBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/3 v2] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20210125095412.qxknd2vbsmgtrhqb@linutronix.de>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-4-bigeasy@linutronix.de>
 <20210125083012.GD942655@infradead.org>
 <20210125083204.ahddujk5m6njwbju@linutronix.de>
 <20210125083903.GB945284@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210125083903.GB945284@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With llist_head it is possible to avoid the locking (the irq-off region)
when items are added. This makes it possible to add items on a remote
CPU without additional locking.
llist_add() returns true if the list was previously empty. This can be
used to invoke the SMP function call / raise sofirq only if the first
item was added (otherwise it is already pending).
This simplifies the code a little and reduces the IRQ-off regions.

blk_mq_raise_softirq() needs a preempt-disable section to ensure the
request is enqueued on the same CPU as the softirq is raised.
Some callers (USB-storage) invoke this path in preemptible context.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: Move var initialisation to declaration in
       blk_mq_complete_send_ipi(). Suggested by hch.

 block/blk-mq.c         | 95 +++++++++++++++++-------------------------
 include/linux/blkdev.h |  2 +-
 2 files changed, 40 insertions(+), 57 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 90348ae518461..8429be0d9b8dd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -41,7 +41,7 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
=20
-static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
+static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
=20
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
@@ -567,68 +567,29 @@ void blk_mq_end_request(struct request *rq, blk_statu=
s_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
=20
-/*
- * Softirq action handler - move entries to local list and loop over them
- * while passing them to the queue registered handler.
- */
-static __latent_entropy void blk_done_softirq(struct softirq_action *h)
+static void blk_complete_reqs(struct llist_head *list)
 {
-	struct list_head *cpu_list, local_list;
+	struct llist_node *entry =3D llist_reverse_order(llist_del_all(list));
+	struct request *rq, *next;
=20
-	local_irq_disable();
-	cpu_list =3D this_cpu_ptr(&blk_cpu_done);
-	list_replace_init(cpu_list, &local_list);
-	local_irq_enable();
-
-	while (!list_empty(&local_list)) {
-		struct request *rq;
-
-		rq =3D list_entry(local_list.next, struct request, ipi_list);
-		list_del_init(&rq->ipi_list);
+	llist_for_each_entry_safe(rq, next, entry, ipi_list)
 		rq->q->mq_ops->complete(rq);
-	}
 }
=20
-static void blk_mq_trigger_softirq(struct request *rq)
+static __latent_entropy void blk_done_softirq(struct softirq_action *h)
 {
-	struct list_head *list;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	list =3D this_cpu_ptr(&blk_cpu_done);
-	list_add_tail(&rq->ipi_list, list);
-
-	/*
-	 * If the list only contains our just added request, signal a raise of
-	 * the softirq.  If there are already entries there, someone already
-	 * raised the irq but it hasn't run yet.
-	 */
-	if (list->next =3D=3D &rq->ipi_list)
-		raise_softirq_irqoff(BLOCK_SOFTIRQ);
-	local_irq_restore(flags);
+	blk_complete_reqs(this_cpu_ptr(&blk_cpu_done));
 }
=20
 static int blk_softirq_cpu_dead(unsigned int cpu)
 {
-	/*
-	 * If a CPU goes away, splice its entries to the current CPU
-	 * and trigger a run of the softirq
-	 */
-	local_irq_disable();
-	list_splice_init(&per_cpu(blk_cpu_done, cpu),
-			 this_cpu_ptr(&blk_cpu_done));
-	raise_softirq_irqoff(BLOCK_SOFTIRQ);
-	local_irq_enable();
-
+	blk_complete_reqs(&per_cpu(blk_cpu_done, cpu));
 	return 0;
 }
=20
-
 static void __blk_mq_complete_request_remote(void *data)
 {
-	struct request *rq =3D data;
-
-	blk_mq_trigger_softirq(rq);
+	__raise_softirq_irqoff(BLOCK_SOFTIRQ);
 }
=20
 static inline bool blk_mq_complete_need_ipi(struct request *rq)
@@ -657,6 +618,28 @@ static inline bool blk_mq_complete_need_ipi(struct req=
uest *rq)
 	return cpu_online(rq->mq_ctx->cpu);
 }
=20
+static void blk_mq_complete_send_ipi(struct request *rq)
+{
+	unsigned int cpu =3D rq->mq_ctx->cpu;
+	struct llist_head *list =3D &per_cpu(blk_cpu_done, cpu);
+
+	if (llist_add(&rq->ipi_list, list)) {
+		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
+		smp_call_function_single_async(cpu, &rq->csd);
+	}
+}
+
+static void blk_mq_raise_softirq(struct request *rq)
+{
+	struct llist_head *list;
+
+	preempt_disable();
+	list =3D this_cpu_ptr(&blk_cpu_done);
+	if (llist_add(&rq->ipi_list, list))
+		raise_softirq(BLOCK_SOFTIRQ);
+	preempt_enable();
+}
+
 bool blk_mq_complete_request_remote(struct request *rq)
 {
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
@@ -669,15 +652,15 @@ bool blk_mq_complete_request_remote(struct request *r=
q)
 		return false;
=20
 	if (blk_mq_complete_need_ipi(rq)) {
-		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
-	} else {
-		if (rq->q->nr_hw_queues > 1)
-			return false;
-		blk_mq_trigger_softirq(rq);
+		blk_mq_complete_send_ipi(rq);
+		return true;
 	}
=20
-	return true;
+	if (rq->q->nr_hw_queues =3D=3D 1) {
+		blk_mq_raise_softirq(rq);
+		return true;
+	}
+	return false;
 }
 EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
=20
@@ -3892,7 +3875,7 @@ static int __init blk_mq_init(void)
 	int i;
=20
 	for_each_possible_cpu(i)
-		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
+		init_llist_head(&per_cpu(blk_cpu_done, i));
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
=20
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e015..89a444c5a5833 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -153,7 +153,7 @@ struct request {
 	 */
 	union {
 		struct hlist_node hash;	/* merge hash */
-		struct list_head ipi_list;
+		struct llist_node ipi_list;
 	};
=20
 	/*
--=20
2.30.0

