Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2D297F7F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762866AbgJXW5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 18:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762843AbgJXW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 18:57:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD4BC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 15:57:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a12so6825074ybc.20
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 15:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=od0bOKb53OTwsMG2RpRVzYQ0MusX9rBedfPOWMkzLBI=;
        b=U0b8ex23eEA3xbvDcPSFs2E/zmvatlGCOY+xHOkGr8bzIc3yF9YXGC8yN4djtWjeyW
         mFiQyYDX8ZEllb0YMZujNB7HEZYlacQsrGgFklknOJTfuaREiiUjFLv7uVXxKWwQ/W5f
         f2IdHMG93PDpswurDPL1aZci2LzDVFkzXYTqDtS9MabtXS9R1dOaMe4MmC3DvkyTnKXA
         x2CCKw3UvcJ1haIJRhCae7jzD006jfn0tNutsLg1khl//mys59xR/gdI3NjuaBS/q1Hu
         rPeobqrnny5yhGlqRiXI3IxwcCXlePBG0o5BEC85ngtJWgP+c0gAj2HIdRd9Vs0Fjw1U
         A26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=od0bOKb53OTwsMG2RpRVzYQ0MusX9rBedfPOWMkzLBI=;
        b=hYZpTdb2CPJgjH+vExy1hV9P8bJKsxea6xvBoq/opmtqY//DPktGRwck8tGtbGOX2l
         NEBsoNTlQs7oeIWE+tJrIm1BO1uIr18TBwMiAIpRILYwZInWVeYLq1O98FVdiUghscWr
         CE8OcBNzLZ/k0GaJ7WQnd38jGJG6lsGNvUFe76hALqU+Hgw8DlvWck5PuGfUglVgXVoz
         e7IeqAVeP22XY4/530pDw4z8t5458inD7pTIpTjZdcidY/J/JbrnKs7dpAgXqWggfvLx
         i2n9uQiXGmjI+xQyCoTq4w/wqfhKAtOkq94x9Eg0r+ctCSnWXThuLotm2umpp7dUS/+t
         SFTw==
X-Gm-Message-State: AOAM533mWDL1flmJo5ZQs8t/urGNvyvXG6T2OS9o5SxN4v4SKysdZSEf
        MgpcOLm1I6OkejuRhtfe/+1XcV4=
X-Google-Smtp-Source: ABdhPJxOWIm+WA69NPKQM3ZCmjZJ9pIC89PfVSPRRO4i74Qit5e41jYEtMBDTIxAxcEe2iVhRVV21JU=
Sender: "xii via sendgmr" <xii@hvdc.svl.corp.google.com>
X-Received: from hvdc.svl.corp.google.com ([2620:15c:2cd:202:cad3:ffff:feb5:feb4])
 (user=xii job=sendgmr) by 2002:a25:d105:: with SMTP id i5mr11978374ybg.6.1603580240716;
 Sat, 24 Oct 2020 15:57:20 -0700 (PDT)
Date:   Sat, 24 Oct 2020 15:57:16 -0700
In-Reply-To: <20201024225716.2854163-1-xii@google.com>
Message-Id: <20201024225716.2854163-2-xii@google.com>
Mime-Version: 1.0
References: <20201024225716.2854163-1-xii@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v3 1/1] sched: watchdog: Touch kernel watchdog with sched count
From:   Xi Wang <xii@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of periodically resetting watchdogs from thread context,
this patch simply forces resched and checks rq->sched_count.
Watchdog is reset if the sched count increases. If the same thread
is picked by pick_next_task during resched, there is no context
switch.

With the new method we lose coverage on: a migration/n thread
actually gets picked and we actually context switch to the
migration/n thread. These steps are unlikely to silently fail.
The change would provide nearly the same level of protection with
less latency / jitter.

