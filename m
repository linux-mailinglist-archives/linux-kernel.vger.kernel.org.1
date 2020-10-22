Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971B62959BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509115AbgJVH7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:59:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:14462 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507028AbgJVH7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:59:23 -0400
IronPort-SDR: J5YkcAFlBEqbovOiJI2irDUlFGwP5LzYiyGBf1fLrQ+dxuIVDWeySKJj0Bbpz186KUOVmiDwjp
 9b53mqwb7GPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="166709038"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="166709038"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 00:59:22 -0700
IronPort-SDR: 6w3fTZ30BoazYLl3sW6YavMCI+U8YpCw5PRhmSRc2D9ojR7ZVpT+sTLy8A/iNm5O231SWXNgN6
 /tE47IsfNWrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="359783774"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga007.jf.intel.com with ESMTP; 22 Oct 2020 00:59:13 -0700
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-3-joel@joelfernandes.org>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
Date:   Thu, 22 Oct 2020 15:59:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201020014336.2076526-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/20 9:43, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Because sched_class::pick_next_task() also implies
> sched_class::set_next_task() (and possibly put_prev_task() and
> newidle_balance) it is not state invariant. This makes it unsuitable
> for remote task selection.
> 
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/deadline.c  | 16 ++++++++++++++--
>  kernel/sched/fair.c      | 32 +++++++++++++++++++++++++++++++-
>  kernel/sched/idle.c      |  8 ++++++++
>  kernel/sched/rt.c        | 14 ++++++++++++--
>  kernel/sched/sched.h     |  3 +++
>  kernel/sched/stop_task.c | 13 +++++++++++--
>  6 files changed, 79 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 814ec49502b1..0271a7848ab3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1848,7 +1848,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
>  	return rb_entry(left, struct sched_dl_entity, rb_node);
>  }
>  
> -static struct task_struct *pick_next_task_dl(struct rq *rq)
> +static struct task_struct *pick_task_dl(struct rq *rq)
>  {
>  	struct sched_dl_entity *dl_se;
>  	struct dl_rq *dl_rq = &rq->dl;
> @@ -1860,7 +1860,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>  	dl_se = pick_next_dl_entity(rq, dl_rq);
>  	BUG_ON(!dl_se);
>  	p = dl_task_of(dl_se);
> -	set_next_task_dl(rq, p, true);
> +
> +	return p;
> +}
> +
> +static struct task_struct *pick_next_task_dl(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	p = pick_task_dl(rq);
> +	if (p)
> +		set_next_task_dl(rq, p, true);
> +
>  	return p;
>  }
>  
> @@ -2517,6 +2528,7 @@ const struct sched_class dl_sched_class
>  
>  #ifdef CONFIG_SMP
>  	.balance		= balance_dl,
> +	.pick_task		= pick_task_dl,
>  	.select_task_rq		= select_task_rq_dl,
>  	.migrate_task_rq	= migrate_task_rq_dl,
>  	.set_cpus_allowed       = set_cpus_allowed_dl,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index dbd9368a959d..bd6aed63f5e3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4450,7 +4450,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	 * Avoid running the skip buddy, if running something else can
>  	 * be done without getting too unfair.
>  	 */
> -	if (cfs_rq->skip == se) {
> +	if (cfs_rq->skip && cfs_rq->skip == se) {
>  		struct sched_entity *second;
>  
>  		if (se == curr) {
> @@ -6976,6 +6976,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  		set_last_buddy(se);
>  }
>  
> +#ifdef CONFIG_SMP
> +static struct task_struct *pick_task_fair(struct rq *rq)
> +{
> +	struct cfs_rq *cfs_rq = &rq->cfs;
> +	struct sched_entity *se;
> +
> +	if (!cfs_rq->nr_running)
> +		return NULL;
> +
> +	do {
> +		struct sched_entity *curr = cfs_rq->curr;
> +
> +		se = pick_next_entity(cfs_rq, NULL);
> +
> +		if (curr) {
> +			if (se && curr->on_rq)
> +				update_curr(cfs_rq);
> +
> +			if (!se || entity_before(curr, se))
> +				se = curr;
> +		}
> +
> +		cfs_rq = group_cfs_rq(se);
> +	} while (cfs_rq);
> +
> +	return task_of(se);
> +}
> +#endif

One of my machines hangs when I run uperf with only one message:
[  719.034962] BUG: kernel NULL pointer dereference, address: 0000000000000050

Then I replicated the problem on my another machine(no serial console),
here is the stack by manual copy.

Call Trace:
 pick_next_entity+0xb0/0x160
 pick_task_fair+0x4b/0x90
 __schedule+0x59b/0x12f0
 schedule_idle+0x1e/0x40
 do_idle+0x193/0x2d0
 cpu_startup_entry+0x19/0x20
 start_secondary+0x110/0x150
 secondary_startup_64_no_verify+0xa6/0xab

> +
>  struct task_struct *
>  pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> @@ -11173,6 +11202,7 @@ const struct sched_class fair_sched_class
>  
>  #ifdef CONFIG_SMP
>  	.balance		= balance_fair,
> +	.pick_task		= pick_task_fair,
>  	.select_task_rq		= select_task_rq_fair,
>  	.migrate_task_rq	= migrate_task_rq_fair,
>  
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 8ce6e80352cf..ce7552c6bc65 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -405,6 +405,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
>  	schedstat_inc(rq->sched_goidle);
>  }
>  
> +#ifdef CONFIG_SMP
> +static struct task_struct *pick_task_idle(struct rq *rq)
> +{
> +	return rq->idle;
> +}
> +#endif
> +
>  struct task_struct *pick_next_task_idle(struct rq *rq)
>  {
>  	struct task_struct *next = rq->idle;
> @@ -472,6 +479,7 @@ const struct sched_class idle_sched_class
>  
>  #ifdef CONFIG_SMP
>  	.balance		= balance_idle,
> +	.pick_task		= pick_task_idle,
>  	.select_task_rq		= select_task_rq_idle,
>  	.set_cpus_allowed	= set_cpus_allowed_common,
>  #endif
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index e57fca05b660..a5851c775270 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1624,7 +1624,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
>  	return rt_task_of(rt_se);
>  }
>  
> -static struct task_struct *pick_next_task_rt(struct rq *rq)
> +static struct task_struct *pick_task_rt(struct rq *rq)
>  {
>  	struct task_struct *p;
>  
> @@ -1632,7 +1632,16 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
>  		return NULL;
>  
>  	p = _pick_next_task_rt(rq);
> -	set_next_task_rt(rq, p, true);
> +
> +	return p;
> +}
> +
> +static struct task_struct *pick_next_task_rt(struct rq *rq)
> +{
> +	struct task_struct *p = pick_task_rt(rq);
> +	if (p)
> +		set_next_task_rt(rq, p, true);
> +
>  	return p;
>  }
>  
> @@ -2443,6 +2452,7 @@ const struct sched_class rt_sched_class
>  
>  #ifdef CONFIG_SMP
>  	.balance		= balance_rt,
> +	.pick_task		= pick_task_rt,
>  	.select_task_rq		= select_task_rq_rt,
>  	.set_cpus_allowed       = set_cpus_allowed_common,
>  	.rq_online              = rq_online_rt,
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 587ebabebaff..54bfac702805 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1800,6 +1800,9 @@ struct sched_class {
>  
>  #ifdef CONFIG_SMP
>  	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
> +
> +	struct task_struct * (*pick_task)(struct rq *rq);
> +
>  	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
>  	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
>  
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 394bc8126a1e..8f92915dd95e 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -34,15 +34,23 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
>  	stop->se.exec_start = rq_clock_task(rq);
>  }
>  
> -static struct task_struct *pick_next_task_stop(struct rq *rq)
> +static struct task_struct *pick_task_stop(struct rq *rq)
>  {
>  	if (!sched_stop_runnable(rq))
>  		return NULL;
>  
> -	set_next_task_stop(rq, rq->stop, true);
>  	return rq->stop;
>  }
>  
> +static struct task_struct *pick_next_task_stop(struct rq *rq)
> +{
> +	struct task_struct *p = pick_task_stop(rq);
> +	if (p)
> +		set_next_task_stop(rq, p, true);
> +
> +	return p;
> +}
> +
>  static void
>  enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
>  {
> @@ -124,6 +132,7 @@ const struct sched_class stop_sched_class
>  
>  #ifdef CONFIG_SMP
>  	.balance		= balance_stop,
> +	.pick_task		= pick_task_stop,
>  	.select_task_rq		= select_task_rq_stop,
>  	.set_cpus_allowed	= set_cpus_allowed_common,
>  #endif
> 

