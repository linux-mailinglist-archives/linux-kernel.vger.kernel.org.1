Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2F2B7242
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgKQXVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgKQXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:21:15 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:15 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id q22so15653qkq.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajwhDz4Rg5ERPE+hyKxmItX3n9b7wMqRzgmxb1+SNEo=;
        b=K7UFzx9W//sTno7KAXZomMYLzhEM8Bbt4P7ci5nvPA44NtArkBnF+RYot07goPCnxF
         Uby6hyoDHcIs58LU+2zA1PT31ItrWFo0Rvu/VEe7JSI/IjtQuwYuz4xhPtji3WsFd7SY
         hx4zQCtubhtgsSJVoB0j7R3jltBbgMCqkEYZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajwhDz4Rg5ERPE+hyKxmItX3n9b7wMqRzgmxb1+SNEo=;
        b=RUtEPYOhT/BJKQANt4Lk0lvnzQ54ZFD2QR2J+1WBph+IdXAPYAHmg/NUcSgzyDuy45
         k230Q89i4iARfdr7BSblkllKD5OUsm5JLsx3PzWlvQIQbFqtzx9+PVwmjGE2NPr4nfy+
         SrERTtI5r+q3u4oFBqAWpUo4XCf2HtYiHnSfUckVnxoe+UbDolv1+TlmCJCUeVZmDE7I
         F9S5p9xYgggEzlD8a8WbP1co0/xtGoosoeDSMLZ9O3/9rkLXQMO96j9ujPZbBLTzZerq
         gOwL6zlGuXFLK+RuqUTcvMkEtgfAUDEPFi7X9RkFHrXI1r++ulQQjUNDOzjT7gMCcoF5
         lgCQ==
X-Gm-Message-State: AOAM533T1O5sDX4r91XHp10euZgavVp6uHhZ+Xb5WUSOmL8v3/4a5Ny/
        ohUj5ZM6mnfumBowZdwqoviyog==
X-Google-Smtp-Source: ABdhPJxpYop+LKVADtgc8Nrc9esqHlhT01i2KcTU4T87Z+18Z4k1StVhxwyskK8bkOr782Ai0j60Sw==
X-Received: by 2002:a37:a402:: with SMTP id n2mr2065409qke.131.1605655274410;
        Tue, 17 Nov 2020 15:21:14 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:21:13 -0800 (PST)
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
Subject: [PATCH -tip 32/32] sched: Debug bits...
Date:   Tue, 17 Nov 2020 18:20:02 -0500
Message-Id: <20201117232003.3580179-33-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
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
index 01938a2154fd..bbeeb18d460e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -127,6 +127,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool
 
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
 
 DEFINE_STATIC_KEY_TRUE(sched_coresched_supported);
@@ -5486,6 +5494,13 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -5580,6 +5595,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					rq->core->core_forceidle_seq++;
 			}
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -5596,6 +5614,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max) {
 					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
@@ -5617,6 +5637,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* Something should have been selected for current CPU */
 	WARN_ON_ONCE(!next);
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -5658,13 +5679,21 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
 
@@ -5704,6 +5733,10 @@ static bool try_steal_cookie(int this, int that)
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
index a89c7c917cc6..81c8a50ab4c4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10798,6 +10798,15 @@ static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forc
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
2.29.2.299.gdc1121823c-goog

