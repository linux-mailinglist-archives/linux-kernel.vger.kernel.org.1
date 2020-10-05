Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3546A2832CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJEJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgJEJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601889068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KsePg+8OJjmgGODX6qQL/O9iT0ASJKU1fWBCLAva6cw=;
        b=in0F7B0XBqCQ5i8qmavGbunItY7Fyb98qwgSWfLPBB/8Pbt/CIBr6CT+YQ7IyxGFsL473V
        hD58a9mbhyDZ6oJu0T/eWZY6UdjvkZWC6ypZU0Q9c37P+SEP2gArtJWBqJLWvk57c7W6ld
        sq6K3brt+aTzf+9JrkOqygmEU7wvo6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-HCvPuM2lPxWKXC4r7qmb_g-1; Mon, 05 Oct 2020 05:11:05 -0400
X-MC-Unique: HCvPuM2lPxWKXC4r7qmb_g-1
Received: by mail-wm1-f70.google.com with SMTP id c204so2202676wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 02:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KsePg+8OJjmgGODX6qQL/O9iT0ASJKU1fWBCLAva6cw=;
        b=njKRaTHbW7Ry5k7BlwtZGXLKnAtB/qls9RX7eBFygHUDlS/UECDYWF3zri/6D5cUbR
         KSYokO6COpsqdgXozHAppd4xq3GRbvvmlgJErsag+5nzuj0Wx0UvyI7JdCIyz+iyS5uD
         rcRCMA3uZnRdpL76/Zn26wXRyvCpSzVO4MV+2zI6CplsAO6bVjGk14rWDd8l+KXyIrhG
         1eo6mm59H21DOY7VaZKSi4mybm2es52BC4M0bmb4FR5vKv7530Dtv0QuEF3nbtFc70dB
         0XhQY7gyIyS3+fmdNptwlw+RUgdH9ud4FT7xxHDWAXQTgvpiPR5ar74eqQTFptS/rlsf
         ZhtQ==
X-Gm-Message-State: AOAM533OZeoMCboZw+idpbDqvIVzsuNp2lVL2B1M0NroVNihtLxRCblh
        YAMOSXTGJ8JLzIJo38O5XNKzRUO3taDataEQwUDxk0LTrqrejwSH8kQpEx3m7NjTcRUOwkNcbNJ
        025Yy/0e0QfyhMrFFZP1ecqfm
X-Received: by 2002:a5d:5307:: with SMTP id e7mr16260573wrv.215.1601889063420;
        Mon, 05 Oct 2020 02:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBy3SFk+78FUQCZfTEV11ezLX36GUPG/U3Tt9OU9m5OZV6n6bFNO3jZ6K2hfRRuQDS8G+05g==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr16260542wrv.215.1601889063055;
        Mon, 05 Oct 2020 02:11:03 -0700 (PDT)
Received: from localhost.localdomain ([151.29.91.67])
        by smtp.gmail.com with ESMTPSA id z67sm12489067wme.41.2020.10.05.02.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:11:02 -0700 (PDT)
