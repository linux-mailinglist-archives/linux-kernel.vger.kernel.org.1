Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761C5304F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405347AbhA0BpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732748AbhAZS6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:58:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620B222228;
        Tue, 26 Jan 2021 18:57:20 +0000 (UTC)
Date:   Tue, 26 Jan 2021 13:57:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Subject: [PATCH] sched/tracing: Reset critical timings on scheduling
Message-ID: <20210126135718.5bf8d273@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's some paths that can call into the scheduler from interrupt disabled
or preempt disabled state. Specifically from the idle thread. The problem is
that it can call the scheduler, still stay idle, and continue. The preempt
and irq disabled tracer considers this a very long latency, and hides real
latencies that we care about.

For example, this is from a preemptirqsoff trace:

  <idle>-0         2dN.1   16us : tick_nohz_account_idle_ticks.isra.0 <-tick_nohz_idle_exit
  <idle>-0         2.N.1   17us : flush_smp_call_function_from_idle <-do_idle
  <idle>-0         2dN.1   17us : flush_smp_call_function_queue <-flush_smp_call_function_from_idle
  <idle>-0         2dN.1   17us : nohz_csd_func <-flush_smp_call_function_queue
  <idle>-0         2.N.1   18us : schedule_idle <-do_idle
  <idle>-0         2dN.1   18us : rcu_note_context_switch <-__schedule
  <idle>-0         2dN.1   18us : rcu_preempt_deferred_qs <-rcu_note_context_switch
  <idle>-0         2dN.1   19us : rcu_preempt_need_deferred_qs <-rcu_preempt_deferred_qs
  <idle>-0         2dN.1   19us : rcu_qs <-rcu_note_context_switch
  <idle>-0         2dN.1   19us : _raw_spin_lock <-__schedule
  <idle>-0         2dN.1   19us : preempt_count_add <-_raw_spin_lock
  <idle>-0         2dN.2   20us : do_raw_spin_trylock <-_raw_spin_lock

do_idle() calls schedule_idle() which calls __schedule, but the latency
continues on for 1.4 milliseconds.

To handle this case, create a new function called
"reset_critical_timings()" which just calls stop_critical_timings() followed
by start_critical_timings() and place this in the scheduler. There's no
reason to worry about timings when the scheduler is called, as that should
allow everything to move forward.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/irqflags.h | 6 ++++++
 kernel/sched/core.c      | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 8de0e1373de7..8649f7dddb04 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -149,6 +149,12 @@ do {						\
 # define start_critical_timings() do { } while (0)
 #endif
 
+static inline void reset_critical_timings(void)
+{
+	stop_critical_timings();
+	start_critical_timings();
+}
+
 /*
  * Wrap the arch provided IRQ routines to provide appropriate checks.
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ff74fca39ed2..dd1c57308f0b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4977,6 +4977,8 @@ static void __sched notrace __schedule(bool preempt)
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
+	reset_critical_timings();
+
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
-- 
2.25.4

