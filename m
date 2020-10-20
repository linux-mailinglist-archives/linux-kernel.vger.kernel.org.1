Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C5A2932DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbgJTBpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390367AbgJTBpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:45:04 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC88C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:45:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h21so548274iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4C8dUB/9Jo4qwamzkPufztF7ulEP3jYiSSgQLHPr9bM=;
        b=SiqCA8Ogi0ND++DOcDhO0yhtYg/DMp2xDdXHHKB7C/BNX+oI/Deu4ghyJNcTEw4zV7
         6anxLrvdKAxLSIr4PGcXR3BdCqNJs4dPvhUG4YolBUywmDv6t+a2l8ZGk7bRFdRpHA+H
         419GwM+c0sRUwkwR8cQ4RLua1vqG4sicYvzPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4C8dUB/9Jo4qwamzkPufztF7ulEP3jYiSSgQLHPr9bM=;
        b=ivrF6psy8XWKhNCPIhQTgaN4gQByZhtGuzfeMXYJurzLVrQQHWkJDS06Hpe/CjxSHR
         OCAvqvHvvHxeISVTHhvmLjM+cWny92c4uqftG0UMSMk2J/dd7hI8SFZs1e5REjtMwEkW
         MvYPf/fdJ5BqAIbSnxmAHOIUtYzK9R8zcnGPE/KukFGX8Rr/yOo28PsjZwRPIfRgzmvF
         VqeC4u6P41Gafzx50pJTskUlqA8LvdYVVLxtLV8Y/MgVdK9v7TI49jRMqZeMQK+98xpw
         Pv4k6kqCtj+DyMHBh2svYVGtl4e6yeiaSiFDvSWjdbsINDoT8pEnGV/LyITxB4L46WGU
         iThw==
X-Gm-Message-State: AOAM532FfEMB/iQVfCbXod0o9z4AUbPe2BmxSRqYFAIGKnR97+atB9eT
        nM2ppHpUU4/WgzjUUqeBCDUFvA==
X-Google-Smtp-Source: ABdhPJzPJPMgZimsBNADOJi+a0ZMAepTJsVl4+T5YNij5QG/zLjsIPdPromSWussV/C6PR96/ibhSg==
X-Received: by 2002:a5d:9e16:: with SMTP id h22mr471097ioh.141.1603158303585;
        Mon, 19 Oct 2020 18:45:03 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:45:02 -0700 (PDT)
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 26/26] sched: Debug bits...
Date:   Mon, 19 Oct 2020 21:43:36 -0400
Message-Id: <20201020014336.2076526-27-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 211e0784675f..61758b5478d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -127,6 +127,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -317,12 +321,16 @@ static void __sched_core_enable(void)
 
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
@@ -4978,6 +4986,13 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -5066,6 +5081,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
+				trace_printk("unconstrained pick: %s/%d %lx\n",
+					     next->comm, next->pid, next->core_cookie);
 				goto done;
 			}
 
@@ -5074,6 +5091,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 			rq_i->core_pick = p;
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -5090,6 +5110,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
@@ -5120,6 +5142,7 @@ next_class:;
 
 	/* Something should have been selected for current CPU */
 	WARN_ON_ONCE(!next);
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -5155,13 +5178,21 @@ next_class:;
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
 
@@ -5209,6 +5240,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
-- 
2.29.0.rc1.297.gfa9743e501-goog

