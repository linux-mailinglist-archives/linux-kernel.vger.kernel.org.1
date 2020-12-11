Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118922D7615
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405978AbgLKMxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:53:46 -0500
Received: from foss.arm.com ([217.140.110.172]:55418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405979AbgLKMw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:52:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DA751FB;
        Fri, 11 Dec 2020 04:52:04 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A1903F68F;
        Fri, 11 Dec 2020 04:52:02 -0800 (PST)
References: <20201210163830.21514-1-valentin.schneider@arm.com> <20201210163830.21514-3-valentin.schneider@arm.com> <20201211113920.GA75974@e120877-lin.cambridge.arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, bigeasy@linutronix.de, qais.yousef@arm.com,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH 2/2] workqueue: Fix affinity of kworkers attached during late hotplug
In-reply-to: <20201211113920.GA75974@e120877-lin.cambridge.arm.com>
Date:   Fri, 11 Dec 2020 12:51:57 +0000
Message-ID: <jhjo8j0tsia.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent,

On 11/12/20 11:39, Vincent Donnefort wrote:
> Hi Valentin,
>
> On Thu, Dec 10, 2020 at 04:38:30PM +0000, Valentin Schneider wrote:
>> Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
>
> Isn't the problem introduced by 1cf12e0 ("sched/hotplug: Consolidate
> task migration on CPU unplug") ?
>
> Previously we had:
>
>  AP_WORKQUEUE_ONLINE -> set POOL_DISASSOCIATED
>    ...
>  TEARDOWN_CPU -> clear CPU in cpu_online_mask
>    |
>    |-AP_SCHED_STARTING -> migrate_tasks()
>    |
>   AP_OFFLINE
>
> worker_attach_to_pool(), is "protected" by the cpu_online_mask in
> set_cpus_allowed_ptr(). IIUC, now, the tasks being migrated before the
> cpu_online_mask is actually flipped, there's a window, between
> CPUHP_AP_SCHED_WAIT_EMPTY and CPUHP_TEARDOWN_CPU where a kworker can wake-up
> a new one, for the hotunplugged pool that wouldn't be caught by the
> hotunplug migration.
>

You're right, the splat should only happen with that other commit. That
said, this fix complements the one referred to in Fixes:, which is the
"logic" I went for.

>> Reported-by: Qian Cai <cai@redhat.com>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  kernel/workqueue.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 9880b6c0e272..fb1418edf85c 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1848,19 +1848,29 @@ static void worker_attach_to_pool(struct worker *worker,
>>  {
>>      mutex_lock(&wq_pool_attach_mutex);
>>
>> -	/*
>> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
>> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
>> -	 */
>> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>> -
>>      /*
>>       * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>>       * stable across this function.  See the comments above the flag
>>       * definition for details.
>> +	 *
>> +	 * Worker might get attached to a pool *after* workqueue_offline_cpu()
>> +	 * was run - e.g. created by manage_workers() from a kworker which was
>> +	 * forcefully moved away by hotplug. Kworkers created from this point on
>> +	 * need to have their affinity changed as if they were present during
>> +	 * workqueue_offline_cpu().
>> +	 *
>> +	 * This will be resolved in rebind_workers().
>>       */
>> -	if (pool->flags & POOL_DISASSOCIATED)
>> +	if (pool->flags & POOL_DISASSOCIATED) {
>>              worker->flags |= WORKER_UNBOUND;
>> +		set_cpus_allowed_ptr(worker->task, cpu_active_mask);
>> +	} else {
>> +		/*
>> +		 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
>> +		 * online CPUs. It'll be re-applied when any of the CPUs come up.
>> +		 */
>
> Does this comment still stand ? IIUC, we should always be in the
> POOL_DISASSOCIATED case if the CPU from cpumask is offline. Unless a
> pool->attrs->cpumask can have several CPUs.

AIUI that should the case for unbound pools

> In that case maybe we should check for the cpu_active_mask here too ?

Looking at it again, I think we might need to.

IIUC you can end up with pools bound to a single NUMA node (?). In that
case, say the last CPU of a node is going down, then:

  workqueue_offline_cpu()
    wq_update_unbound_numa()
      alloc_unbound_pwq()
        get_unbound_pool()

would still pick that node, because it doesn't look at the online / active
mask. And at this point, we would affine the
kworkers to that node, and we're back to having kworkers enqueued on a
(!active, online) CPU that is going down...

The annoying thing is we can't just compare attrs->cpumask with
cpu_active_mask, because workqueue_offline_cpu() happens a few steps below
sched_cpu_deactivate() (CPUHP_AP_ACTIVE):

  CPUHP_ONLINE -> CPUHP_AP_ACTIVE # CPU X is !active

  # Some new kworker gets created here
  worker_attach_to_pool()
    !cpumask_subset(attrs->cpumask, cpu_active_mask)
    -> affine worker to active CPUs

  CPUHP_AP_ACTIVE -> CPUHP_ONLINE # CPU X is active
  # Nothing will ever correct the kworker's affinity :(