Suggested-by: Paul Turner <pjt@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Xi Wang <xii@google.com>
---
 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   | 23 +++++++++++++++++++--
 kernel/sched/sched.h  |  6 +++++-
 kernel/watchdog.c     | 47 +++++++++++++------------------------------
 4 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d383cf09e78f..1e3bef9a9cdb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1662,6 +1662,10 @@ extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
 
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+extern unsigned int sched_get_count(int cpu);
+#endif
+
 /**
  * is_idle_task - is the specified task an idle task?
  * @p: the task in question.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8160ab5263f8..378f0f36c402 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4293,8 +4293,6 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 	rcu_sleep_check();
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
-
-	schedstat_inc(this_rq()->sched_count);
 }
 
 static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
@@ -4492,6 +4490,12 @@ static void __sched notrace __schedule(bool preempt)
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+	this_rq()->sched_count++; /* sched count is also used by watchdog */
+#else
+	schedstat_inc(this_rq()->sched_count);
+#endif
+
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		/*
@@ -5117,6 +5121,21 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+
+/**
+ * sched_get_count - get the sched count of a CPU.
+ * @cpu: the CPU in question.
+ *
+ * Return: sched count.
+ */
+unsigned int sched_get_count(int cpu)
+{
+	return cpu_rq(cpu)->sched_count;
+}
+
+#endif
+
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..f23255981d52 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -959,6 +959,11 @@ struct rq {
 	u64			clock_pelt;
 	unsigned long		lost_idle_time;
 
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_SOFTLOCKUP_DETECTOR)
+	/* Also used by watchdog - no longer grouping with other sched stats */
+	unsigned int		sched_count;
+#endif
+
 	atomic_t		nr_iowait;
 
 #ifdef CONFIG_MEMBARRIER
@@ -1036,7 +1041,6 @@ struct rq {
 	unsigned int		yld_count;
 
 	/* schedule() stats */
-	unsigned int		sched_count;
 	unsigned int		sched_goidle;
 
 	/* try_to_wake_up() stats */
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5abb5b22ad13..22f87aded95a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -170,6 +170,7 @@ static bool softlockup_initialized __read_mostly;
 static u64 __read_mostly sample_period;
 
 static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
+static DEFINE_PER_CPU(unsigned int, watchdog_sched_prev);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
@@ -239,6 +240,7 @@ static void set_sample_period(void)
 static void __touch_watchdog(void)
 {
 	__this_cpu_write(watchdog_touch_ts, get_timestamp());
+	__this_cpu_write(watchdog_sched_prev, sched_get_count(smp_processor_id()));
 }
 
 /**
@@ -318,25 +320,6 @@ static void watchdog_interrupt_count(void)
 	__this_cpu_inc(hrtimer_interrupts);
 }
 
-static DEFINE_PER_CPU(struct completion, softlockup_completion);
-static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
-
-/*
- * The watchdog thread function - touches the timestamp.
- *
- * It only runs once every sample_period seconds (4 seconds by
- * default) to reset the softlockup timestamp. If this gets delayed
- * for more than 2*watchdog_thresh seconds then the debug-printout
- * triggers in watchdog_timer_fn().
- */
-static int softlockup_fn(void *data)
-{
-	__touch_watchdog();
-	complete(this_cpu_ptr(&softlockup_completion));
-
-	return 0;
-}
-
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
@@ -351,15 +334,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* kick the hardlockup detector */
 	watchdog_interrupt_count();
 
-	/* kick the softlockup detector */
-	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
-		reinit_completion(this_cpu_ptr(&softlockup_completion));
-		stop_one_cpu_nowait(smp_processor_id(),
-				softlockup_fn, NULL,
-				this_cpu_ptr(&softlockup_stop_work));
-	}
-
-	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
 	if (touch_ts == SOFTLOCKUP_RESET) {
@@ -378,6 +352,18 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		return HRTIMER_RESTART;
 	}
 
+	/* Trigger reschedule for the next round */
+	set_tsk_need_resched(current);
+	set_preempt_need_resched();
+
+	/* sched_count increase in __schedule is taken as watchdog touched */
+	if (sched_get_count(smp_processor_id()) -
+	    __this_cpu_read(watchdog_sched_prev)) {
+		__touch_watchdog();
+		__this_cpu_write(soft_watchdog_warn, false);
+		return HRTIMER_RESTART;
+	}
+
 	/* check for a softlockup
 	 * This is done by making sure a high priority task is
 	 * being scheduled.  The task touches the watchdog to
@@ -443,13 +429,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 static void watchdog_enable(unsigned int cpu)
 {
 	struct hrtimer *hrtimer = this_cpu_ptr(&watchdog_hrtimer);
-	struct completion *done = this_cpu_ptr(&softlockup_completion);
 
 	WARN_ON_ONCE(cpu != smp_processor_id());
 
-	init_completion(done);
-	complete(done);
-
 	/*
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
@@ -479,7 +461,6 @@ static void watchdog_disable(unsigned int cpu)
 	 */
 	watchdog_nmi_disable(cpu);
 	hrtimer_cancel(hrtimer);
-	wait_for_completion(this_cpu_ptr(&softlockup_completion));
 }
 
 static int softlockup_stop_fn(void *data)
-- 
2.29.0.rc2.309.g374f81d7ae-goog

