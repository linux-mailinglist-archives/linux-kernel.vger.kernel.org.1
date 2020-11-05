Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2952A7848
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgKEHum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKEHum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604562638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B2rsPct0rX/zJhpKmlaRNx4HMmaPfAWnNai2JfPkgnE=;
        b=aTn4qnQeR/47KCTEGq8mpalH0SuGZ/LTjis7izU+9LvnlsFG/5tnLXfXs2s6NoE+uEHb9f
        k6xcnCiUdOCk1N3CI+uLX8Zs1c8OC0ubFuwp5oA9sBv1q1VNKa5gzWsTQUOsnaVf8jkRty
        Y8f01Gt4CEB/gBOjl+iO0RfYu5xL/Eo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-XAIELEp-OuO7EYZJp5ufrw-1; Thu, 05 Nov 2020 02:50:37 -0500
X-MC-Unique: XAIELEp-OuO7EYZJp5ufrw-1
Received: by mail-wr1-f69.google.com with SMTP id w6so370383wrk.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 23:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2rsPct0rX/zJhpKmlaRNx4HMmaPfAWnNai2JfPkgnE=;
        b=fUYkE1fLP9Md+Fs1IKJt51w9/RIm59Q9gFZXDNHl6wMnge9+4D4aDMupoji0B/+d13
         VOYQK2EJRIPIoVGwFxg8WEzvSBvqWxi+7Cv0UeLMYXXOOUReGeXBFI6bf4FlYSxKUgzN
         y/HpOk2piCRdilw9zqk9i4BLIdtoTiknlZiL6MaiHg86LaajvZjQ9G/F4jGUPV4BbssS
         XoK+JB9yq25Dc5YSS3WJVLfwzanp8fhQKk6gp8TseWPgFKZ4SsQkHpdcGkqTL6Cqo12o
         sBxxY3muGgsQYd8yzXFEdGpINcGR89CW5l5apxig0JTJUlFq/t9KZWviKMhjZdm+5Ezk
         1M2w==
X-Gm-Message-State: AOAM533XeCBwkRFVJsehnz2ULbJfYRfneaGJ6u1FCOc5sReXyn3pZmUQ
        qzmhkkY8GxI5HcDnpPwpsCrR7yEUqDaa6T2/GvvD2Q6ln7aeFpF/ZtOz9qytJjNUpu3tgkJMyYh
        FdYQi1tk3Tnap7ohxy7P/LomL
X-Received: by 2002:adf:c547:: with SMTP id s7mr1284857wrf.222.1604562635562;
        Wed, 04 Nov 2020 23:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmQlxBPjmbwG/1LUV66TaVodWG8XQYhJ3ZpG09EgGne4kyDINi85bnzyT+fDj8S8qRjQfhKA==
X-Received: by 2002:adf:c547:: with SMTP id s7mr1284831wrf.222.1604562635271;
        Wed, 04 Nov 2020 23:50:35 -0800 (PST)
