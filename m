Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8D2B7246
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgKQXWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgKQXUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:32 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC015C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:30 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ek7so105221qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGlc9a+HnaK1a/NuCde6yY5pCgfxdYeTD2NkrQxI9qk=;
        b=qpJZi0Y0jGNbekO/73hIFVR648/GSbiknqox7pCWaw9K8N25RTvOeR43EIM0htU2EU
         URzKpvW8CzXAFaNy39RD/r+KC2ylp8oCpBbRCu7ieaWPF1HQQwq55ZsrsqUwZmyt4K+B
         62wkTgjsoaMXsOcEuAyQ7g5jljxbiOPmEDumE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGlc9a+HnaK1a/NuCde6yY5pCgfxdYeTD2NkrQxI9qk=;
        b=EfHn2/E3eHvhBySAVeSiIe+VRqYKdZLiaTybT7+lekAMRqM0GO6/2gOusbCIxaCcd1
         ryMK3OInFOu75KMktVPfE8sOgvnsmokDqG+97NP+oz2fNQg66i9xTsuVGuqYTXOfc34D
         eBKyEQyBvpFGTztUUUzHY8V++SIpS614QJROzGfPhtUwsdSvHafCq4rBkiRDeLVHzjT3
         Rr82WpmhmpskgkRkEYh8kQAuZG26I65ihg1UnxJi1obnDycRWp+GDT52mY1XGnxvNT/C
         Jv0Rx5eQomeEvY9sPYEK6vL2PEXFypQQP9Z7vk63CjQPhIx59Nk+uSkhL9zlT6hFkXuc
         Icvw==
X-Gm-Message-State: AOAM533iAhg2TjwH5WsCZO7Goj9Jd+SKq2wFIDMA3BqSO7pujJcbPc5m
        LMOyMIzReg5j1f8ggxwbaG3wFQ==
X-Google-Smtp-Source: ABdhPJyBS6UOJ/uoAuL+JGri9ojN5HcN6R8Vbm/vsaL2QCRLE3emJoCrklJaefkIfDHi5YLGjUWBzw==
X-Received: by 2002:a05:6214:20a3:: with SMTP id 3mr1845361qvd.13.1605655229922;
        Tue, 17 Nov 2020 15:20:29 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:29 -0800 (PST)
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 08/32] sched/fair: Fix forced idle sibling starvation corner case
Date:   Tue, 17 Nov 2020 18:19:38 -0500
Message-Id: <20201117232003.3580179-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

If there is only one long running local task and the sibling is
forced idle, it  might not get a chance to run until a schedule
event happens on any cpu in the core.

So we check for this condition during a tick to see if a sibling
is starved and then give it a chance to schedule.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 15 ++++++++-------
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 +-
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bd0b0bbb040..52d0e83072a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5206,16 +5206,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
+	if (rq->core->core_forceidle) {
+		need_sync = true;
+		rq->core->core_forceidle = false;
+	}
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
 		rq_i->core_pick = NULL;
 
-		if (rq_i->core_forceidle) {
-			need_sync = true;
-			rq_i->core_forceidle = false;
-		}
-
 		if (i != cpu)
 			update_rq_clock(rq_i);
 	}
@@ -5335,8 +5334,10 @@ next_class:;
 		if (!rq_i->core_pick)
 			continue;
 
-		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running)
-			rq_i->core_forceidle = true;
+		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
+		    !rq_i->core->core_forceidle) {
+			rq_i->core->core_forceidle = true;
+		}
 
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f53681cd263e..42965c4fd71f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10692,6 +10692,44 @@ static void rq_offline_fair(struct rq *rq)
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_SCHED_CORE
+static inline bool
+__entity_slice_used(struct sched_entity *se, int min_nr_tasks)
+{
+	u64 slice = sched_slice(cfs_rq_of(se), se);
+	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+
+	return (rtime * min_nr_tasks > slice);
+}
+
+#define MIN_NR_TASKS_DURING_FORCEIDLE	2
+static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	/*
+	 * If runqueue has only one task which used up its slice and
+	 * if the sibling is forced idle, then trigger schedule to
+	 * give forced idle task a chance.
+	 *
+	 * sched_slice() considers only this active rq and it gets the
+	 * whole slice. But during force idle, we have siblings acting
+	 * like a single runqueue and hence we need to consider runnable
+	 * tasks on this cpu and the forced idle cpu. Ideally, we should
+	 * go through the forced idle rq, but that would be a perf hit.
+	 * We can assume that the forced idle cpu has atleast
+	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
+	 * if we need to give up the cpu.
+	 */
+	if (rq->core->core_forceidle && rq->cfs.nr_running == 1 &&
+	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
+		resched_curr(rq);
+}
+#else
+static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
+#endif
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -10715,6 +10753,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+	task_tick_core(rq, curr);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 63b28e1843ee..be656ca8693d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1069,12 +1069,12 @@ struct rq {
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
-	unsigned char		core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+	unsigned char		core_forceidle;
 #endif
 };
 
-- 
2.29.2.299.gdc1121823c-goog

