Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BFE2F1BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389382AbhAKRMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:12:33 -0500
Received: from foss.arm.com ([217.140.110.172]:33220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbhAKRMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:12:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1477312FC;
        Mon, 11 Jan 2021 09:11:36 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A6BD3F70D;
        Mon, 11 Jan 2021 09:11:35 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 3/4] cpu/hotplug: Add cpuhp_invoke_callback_range()
Date:   Mon, 11 Jan 2021 17:10:46 +0000
Message-Id: <1610385047-92151-4-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

Factorizing and unifying cpuhp callback range invocations, especially for
the hotunplug path, where two different ways of decrementing were used. The
first one, decrements before the callback is called:

 cpuhp_thread_fun()
     state = st->state;
     st->state--;
     cpuhp_invoke_callback(state);

The second one, after:

 take_down_cpu()|cpuhp_down_callbacks()
     cpuhp_invoke_callback(st->state);
     st->state--;

This is problematic for rolling back the steps in case of error, as
depending on the decrement, the rollback will start from N or N-1. It also
makes tracing inconsistent, between steps run in the cpuhp thread and
the others.

Additionally, avoid useless cpuhp_thread_fun() loops by skipping empty
steps.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
---
 kernel/cpu.c | 150 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 90 insertions(+), 60 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bcd7b2a..aebec3a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -135,6 +135,11 @@ static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
 	return cpuhp_hp_states + state;
 }
 
+static bool cpuhp_step_empty(bool bringup, struct cpuhp_step *step)
+{
+	return bringup ? !step->startup.single : !step->teardown.single;
+}
+
 /**
  * cpuhp_invoke_callback _ Invoke the callbacks for a given state
  * @cpu:	The cpu for which the callback should be invoked
@@ -157,26 +162,24 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
-
-		if (!(bringup ? step->startup.single : step->teardown.single))
-			return 0;
-
 		return -EAGAIN;
 	}
 
+	if (cpuhp_step_empty(bringup, step)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
 	if (!step->multi_instance) {
 		WARN_ON_ONCE(lastp && *lastp);
 		cb = bringup ? step->startup.single : step->teardown.single;
-		if (!cb)
-			return 0;
+
 		trace_cpuhp_enter(cpu, st->target, state, cb);
 		ret = cb(cpu);
 		trace_cpuhp_exit(cpu, st->state, state, ret);
 		return ret;
 	}
 	cbm = bringup ? step->startup.multi : step->teardown.multi;
-	if (!cbm)
-		return 0;
 
 	/* Single invocation for instance add/remove */
 	if (node) {
@@ -475,6 +478,11 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 static inline void
 cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 {
+	st->target = prev_state;
+
+	if (st->rollback)
+		return;
+
 	st->rollback = true;
 
 	/*
@@ -488,7 +496,6 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 			st->state++;
 	}
 
-	st->target = prev_state;
 	st->bringup = !st->bringup;
 }
 
@@ -591,10 +598,53 @@ static int finish_cpu(unsigned int cpu)
  * Hotplug state machine related functions
  */
 
-static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
+/*
+ * Get the next state to run. Empty ones will be skipped. Returns true if a
+ * state must be run.
+ *
+ * st->state will be modified ahead of time, to match state_to_run, as if it
+ * has already ran.
+ */
+static bool cpuhp_next_state(bool bringup,
+			     enum cpuhp_state *state_to_run,
+			     struct cpuhp_cpu_state *st,
+			     enum cpuhp_state target)
 {
-	for (st->state--; st->state > st->target; st->state--)
-		cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
+	do {
+		if (bringup) {
+			if (st->state >= target)
+				return false;
+
+			*state_to_run = ++st->state;
+		} else {
+			if (st->state <= target)
+				return false;
+
+			*state_to_run = st->state--;
+		}
+
+		if (!cpuhp_step_empty(bringup, cpuhp_get_step(*state_to_run)))
+			break;
+	} while (true);
+
+	return true;
+}
+
+static int cpuhp_invoke_callback_range(bool bringup,
+				       unsigned int cpu,
+				       struct cpuhp_cpu_state *st,
+				       enum cpuhp_state target)
+{
+	enum cpuhp_state state;
+	int err = 0;
+
+	while (cpuhp_next_state(bringup, &state, st, target)) {
+		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
+		if (err)
+			break;
+	}
+
+	return err;
 }
 
 static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
@@ -617,16 +667,12 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 	enum cpuhp_state prev_state = st->state;
 	int ret = 0;
 
-	while (st->state < target) {
-		st->state++;
-		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-		if (ret) {
-			if (can_rollback_cpu(st)) {
-				st->target = prev_state;
-				undo_cpu_up(cpu, st);
-			}
-			break;
-		}
+	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
+	if (ret) {
+		cpuhp_reset_state(st, prev_state);
+		if (can_rollback_cpu(st))
+			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st,
+							    prev_state));
 	}
 	return ret;
 }
