Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB9F23EAF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHGJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 05:51:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48644 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728226AbgHGJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596793888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlmTabovXZ2fgjLtcolsd78Ty7R3ImRLaiM37Al4fII=;
        b=HrQkcgFrY+mfvydOkfw4/rTLvTVpVX4YBSwJg58fv9jmOCFY0spKKw4bJtCxdj4qBzV0SG
        dM5HTfKAvMu/ITW6DjCzbVt11LC1dn1J2NAdxQlZBL/EK4U/rq3ijck/rEIIQRsfyqi3NE
        62Yo3OBLVi2df2z+Z/oD8cxRHQdyWqE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-vlENfwMGOv-4syvaS43OnQ-1; Fri, 07 Aug 2020 05:51:26 -0400
X-MC-Unique: vlENfwMGOv-4syvaS43OnQ-1
Received: by mail-wr1-f70.google.com with SMTP id e14so538358wrr.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zlmTabovXZ2fgjLtcolsd78Ty7R3ImRLaiM37Al4fII=;
        b=i5WZcrhOyq7r9s2JQErX2IgVhhNtC8eKLgn1HEitBlXa2BDxos7mUJndHAORtVyMi1
         FVplJzTHDn1KFZFDa+1ZnjgNKt1tQilhdXGcb3OzjwdgGUInTQ+SktJr4ofEm3aNjciU
         brQcxY3m8hi6EmBCb7uZvlzYqwAxWW6SRO1/Pog8u44HR0BhFDNTYdc3R5s8Zn44bOuw
         CLY8J6DgZMWHj0TcWToR/+i2T+zNMKqIcaFMPuyfUl61rQCKiHzY/XLb93J6grr64pMp
         41RPuT9965gCgSx47fX3Mi8Dfu6CbViGxTy69qbFj7xrsYPRy82WF5Xou0RI8wDL5CJ/
         n3bA==
X-Gm-Message-State: AOAM532emHtujOy1yD/fz8HBO1ny2nlrVgTCQmqdJSKGYf5YhS8s0Ce/
        3HUR28G1fwpPOotWiG4cqLiKlvz64epPsyGtq7iAUCA/ac+tGfOoAJOTaCr4xjW9P0wEAV5+Q67
        FswhtFSLHSnf2wz5sJZcrOAr5
X-Received: by 2002:adf:bc13:: with SMTP id s19mr11310632wrg.412.1596793885078;
        Fri, 07 Aug 2020 02:51:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylQnElTj7b7gZGH/WtYS0FK/MtmHyuLL9MvzxAkcJAbc6UMM9KREiGoVELmDlyGkfAE5uonQ==
X-Received: by 2002:adf:bc13:: with SMTP id s19mr11310594wrg.412.1596793884582;
        Fri, 07 Aug 2020 02:51:24 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id h14sm9388396wml.30.2020.08.07.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:51:23 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: [RFC PATCH v2 3/6] sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity
Date:   Fri,  7 Aug 2020 11:50:48 +0200
Message-Id: <20200807095051.385985-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807095051.385985-1-juri.lelli@redhat.com>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation of introducing !task sched_dl_entity; move the
bandwidth accounting into {en.de}queue_dl_entity().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c | 128 ++++++++++++++++++++++------------------
 kernel/sched/sched.h    |   6 ++
 2 files changed, 77 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8d909bdb9a119..d4007d1461522 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -275,12 +275,12 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se);
  * up, and checks if the task is still in the "ACTIVE non contending"
  * state or not (in the second case, it updates running_bw).
  */
