Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E02DC749
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgLPTiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:38:13 -0500
Received: from foss.arm.com ([217.140.110.172]:43254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgLPTiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:38:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A526E31B;
        Wed, 16 Dec 2020 11:37:26 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D9AC3F718;
        Wed, 16 Dec 2020 11:37:26 -0800 (PST)
Date:   Wed, 16 Dec 2020 19:37:24 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: topology: Make AMUs work with modular
 cpufreq drivers
Message-ID: <20201216193724.GA375@arm.com>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
 <20201216000349.GA5299@arm.com>
 <20201216043805.bx6laemhfm2eaufv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216043805.bx6laemhfm2eaufv@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 16 Dec 2020 at 10:08:05 (+0530), Viresh Kumar wrote:
[..]
> > > +static void amu_fie_setup(const struct cpumask *cpus)
> > >  {
> > > -	cpumask_var_t valid_cpus;
> > >  	bool invariant;
> > > -	int ret = 0;
> > >  	int cpu;
> > >  
> > > -	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL))
> > > -		return -ENOMEM;
> > > -
> > > -	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
> > > -		ret = -ENOMEM;
> > > -		goto free_valid_mask;
> > > -	}
> > > +	/* We are already set since the last insmod of cpufreq driver */
> > > +	if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
> > > +		return;
> > >  
> > > -	for_each_present_cpu(cpu) {
> > > +	for_each_cpu(cpu, cpus) {
> > >  		if (!freq_counters_valid(cpu) ||
> > >  		    freq_inv_set_max_ratio(cpu,
> > >  					   cpufreq_get_hw_max_freq(cpu) * 1000,
> > >  					   arch_timer_get_rate()))
> > > -			continue;
> > > -
> > > -		cpumask_set_cpu(cpu, valid_cpus);
> > > -		enable_policy_freq_counters(cpu, valid_cpus);
> > > +			return;
> > >  	}
> > >  
> > > -	/* Overwrite amu_fie_cpus if all CPUs support AMU */
> > > -	if (cpumask_equal(valid_cpus, cpu_present_mask))
> > > -		cpumask_copy(amu_fie_cpus, cpu_present_mask);
> > > -
> > > -	if (cpumask_empty(amu_fie_cpus))
> > > -		goto free_valid_mask;
> > > +	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
> > >  
> > >  	invariant = topology_scale_freq_invariant();
> > >  
> > >  	/* We aren't fully invariant yet */
> > >  	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
> > > -		goto free_valid_mask;
> > > +		return;
> > >  
> > >  	static_branch_enable(&amu_fie_key);
> > >  
> > 
> > If we are cpufreq invariant, we'll reach this point and the following
> > pr_info, even if not all CPUs have been checked, which (at this late
> > hour) I think it's functionally fine.
> 
> Even then I think we should print cpus here instead of amu_fie_cpus,
> just to not repeat things..
> 

Agreed!

> > But we get prints like:
> > 
> > [    2.665918] AMU: CPUs[0-3]: counters will be used for FIE.
> > [    2.666293] AMU: CPUs[0-5]: counters will be used for FIE.
> > 
> > For two policies this is fine (although confusing) but if we had more
> > CPUs and more policies, it would be too many lines.
> > 
> > I'm not sure if there's a better way of fixing this other than keeping
> > track of all visited CPUs and printing this line when all online CPUs
> > have been visited.
> 
> This is at best a debug message and maybe we should just convert it to
> that and then it should be fine ?
> 
> And any logic added to print a better message isn't worth it I
> believe.
> 

That's true. The reason I would have wanted a single line to mention the
use of counters for FIE is because it's difficult to notice frequency
invariance issues. Everything might seems to work fine but without
or with broken frequency invariance the scheduler would not behave
optimally.

But we did the same compromise for EAS so making this a debug message is
fine I think.

> > > @@ -271,13 +240,48 @@ static int __init init_amu_fie(void)
> > >  	 */
> > >  	if (!invariant)
> > >  		rebuild_sched_domains_energy();
> > > +}
> > > +
> > > +static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
> > > +				 void *data)
> > > +{
> > > +	struct cpufreq_policy *policy = data;
> > > +
> > > +	if (val == CPUFREQ_CREATE_POLICY)
> > > +		amu_fie_setup(policy->related_cpus);
> > > +
> > 
> > Is is guaranteed that cpuinfo.max_freq is always set at this point?
> 
> Yes, we call this after the policy is initialized and all basic setup
> is done.
> 
> > I have a vague recollection of a scenario where cpuinfo.max_freq could
> > be populated later in case the driver needs to talk to firmware to
> > obtain this value.
> 
> I don't remember anything like that for sure, we can see what to do if
> we ever come across such a scenario.
> 

Makes sense!

> > The setup above will fail if the CPU's max frequency cannot be obtained.
> 
> Yeah, I agree. Shouldn't happen though.
> 

> > > +	/*
> > > +	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> > > +	 * counters don't have any dependency on cpufreq driver once we have
> > > +	 * initialized AMU support and enabled invariance. The AMU counters will
> > > +	 * keep on working just fine in the absence of the cpufreq driver, and
> > > +	 * for the CPUs for which there are no counters availalbe, the last set
                                                        ^^^^^^^^^
							available

> > > +	 * value of freq_scale will remain valid as that is the frequency those
> > > +	 * CPUs are running at.
> +	 */

I did not yet test this, but reading this comment made me wonder..

arch_scale_freq_invariant() (or topology_scale_freq_invariant()) is also
called from schedutil when obtaining the next frequency.

So if we had a system that only partly supports AMUs but had at some
point a cpufreq driver that provided FIE for the other CPUs, when we
unregister the driver, the cpufreq_freq_invariance static key is
disabled. Therefore, none of the conditions for system invariance is
now accomplished and arch_scale_freq_invariant() will return false.
This will be broken as utilization is still scaled, but the algorithm
for computing the next frequency in schedutil will not take this into
account.

[..]
> > > +	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> > > +					CPUFREQ_POLICY_NOTIFIER);

The above makes the use of AMUs for FIE tightly coupled with cpufreq.

Initially I made cpufreq_get_hw_max_freq(cpu) a weak function for the
possible platforms that might not use a cpufreq driver and might want to
provide this function to still benefit from the use of counters for
frequency invariance.

But I'm starting to believe that supporting all these corner-cases in
advance just introduces messiness.

So feel free to remove the 'weak' state of cpufreq_get_hw_max_freq() as
well, so we don't keep wondering why we had that in the first place.
It would not make any sense keeping that in light of these changes.

P.S. I will be on holiday starting tomorrow until beginning of January.
Were you intending this for 5.11, or can I take more time to review
future versions and continue testing?

Thanks,
Ionela.

> -- 
> viresh
