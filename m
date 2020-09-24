Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1812C277611
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgIXP7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgIXP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:59:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:59:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d19so1921665pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9UnsUE38lY5P++mA2KHId6gwRqtWgUbT4uO4Se4XFs=;
        b=ml1szZHqdLoAjr7N7cURKwfeb7cJ6U8JnvpfwxfQ1avajQ5qzXJxpRXjvRoZ1qwugh
         XmmyQIpoKKK011kF5EN1ibt2J6WiWTNuretYmv8H6Tno7lpLW/CrsY5wOMl/d9Pq1kDc
         L+OqYHNouLHSCDbcnso6ZFRnossPWKQCwLc4Hoeup17hK/hJPmXOIOKnRjwDwG3/EN8X
         tJkZnc1avcKfitbYsAalAj1t6wmniW3Nn6AYVQC81ZJRwVPA7ZInU4nl9IarC0u5DFRO
         4cdIefrY4L49r0p/CAptygaIUgqEJStJNss799LQMJTQf2MI3Yvv4ojAV191jEtxZKTe
         cPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9UnsUE38lY5P++mA2KHId6gwRqtWgUbT4uO4Se4XFs=;
        b=GNPZrCtCQgwZCdQp6YDeSe1oyfMpb5PNuXBKMC5dgKBcXvMwyiRLsx84fpCSbopavO
         h2NUi3VUaKMdtvMvzbOk6cYu3dka0hLxBtPeQXiR+IAqWB0vLjFXF81DeII6sdN8p2ee
         LcthXushPOjea9/uClrP+d2pfZbar2lb+PrMZKbNucrmAHdPgxayD1ZcnuQ3ID/bv0Zw
         jp/sgWSpMt+dtrJ+XNl2ewEis8Wq5tncMnyVuW7W8gqYxta7gs1XeazvCtfHziRoNkU/
         mEHO0f33R7/PBtiVvWL87HyJMSdRWUwSEsez8psx4CxnXStg+O/1odjr9o9ZFkyvcp4d
         SZgA==
X-Gm-Message-State: AOAM530GF259fbDO6ypHiAv07BbdlNbK0s+CNh1lIL7/6B9KCnjyZKW1
        A+vvggAsJbINjAicg8NlBjt9pfkgee8=
X-Google-Smtp-Source: ABdhPJwZ5mUasK5APRGvAV68scOMkLebs4HLf5MWpRR/KQ3kZJJaKTUgDgbUIyMAAkjp+OR6W/AvCA==
X-Received: by 2002:a17:902:bc81:b029:d2:2988:4781 with SMTP id bb1-20020a170902bc81b02900d229884781mr5078442plb.50.1600963154002;
        Thu, 24 Sep 2020 08:59:14 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id n7sm3352173pfq.114.2020.09.24.08.59.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 08:59:13 -0700 (PDT)
Date:   Thu, 24 Sep 2020 23:59:09 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20200924155909.GA7951@iZj6chx1xj0e0buvshuecpZ>
References: <20200919014249.GA31707@iZj6chx1xj0e0buvshuecpZ>
 <20200924105714.GB2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924105714.GB2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for looking at this.

On Thu, Sep 24, 2020 at 12:57:14PM +0200, Peter Zijlstra wrote:
> On Sat, Sep 19, 2020 at 09:42:49AM +0800, Peng Liu wrote:
> > When user changes sched_rt_{runtime, period}_us, then
> > 
> >   sched_rt_handler()
> >     -->	sched_dl_bandwidth_validate()
> > 	{
> > 		new_bw = global_rt_runtime()/global_rt_period();
> > 
> > 		for_each_possible_cpu(cpu) {
> > 			dl_b = dl_bw_of(cpu);
> > 			if (new_bw < dl_b->total_bw)
> > 				ret = -EBUSY;
> > 		}
> > 	}
> > 
> > Under CONFIG_SMP, dl_bw is per root domain , but not per CPU,
> > dl_b->total_bw is the allocated bandwidth of the whole root domain.
> > we should compare dl_b->total_bw against cpus*new_bw, where 'cpus'
> > is the number of CPUs of the root domain.
> 
> Is there an actual problem there? Spell it out.

I created another root domain(contains 2 CPUs) besides the default
one, and the global default rt bandwidth is 95%. Then I launched a
DL process which need 25% bandwidth and moved it to the new root
domain, so far so good.

Then I tried to change global rt bandwidth to 20% with cmd:
	echo 200000 > /proc/sys/kernel/sched_rt_runtime_us
but ending with the "device busy" error. Only values greater than
250000 could work.

The new root domain contains two CPUs, thus should could provide
totally 2*20%(>25%) bandwidth. So the error is strange.

Finally I found it is the sched_dl_global_validate() mistakenly
do the validation. It doesn't multiply the root domain weight.

way to reproduce:
cd /sys/fs/cgroup/cpuset/
mkdir cluster
echo 0 > cpuset.sched_load_balance
cd cluster
echo 10-11 > cpuset.cpus
echo 0 > cpuset.mems
echo 1 > cpuset.cpu_exclusive
echo pid-of-dl25 > tasks

> > 
> > [1] https://lkml.org/lkml/2010/2/28/119
> 
> Don't use lkml.org links, use lkml.kernel.org/r/$MsgID instead.

OK, I will.

> 
> > [!CONFIG_SMP build error]
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> 
> Quite frankly this patch is horrible #ifdef soup.

Frankly speaking, I also hate the ugly #ifdef guys, but I have no
idea how to eliminate them until seeing your method. Indeed, quite
clear. I will refine the patch according your suggestion. Thanks.

> 
> Can't you make something like the below work?
> 
> ---
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3862a28cd05d..3f309e0f69f5 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -97,6 +97,17 @@ static inline unsigned long dl_bw_capacity(int i)
>  		return __dl_bw_capacity(i);
>  	}
>  }
> +
> +static inline bool dl_bw_visited(int cpu, u64 gen)
> +{
> +	struct root_domain *rd = cpu_rq(i)->rd;
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
> @@ -2513,31 +2529,35 @@ const struct sched_class dl_sched_class
>  
>  int sched_dl_global_validate(void)
>  {
> +	static u64 generation = 0;
>  	u64 runtime = global_rt_runtime();
>  	u64 period = global_rt_period();
>  	u64 new_bw = to_ratio(period, runtime);
> -	struct dl_bw *dl_b;
> -	int cpu, ret = 0;
> +	int cpu, cpus, ret = 0;
>  	unsigned long flags;
> +	struct dl_bw *dl_b;
> +	u64 gen = ++generation;
>  
>  	/*
>  	 * Here we want to check the bandwidth not being set to some
>  	 * value smaller than the currently allocated bandwidth in
>  	 * any of the root_domains.
> -	 *
> -	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
> -	 * cycling on root_domains... Discussion on different/better
> -	 * solutions is welcome!
>  	 */
>  	for_each_possible_cpu(cpu) {
> +
>  		rcu_read_lock_sched();
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
> +	next:
>  		rcu_read_unlock_sched();
>  
>  		if (ret)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 28709f6b0975..7f0947db6e2c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -801,6 +801,8 @@ struct root_domain {
>  	struct dl_bw		dl_bw;
>  	struct cpudl		cpudl;
>  
> +	u64			visit_gen;
> +
>  #ifdef HAVE_RT_PUSH_IPI
>  	/*
>  	 * For IPI pull requests, loop across the rto_mask.
