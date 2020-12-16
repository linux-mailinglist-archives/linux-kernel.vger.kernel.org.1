Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A422DBA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 05:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgLPEit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 23:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgLPEit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 23:38:49 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D904C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:38:09 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 11so15814354pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TtYtbX1lI2eJjytGEUb089ONjbljIk6Ne6Tbl0/wHFk=;
        b=mQF5a9nebwpCJAF2yM+z0QxcE8dm7pobcpBX+N177QLAJaLo248YPZtugKk5fo20bG
         67YNPmM5dEtX5UE97o+QXI0IHDNz20C0peGSH0lXsHf6ykVUWHgofISChknZDgr1uWUo
         vAYEZeXIYDCtGNKPmoCGXIoEDWQUQmiVOMzLHTUM8BzSF404Oyo2i8Fr2tsZX4IxusG5
         oEojAeKxTGUQQZI0DW7/NI4sQB8eIEE4RohkBlA0nnz7rBuR/eXwQENhD0bxwXgWKJqk
         7RpoPr+pUq5m8dUJRBjiwi+O9+3c690gJ+224ba+K06ngUIFpl7jP/SlXLtL0D03cMs3
         ADjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TtYtbX1lI2eJjytGEUb089ONjbljIk6Ne6Tbl0/wHFk=;
        b=CezPMr7f29sbX2qJ1+9jze/wYJQSk7tncsNxuM61VLI1HRAmWVjA2DrNbet+ZOT8Ns
         sbAz727NvkzZThtE3qH8R/jsj6B/rSB4BDKW/J3Qs50wtQBqT61GnGBKmLDRr284OP3t
         CosieggmE3zLCZHLmVeWPIqdlR6TQkBxKNXCw6D7DTdK+avODXXCPSfPL+LFqkstuRf2
         WT8+XkxBoEBEN24mpo6pZOpzJ9bErrQpQWGhBJQ7vGpp36USpNTtqqIEnVqAg1M7gZa2
         5/FY6b15mQkACEirXRVvnGR+YKTEDjvYuef/U7EKAGbLcZdzytDSa0s7D3R8mGJgHbWd
         faDg==
X-Gm-Message-State: AOAM531Jsb7wUUbttBCc6H4eziuGVf3x0MDqQym7IMnzkkXbwYRWGFBu
        5QSlZqXW0UGUiH/81MfZfPeDwA==
X-Google-Smtp-Source: ABdhPJy5WelY58JqxtcuFokYE7gq8U+66RIthnVkkk/YxpESmRIKo/Bk8gT5QnZ4PpNzRmlbJen2Bw==
X-Received: by 2002:a63:924f:: with SMTP id s15mr1078889pgn.360.1608093488591;
        Tue, 15 Dec 2020 20:38:08 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id t5sm467720pjr.22.2020.12.15.20.38.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 20:38:07 -0800 (PST)
Date:   Wed, 16 Dec 2020 10:08:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: topology: Make AMUs work with modular
 cpufreq drivers
Message-ID: <20201216043805.bx6laemhfm2eaufv@vireshk-i7>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
 <20201216000349.GA5299@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216000349.GA5299@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-12-20, 00:03, Ionela Voinescu wrote:
> Hi,
> 
> On Tuesday 15 Dec 2020 at 11:04:16 (+0530), Viresh Kumar wrote:
> > The AMU counters won't get used today if the cpufreq driver is built as
> > a module as the amu core requires everything to be ready by late init.
> > 
> > Fix that properly by registering for cpufreq policy notifier. Note that
> > the amu core don't have any cpufreq dependency after the first time
> > CPUFREQ_CREATE_POLICY notifier is called for all the CPUs. And so we
> > don't need to do anything on the CPUFREQ_REMOVE_POLICY notifier. And for
> > the same reason we check if the CPUs are already parsed in the beginning
> > of amu_fie_setup() and skip if that is true. Alternatively we can shoot
> > a work from there to unregister the notifier instead, but that seemed
> > too much instead of this simple check.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V3:
> > - This is a new patch.
> > 
> > Ionela,
> > 
> > I don't have a way to test the AMU stuff, will it be possible for you to
> > give it a try ?
> > 
> 
> My best AMU test setup is a hacked Juno :).

Everyone is hacking around :)

