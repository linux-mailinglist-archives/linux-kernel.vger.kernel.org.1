Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359303011F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbhAWBSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbhAWBRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:17:50 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E9C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:10 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 143so7084279qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7rbpUAatvw7ig66Jq89S+FocysWUeQC2At8lxkex9us=;
        b=pYexIY2pTEphRVJ8ZwPY47RGKMfceTKez6idyXsbSOFYXk1B7U+aHA1LL4iFv8akZL
         pvN+WQz8i28qOv/2RaDKzF2b8OBbtL67KX4vKbS3SlQVAukvvzWi4S+Wav4iaJeJb05T
         jw5qGQ8qtxribnbAincX0b8WyCB4zjS7OaC04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rbpUAatvw7ig66Jq89S+FocysWUeQC2At8lxkex9us=;
        b=KUOVAvfneNIdayLb3PPcEtTunsYeJqUjA5aGmMdfUaehjFoj9Wk9SKd5yJL3qe9iu9
         Fy1l0Oz+8lDGkYwDI99y0140gtUSkQEjPuCsh8L/2+rvneUw7p/FXt6zExWB7YC6xJT6
         N3QguERDnHWrmTVnKFUKdhWf63745RXTgqLX+7Kw/tgeCe5DoztA9hvwaDFXFSyZV51A
         sOFDz/UT+CA4fhAk666YY4FsF80PZhSWCIEzXXGA0JtAFMXmgX1PQbd3IASLdiSdkoVH
         TwMu3V/BZ11NdPNcgCEpt4NEyEKlJctggZdPVeooZO+Uif0kr/bzJiM/6XoLa+WkUs5c
         BkhA==
X-Gm-Message-State: AOAM5339+m8Z2xju4Jz1zjQpwNEdcekP3VGhQj7F4sJ1wT/JgrVIOBe1
        0tV31Z4V6H6xUUZU1D21fi6uKA==
X-Google-Smtp-Source: ABdhPJzAwKOEocSzJSuvsCeXNRiOLUOFtX2FH4kqo1FcokxtyyXg2kvY8zY7gQfUD7/AQiZKuoJ6bA==
X-Received: by 2002:a37:78c4:: with SMTP id t187mr7406134qkc.139.1611364629422;
        Fri, 22 Jan 2021 17:17:09 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x15sm2516840qtr.72.2021.01.22.17.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 17:17:08 -0800 (PST)
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
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v10 1/5] sched: migration changes for core scheduling
Date:   Fri, 22 Jan 2021 20:17:00 -0500
Message-Id: <20210123011704.1901835-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123011704.1901835-1-joel@joelfernandes.org>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
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
 kernel/sched/fair.c  | 33 +++++++++++++++++---
 kernel/sched/sched.h | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7f90765f7fd..fddd7c44bbf3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1921,6 +1921,13 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
 			continue;
 
+		/*
+		 * Skip this cpu if source task's cookie does not match
+		 * with CPU's core cookie.
+		 */
+		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
+			continue;
+
 		env->dst_cpu = cpu;
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;
@@ -5867,11 +5874,15 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		struct rq *rq = cpu_rq(i);
+
+		if (!sched_core_cookie_match(rq, p))
+			continue;
+
 		if (sched_idle_cpu(i))
 			return i;
 
 		if (available_idle_cpu(i)) {
-			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
@@ -6129,7 +6140,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+
+		if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
+		    sched_cpu_cookie_match(cpu_rq(cpu), p))
 			break;
 	}
 
@@ -7530,8 +7543,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
@@ -7566,6 +7580,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
+	/*
+	 * Don't migrate task if the task's cookie does not match
+	 * with the destination CPU's core cookie.
+	 */
+	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
+		return 0;
+
 	/* Record that we found atleast one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
@@ -8792,6 +8813,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 					p->cpus_ptr))
 			continue;
 
+		/* Skip over this group if no cookie matched */
+		if (!sched_group_cookie_match(cpu_rq(this_cpu), p, group))
+			continue;
+
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_span(group));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3efcbc779a75..d6efb1ffc08c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1122,6 +1122,7 @@ static inline bool is_migration_disabled(struct task_struct *p)
 
 #ifdef CONFIG_SCHED_CORE
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
 static inline bool sched_core_enabled(struct rq *rq)
 {
@@ -1138,6 +1139,61 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
+/*
+ * Helpers to check if the CPU's core cookie matches with the task's cookie
+ * when core scheduling is enabled.
+ * A special case is that the task's cookie always matches with CPU's core
+ * cookie if the CPU is in an idle core.
+ */
+static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	return rq->core->core_cookie == p->core_cookie;
+}
+
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
+static inline bool sched_group_cookie_match(struct rq *rq,
+					    struct task_struct *p,
+					    struct sched_group *group)
+{
+	int cpu;
+
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	for_each_cpu_and(cpu, sched_group_span(group), p->cpus_ptr) {
+		if (sched_core_cookie_match(rq, p))
+			return true;
+	}
+	return false;
+}
+
 extern void queue_core_balance(struct rq *rq);
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
@@ -1158,6 +1214,22 @@ static inline void queue_core_balance(struct rq *rq)
 {
 }
 
+static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	return true;
+}
+
+static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	return true;
+}
+
+static inline bool sched_group_cookie_match(struct rq *rq,
+					    struct task_struct *p,
+					    struct sched_group *group)
+{
+	return true;
+}
 #endif /* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.30.0.280.ga3ce27912f-goog

