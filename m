Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37DB2932D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbgJTBod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390205AbgJTBoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:20 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DAAC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:19 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t12so321013ilh.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1NCExe7zByQd0h6uT7zTBe3uiNk1NVn7Gv7bd05NqM=;
        b=UlPWdY7Jc8qwqpfm8ulAujaCH2joJvqGOWp0ApyXCbHPgu/p0yFHokIFHjAXx5jkxJ
         11yJ7yPmF7p4ooU9t+BhT9H3aEVjRQGcRj2Lo0Poec+0bXgJjK+ajEnQhRjID1x/Qnnd
         KptyiWiX6eef2rzL3d7zWSrqcXwUYFCRH5m2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1NCExe7zByQd0h6uT7zTBe3uiNk1NVn7Gv7bd05NqM=;
        b=HahfnICvqwWgjfXoYUHHao0ml+0xOZoIyjzghSWoBuma2FPdeYgoXCUHC6CdQBVGa2
         gI3Jl+6HYO+3ubEvXfz0HS3xZbNhSWlSvUJ4PxJ+H3AbbtZqb4EpO4Dv1BIMTehTq6vc
         Xtr83oWZNyNaPqu9FvtY4ootgXt0vK3oohfcd/6vDZz8PD3tTuUnPz3W8s4HJUbDMLw+
         4Ezo9m2kScwthv5hMJqpWhb3ZfucMVvEbPFPBm9uwCotdDt4SlzBGIum/hKVrCYOeCoE
         9ET0NqSPysFB5+S0mvGBOEXRwaFhJZV9PMxhZFPitl7gm7lGs2MTj/Mykg2gra9t9xPh
         UC3w==
X-Gm-Message-State: AOAM5312I0LgWOrD5Xt0IvOAfWr7M6ituo+3V8BCO7zD9LjrdIkfT2Hh
        /YTEYJFKrjmKB74Y9t8NxCVNog==
X-Google-Smtp-Source: ABdhPJyF9tJUPfo6D35CecdO9Aw4K1gnV7FQdNfcpfoYcT8HAzr5xZ6DFjJgnh4oKtWmGDdjt1cyEg==
X-Received: by 2002:a92:512:: with SMTP id q18mr222744ile.147.1603158259105;
        Mon, 19 Oct 2020 18:44:19 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:18 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 11/26] irq_work: Cleanup
Date:   Mon, 19 Oct 2020 21:43:21 -0400
Message-Id: <20201020014336.2076526-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Get rid of the __call_single_node union and clean up the API a little
to avoid external code relying on the structure layout as much.

(Needed for irq_work_is_busy() API in core-scheduling series).

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/gpu/drm/i915/i915_request.c |  4 ++--
 include/linux/irq_work.h            | 33 ++++++++++++++++++-----------
 include/linux/irqflags.h            |  4 ++--
 kernel/bpf/stackmap.c               |  2 +-
 kernel/irq_work.c                   | 18 ++++++++--------
 kernel/printk/printk.c              |  6 ++----
 kernel/rcu/tree.c                   |  3 +--
 kernel/time/tick-sched.c            |  6 ++----
 kernel/trace/bpf_trace.c            |  2 +-
 9 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 0e813819b041..5385b081a376 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -197,7 +197,7 @@ __notify_execute_cb(struct i915_request *rq, bool (*fn)(struct irq_work *wrk))
 
 	llist_for_each_entry_safe(cb, cn,
 				  llist_del_all(&rq->execute_cb),
-				  work.llnode)
+				  work.node.llist)
 		fn(&cb->work);
 }
 
