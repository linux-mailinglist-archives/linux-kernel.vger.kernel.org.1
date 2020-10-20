Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4F2932C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbgJTBoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgJTBoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EA5C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 67so558069iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlj6uMgqye3sNdx+NX3t8GEGIV8O1B0tM0quVu2qzg0=;
        b=RW80QFNL4iqRO+dc1gvPnm/ISemqsNIJpzAYBArJKVUJ96Y8SwG92ht2qjuMUUNSre
         s0+k4M9OYZsP1u0BSTEc00AKJmgGr6vq29YDrClEP7dnO6x1JFc/vLKmpWCMSSrgPAJ4
         A0dOPk3ydEtMrzy2BIXLrBbsNRIJhKlYP/M7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlj6uMgqye3sNdx+NX3t8GEGIV8O1B0tM0quVu2qzg0=;
        b=pwtUrUWwkbcg8FOIepfN8gBnmiCuCtWVqWfpfrYA4H5MXavVLNzVOq817KEbj+wYs6
         XT+e5hatmBrFOrbw2cbry9+i8xJp6l3xlqk2H9dt7T4/8u1JCl7NwC7AF9GwhBfmU1BJ
         m/XBbiPAYXaYFveCLMw8OeRSPfX0lOvLLCaAelQlR6M/fqpcHNGxv04QThrVXLeU3Iq9
         o6b3Z6o/reUcoEbuy8WiL5hcOZ9eSeZbObhAS9NoRaWyHwTWApD4HrXlFbOAs3xTVaL1
         AdEMwfCRIggRpxyMvSAr56d+RECJwYni8AIgm3kqAO00YJXPsT5k4SXT6Olj1MIyINao
         z8FQ==
X-Gm-Message-State: AOAM530lW2lXUwkWyMN3OoTDnC5eKSXn5w4Zt+CjR0GJtShNvO7mPPvB
        pLx1mgTNxgxDPn+6qviehqC2Uw==
X-Google-Smtp-Source: ABdhPJypfCUbTHlrXHTWQp5tciMnc21zC+6hYk2ViHQVOw2t5YTidPsMJ+jmmrLZyP0C+nbqAKAhsg==
X-Received: by 2002:a6b:e51a:: with SMTP id y26mr484709ioc.86.1603158246978;
        Mon, 19 Oct 2020 18:44:06 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:06 -0700 (PDT)
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
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 07/26] sched/fair: Fix forced idle sibling starvation corner case
Date:   Mon, 19 Oct 2020 21:43:17 -0400
Message-Id: <20201020014336.2076526-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
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
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/core.c  | 15 ++++++++-------
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 +-
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 12030b77bd6d..469428979182 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4710,16 +4710,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
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
@@ -4839,8 +4838,10 @@ next_class:;
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
index 58f670e5704d..56bea0decda1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10652,6 +10652,44 @@ static void rq_offline_fair(struct rq *rq)
 
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
@@ -10675,6 +10713,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+	task_tick_core(rq, curr);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2b6e0bf61720..884d23d5e55d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1056,12 +1056,12 @@ struct rq {
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
2.29.0.rc1.297.gfa9743e501-goog

