Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB6294423
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409688AbgJTU5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409679AbgJTU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:57:33 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44CC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 13:57:33 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m126so3027181qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3ETZGj7tP4LPJJX3gTbO22rzqGgKjA0wOd4KtHhuByU=;
        b=Mg4pnpFgFKZZJBLzQ1qKeZ2YNGqf4bRkQY1L7o+R+QJz9nj32CjbBqYnEXUkMAG1/b
         RQdeScZhFceccdfmq704FhXDQy9EYIYrKqq+EYLWiDOwYVGRALkSda67+K4nO8W59eNA
         Cr7CzzReKIblPFw7QHq2oGrxpSvARlvTLBgqZJxqZT/X7/A88nWkK+sZzHpTKXraD9Og
         Lq8rduExp4/1hNA6DT+vxslpt2uK/VMz1TpBQ4OWEA2D6mLYS7mYLCcUUNTJNgIpZR/N
         TciwuTSfnGOldH4VlfhI7pnSvLobOEwidC6TBx9efvCwU5iHfBPiuRJreB4VbCtK4IKL
         tS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3ETZGj7tP4LPJJX3gTbO22rzqGgKjA0wOd4KtHhuByU=;
        b=mo/Hp1rqCbwSlRsPvgAt69cJOxjxeTwaLN7z8wuQXjm46sfjBpDCSgogrd1uTqHfF/
         Tl4nrJpApGrlrPhJMEE9C/2/K3N0pBIE0XR4/cI+Bmj5IdJBPeMT96l+MD7PlalUudcl
         eb5+hGVTxWiuzIzi/z39i99y1r9qifgwzNX1g/6cQbxDc5dvbDIwi/+jsVnnUQBf4QMh
         0Ao4BEVGCq3Io7HxNukpxTSLL1QpvKJx9f5HjXfp2idwdXfTkkHV2Nkws3uS7Rc6LvCl
         NNoLar66SRsQW+M2lQPPmVAyZqmk7r0E6toT4DU4SsHjBQaHWtmoYN6o6aKS5Tg03VEx
         Uj4A==
X-Gm-Message-State: AOAM530+xalH5NMHi9GGe3+937wi+/6HCwJIzzx4Us8c10KFdXszxnpX
        EUeLjNpB+Pc2xPvaJ9KKpY9Ir54=
X-Google-Smtp-Source: ABdhPJwDW3clQJXKUnWrBisMrcF+iUX4tXxHX7jKs1d7Buc4OsKLzobJUjJHBgyfRWM7iXfyloX8fXE=
Sender: "xii via sendgmr" <xii@hvdc.svl.corp.google.com>
X-Received: from hvdc.svl.corp.google.com ([2620:15c:2cd:202:cad3:ffff:feb5:feb4])
 (user=xii job=sendgmr) by 2002:a0c:90f1:: with SMTP id p104mr5553548qvp.15.1603227452413;
 Tue, 20 Oct 2020 13:57:32 -0700 (PDT)
Date:   Tue, 20 Oct 2020 13:57:04 -0700
In-Reply-To: <20201020205704.1741543-1-xii@google.com>
Message-Id: <20201020205704.1741543-2-xii@google.com>
Mime-Version: 1.0
References: <20201020205704.1741543-1-xii@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 1/1] sched: watchdog: Touch kernel watchdog with sched count
From:   Xi Wang <xii@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Xi Wang <xii@google.com>, Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of kernel watchdog is to test whether scheduler can
still schedule tasks on a cpu. In order to reduce latency / jitter
from periodically invoking watchdog reset in thread context, we can
simply test if pick_next_task can run. This is done by forcing resched
and checking rq->sched_count. Compared to actually resetting watchdog
from cpu stop / migration threads, we lose coverage on: a migration
thread actually get picked and we actually context switch to the
migration thread. These steps are unlikely to silently fail. The
change would provide nearly the same level of protection with less
overhead.

With this patch we can still switch back to the old method with the
boot option watchdog_touch_with_thread. However code for the old
method can be completely removed in the future.

Suggested-by: Paul Turner <pjt@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Xi Wang <xii@google.com>
---
 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   | 23 ++++++++++++++++++++--
 kernel/sched/sched.h  |  6 +++++-
 kernel/watchdog.c     | 44 +++++++++++++++++++++++++++++++++++++------
 4 files changed, 68 insertions(+), 9 deletions(-)

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
index 5abb5b22ad13..df7f7e585502 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -170,6 +170,7 @@ static bool softlockup_initialized __read_mostly;
 static u64 __read_mostly sample_period;
 
 static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
+static DEFINE_PER_CPU(unsigned int, watchdog_sched_prev);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
@@ -177,6 +178,12 @@ static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
+/*
+ * Touch watchdog if __schedule and pick_next_task can run - avoid actual
+ * context switch and associated latency for most cases
+ */
+int __read_mostly watchdog_touch_with_sched = 1;
+
 static int __init nowatchdog_setup(char *str)
 {
 	watchdog_user_enabled = 0;
@@ -198,6 +205,13 @@ static int __init watchdog_thresh_setup(char *str)
 }
 __setup("watchdog_thresh=", watchdog_thresh_setup);
 
+static int __init watchdog_touch_with_thread_setup(char *str)
+{
+	watchdog_touch_with_sched = 0;
+	return 1;
+}
+__setup("watchdog_touch_with_thread", watchdog_touch_with_thread_setup);
+
 static void __lockup_detector_cleanup(void);
 
 /*
@@ -239,6 +253,9 @@ static void set_sample_period(void)
 static void __touch_watchdog(void)
 {
 	__this_cpu_write(watchdog_touch_ts, get_timestamp());
+	if (watchdog_touch_with_sched)
+		__this_cpu_write(watchdog_sched_prev,
+				 sched_get_count(smp_processor_id()));
 }
 
 /**
@@ -351,12 +368,14 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* kick the hardlockup detector */
 	watchdog_interrupt_count();
 
-	/* kick the softlockup detector */
-	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
-		reinit_completion(this_cpu_ptr(&softlockup_completion));
-		stop_one_cpu_nowait(smp_processor_id(),
-				softlockup_fn, NULL,
-				this_cpu_ptr(&softlockup_stop_work));
+	if (!watchdog_touch_with_sched) {
+		/* kick the softlockup detector */
+		if (completion_done(this_cpu_ptr(&softlockup_completion))) {
+			reinit_completion(this_cpu_ptr(&softlockup_completion));
+			stop_one_cpu_nowait(smp_processor_id(),
+					softlockup_fn, NULL,
+					this_cpu_ptr(&softlockup_stop_work));
+		}
 	}
 
 	/* .. and repeat */
@@ -378,6 +397,19 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		return HRTIMER_RESTART;
 	}
 
+	if (watchdog_touch_with_sched) {
+		/* Trigger reschedule for the next round */
+		set_tsk_need_resched(current);
+		set_preempt_need_resched();
+		/* sched_count increase in __schedule is taken as watchdog touched */
+		if (sched_get_count(smp_processor_id()) -
+		    __this_cpu_read(watchdog_sched_prev)) {
+			__touch_watchdog();
+			__this_cpu_write(soft_watchdog_warn, false);
+			return HRTIMER_RESTART;
+		}
+	}
+
 	/* check for a softlockup
 	 * This is done by making sure a high priority task is
 	 * being scheduled.  The task touches the watchdog to
-- 
2.29.0.rc1.297.gfa9743e501-goog