@@ -460,7 +460,7 @@ __await_execution(struct i915_request *rq,
 	 * callback first, then checking the ACTIVE bit, we serialise with
 	 * the completed/retired request.
 	 */
-	if (llist_add(&cb->work.llnode, &signal->execute_cb)) {
+	if (llist_add(&cb->work.node.llist, &signal->execute_cb)) {
 		if (i915_request_is_active(signal) ||
 		    __request_in_flight(signal))
 			__notify_execute_cb_imm(signal);
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 30823780c192..ec2a47a81e42 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -14,28 +14,37 @@
  */
 
 struct irq_work {
-	union {
-		struct __call_single_node node;
-		struct {
-			struct llist_node llnode;
-			atomic_t flags;
-		};
-	};
+	struct __call_single_node node;
 	void (*func)(struct irq_work *);
 };
 
+#define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
+	.node = { .u_flags = (_flags), },			\
+	.func = (_func),					\
+}
+
+#define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
+#define IRQ_WORK_INIT_LAZY(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY)
+#define IRQ_WORK_INIT_HARD(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_HARD_IRQ)
+
+#define DEFINE_IRQ_WORK(name, _f)				\
+	struct irq_work name = IRQ_WORK_INIT(_f)
+
 static inline
 void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 {
-	atomic_set(&work->flags, 0);
-	work->func = func;
+	*work = IRQ_WORK_INIT(func);
 }
 
-#define DEFINE_IRQ_WORK(name, _f) struct irq_work name = {	\
-		.flags = ATOMIC_INIT(0),			\
-		.func  = (_f)					\
+static inline bool irq_work_is_pending(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_PENDING;
 }
 
+static inline bool irq_work_is_busy(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
+}
 
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3ed4e8771b64..fef2d43a7a1d 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -109,12 +109,12 @@ do {						\
 
 # define lockdep_irq_work_enter(__work)					\
 	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
 			current->irq_config = 1;			\
 	  } while (0)
 # define lockdep_irq_work_exit(__work)					\
 	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
 			current->irq_config = 0;			\
 	  } while (0)
 
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 06065fa27124..599041cd0c8a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -298,7 +298,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	if (irqs_disabled()) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			work = this_cpu_ptr(&up_read_work);
-			if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY) {
+			if (irq_work_is_busy(&work->irq_work)) {
 				/* cannot queue more up_read, fallback */
 				irq_work_busy = true;
 			}
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index eca83965b631..fbff25adb574 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -31,7 +31,7 @@ static bool irq_work_claim(struct irq_work *work)
 {
 	int oflags;
 
-	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->flags);
+	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->node.a_flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
 	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
@@ -53,12 +53,12 @@ void __weak arch_irq_work_raise(void)
 static void __irq_work_queue_local(struct irq_work *work)
 {
 	/* If the work is "lazy", handle it from next tick if any */
-	if (atomic_read(&work->flags) & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
+	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
+		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
 		    tick_nohz_tick_stopped())
 			arch_irq_work_raise();
 	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
 			arch_irq_work_raise();
 	}
 }
@@ -102,7 +102,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (cpu != smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
-		__smp_call_single_queue(cpu, &work->llnode);
+		__smp_call_single_queue(cpu, &work->node.llist);
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -142,7 +142,7 @@ void irq_work_single(void *arg)
 	 * to claim that work don't rely on us to handle their data
 	 * while we are in the middle of the func.
 	 */
-	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
+	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->node.a_flags);
 
 	lockdep_irq_work_enter(work);
 	work->func(work);
@@ -152,7 +152,7 @@ void irq_work_single(void *arg)
 	 * no-one else claimed it meanwhile.
 	 */
 	flags &= ~IRQ_WORK_PENDING;
-	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -166,7 +166,7 @@ static void irq_work_run_list(struct llist_head *list)
 		return;
 
 	llnode = llist_del_all(list);
-	llist_for_each_entry_safe(work, tmp, llnode, llnode)
+	llist_for_each_entry_safe(work, tmp, llnode, node.llist)
 		irq_work_single(work);
 }
 
@@ -198,7 +198,7 @@ void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
 
-	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
+	while (irq_work_is_busy(work))
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fe64a49344bf..9ef23d4b07c7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3025,10 +3025,8 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 		wake_up_interruptible(&log_wait);
 }
 
-static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
-	.func = wake_up_klogd_work_func,
-	.flags = ATOMIC_INIT(IRQ_WORK_LAZY),
-};
+static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
+	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);
 
 void wake_up_klogd(void)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef85d69..a41e84f1b55a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1311,8 +1311,6 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
-			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
-			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
@@ -3964,6 +3962,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->cpu_no_qs.b.norm = true;
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
+	rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler);
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81632cd5e3b7..1b734070f028 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -243,10 +243,8 @@ static void nohz_full_kick_func(struct irq_work *work)
 	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
 }
 
-static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
-	.func = nohz_full_kick_func,
-	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
-};
+static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
+	IRQ_WORK_INIT_HARD(nohz_full_kick_func);
 
 /*
  * Kick this CPU if it's full dynticks in order to force it to
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4517c8b66518..a6903912f7a0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1086,7 +1086,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 			return -EINVAL;
 
 		work = this_cpu_ptr(&send_signal_work);
-		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
+		if (irq_work_is_busy(&work->irq_work))
 			return -EBUSY;
 
 		/* Add the current task, which is the target of sending signal,
-- 
2.29.0.rc1.297.gfa9743e501-goog