Received: from localhost.localdomain.com ([151.29.191.209])
        by smtp.gmail.com with ESMTPSA id t2sm1218628wrq.56.2020.11.04.23.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 23:50:34 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, glenn@aurora.tech
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        valentin.schneider@arm.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched/deadline: Fix priority inheritance with multiple scheduling classes
Date:   Thu,  5 Nov 2020 08:50:21 +0100
Message-Id: <20201105075021.1302386-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glenn reported that "an application [he developed produces] a BUG in
deadline.c when a SCHED_DEADLINE task contends with CFS tasks on nested
PTHREAD_PRIO_INHERIT mutexes.  I believe the bug is triggered when a CFS
task that was boosted by a SCHED_DEADLINE task boosts another CFS task
(nested priority inheritance).

 ------------[ cut here ]------------
 kernel BUG at kernel/sched/deadline.c:1462!
 invalid opcode: 0000 [#1] PREEMPT SMP
 CPU: 12 PID: 19171 Comm: dl_boost_bug Tainted: ...
 Hardware name: ...
 RIP: 0010:enqueue_task_dl+0x335/0x910
 Code: ...
 RSP: 0018:ffffc9000c2bbc68 EFLAGS: 00010002
 RAX: 0000000000000009 RBX: ffff888c0af94c00 RCX: ffffffff81e12500
 RDX: 000000000000002e RSI: ffff888c0af94c00 RDI: ffff888c10b22600
 RBP: ffffc9000c2bbd08 R08: 0000000000000009 R09: 0000000000000078
 R10: ffffffff81e12440 R11: ffffffff81e1236c R12: ffff888bc8932600
 R13: ffff888c0af94eb8 R14: ffff888c10b22600 R15: ffff888bc8932600
 FS:  00007fa58ac55700(0000) GS:ffff888c10b00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fa58b523230 CR3: 0000000bf44ab003 CR4: 00000000007606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  ? intel_pstate_update_util_hwp+0x13/0x170
  rt_mutex_setprio+0x1cc/0x4b0
  task_blocks_on_rt_mutex+0x225/0x260
  rt_spin_lock_slowlock_locked+0xab/0x2d0
  rt_spin_lock_slowlock+0x50/0x80
  hrtimer_grab_expiry_lock+0x20/0x30
  hrtimer_cancel+0x13/0x30
  do_nanosleep+0xa0/0x150
  hrtimer_nanosleep+0xe1/0x230
  ? __hrtimer_init_sleeper+0x60/0x60
  __x64_sys_nanosleep+0x8d/0xa0
  do_syscall_64+0x4a/0x100
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x7fa58b52330d
 ...
 ---[ end trace 0000000000000002 ]—

He also provided a simple reproducer creating the situation below:

 So the execution order of locking steps are the following
 (N1 and N2 are non-deadline tasks. D1 is a deadline task. M1 and M2
 are mutexes that are enabled * with priority inheritance.)

 Time moves forward as this timeline goes down:

 N1              N2               D1
 |               |                |
 |               |                |
 Lock(M1)        |                |
 |               |                |
 |             Lock(M2)           |
 |               |                |
 |               |              Lock(M2)
 |               |                |
 |             Lock(M1)           |
 |             (!!bug triggered!) |

Daniel reported a similar situation as well, by just letting ksoftirqd
run with DEADLINE (and eventually block on a mutex).

Problem is that boosted entities (Priority Inheritance) use static
DEADLINE parameters of the top priority waiter. However, there might be
cases where top waiter could be a non-DEADLINE entity that is currently
boosted by a DEADLINE entity from a different lock chain (i.e., nested
priority chains involving entities of non-DEADLINE classes). In this
case, top waiter static DEADLINE parameters could be null (initialized
to 0 at fork()) and replenish_dl_entity() would hit a BUG().

Fix this by keeping track of the original donor and using its parameters
when a task is boosted.

Reported-by: Glenn Elliott <glenn@aurora.tech>
Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---

This is actually a v2 attempt (didn't keep $SUBJECT since it's quite
different than v1 [1]) to fix this problem.

v1 was admittedly pretty ugly. Hope this looks slightly better (even
though there is of course overhead associated to the additional
pointer).

Again, the proper way to fix this is by proxy execution. But, I don't
think we are yet there and this problem needs a quick band-aid.

One could probably also think to complicate the present approach and
actually perform accounting using donor's dynamic parameters, but I fear
it would be of little benefit since it would still bring all the
problems associated to affinities. So, I'd propose let's try to fix all
this properly with proxy and just avoid crashes in the meantime.

1 - 20191112075056.19971-1-juri.lelli@redhat.com
---
 include/linux/sched.h   |  9 +++++
 kernel/sched/core.c     | 13 ++++++--
 kernel/sched/deadline.c | 74 ++++++++++++++++++++---------------------
 3 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..db29ab492181 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -571,6 +571,15 @@ struct sched_dl_entity {
 	 * time.
 	 */
 	struct hrtimer inactive_timer;
+
+#ifdef CONFIG_RT_MUTEXES
+	/*
+	 * Priority Inheritance. When a DEADLINE scheduling entity is boosted
+	 * pi_se points to the donor, otherwise points to the dl_se it belongs
+	 * to (the original one/itself).
+	 */
+	struct sched_dl_entity *pi_se;
+#endif
 };
 
 #ifdef CONFIG_UCLAMP_TASK
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6f533bb7d3b9..e10aba6c363d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4908,19 +4908,26 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		    (pi_task && dl_prio(pi_task->prio) &&
 		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
 			p->dl.dl_boosted = 1;
+			p->dl.pi_se = pi_task->dl.pi_se;
 			queue_flag |= ENQUEUE_REPLENISH;
-		} else
+		} else {
 			p->dl.dl_boosted = 0;
+			p->dl.pi_se = &p->dl;
+		}
 		p->sched_class = &dl_sched_class;
 	} else if (rt_prio(prio)) {
-		if (dl_prio(oldprio))
+		if (dl_prio(oldprio)) {
 			p->dl.dl_boosted = 0;
+			p->dl.pi_se = &p->dl;
+		}
 		if (oldprio < prio)
 			queue_flag |= ENQUEUE_HEAD;
 		p->sched_class = &rt_sched_class;
 	} else {
-		if (dl_prio(oldprio))
+		if (dl_prio(oldprio)) {
 			p->dl.dl_boosted = 0;
+			p->dl.pi_se = &p->dl;
+		}
 		if (rt_prio(oldprio))
 			p->rt.timeout = 0;
 		p->sched_class = &fair_sched_class;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c6ce90fbb7ac..7e2367a08dfd 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -43,6 +43,18 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_se)
 	return !RB_EMPTY_NODE(&dl_se->rb_node);
 }
 
