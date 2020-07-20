Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1190122574F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 08:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGTGHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 02:07:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:7506 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGTGHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:07:00 -0400
IronPort-SDR: zAEJIIXIiCmFHi8eJZT+lfgu5nJhMCjmkfedDXZSpP5hLG2J5XdiyenMqyI6zxi0HoiodbKqJV
 9LPKintPUSWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="149015360"
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208";a="149015360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2020 23:06:59 -0700
IronPort-SDR: eFtD+xHfrrkktCRUlkKydb4OTCZdu7wdXII3Q1X/lZ63OzStopi+YxOjmtapxfhJsTBY7dZYDA
 9GEJEA7L4Dmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208";a="327430436"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2020 23:06:53 -0700
Subject: Re: [RFC PATCH 10/16] sched: Trivial forced-newidle balancer(Internet
 mail)
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <980b600006945a45ce1ec34ef206fc04bcf0b5dc.1593530334.git.vpillai@digitalocean.com>
 <750BB828-1AAE-4DED-A460-CF8ADDE3CFDA@tencent.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <288368e3-9f6b-21bf-287a-f2446073f6fb@linux.intel.com>
Date:   Mon, 20 Jul 2020 14:06:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <750BB828-1AAE-4DED-A460-CF8ADDE3CFDA@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/20 12:06, benbjiang(蒋彪) wrote:
> Hi,
> 
>> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@digitalocean.com> wrote:
>>
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> When a sibling is forced-idle to match the core-cookie; search for
>> matching tasks to fill the core.
>>
>> rcu_read_unlock() can incur an infrequent deadlock in
>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>> ---
>> include/linux/sched.h |   1 +
>> kernel/sched/core.c   | 131 +++++++++++++++++++++++++++++++++++++++++-
>> kernel/sched/idle.c   |   1 +
>> kernel/sched/sched.h  |   6 ++
>> 4 files changed, 138 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 3c8dcc5ff039..4f9edf013df3 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -688,6 +688,7 @@ struct task_struct {
>> #ifdef CONFIG_SCHED_CORE
>> 	struct rb_node			core_node;
>> 	unsigned long			core_cookie;
>> +	unsigned int			core_occupation;
>> #endif
>>
>> #ifdef CONFIG_CGROUP_SCHED
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 4d6d6a678013..fb9edb09ead7 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -201,6 +201,21 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
>> 	return match;
>> }
>>
>> +static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
>> +{
>> +	struct rb_node *node = &p->core_node;
>> +
>> +	node = rb_next(node);
>> +	if (!node)
>> +		return NULL;
>> +
>> +	p = container_of(node, struct task_struct, core_node);
>> +	if (p->core_cookie != cookie)
>> +		return NULL;
>> +
>> +	return p;
>> +}
>> +
>> /*
>>  * The static-key + stop-machine variable are needed such that:
>>  *
>> @@ -4233,7 +4248,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>> 	struct task_struct *next, *max = NULL;
>> 	const struct sched_class *class;
>> 	const struct cpumask *smt_mask;
>> -	int i, j, cpu;
>> +	int i, j, cpu, occ = 0;
>> 	bool need_sync;
>>
>> 	if (!sched_core_enabled(rq))
>> @@ -4332,6 +4347,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>> 				goto done;
>> 			}
>>
>> +			if (!is_idle_task(p))
>> +				occ++;
>> +
>> 			rq_i->core_pick = p;
>>
>> 			/*
>> @@ -4357,6 +4375,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>
>> 						cpu_rq(j)->core_pick = NULL;
>> 					}
>> +					occ = 1;
>> 					goto again;
>> 				} else {
>> 					/*
>> @@ -4393,6 +4412,8 @@ next_class:;
>> 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
>> 			rq_i->core_forceidle = true;
>>
>> +		rq_i->core_pick->core_occupation = occ;
>> +
>> 		if (i == cpu)
>> 			continue;
>>
>> @@ -4408,6 +4429,114 @@ next_class:;
>> 	return next;
>> }
>>
>> +static bool try_steal_cookie(int this, int that)
>> +{
>> +	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
>> +	struct task_struct *p;
>> +	unsigned long cookie;
>> +	bool success = false;
>> +
>> +	local_irq_disable();
>> +	double_rq_lock(dst, src);
>> +
>> +	cookie = dst->core->core_cookie;
>> +	if (!cookie)
>> +		goto unlock;
>> +
>> +	if (dst->curr != dst->idle)
>> +		goto unlock;
>> +
>> +	p = sched_core_find(src, cookie);
>> +	if (p == src->idle)
>> +		goto unlock;
>> +
>> +	do {
>> +		if (p == src->core_pick || p == src->curr)
>> +			goto next;
>> +
>> +		if (!cpumask_test_cpu(this, &p->cpus_mask))
>> +			goto next;
>> +
>> +		if (p->core_occupation > dst->idle->core_occupation)
>> +			goto next;
>> +
>> +		p->on_rq = TASK_ON_RQ_MIGRATING;
>> +		deactivate_task(src, p, 0);
>> +		set_task_cpu(p, this);
>> +		activate_task(dst, p, 0);
>> +		p->on_rq = TASK_ON_RQ_QUEUED;
>> +
>> +		resched_curr(dst);
>> +
>> +		success = true;
>> +		break;
>> +
>> +next:
>> +		p = sched_core_next(p, cookie);
>> +	} while (p);
>> +
>> +unlock:
>> +	double_rq_unlock(dst, src);
>> +	local_irq_enable();
>> +
>> +	return success;
>> +}
>> +
>> +static bool steal_cookie_task(int cpu, struct sched_domain *sd)
>> +{
>> +	int i;
>> +
>> +	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
> Since (i == cpu) should be skipped, should we start iteration at cpu+1? like,
> 	for_each_cpu_wrap(i, sched_domain_span(sd), cpu+1) {
> 		…
> 	}
> In that way, we could avoid hitting following if(i == cpu) always.

IMHO, this won't work, as cpuid is not continuous.

>> +		if (i == cpu)
>> +			continue;
>> +
>> +		if (need_resched())
>> +			break;
> Should we return true here to accelerate the breaking of sched_core_balance? 
> Otherwise the breaking would be delayed to the next level sd iteration.
>> +
>> +		if (try_steal_cookie(cpu, i))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static void sched_core_balance(struct rq *rq)
>> +{
>> +	struct sched_domain *sd;
>> +	int cpu = cpu_of(rq);
>> +
>> +	rcu_read_lock_sched();
>> +	raw_spin_unlock_irq(rq_lockp(rq));
>> +	for_each_domain(cpu, sd) {
>> +		if (!(sd->flags & SD_LOAD_BALANCE))
>> +			break;
>> +
>> +		if (need_resched())
>> +			break;
> If rescheded here, we missed the chance to do further forced-newidle balance, 
> and the idle-core could be idle for a long time, because lacking of pulling chance.
> Could it be possible to add a new forced-newidle balance chance in task_tick_idle?
> which could make it more efficient.

This flag indicates there is another thread deserves to run, So I guess the core won't
be idle for a long time.

Thanks,
-Aubrey
> 
>> +		if (steal_cookie_task(cpu, sd))
>> +			break;
>> +	}
>> +	raw_spin_lock_irq(rq_lockp(rq));
>> +	rcu_read_unlock_sched();
>> +}
>> +
>> +static DEFINE_PER_CPU(struct callback_head, core_balance_head);
>> +
>> +void queue_core_balance(struct rq *rq)
>> +{
>> +	if (!sched_core_enabled(rq))
>> +		return;
>> +
>> +	if (!rq->core->core_cookie)
>> +		return;
>> +
>> +	if (!rq->nr_running) /* not forced idle */
>> +		return;
>> +
>> +	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
>> +}
>> +
>> #else /* !CONFIG_SCHED_CORE */
>>
>> static struct task_struct *
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index a8d40ffab097..dff6ba220ed7 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -395,6 +395,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
>> {
>> 	update_idle_core(rq);
>> 	schedstat_inc(rq->sched_goidle);
>> +	queue_core_balance(rq);
>> }
>>
>> #ifdef CONFIG_SMP
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 293aa1ae0308..464559676fd2 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1089,6 +1089,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>> bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
>> void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled);
>>
>> +extern void queue_core_balance(struct rq *rq);
>> +
>> #else /* !CONFIG_SCHED_CORE */
>>
>> static inline bool sched_core_enabled(struct rq *rq)
>> @@ -1101,6 +1103,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>> 	return &rq->__lock;
>> }
>>
>> +static inline void queue_core_balance(struct rq *rq)
>> +{
>> +}
>> +
>> #endif /* CONFIG_SCHED_CORE */
>>
>> #ifdef CONFIG_SCHED_SMT
>> -- 
>> 2.17.1
>>
>>
> 

