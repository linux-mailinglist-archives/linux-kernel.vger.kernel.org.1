Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FA2EC034
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAFPOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:14:37 -0500
Received: from foss.arm.com ([217.140.110.172]:42506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbhAFPOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:14:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070AD106F;
        Wed,  6 Jan 2021 07:13:51 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FCAF3F719;
        Wed,  6 Jan 2021 07:13:49 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/3] sched/fair: don't set LBF_ALL_PINNED unnecessarily
In-Reply-To: <20210106133419.2971-3-vincent.guittot@linaro.org>
References: <20210106133419.2971-1-vincent.guittot@linaro.org> <20210106133419.2971-3-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 06 Jan 2021 15:13:47 +0000
Message-ID: <jhjzh1m2j4k.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/21 14:34, Vincent Guittot wrote:
> Setting LBF_ALL_PINNED during active load balance is only valid when there
> is only 1 running task on the rq otherwise this ends up increasing the
> balance interval whereas other tasks could migrate after the next interval
> once they become cache-cold as an example.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5428b8723e61..69a455113b10 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9759,7 +9759,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                       if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
>                               raw_spin_unlock_irqrestore(&busiest->lock,
>                                                           flags);
> -				env.flags |= LBF_ALL_PINNED;
> +				if (busiest->nr_running == 1)
> +					env.flags |= LBF_ALL_PINNED;

So LBF_ALL_PINNED *can* be set if busiest->nr_running > 1, because
before we get there we have:

  if (nr_running > 1) {
      env.flags |= LBF_ALL_PINNED;
      detach_tasks(&env); // Removes LBF_ALL_PINNED if > 0 tasks can be pulled
      ...
  }

What about following the logic used by detach_tasks() and only clear the
flag? Say something like the below. if nr_running > 1, then we'll have
gone through detach_tasks() and will have cleared the flag (if
possible).
---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..211c86ba3f5b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9623,6 +9623,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	env.src_rq = busiest;
 
 	ld_moved = 0;
+	/* Clear this as soon as we find a single pullable task */
+	env.flags |= LBF_ALL_PINNED;
 	if (busiest->nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If find_busiest_group has found
@@ -9630,7 +9632,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		env.flags |= LBF_ALL_PINNED;
 		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
 
 more_balance:
@@ -9756,10 +9757,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
 				raw_spin_unlock_irqrestore(&busiest->lock,
 							    flags);
-				env.flags |= LBF_ALL_PINNED;
 				goto out_one_pinned;
 			}
 
+			env.flags &= ~LBF_ALL_PINNED;
+
 			/*
 			 * ->active_balance synchronizes accesses to
 			 * ->active_balance_work.  Once set, it's cleared
---
