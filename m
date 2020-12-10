Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C22D5939
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbgLJLaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:30:20 -0500
Received: from foss.arm.com ([217.140.110.172]:36438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbgLJLaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B9C30E;
        Thu, 10 Dec 2020 03:29:13 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A5DE3F718;
        Thu, 10 Dec 2020 03:29:13 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:29:12 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201210112912.GB5300@arm.com>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
 <20201210103815.GA3313@arm.com>
 <20201210105506.gi76peabl2bv5j62@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210105506.gi76peabl2bv5j62@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Dec 2020 at 16:25:06 (+0530), Viresh Kumar wrote:
> My intent was to keep the logical working of the code as is (in all
> the patches I have sent today), let me see if I broke that assumption
> somewhere unintentionally.
> 

Okay, I replied separately in regards to the piece of code that confused
things.

> On 10-12-20, 10:38, Ionela Voinescu wrote:
> > I'm first of all replying to discuss the need of this policy analysis
> > that enable_policy_freq_counters() does which results in the setting of
> > have_policy.
> > 
> > Basically, that's functions purpose is only to make sure that invariance
> > at the level of the policy is consistent: either all CPUs in a policy
> > support counters and counters will be used for the scale factor, or
> > either none or only some support counters and therefore the default
> > cpufreq implementation will be used (arch_set_freq_scale()) for all CPUs
> > in a policy.
> > 
> > If we find that cpufreq policies are not present at all, we only enable
> > counter use if all CPUs support them.
> 
> Right, and the same must be true after this patch.
> 
> > This being said, there is a very important part of your patches in this
> > set:
> > 
> > +	/* Disallow partial use of counters for frequency invariance */
> > +	if (!cpumask_equal(amu_fie_cpus, cpu_present_mask))
> > +		goto free_valid_mask;
> 
> The current code already has this check and so this isn't something
> new.
>  

Replied separately for the patch.

> > If this is agreed upon, there is a lot more that can be removed from the
> > initialisation: enable_policy_freq_counters() can entirely go away plus
> > all the checks around it.
> > 
> > I completely agree that all of this will be more clear if we decided to
> > "Disallow partial use of counters for frequency invariance", but I think
> > we might have to add it back in again when systems with partial support
> > for counters show up.
> > 
> > I don't agree to not support these systems from the get go as it's
> > likely that the first big.LITTLE systems will only have partial support
> > for AMUs, but it's only an assumption at this point.
> 
> Here is how things move AFAICT:
> 
> - We set valid_cpus 1-by-1 with all CPUs that have counters available.
> 

Yes.

> - Once all CPUs of a policy are part of valid_cpus, we update
>   amu_fie_cpus with that policies related_cpus.
> 

Yes.

> - Once we are done with all CPUs, we check if cpufreq policy was there
>   for any of the CPUs, if not, we update amu_fie_cpus if all present
>   CPUs are part of valid_cpus.
> 

Yes.

> - At this point we call static_branch_enable() if amu_fie_cpus is not
>   empty (i.e. even if it is partially set).
> 

Yes.

> - But right after that we call static_branch_disable() if we aren't
>   invariant (call to topology_scale_freq_invariant()), and this will
>   happen if amu_fie_cpus doesn't have all the CPUs there. Isn't it? So
>   partial amu support is already disallowed, without cpufreq.
> 

This is the point that needs clarification:

topology_scale_freq_invariant()) = cpufreq_supports_freq_invariance() ||
                                   arch_freq_counters_available(cpu_online_mask);

This checks if the full system is invariant.

The possible scenarios are:

 - All online CPUs support AMUs - arch_freq_counters_available() will
   return true -> topology_scale_freq_invariant() will return true.

 - None of the CPUs support AMUs, or part of the CPUs support AMUs - the
   system is invariant only if cpufreq is invariant (dependent on
   whether the driver implements the proper callbacks that results in
   calling arch_set_freq_scale() in cpufreq core.

 - Either cpufreq does not support invariance or we don't have AMU
   support on all CPUs -> the system is not invariant so we disable
   the AMU static key that guards the calls to
   topology_scale_freq_tick() - we would not want to set a scale factor
   for only a part of the CPUs.

So whether were are or are not invariant does not depend only on the AMU
presence, but also on the cpufreq support for invariance. We have to
disable invariance altogether (including the AMU guarding static key)
if the system is not invariant (it no all CPUs have means to provide the
scale).

Let me know if it makes sense.

> Where am I wrong ? (And I know there is a high possibility of that
> happening here :) )..
> 

No worries. I myself sometimes wonder if I missed something. I will be
happy in a few years when we can remove this and use counters for all
CPUs.

Thanks,
Ionela.

> -- 
> viresh