@@ -690,17 +736,9 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		state = st->cb_state;
 		st->should_run = false;
 	} else {
-		if (bringup) {
-			st->state++;
-			state = st->state;
-			st->should_run = (st->state < st->target);
-			WARN_ON_ONCE(st->state > st->target);
-		} else {
-			state = st->state;
-			st->state--;
-			st->should_run = (st->state > st->target);
-			WARN_ON_ONCE(st->state < st->target);
-		}
+		st->should_run = cpuhp_next_state(bringup, &state, st, st->target);
+		if (!st->should_run)
+			goto end;
 	}
 
 	WARN_ON_ONCE(!cpuhp_is_ap_state(state));
@@ -728,6 +766,7 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		st->should_run = false;
 	}
 
+end:
 	cpuhp_lock_release(bringup);
 	lockdep_release_cpus_lock();
 
@@ -881,19 +920,18 @@ static int take_cpu_down(void *_param)
 		return err;
 
 	/*
-	 * We get here while we are in CPUHP_TEARDOWN_CPU state and we must not
-	 * do this step again.
+	 * Must be called from CPUHP_TEARDOWN_CPU, which means, as we are going
+	 * down, that the current state is CPUHP_TEARDOWN_CPU - 1.
 	 */
-	WARN_ON(st->state != CPUHP_TEARDOWN_CPU);
-	st->state--;
+	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
+
 	/* Invoke the former CPU_DYING callbacks */
-	for (; st->state > target; st->state--) {
-		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
+	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
+	if (ret)
 		/*
 		 * DYING must not fail!
 		 */
 		WARN_ON_ONCE(ret);
-	}
 
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
@@ -975,27 +1013,22 @@ void cpuhp_report_idle_dead(void)
 				 cpuhp_complete_idle_dead, st, 0);
 }
 
-static void undo_cpu_down(unsigned int cpu, struct cpuhp_cpu_state *st)
-{
-	for (st->state++; st->state < st->target; st->state++)
-		cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
-}
-
 static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 				enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state = st->state;
 	int ret = 0;
 
-	for (; st->state > target; st->state--) {
-		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
-		if (ret) {
-			st->target = prev_state;
-			if (st->state < prev_state)
-				undo_cpu_down(cpu, st);
-			break;
-		}
+	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
+	if (ret) {
+
+		cpuhp_reset_state(st, prev_state);
+
+		if (st->state < prev_state)
+			WARN_ON(cpuhp_invoke_callback_range(true, cpu, st,
+							    prev_state));
 	}
+
 	return ret;
 }
 
@@ -1164,14 +1197,12 @@ void notify_cpu_starting(unsigned int cpu)
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
-	while (st->state < target) {
-		st->state++;
-		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
+	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
+	if (ret)
 		/*
 		 * STARTING must not fail!
 		 */
 		WARN_ON_ONCE(ret);
-	}
 }
 
 /*
@@ -1777,8 +1808,7 @@ static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
 	 * If there's nothing to do, we done.
 	 * Relies on the union for multi_instance.
 	 */
-	if ((bringup && !sp->startup.single) ||
-	    (!bringup && !sp->teardown.single))
+	if (cpuhp_step_empty(bringup, sp))
 		return 0;
 	/*
 	 * The non AP bound callbacks can fail on bringup. On teardown
-- 
2.7.4