-static void task_non_contending(struct task_struct *p)
+static void task_non_contending(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
 	struct hrtimer *timer = &dl_se->inactive_timer;
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct task_struct *p = dl_task_of(dl_se);
 	s64 zerolag_time;
 
 	/*
@@ -312,13 +312,14 @@ static void task_non_contending(struct task_struct *p)
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
+
 		if (!dl_task(p) || p->state == TASK_DEAD) {
 			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
 			if (p->state == TASK_DEAD)
-				sub_rq_bw(&p->dl, &rq->dl);
+				sub_rq_bw(dl_se, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
+			__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
 			__dl_clear_params(dl_se);
 			raw_spin_unlock(&dl_b->lock);
 		}
@@ -1477,6 +1478,41 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 {
 	BUG_ON(on_dl_rq(dl_se));
 
+	/*
+	 * Check if a constrained deadline task was activated
+	 * after the deadline but before the next period.
+	 * If that is the case, the task will be throttled and
+	 * the replenishment timer will be set to the next period.
+	 */
+	if (!dl_se->dl_throttled && !dl_is_implicit(dl_se))
+		dl_check_constrained_dl(dl_se);
+
+	if (flags & (ENQUEUE_RESTORE|ENQUEUE_MIGRATING)) {
+		struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+
+		add_rq_bw(dl_se, dl_rq);
+		add_running_bw(dl_se, dl_rq);
+	}
+
+	/*
+	 * If p is throttled, we do not enqueue it. In fact, if it exhausted
+	 * its budget it needs a replenishment and, since it now is on
+	 * its rq, the bandwidth timer callback (which clearly has not
+	 * run yet) will take care of this.
+	 * However, the active utilization does not depend on the fact
+	 * that the task is on the runqueue or not (but depends on the
+	 * task's state - in GRUB parlance, "inactive" vs "active contending").
+	 * In other words, even if a task is throttled its utilization must
+	 * be counted in the active utilization; hence, we need to call
+	 * add_running_bw().
+	 */
+	if (dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
+		if (flags & ENQUEUE_WAKEUP)
+			task_contending(dl_se, flags);
+
+		return;
+	}
+
 	/*
 	 * If this is a wakeup or a new instance, the scheduling
 	 * parameters of the task might need updating. Otherwise,
@@ -1496,9 +1532,28 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 	__enqueue_dl_entity(dl_se);
 }
 
-static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
+static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	__dequeue_dl_entity(dl_se);
+
+	if (flags & (DEQUEUE_SAVE|DEQUEUE_MIGRATING)) {
+		struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+
+		sub_running_bw(dl_se, dl_rq);
+		sub_rq_bw(dl_se, dl_rq);
+	}
+
+	/*
+	 * This check allows to start the inactive timer (or to immediately
+	 * decrease the active utilization, if needed) in two cases:
+	 * when the task blocks and when it is terminating
+	 * (p->state == TASK_DEAD). We can handle the two cases in the same
+	 * way, because from GRUB's point of view the same thing is happening
+	 * (the task moves from "active contending" to "active non contending"
+	 * or "inactive")
+	 */
+	if (flags & DEQUEUE_SLEEP)
+		task_non_contending(dl_se);
 }
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
@@ -1528,72 +1583,31 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
-	/*
-	 * Check if a constrained deadline task was activated
-	 * after the deadline but before the next period.
-	 * If that is the case, the task will be throttled and
-	 * the replenishment timer will be set to the next period.
-	 */
-	if (!p->dl.dl_throttled && !dl_is_implicit(&p->dl))
-		dl_check_constrained_dl(&p->dl);
-
-	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & ENQUEUE_RESTORE) {
-		add_rq_bw(&p->dl, &rq->dl);
-		add_running_bw(&p->dl, &rq->dl);
-	}
-
-	/*
-	 * If p is throttled, we do not enqueue it. In fact, if it exhausted
-	 * its budget it needs a replenishment and, since it now is on
-	 * its rq, the bandwidth timer callback (which clearly has not
-	 * run yet) will take care of this.
-	 * However, the active utilization does not depend on the fact
-	 * that the task is on the runqueue or not (but depends on the
-	 * task's state - in GRUB parlance, "inactive" vs "active contending").
-	 * In other words, even if a task is throttled its utilization must
-	 * be counted in the active utilization; hence, we need to call
-	 * add_running_bw().
-	 */
-	if (p->dl.dl_throttled && !(flags & ENQUEUE_REPLENISH)) {
-		if (flags & ENQUEUE_WAKEUP)
-			task_contending(&p->dl, flags);
-
-		return;
-	}
+	if (p->on_rq == TASK_ON_RQ_MIGRATING)
+		flags |= ENQUEUE_MIGRATING;
 
 	enqueue_dl_entity(&p->dl, pi_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && !p->dl.dl_throttled && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
 
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
-	dequeue_dl_entity(&p->dl);
-	dequeue_pushable_dl_task(rq, p);
+	dequeue_dl_entity(&p->dl, flags);
+
+	if (!p->dl.dl_throttled)
+		dequeue_pushable_dl_task(rq, p);
 }
 
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
-	__dequeue_task_dl(rq, p, flags);
 
-	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & DEQUEUE_SAVE) {
-		sub_running_bw(&p->dl, &rq->dl);
-		sub_rq_bw(&p->dl, &rq->dl);
-	}
+	if (p->on_rq == TASK_ON_RQ_MIGRATING)
+		flags |= DEQUEUE_MIGRATING;
 
-	/*
-	 * This check allows to start the inactive timer (or to immediately
-	 * decrease the active utilization, if needed) in two cases:
-	 * when the task blocks and when it is terminating
-	 * (p->state == TASK_DEAD). We can handle the two cases in the same
-	 * way, because from GRUB's point of view the same thing is happening
-	 * (the task moves from "active contending" to "active non contending"
-	 * or "inactive")
-	 */
-	if (flags & DEQUEUE_SLEEP)
-		task_non_contending(p);
+	__dequeue_task_dl(rq, p, flags);
 }
 
 /*
@@ -2373,7 +2387,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	 * will reset the task parameters.
 	 */
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
-		task_non_contending(p);
+		task_non_contending(&p->dl);
 
 	if (!task_on_rq_queued(p)) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62304d4de99cc..d3db8c7d8b641 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1741,6 +1741,10 @@ extern const u32		sched_prio_to_wmult[40];
  * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the location
  *        in the runqueue.
  *
+ * NOCLOCK - skip the update_rq_clock() (avoids double updates)
+ *
+ * MIGRATION - p->on_rq == TASK_ON_RQ_MIGRATING (used for DEADLINE)
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
@@ -1751,6 +1755,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
+#define DEQUEUE_MIGRATING	0x80 /* Matches ENQUEUE_MIGRATING */
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
@@ -1764,6 +1769,7 @@ extern const u32		sched_prio_to_wmult[40];
 #else
 #define ENQUEUE_MIGRATED	0x00
 #endif
+#define ENQUEUE_MIGRATING	0x80
 
 #define RETRY_TASK		((void *)-1UL)
 
-- 
2.26.2

