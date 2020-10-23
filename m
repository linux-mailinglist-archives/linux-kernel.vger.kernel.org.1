Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28B296CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462331AbgJWKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462267AbgJWKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2376C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=t3Jvtb/vFM6qTG2WF/nyNwjrlskxt344vZcIr2UHE6g=; b=Ky/N4ipWKu6PKOMsRbcSdNEcVg
        D4Rzj/TOdDWR8J0R04XjpZqUrTjJE8lE9Y16WmlfxXhUKgKgKBiWMgeZy6hI7kXO5L4PQuNG9Bi00
        o1IwpJTp21RvVbkR02VXobzcgNXtMRRAjyUo/svxO4WTDQJ+0TCD8oW3kHBHiFkveOlPjJ5169Isn
        glte7BR/Zj6tf/V6k7D3XCBxw6EUK89MrUFsTWvxXKFkZFt5uFpW7w5HQwrS5SDxppmi0ZJ90PLRT
        Ak+r4KBYeTNznP72TDIyYa+0rqb3oIL9PO5Q33Iz/4OmB9vnKIaEpabO55eezL3qUjNXgRGnzGDru
        ffbPS/vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFo-0002tB-EH; Fri, 23 Oct 2020 10:25:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D52A2307697;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5514929DDA65F; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102346.729082820@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 08/19] sched: Massage set_cpus_allowed()
References: <20201023101158.088940906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thread a u32 flags word through the *set_cpus_allowed*() callchain.
This will allow adding behavioural tweaks for future users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |   28 ++++++++++++++++++----------
 kernel/sched/deadline.c |    5 +++--
 kernel/sched/sched.h    |    7 +++++--
 3 files changed, 26 insertions(+), 14 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1828,13 +1828,14 @@ static int migration_cpu_stop(void *data
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
  */
-void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
+void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
 	cpumask_copy(&p->cpus_mask, new_mask);
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+static void
+__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -1855,7 +1856,7 @@ void do_set_cpus_allowed(struct task_str
 	if (running)
 		put_prev_task(rq, p);
 
-	p->sched_class->set_cpus_allowed(p, new_mask);
+	p->sched_class->set_cpus_allowed(p, new_mask, flags);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -1863,6 +1864,11 @@ void do_set_cpus_allowed(struct task_str
 		set_next_task(rq, p);
 }
 
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+{
+	__do_set_cpus_allowed(p, new_mask, 0);
+}
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -1873,7 +1879,8 @@ void do_set_cpus_allowed(struct task_str
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, bool check)
+				  const struct cpumask *new_mask,
+				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	unsigned int dest_cpu;
@@ -1895,7 +1902,7 @@ static int __set_cpus_allowed_ptr(struct
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
 	 */
-	if (check && (p->flags & PF_NO_SETAFFINITY)) {
+	if ((flags & SCA_CHECK) && (p->flags & PF_NO_SETAFFINITY)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1914,7 +1921,7 @@ static int __set_cpus_allowed_ptr(struct
 		goto out;
 	}
 
-	do_set_cpus_allowed(p, new_mask);
+	__do_set_cpus_allowed(p, new_mask, flags);
 
 	if (p->flags & PF_KTHREAD) {
 		/*
@@ -1951,7 +1958,7 @@ static int __set_cpus_allowed_ptr(struct
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, false);
+	return __set_cpus_allowed_ptr(p, new_mask, 0);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -2410,7 +2417,8 @@ void sched_set_stop_task(int cpu, struct
 #else
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 const struct cpumask *new_mask, bool check)
+					 const struct cpumask *new_mask,
+					 u32 flags)
 {
 	return set_cpus_allowed_ptr(p, new_mask);
 }
@@ -6025,7 +6033,7 @@ long sched_setaffinity(pid_t pid, const
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, true);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 
 	if (!retval) {
 		cpuset_cpus_allowed(p, cpus_allowed);
@@ -6608,7 +6616,7 @@ void init_idle(struct task_struct *idle,
 	 *
 	 * And since this is boot we can forgo the serialization.
 	 */
-	set_cpus_allowed_common(idle, cpumask_of(cpu));
+	set_cpus_allowed_common(idle, cpumask_of(cpu), 0);
 #endif
 	/*
 	 * We're having a chicken and egg problem, even though we are
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2280,7 +2280,8 @@ static void task_woken_dl(struct rq *rq,
 }
 
 static void set_cpus_allowed_dl(struct task_struct *p,
-				const struct cpumask *new_mask)
+				const struct cpumask *new_mask,
+				u32 flags)
 {
 	struct root_domain *src_rd;
 	struct rq *rq;
@@ -2309,7 +2310,7 @@ static void set_cpus_allowed_dl(struct t
 		raw_spin_unlock(&src_dl_b->lock);
 	}
 
-	set_cpus_allowed_common(p, new_mask);
+	set_cpus_allowed_common(p, new_mask, flags);
 }
 
 /* Assumes rq->lock is held */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1806,7 +1806,8 @@ struct sched_class {
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
 	void (*set_cpus_allowed)(struct task_struct *p,
-				 const struct cpumask *newmask);
+				 const struct cpumask *newmask,
+				 u32 flags);
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
@@ -1899,7 +1900,9 @@ extern void update_group_capacity(struct
 
 extern void trigger_load_balance(struct rq *rq);
 
-extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask);
+#define SCA_CHECK		0x01
+
+extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
 
 #endif
 


