Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855682F9412
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 17:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbhAQQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 11:58:28 -0500
Received: from foss.arm.com ([217.140.110.172]:55354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbhAQQ6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 11:58:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C75431B;
        Sun, 17 Jan 2021 08:57:37 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B384B3F68F;
        Sun, 17 Jan 2021 08:57:35 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        paulmck@kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH 7/8] sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
In-Reply-To: <20210116113920.103635633@infradead.org>
References: <20210116113033.608340773@infradead.org> <20210116113920.103635633@infradead.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Sun, 17 Jan 2021 16:57:27 +0000
Message-ID: <jhjsg6z4i2w.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/21 12:30, Peter Zijlstra wrote:
> @@ -1796,13 +1796,28 @@ static inline bool rq_has_pinned_tasks(s
>   */
>  static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>  {
> +	/* When not in the task's cpumask, no point in looking further. */
>       if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>               return false;
>
> -	if (is_per_cpu_kthread(p) || is_migration_disabled(p))
> +	/* migrate_disabled() must be allowed to finish. */
> +	if (is_migration_disabled(p))
>               return cpu_online(cpu);
>
> -	return cpu_active(cpu);
> +	/* Non kernel threads are not allowed during either online or offline. */
> +	if (!(p->flags & PF_KTHREAD))
> +		return cpu_active(cpu);
> +
> +	/* KTHREAD_IS_PER_CPU is always allowed. */
> +	if (kthread_is_per_cpu(p))
> +		return cpu_online(cpu);
> +
> +	/* Regular kernel threads don't get to stay during offline. */
> +	if (cpu_rq(cpu)->balance_callback == &balance_push_callback)
> +		return cpu_active(cpu);

is_cpu_allowed(, cpu) isn't guaranteed to have cpu_rq(cpu)'s rq_lock
held, so this can race with balance_push_set(, true). This shouldn't
matter under normal circumstances as we'll have sched_cpu_wait_empty()
further down the line.

This might get ugly with the rollback faff - this is jumping the gun a
bit, but that's something we'll have to address, and I think what I'm
concerned about is close to what you mentioned in

  http://lore.kernel.org/r/YAM1t2Qzr7Rib3bN@hirez.programming.kicks-ass.net

Here's what I'm thinking of:

_cpu_up()                            ttwu()
                                       select_task_rq()
                                         is_cpu_allowed()
                                           rq->balance_callback != balance_push_callback
  smpboot_unpark_threads() // FAIL
  (now going down, set push here)
  sched_cpu_wait_empty()
  ...                                  ttwu_queue()
  sched_cpu_dying()
  *ARGH*

I've written some horrors on top of this series here:

  https://gitlab.arm.com/linux-arm/linux-vs/-/commits/mainline/migrate_disable/stragglers/

Also, my TX2 is again in need of CPR, so in the meantime I'm running
tests on a (much) smaller machine...

> +
> +	/* But are allowed during online. */
> +	return cpu_online(cpu);
>  }
