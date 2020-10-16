Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E112290580
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406340AbgJPMs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:48:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405891AbgJPMs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:48:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E05FD13D5;
        Fri, 16 Oct 2020 05:48:24 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C794F3F66B;
        Fri, 16 Oct 2020 05:48:22 -0700 (PDT)
References: <20201015110532.738127234@infradead.org> <20201015110923.910090294@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v3 10/19] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <20201015110923.910090294@infradead.org>
Date:   Fri, 16 Oct 2020 13:48:17 +0100
Message-ID: <jhjlfg6qqum.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/10/20 12:05, Peter Zijlstra wrote:
> @@ -1862,15 +1875,27 @@ static int migration_cpu_stop(void *data
>        * we're holding p->pi_lock.
>        */
>       if (task_rq(p) == rq) {
> +		if (is_migration_disabled(p))
> +			goto out;
> +
>               if (task_on_rq_queued(p))
>                       rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
>               else
>                       p->wake_cpu = arg->dest_cpu;
> +
> +		if (arg->done) {
> +			p->migration_pending = NULL;
> +			complete = true;

Ok so nasty ahead:

P0@CPU0             P1                    P2                      stopper

migrate_disable();
                   sca(P0, {CPU1});
                     <installs pending>
migrate_enable();
  <kicks stopper>
                                          sca(P0, {CPU0});
                                             <locks>
                                             <local, has pending:
                                              goto do_complete>
                                             <unlocks>
                                             complete_all();
                                             refcount_dec();
                     refcount_dec();
                   <done>
                                           <done>

                                                                  <locks>
                                                                  <fiddles with pending->arg->done>

First, P2 can clear p->migration_pending before the stopper gets to run.

Second, the complete_all() is done without pi / rq locks held, but P2 might
get to it before the stopper does. This may cause &pending to be popped off
the stack before the stopper gets to it, so mayhaps we would need the below
hunk.

The move_queued_task() from the stopper is "safe" in that we won't kick a
task outside of its allowed mask, although we may move it around for no
reason - I tried to prevent that.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a5b6eac07adb..1ebf653c2c2f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1859,6 +1859,13 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 	return rq;
 }
 
+struct set_affinity_pending {
+	refcount_t		refs;
+	struct completion	done;
+	struct cpu_stop_work	stop_work;
+	struct migration_arg	arg;
+};
+
 /*
  * migration_cpu_stop - this will be executed by a highprio stopper thread
  * and performs thread migration by bumping thread off CPU then
@@ -1866,6 +1873,7 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  */
 static int migration_cpu_stop(void *data)
 {
+	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
 	struct task_struct *p = arg->task;
 	struct rq *rq = this_rq();
@@ -1886,13 +1894,22 @@ static int migration_cpu_stop(void *data)
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
+
+	if (arg->done)
+		pending = container_of(arg->done, struct set_affinity_pending, done);
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
 	 * we're holding p->pi_lock.
 	 */
 	if (task_rq(p) == rq) {
-		if (is_migration_disabled(p))
+		/*
+		 * An affinity update may have raced with us.
+		 * p->migration_pending could now be NULL, or could be pointing
+		 * elsewhere entirely.
+		 */
+		if (is_migration_disabled(p) ||
+		    (arg->done && p->migration_pending != pending))
 			goto out;
 
 		if (task_on_rq_queued(p))
@@ -2024,13 +2041,6 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	__do_set_cpus_allowed(p, new_mask, 0);
 }
 
-struct set_affinity_pending {
-	refcount_t		refs;
-	struct completion	done;
-	struct cpu_stop_work	stop_work;
-	struct migration_arg	arg;
-};
-
 /*
  * This function is wildly self concurrent; here be dragons.
  *
