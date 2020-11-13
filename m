Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0912B1389
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKMAwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:52:02 -0500
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74]:61326 "EHLO
        mx0b-00364e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbgKMAwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:52:02 -0500
X-Greylist: delayed 828 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2020 19:52:01 EST
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD0fvdx003786
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 19:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=date : from : to :
 cc : subject : message-id : mime-version : content-type; s=pps01;
 bh=zG/VASeOEG2YS7bU5jTEIeHid6pd0QxCQwBJkjIPhxw=;
 b=ejR1ROI5c1nPtURVcZJlxh2JgI7x+U+DTxyUrdx7ebnXqF+GWp1OjIvdxvUWAJeSgCDa
 7Z80jBbraZARbdl+eJ0BO2f6A+GB4X+hhYvyWghK1n0Zfxjk+a+2p5DMpqJzDMAWPR9M
 yv5Zd73h/E1CkzFKnzCNE9NbeMJOeoAFfMUcbvxC1lG/dgcFt1OLAWRvKB8LwKUASqHk
 WZEqI/2mdYvurIzppjF0xYl0Wdt9OziSJzeeyMGtX/7RjSV4eQMHZEt0THMuSjdBKyPm
 OZ22ncDgroCzGYFlqZr9bGc+8E8SiNwM+W1FiU+G2t7filgVSlm3Snk5+9g8K+UiJ8Us Ag== 
Received: from sendprdmail20.cc.columbia.edu (sendprdmail20.cc.columbia.edu [128.59.72.22])
        by mx0b-00364e01.pphosted.com with ESMTP id 34nngmp1s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 19:52:00 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by sendprdmail20.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 0AD0px0L040659
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 19:51:59 -0500
Received: by mail-qt1-f199.google.com with SMTP id l67so4726070qte.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zG/VASeOEG2YS7bU5jTEIeHid6pd0QxCQwBJkjIPhxw=;
        b=Hl24RkeWkghfBkR3AJ5cK9J22R/jR2oWfuE56HXxW2MEjGrPTRrjt7afniq29MiuX/
         Og0u6d1ehHXGdm+WAGl7W2EWJIYgXtPj6qptxaaMIwA6t6z9+3s/w7X277q6UJYtkuY+
         ZPTkvcjdCw5Nh0c/6RETQhYyo+aMjMEywTZ5vB886cXqr/TTthPAXZNYadX7tbKL7eHW
         Wx7FGrDyjOHeRgUBi7w4RlgtfXUbO1XueINGWJAwxjfUzg7og52vLjCkdye+1KeDAmAd
         9bBdC83pHn/KAjGpmKEFGvZcGdUGH/+7gpUBwunQq+eYfJbl+cCjLO/ikcxaylhQjvr4
         ya0w==
X-Gm-Message-State: AOAM532UiorbICMi4HBkEPTZLfigQazy8USAtNi5DkEjooyw6+VEGBO5
        bxA7x35vXWYXPmC1zm9xGJLQz3yZLRoYaYvquKJqvQQH3mJy5U+BG2eRPEI/F/VlcBT85FRs4nI
        Sk8GYjhFdfRRWWy16yB2tVrYtfDhqxnWD
X-Received: by 2002:a37:a3c4:: with SMTP id m187mr2514462qke.119.1605228718490;
        Thu, 12 Nov 2020 16:51:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygN5zRJXCGRxKNUZEDJdZZzw0+nii6PyBtCSoR0revl76+JVEIX7UQwmyrRgolcrJbj71sjg==
X-Received: by 2002:a37:a3c4:: with SMTP id m187mr2514442qke.119.1605228718042;
        Thu, 12 Nov 2020 16:51:58 -0800 (PST)
Received: from charmander (dyn-160-39-33-233.dyn.columbia.edu. [160.39.33.233])
        by smtp.gmail.com with ESMTPSA id h6sm5535211qtm.68.2020.11.12.16.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:51:57 -0800 (PST)
Date:   Thu, 12 Nov 2020 19:51:56 -0500
From:   Tal Zussman <tz2294@columbia.edu>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>
Subject: [PATCH] sched/core: trivial: Fix typos in comments
Message-ID: <20201113005156.GA8408@charmander>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_16:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_notspam policy=inbound score=0 priorityscore=1501 bulkscore=10
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=10
 phishscore=0 adultscore=0 impostorscore=10 suspectscore=2 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 kernel/sched/core.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..f30f28b91833 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -97,7 +97,7 @@ int sysctl_sched_rt_runtime = 950000;
  *
  * Normal scheduling state is serialized by rq->lock. __schedule() takes the
  * local CPU's rq->lock, it optionally removes the task from the runqueue and
- * always looks at the local rq data structures to find the most elegible task
+ * always looks at the local rq data structures to find the most eligible task
  * to run next.
  *
  * Task enqueue is also under rq->lock, possibly taken from another CPU.
