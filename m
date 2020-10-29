Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979BA29F16B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgJ2Q1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:27:55 -0400
Received: from foss.arm.com ([217.140.110.172]:40424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgJ2Q1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:27:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9139139F;
        Thu, 29 Oct 2020 09:27:49 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1E763F66E;
        Thu, 29 Oct 2020 09:27:47 -0700 (PDT)
References: <20201023101158.088940906@infradead.org> <20201023102347.866412704@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 19/19] sched: Comment affine_move_task()
In-reply-to: <20201023102347.866412704@infradead.org>
Date:   Thu, 29 Oct 2020 16:27:45 +0000
Message-ID: <jhj8sbpov3y.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/10/20 11:12, Peter Zijlstra wrote:
> + * (1) In the cases covered above. There is one more where the completion is
> + * signaled within affine_move_task() itself: when a subsequent affinity request
> + * cancels the need for an active migration. Consider:
> + *
> + *     Initial conditions: P0->cpus_mask = [0, 1]
> + *
> + *     P0@CPU0            P1                             P2
> + *
> + *     migrate_disable();
> + *     <preempted>
> + *                        set_cpus_allowed_ptr(P0, [1]);
> + *                          <blocks>
> + *                                                       set_cpus_allowed_ptr(P0, [0, 1]);
> + *                                                         <signal completion>
> + *                          <awakes>
> + *
> + * Note that the above is safe vs a concurrent migrate_enable(), as any
> + * pending affinity completion is preceded an uninstallion of
> + * p->migration_pending done with p->pi_lock held.

I too must have been thinking too much about ponies lately.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0a3f9fd3b061..d8c85f180b09 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2147,7 +2147,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
  *                          <awakes>
  *
  * Note that the above is safe vs a concurrent migrate_enable(), as any
- * pending affinity completion is preceded an uninstallion of
+ * pending affinity completion is preceded by an uninstallation of
  * p->migration_pending done with p->pi_lock held.
  */
 static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
