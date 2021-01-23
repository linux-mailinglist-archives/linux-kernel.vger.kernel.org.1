Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868163011F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAWBTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbhAWBSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:18:39 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A88C061793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:17 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z11so7094747qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5ebNQKkhq/Ch6vr88Tgt4LKrWTE+sKlgNVfMrjel3c=;
        b=GgsfeKnqA5/bJIbK4E7M3v8vmYFDlyb5KJSAvn4NrzBLqCYWUYd4GmqMElmkcyY+ak
         oLDWCBHFdw/g+kqSEZzkXVfArsEx8nJyHMHBEaGgeqdukKOFVlVguIdxJqHkKZg0RRRQ
         yTwGatb0bRb8dUcASJLWFA90Gg+TK4lumw4mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5ebNQKkhq/Ch6vr88Tgt4LKrWTE+sKlgNVfMrjel3c=;
        b=WwsY4EwrURwJcg5Qpuf7U1EI+UdLUX1mUqqWgdAWi8HZ0AJ3evCxGiw2qm9+UTjVtw
         lr+GaAUlzulHPT9HJj+kHPJYAxKCqZ7onzuX9ZhkfbSCvnsR5PQ/Q81oAEZvxNU+2HjS
         ZC8MOIUJIaLFu1VdvEdrtDqRKm4k8lZ0wjAFyTBdA8S9ga7yuQV7XF0LfjCetIRMEgrm
         WV4uDJdQJKXaMZPzvzGnQwDIkGrOltTE5WVtB4h6Xzi9vZ6NQqWT522Swd9SO11kxMwM
         HzokWV18eN5fUwW1EK6lwIokbF5UXNANP6HB4FTHqnZ4p24aF/Pv5yGROA7hUENvqVRO
         dG6Q==
X-Gm-Message-State: AOAM531L7wbaGm9S/npw7yhMdhIGHRRuEZDue73U3WfQCNRZmd/pGr33
        eaKfqT6a2cEMNPArLEQktCu+MA==
X-Google-Smtp-Source: ABdhPJzY42NgK8hmlkLgwRwLo3r7myfrZNksYHVBY5AWViSLBmoFV3oecFEKwq7mLF5uxZedFuBxeA==
X-Received: by 2002:a37:74c5:: with SMTP id p188mr3460097qkc.263.1611364636578;
        Fri, 22 Jan 2021 17:17:16 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x15sm2516840qtr.72.2021.01.22.17.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 17:17:16 -0800 (PST)
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
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v10 5/5] sched: Debug bits...
Date:   Fri, 22 Jan 2021 20:17:04 -0500
Message-Id: <20210123011704.1901835-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123011704.1901835-1-joel@joelfernandes.org>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 35 ++++++++++++++++++++++++++++++++++-
 kernel/sched/fair.c |  9 +++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a3844e2e7379..56ba2ca4f922 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -106,6 +106,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -296,12 +300,16 @@ static void __sched_core_enable(void)
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
+
+	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
 {
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
+
+	printk("core sched disabled\n");
 }
 
 void sched_core_get(void)
@@ -5237,6 +5245,13 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			set_next_task(rq, next);
 		}
 
+		trace_printk("pick pre selected (%u %u %u): %s/%d %lx\n",
+			     rq->core->core_task_seq,
+			     rq->core->core_pick_seq,
+			     rq->core_sched_seq,
+			     next->comm, next->pid,
+			     next->core_cookie);
+
 		rq->core_pick = NULL;
 		return next;
 	}
@@ -5331,6 +5346,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					rq->core->core_forceidle_seq++;
 			}
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -5347,6 +5365,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max) {
 					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
@@ -5368,6 +5388,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* Something should have been selected for current CPU */
 	WARN_ON_ONCE(!next);
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -5409,13 +5430,21 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 
 		/* Did we break L1TF mitigation requirements? */
-		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+		if (unlikely(!cookie_match(next, rq_i->core_pick))) {
+			trace_printk("[%d]: cookie mismatch. %s/%d/0x%lx/0x%lx\n",
+				     rq_i->cpu, rq_i->core_pick->comm,
+				     rq_i->core_pick->pid,
+				     rq_i->core_pick->core_cookie,
+				     rq_i->core->core_cookie);
+			WARN_ON_ONCE(1);
+		}
 
 		if (rq_i->curr == rq_i->core_pick) {
 			rq_i->core_pick = NULL;
 			continue;
 		}
 
+		trace_printk("IPI(%d)\n", i);
 		resched_curr(rq_i);
 	}
 
@@ -5455,6 +5484,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fddd7c44bbf3..ebeeebc4223a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10769,6 +10769,15 @@ static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forc
 			cfs_rq->forceidle_seq = fi_seq;
 		}
 
+
+		if (root) {
+			old = cfs_rq->min_vruntime_fi;
+			new = cfs_rq->min_vruntime;
+			root = false;
+			trace_printk("cfs_rq(min_vruntime_fi) %lu->%lu\n",
+				     old, new);
+		}
+
 		cfs_rq->min_vruntime_fi = cfs_rq->min_vruntime;
 	}
 }
-- 
2.30.0.280.ga3ce27912f-goog