+#ifdef CONFIG_RT_MUTEXES
+static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
+{
+	return dl_se->pi_se;
+}
+#else
+static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
+{
+	return dl_se;
+}
+#endif
+
 #ifdef CONFIG_SMP
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -752,21 +764,20 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
  * could happen are, typically, a entity voluntarily trying to overcome its
  * runtime, or it just underestimated it during sched_setattr().
  */
-static void replenish_dl_entity(struct sched_dl_entity *dl_se,
-				struct sched_dl_entity *pi_se)
+static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
 
-	BUG_ON(pi_se->dl_runtime <= 0);
+	BUG_ON(pi_of(dl_se)->dl_runtime <= 0);
 
 	/*
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
 	 */
 	if (dl_se->dl_deadline == 0) {
-		dl_se->deadline = rq_clock(rq) + pi_se->dl_deadline;
-		dl_se->runtime = pi_se->dl_runtime;
+		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime = pi_of(dl_se)->dl_runtime;
 	}
 
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
@@ -779,8 +790,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
 	 * arbitrary large.
 	 */
 	while (dl_se->runtime <= 0) {
-		dl_se->deadline += pi_se->dl_period;
-		dl_se->runtime += pi_se->dl_runtime;
+		dl_se->deadline += pi_of(dl_se)->dl_period;
+		dl_se->runtime += pi_of(dl_se)->dl_runtime;
 	}
 
 	/*
@@ -794,8 +805,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
 	 */
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
 		printk_deferred_once("sched: DL replenish lagged too much\n");
-		dl_se->deadline = rq_clock(rq) + pi_se->dl_deadline;
-		dl_se->runtime = pi_se->dl_runtime;
+		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime = pi_of(dl_se)->dl_runtime;
 	}
 
 	if (dl_se->dl_yielded)
@@ -828,8 +839,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se,
  * task with deadline equal to period this is the same of using
  * dl_period instead of dl_deadline in the equation above.
  */