@@ -518,7 +518,7 @@ static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
 
 	/*
 	 * Atomically grab the task, if ->wake_q is !nil already it means
-	 * its already queued (either by us or someone else) and will get the
+	 * it's already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
 	 * In order to ensure that a pending wakeup will observe our pending
@@ -769,7 +769,7 @@ bool sched_can_stop_tick(struct rq *rq)
 		return false;
 
 	/*
-	 * If there are more than one RR tasks, we need the tick to effect the
+	 * If there are more than one RR tasks, we need the tick to affect the
 	 * actual RR behaviour.
 	 */
 	if (rq->rt.rr_nr_running) {
@@ -1187,14 +1187,14 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	 * accounting was performed at enqueue time and we can just return
 	 * here.
 	 *
-	 * Need to be careful of the following enqeueue/dequeue ordering
+	 * Need to be careful of the following enqueue/dequeue ordering
 	 * problem too
 	 *
 	 *	enqueue(taskA)
 	 *	// sched_uclamp_used gets enabled
 	 *	enqueue(taskB)
 	 *	dequeue(taskA)
-	 *	// Must not decrement bukcet->tasks here
+	 *	// Must not decrement bucket->tasks here
 	 *	dequeue(taskB)
 	 *
 	 * where we could end up with stale data in uc_se and
@@ -2465,7 +2465,7 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-		 * Our task @p is fully woken up and running; so its safe to
+		 * Our task @p is fully woken up and running; so it's safe to
 		 * drop the rq->lock, hereafter rq is only used for statistics.
 		 */
 		rq_unpin_lock(rq, rf);
@@ -2952,7 +2952,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
-	 * this task as prev, wait until its done referencing the task.
+	 * this task as prev, wait until it's done referencing the task.
 	 *
 	 * Pairs with the smp_store_release() in finish_task().
 	 *
@@ -3356,7 +3356,7 @@ void wake_up_new_task(struct task_struct *p)
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-		 * Nothing relies on rq->lock after this, so its fine to
+		 * Nothing relies on rq->lock after this, so it's fine to
 		 * drop it.
 		 */
 		rq_unpin_lock(rq, &rf);
@@ -3836,7 +3836,7 @@ unsigned long nr_iowait_cpu(int cpu)
 }
 
 /*
- * IO-wait accounting, and how its mostly bollocks (on SMP).
+ * IO-wait accounting, and how it's mostly bollocks (on SMP).
  *
  * The idea behind IO-wait account is to account the idle time that we could
  * have spend running if it were not for IO. That is, if we were to improve the
@@ -4331,7 +4331,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
-	 * higher scheduling class, because otherwise those loose the
+	 * higher scheduling class, because otherwise those lose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely(prev->sched_class <= &fair_sched_class &&
@@ -4852,7 +4852,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 * right. rt_mutex_slowunlock()+rt_mutex_postunlock() work together to
 	 * ensure a task is de-boosted (pi_task is set to NULL) before the
 	 * task is allowed to run again (and can exit). This ensures the pointer
-	 * points to a blocked task -- which guaratees the task is present.
+	 * points to a blocked task -- which guarantees the task is present.
 	 */
 	p->pi_top_task = pi_task;
 
@@ -4968,7 +4968,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
-	 * it wont have any effect on scheduling until the task is
+	 * it won't have any effect on scheduling until the task is
 	 * SCHED_DEADLINE, SCHED_FIFO or SCHED_RR:
 	 */
 	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
@@ -6159,7 +6159,7 @@ EXPORT_SYMBOL(__cond_resched_lock);
  *
  * The scheduler is at all times free to pick the calling task as the most
  * eligible task to run, if removing the yield() call from your code breaks
- * it, its already broken.
+ * it, it's already broken.
  *
  * Typical broken usage is:
  *
@@ -6532,7 +6532,7 @@ void init_idle(struct task_struct *idle, int cpu)
 
 #ifdef CONFIG_SMP
 	/*
-	 * Its possible that init_idle() gets called multiple times on a task,
+	 * It's possible that init_idle() gets called multiple times on a task,
 	 * in that case do_set_cpus_allowed() will not do the right thing.
 	 *
 	 * And since this is boot we can forgo the serialization.
@@ -6725,7 +6725,7 @@ static struct task_struct *__pick_migrate_task(struct rq *rq)
  * Migrate all tasks from the rq, sleeping tasks will be migrated by
  * try_to_wake_up()->select_task_rq().
  *
- * Called with rq->lock held even though we'er in stop_machine() and
+ * Called with rq->lock held even though we're in stop_machine() and
  * there's no concurrency possible, we hold the required locks anyway
  * because of lock validation efforts.
  */
@@ -7660,7 +7660,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 			return -EINVAL;
 #endif
 		/*
-		 * Serialize against wake_up_new_task() such that if its
+		 * Serialize against wake_up_new_task() such that if it's
 		 * running, we're sure to observe its full state.
 		 */
 		raw_spin_lock_irq(&task->pi_lock);
-- 
2.20.1