> A few runs with different
> "AMU settings" showed everything works nicely. I'll continue reviewing
> and testing tomorrow as I want to test with CPPC and on some models as
> well.
> 
> >  arch/arm64/kernel/topology.c | 88 +++++++++++++++++++-----------------
> >  1 file changed, 46 insertions(+), 42 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 57267d694495..0fc2b32ddb45 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -199,64 +199,33 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
> >  	return 0;
> >  }
> >  
> > -static inline void
> > -enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
> > -{
> > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > -
> > -	if (!policy) {
> > -		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
> > -		return;
> > -	}
> > -
> > -	if (cpumask_subset(policy->related_cpus, valid_cpus))
> > -		cpumask_or(amu_fie_cpus, policy->related_cpus,
> > -			   amu_fie_cpus);
> > -
> > -	cpufreq_cpu_put(policy);
> > -}
> > -
> >  static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
> >  #define amu_freq_invariant() static_branch_unlikely(&amu_fie_key)
> >  
> > -static int __init init_amu_fie(void)
> > +static void amu_fie_setup(const struct cpumask *cpus)
> >  {
> > -	cpumask_var_t valid_cpus;
> >  	bool invariant;
> > -	int ret = 0;
> >  	int cpu;
> >  
> > -	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL))
> > -		return -ENOMEM;
> > -
> > -	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
> > -		ret = -ENOMEM;
> > -		goto free_valid_mask;
> > -	}
> > +	/* We are already set since the last insmod of cpufreq driver */
> > +	if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
> > +		return;
> >  
> > -	for_each_present_cpu(cpu) {
> > +	for_each_cpu(cpu, cpus) {
> >  		if (!freq_counters_valid(cpu) ||
> >  		    freq_inv_set_max_ratio(cpu,
> >  					   cpufreq_get_hw_max_freq(cpu) * 1000,
> >  					   arch_timer_get_rate()))
> > -			continue;
> > -
> > -		cpumask_set_cpu(cpu, valid_cpus);
> > -		enable_policy_freq_counters(cpu, valid_cpus);
> > +			return;
> >  	}
> >  
> > -	/* Overwrite amu_fie_cpus if all CPUs support AMU */
> > -	if (cpumask_equal(valid_cpus, cpu_present_mask))
> > -		cpumask_copy(amu_fie_cpus, cpu_present_mask);
> > -
> > -	if (cpumask_empty(amu_fie_cpus))
> > -		goto free_valid_mask;
> > +	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
> >  
> >  	invariant = topology_scale_freq_invariant();
> >  
> >  	/* We aren't fully invariant yet */
> >  	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
> > -		goto free_valid_mask;
> > +		return;
> >  
> >  	static_branch_enable(&amu_fie_key);
> >  
> 
> If we are cpufreq invariant, we'll reach this point and the following
> pr_info, even if not all CPUs have been checked, which (at this late
> hour) I think it's functionally fine.

Even then I think we should print cpus here instead of amu_fie_cpus,
just to not repeat things..

> But we get prints like:
> 
> [    2.665918] AMU: CPUs[0-3]: counters will be used for FIE.
> [    2.666293] AMU: CPUs[0-5]: counters will be used for FIE.
> 
> For two policies this is fine (although confusing) but if we had more
> CPUs and more policies, it would be too many lines.
> 
> I'm not sure if there's a better way of fixing this other than keeping
> track of all visited CPUs and printing this line when all online CPUs
> have been visited.

This is at best a debug message and maybe we should just convert it to
that and then it should be fine ?

And any logic added to print a better message isn't worth it I
believe.

> > @@ -271,13 +240,48 @@ static int __init init_amu_fie(void)
> >  	 */
> >  	if (!invariant)
> >  		rebuild_sched_domains_energy();
> > +}
> > +
> > +static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
> > +				 void *data)
> > +{
> > +	struct cpufreq_policy *policy = data;
> > +
> > +	if (val == CPUFREQ_CREATE_POLICY)
> > +		amu_fie_setup(policy->related_cpus);
> > +
> 
> Is is guaranteed that cpuinfo.max_freq is always set at this point?

Yes, we call this after the policy is initialized and all basic setup
is done.

> I have a vague recollection of a scenario where cpuinfo.max_freq could
> be populated later in case the driver needs to talk to firmware to
> obtain this value.

I don't remember anything like that for sure, we can see what to do if
we ever come across such a scenario.

> The setup above will fail if the CPU's max frequency cannot be obtained.

Yeah, I agree. Shouldn't happen though.

-- 
viresh