-static bool dl_entity_overflow(struct sched_dl_entity *dl_se,
-			       struct sched_dl_entity *pi_se, u64 t)
+static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t)
 {
 	u64 left, right;
 
@@ -851,9 +861,9 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl_se,
 	 * of anything below microseconds resolution is actually fiction
 	 * (but still we want to give the user that illusion >;).
 	 */
-	left = (pi_se->dl_deadline >> DL_SCALE) * (dl_se->runtime >> DL_SCALE);
+	left = (pi_of(dl_se)->dl_deadline >> DL_SCALE) * (dl_se->runtime >> DL_SCALE);
 	right = ((dl_se->deadline - t) >> DL_SCALE) *
-		(pi_se->dl_runtime >> DL_SCALE);
+		(pi_of(dl_se)->dl_runtime >> DL_SCALE);
 
 	return dl_time_before(right, left);
 }
@@ -938,14 +948,13 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
  * Please refer to the comments update_dl_revised_wakeup() function to find
  * more about the Revised CBS rule.
  */
-static void update_dl_entity(struct sched_dl_entity *dl_se,
-			     struct sched_dl_entity *pi_se)
+static void update_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
-	    dl_entity_overflow(dl_se, pi_se, rq_clock(rq))) {
+	    dl_entity_overflow(dl_se, rq_clock(rq))) {
 
 		if (unlikely(!dl_is_implicit(dl_se) &&
 			     !dl_time_before(dl_se->deadline, rq_clock(rq)) &&
@@ -954,8 +963,8 @@ static void update_dl_entity(struct sched_dl_entity *dl_se,
 			return;
 		}
 
-		dl_se->deadline = rq_clock(rq) + pi_se->dl_deadline;
-		dl_se->runtime = pi_se->dl_runtime;
+		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime = pi_of(dl_se)->dl_runtime;
 	}
 }
 
@@ -1082,7 +1091,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	 * but do not enqueue -- wait for our wakeup to do that.
 	 */
 	if (!task_on_rq_queued(p)) {
-		replenish_dl_entity(dl_se, dl_se);
+		replenish_dl_entity(dl_se);
 		goto unlock;
 	}
 
@@ -1500,8 +1509,7 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
 }
 
 static void
-enqueue_dl_entity(struct sched_dl_entity *dl_se,
-		  struct sched_dl_entity *pi_se, int flags)
+enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	BUG_ON(on_dl_rq(dl_se));
 
@@ -1512,9 +1520,9 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 	 */
 	if (flags & ENQUEUE_WAKEUP) {
 		task_contending(dl_se, flags);
-		update_dl_entity(dl_se, pi_se);
+		update_dl_entity(dl_se);
 	} else if (flags & ENQUEUE_REPLENISH) {
-		replenish_dl_entity(dl_se, pi_se);
+		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
 		  dl_time_before(dl_se->deadline,
 				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
@@ -1531,19 +1539,7 @@ static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
-	struct task_struct *pi_task = rt_mutex_get_top_task(p);
-	struct sched_dl_entity *pi_se = &p->dl;
-
-	/*
-	 * Use the scheduling parameters of the top pi-waiter task if:
-	 * - we have a top pi-waiter which is a SCHED_DEADLINE task AND
-	 * - our dl_boosted is set (i.e. the pi-waiter's (absolute) deadline is
-	 *   smaller than our deadline OR we are a !SCHED_DEADLINE task getting
-	 *   boosted due to a SCHED_DEADLINE pi-waiter).
-	 * Otherwise we keep our runtime and deadline.
-	 */
-	if (pi_task && dl_prio(pi_task->normal_prio) && p->dl.dl_boosted) {
-		pi_se = &pi_task->dl;
+	if (p->dl.dl_boosted) {
 		/*
 		 * Because of delays in the detection of the overrun of a
 		 * thread's runtime, it might be the case that a thread
@@ -1613,7 +1609,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
-	enqueue_dl_entity(&p->dl, pi_se, flags);
+	enqueue_dl_entity(&p->dl, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
@@ -2821,6 +2817,10 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
+
+#ifdef CONFIG_RT_MUTEXES
+	dl_se->pi_se			= dl_se;
+#endif
 }
 
 bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
-- 
2.26.2

