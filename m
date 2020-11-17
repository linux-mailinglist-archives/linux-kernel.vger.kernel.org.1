Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D591B2B722B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgKQXUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgKQXUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:41 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F59C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:41 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so34962qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqxkUw/2njEbECtZHtH/lT98UIAIBnUv8/xT/civ1zE=;
        b=DhbfpYrMStoC+iUCivqWPz9RLwwt1XQOeqKE2/Fbch9sbNz9/8eecc4iI+AUrONfY0
         yu5rjMPmEZ4uJKe0n7rOT8KrMSVfCSw4O0D8UK+vDVpFvunXLRZPRBTcm1awqjPRtv3X
         5jSYRQEHE4yYLu29oonpq7zYarGV/wZCGC4Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqxkUw/2njEbECtZHtH/lT98UIAIBnUv8/xT/civ1zE=;
        b=DI+cWbKya7iBiCIapjTCd/5vLIsq3PVHSmOWGppBLZdnA7ERfRe6AOD83LJ3xy4KgR
         ueW6wbe4GrtX3tvv8QQnOgaf6mZVVSaI+qdI9nCfC5rgvX1eQFM+oxH0HFJNeurln60f
         PVNtQJ754XKzLDDwi7HVE1AAXsXew0PCl2kwEUsh87b+dJSNkTUSL3/hn2KJr3eBGhPr
         fWv6DLZs0pPNWinE8W1PKxSTD8yEnoXNBpBsMUSKgEGIAbyuWcUqVfbbLYvRI2BFyyJC
         GQ+wISgsYUzU1aUdP7xasVyosJqdhQFpaGalWCeUO/bONnFm2LMJRDWYGO9ybLPfSLfM
         jU9g==
X-Gm-Message-State: AOAM532wHAeZtq+bPM+eaHDBVSpPXp2Jt7Lf1GF74jKbnNCNeFP9yRdj
        nUlIL2kcx5NsVL3m3tH/RBYijQ==
X-Google-Smtp-Source: ABdhPJy88wCGnx8Pqfuh+lSbIeTeaCYr4OBuHsVU/OSL+cpo3lvI/1P3Jh2Euo3Jnn6nEC9c4v22Pg==
X-Received: by 2002:a37:6554:: with SMTP id z81mr2028475qkb.423.1605655240843;
        Tue, 17 Nov 2020 15:20:40 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:40 -0800 (PST)
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 14/32] sched: migration changes for core scheduling
Date:   Tue, 17 Nov 2020 18:19:44 -0500
Message-Id: <20201117232003.3580179-15-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
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
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c  | 64 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h | 29 ++++++++++++++++++++
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index de82f88ba98c..ceb3906c9a8a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1921,6 +1921,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
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
@@ -5867,11 +5876,17 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
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
@@ -6129,8 +6144,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
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
@@ -7530,8 +7555,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
@@ -7566,6 +7592,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
 
@@ -8792,6 +8827,25 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
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
index e72942a9ee11..de553d39aa40 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1135,6 +1135,35 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 
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
2.29.2.299.gdc1121823c-goog