Date:   Mon, 5 Oct 2020 11:11:00 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        raistlin@linux.it
Subject: Re: [PATCH v4] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20201005091100.GA4352@localhost.localdomain>
References: <20200925162032.GA9692@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925162032.GA9692@iZj6chx1xj0e0buvshuecpZ>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/09/20 00:20, Peng Liu wrote:
> I created another root domain(contains 2 CPUs) besides the default
> one, and the global default rt bandwidth is 95%. Then launched a
> DL process which need 25% bandwidth and moved it to the new root
> domain, so far so good.
> 
> Then I tried to change global rt bandwidth to 20% with cmd:
> 	echo 200000 > /proc/sys/kernel/sched_rt_runtime_us
> but ending with the below error:
> 	bash: echo: write error: Device or resource busy
> Only values greater than 250000 could work.
> 
> The new root domain contains two CPUs, thus should could provide
> totally 2*20%(>25%) bandwidth. So the error is strange.
> Finally I found it's the sched_dl_global_validate() mistakenly
> do the validation.
> 
> When change sched_rt_{runtime, period}_us, then
> 
>   sched_rt_handler()
>     -->	sched_dl_bandwidth_validate()
> 	{
> 		new_bw = global_rt_runtime()/global_rt_period();
> 
> 		for_each_possible_cpu(cpu) {
> 			dl_b = dl_bw_of(cpu);
> 			if (new_bw < dl_b->total_bw)
> 				ret = -EBUSY;
> 		}
> 	}
> 
> Under CONFIG_SMP, dl_bw is per root domain , but not per CPU,
> dl_b->total_bw is the allocated bandwidth of the whole root domain.
> we should compare dl_b->total_bw against cpus*new_bw, where 'cpus'
> is the number of CPUs of the root domain.
> 
> Also, below annotation(in kernel/sched/sched.h) implied implementation
> only appeared in SCHED_DEADLINE v2[1], then deadline scheduler kept
> evolving till got merged(v9), but the annotation remains unchanged,
> meaningless and misleading, correct it.
> 
> * With respect to SMP, the bandwidth is given on a per-CPU basis,
> * meaning that:
> *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
> *  - dl_total_bw array contains, in the i-eth element, the currently
> *    allocated bandwidth on the i-eth CPU.
> 
> [1]: https://lore.kernel.org/lkml/1267385230.13676.101.camel@Palantir/
> 
> Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> ---
> 
> v4 <-- v3:
>  - refine changelog;
>  - eliminate the ugly #ifdef guys with Peter's method;
> 
> v3 <-- v2:
>  - fix build error for !CONFIG_SMP, reported by kernel test robot;
> 
> v2 <-- v1:
>  - replace cpumask_weight(cpu_rq(cpu)->rd->span) with dl_bw_cpus(cpu),
>    suggested by Juri;
> 
>  kernel/sched/deadline.c | 43 ++++++++++++++++++++++++++++++++---------
>  kernel/sched/sched.h    | 22 +++++++++------------
>  kernel/sched/topology.c |  1 +
>  3 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3862a28cd05d..c95af33b7274 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -97,6 +97,17 @@ static inline unsigned long dl_bw_capacity(int i)
>  		return __dl_bw_capacity(i);
>  	}
>  }
> +
> +static inline bool dl_bw_visited(int cpu, u64 gen)
> +{
> +	struct root_domain *rd = cpu_rq(cpu)->rd;
> +
> +	if (rd->visit_gen == gen)
> +		return true;
> +
> +	rd->visit_gen = gen;
> +	return false;
> +}
>  #else
>  static inline struct dl_bw *dl_bw_of(int i)
>  {
> @@ -112,6 +123,11 @@ static inline unsigned long dl_bw_capacity(int i)
>  {
>  	return SCHED_CAPACITY_SCALE;
>  }
> +
> +static inline bool dl_bw_visited(int cpu, u64 gen)
> +{
> +	return false;
> +}
>  #endif
>  
>  static inline
> @@ -2511,33 +2527,38 @@ const struct sched_class dl_sched_class
>  	.update_curr		= update_curr_dl,
>  };
>  
> +static u64 dl_generation;
> +
>  int sched_dl_global_validate(void)
>  {
>  	u64 runtime = global_rt_runtime();
>  	u64 period = global_rt_period();
>  	u64 new_bw = to_ratio(period, runtime);
>  	struct dl_bw *dl_b;
> -	int cpu, ret = 0;
> +	int cpu, cpus, ret = 0;
>  	unsigned long flags;
> +	u64 gen = ++dl_generation;
>  
>  	/*
>  	 * Here we want to check the bandwidth not being set to some
>  	 * value smaller than the currently allocated bandwidth in
>  	 * any of the root_domains.
> -	 *
> -	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
> -	 * cycling on root_domains... Discussion on different/better
> -	 * solutions is welcome!

So, this patch changes 2 things: it actually fixes the problem and it
optimizes scanning of root domains. Even though the changes are limited,
I'd be more comfortable if we split them in two (fix + optimization).

Would you be up for doing it?

>  	 */
>  	for_each_possible_cpu(cpu) {
>  		rcu_read_lock_sched();
> +
> +		if (dl_bw_visited(cpu, gen))
> +			goto next;
> +
>  		dl_b = dl_bw_of(cpu);
> +		cpus = dl_bw_cpus(cpu);
>  
>  		raw_spin_lock_irqsave(&dl_b->lock, flags);
> -		if (new_bw < dl_b->total_bw)
> +		if (new_bw * cpus < dl_b->total_bw)
>  			ret = -EBUSY;
>  		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
>  
> +next:
>  		rcu_read_unlock_sched();
>  
>  		if (ret)
> @@ -2563,6 +2584,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
>  void sched_dl_do_global(void)
>  {
>  	u64 new_bw = -1;
> +	u64 gen = ++dl_generation;
>  	struct dl_bw *dl_b;
>  	int cpu;
>  	unsigned long flags;
> @@ -2573,11 +2595,14 @@ void sched_dl_do_global(void)
>  	if (global_rt_runtime() != RUNTIME_INF)
>  		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
>  
> -	/*
> -	 * FIXME: As above...
> -	 */
>  	for_each_possible_cpu(cpu) {
>  		rcu_read_lock_sched();
> +
> +		if (dl_bw_visited(cpu, gen)) {
> +			rcu_read_unlock_sched();
> +			continue;
> +		}
> +
>  		dl_b = dl_bw_of(cpu);
>  
>  		raw_spin_lock_irqsave(&dl_b->lock, flags);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 28709f6b0975..c23976bc38e9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -258,10 +258,11 @@ struct rt_bandwidth {
>  void __dl_clear_params(struct task_struct *p);
>  
>  /*
> - * To keep the bandwidth of -deadline tasks and groups under control
> + * To keep the bandwidth of -deadline tasks under control
>   * we need some place where:
> - *  - store the maximum -deadline bandwidth of the system (the group);
> - *  - cache the fraction of that bandwidth that is currently allocated.
> + *  - store the maximum -deadline bandwidth of each CPU;
> + *  - cache the fraction of that bandwidth that is currently allocated
> + *    in each root domain;
>   *
>   * This is all done in the data structure below. It is similar to the
>   * one used for RT-throttling (rt_bandwidth), with the main difference
> @@ -269,17 +270,10 @@ void __dl_clear_params(struct task_struct *p);
>   * do not decrease any runtime while the group "executes", neither we
>   * need a timer to replenish it.
>   *
> - * With respect to SMP, the bandwidth is given on a per-CPU basis,
> + * With respect to SMP, the bandwidth is given on per root domain basis,
>   * meaning that:
> - *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
> - *  - dl_total_bw array contains, in the i-eth element, the currently
> - *    allocated bandwidth on the i-eth CPU.
> - * Moreover, groups consume bandwidth on each CPU, while tasks only
> - * consume bandwidth on the CPU they're running on.
> - * Finally, dl_total_bw_cpu is used to cache the index of dl_total_bw
> - * that will be shown the next time the proc or cgroup controls will
> - * be red. It on its turn can be changed by writing on its own
> - * control.
> + *  - bw (< 100%) is the deadline bandwidth of each CPU;
> + *  - total_bw is the currently allocated bandwidth on each root domain.
>   */
>  struct dl_bandwidth {
>  	raw_spinlock_t		dl_runtime_lock;
> @@ -801,6 +795,8 @@ struct root_domain {
>  	struct dl_bw		dl_bw;
>  	struct cpudl		cpudl;
>  
> +	u64			visit_gen;
> +

I think this deserves a comment explaining what it is and how it's used.

Also, do we really need an u64? Maybe an smaller type would be OK as
well and could fit in the 4 bytes hole that seems available after
dlo_count, I'm thinking.

Thanks,
Juri

