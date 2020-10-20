Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC492932CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgJTBoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390197AbgJTBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D657EC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p9so331672ilr.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzFeLd3Ul9UYvJhyhWguM7eMGuk5M7WHuEML0jXsWiQ=;
        b=AxgB6+vWNXD/bGD3Ct/8etWge7ecjLIazUQe0x+mzC3OIenqFcllfkG+/QuW8j7gtQ
         FCLZ8GgCGR6r6lzRTRdXFw5RmiZ/M9OI+xnx9hNMHt/TCqxUJJe/KsvtZL8hcJ2WtgGp
         DT/Tv3JIWAr8ypKXLG/MvlIuikBrAs5qbNRYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzFeLd3Ul9UYvJhyhWguM7eMGuk5M7WHuEML0jXsWiQ=;
        b=HmFWakXrqxd/ups8F1IQhrlBsG0QXEnoY8ONpzYB/el5ZY9eNboSK7HaomsEIArdeq
         HPEsXwL838Fq6b5waObRyq0EU7o6+OfplHZGYsWv5PXo55p2k6hX+pb3lcbZ0MOW0UzV
         3YcJnU8Ob2zUSJYrM1m1fOO+V82HlZg9fNmKETGCLQEbvzQ0aS1ZRjfjZKTx5U/95u/U
         5McxIngD9THx0LEYdvjsvaVn/ybGr0TmeDSoQqpDON6iKgUHcFeuVsZihICaeI4AxmPa
         UvjExGwpaRtg4ehYUOw8ySB/4fo1LAMVw7TEfYPFbyDOE1QgMsXZ9HPgl8UBRBNQSGXt
         2WFA==
X-Gm-Message-State: AOAM5303w3TyKxCbm49aUwUQGhPSv2OFQRirmLgJniFETfYQMAqUYZJ+
        Ulbe3aHGTi8OPRmQnsf0LQiNiQ==
X-Google-Smtp-Source: ABdhPJxtJiEorwgIw5K821aXhnwzt1vki2c5A1qI+pe/JbpZI6STW4minAhTmEbI8tb3/z/84gmSmQ==
X-Received: by 2002:a92:dcc7:: with SMTP id b7mr252188ilr.210.1603158256201;
        Mon, 19 Oct 2020 18:44:16 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:15 -0700 (PDT)
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 10/26] sched: migration changes for core scheduling
Date:   Mon, 19 Oct 2020 21:43:20 -0400
Message-Id: <20201020014336.2076526-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aubrey Li <aubrey.li@intel.com>

 - Don't migrate if there is a cookie mismatch
     Load balance tries to move task from busiest CPU to the
     destination CPU. When core scheduling is enabled, if the
     task's cookie does not match with the destination CPU's
     core cookie, this task will be skipped by this CPU. This
     mitigates the forced idle time on the destination CPU.

 - Select cookie matched idle CPU
     In the fast path of task wakeup, select the first cookie matched
     idle CPU instead of the first idle CPU.

 - Find cookie matched idlest CPU
     In the slow path of task wakeup, find the idlest CPU whose core
     cookie matches with task's cookie

 - Don't migrate task if cookie not match
     For the NUMA load balance, don't migrate task to the CPU whose
     core cookie does not match with task's cookie

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---
 kernel/sched/fair.c  | 64 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h | 29 ++++++++++++++++++++
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9cae08c3fca1..93a3b874077d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1912,6 +1912,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
 			continue;
 
+#ifdef CONFIG_SCHED_CORE
+		/*
+		 * Skip this cpu if source task's cookie does not match
+		 * with CPU's core cookie.
+		 */
+		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
+			continue;
+#endif
+
 		env->dst_cpu = cpu;
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;
@@ -5846,11 +5855,17 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		struct rq *rq = cpu_rq(i);
+
+#ifdef CONFIG_SCHED_CORE
+		if (!sched_core_cookie_match(rq, p))
+			continue;
+#endif
+
 		if (sched_idle_cpu(i))
 			return i;
 
 		if (available_idle_cpu(i)) {
-			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
@@ -6108,8 +6123,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			break;
+
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
+#ifdef CONFIG_SCHED_CORE
+			/*
+			 * If Core Scheduling is enabled, select this cpu
+			 * only if the process cookie matches core cookie.
+			 */
+			if (sched_core_enabled(cpu_rq(cpu)) &&
+			    p->core_cookie == cpu_rq(cpu)->core->core_cookie)
+#endif
+				break;
+		}
 	}
 
 	time = cpu_clock(this) - time;
@@ -7495,8 +7520,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU.
+	 * 3) task's cookie does not match with this CPU's core cookie
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU.
 	 */
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
@@ -7531,6 +7557,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
+#ifdef CONFIG_SCHED_CORE
+	/*
+	 * Don't migrate task if the task's cookie does not match
+	 * with the destination CPU's core cookie.
+	 */
+	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
+		return 0;
+#endif
+
 	/* Record that we found atleast one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
@@ -8757,6 +8792,25 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 					p->cpus_ptr))
 			continue;
 
+#ifdef CONFIG_SCHED_CORE
+		if (sched_core_enabled(cpu_rq(this_cpu))) {
+			int i = 0;
+			bool cookie_match = false;
+
+			for_each_cpu(i, sched_group_span(group)) {
+				struct rq *rq = cpu_rq(i);
+
+				if (sched_core_cookie_match(rq, p)) {
+					cookie_match = true;
+					break;
+				}
+			}
+			/* Skip over this group if no cookie matched */
+			if (!cookie_match)
+				continue;
+		}
+#endif
+
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_span(group));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58f741b52103..d0c7a7f87d73 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1111,6 +1111,35 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
 
+/*
+ * Helper to check if the CPU's core cookie matches with the task's cookie
+ * when core scheduling is enabled.
+ * A special case is that the task's cookie always matches with CPU's core
+ * cookie if the CPU is in an idle core.
+ */
+static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	bool idle_core = true;
+	int cpu;
+
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
+		if (!available_idle_cpu(cpu)) {
+			idle_core = false;
+			break;
+		}
+	}
+
+	/*
+	 * A CPU in an idle core is always the best choice for tasks with
+	 * cookies.
+	 */
+	return idle_core || rq->core->core_cookie == p->core_cookie;
+}
+
 extern void queue_core_balance(struct rq *rq);
 
 #else /* !CONFIG_SCHED_CORE */
-- 
2.29.0.rc1.297.gfa9743e501-goog

