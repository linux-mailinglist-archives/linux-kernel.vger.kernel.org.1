Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5144D2D5BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbgLJN11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:27:27 -0500
Received: from foss.arm.com ([217.140.110.172]:41676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbgLJN10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:27:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B9841FB;
        Thu, 10 Dec 2020 05:26:41 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFE1C3F718;
        Thu, 10 Dec 2020 05:26:40 -0800 (PST)
Date:   Thu, 10 Dec 2020 13:26:39 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201210132639.GB8683@arm.com>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
 <20201210103815.GA3313@arm.com>
 <20201210105506.gi76peabl2bv5j62@vireshk-i7>
 <20201210112912.GB5300@arm.com>
 <20201210123439.zugex2zzbmy6z3le@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210123439.zugex2zzbmy6z3le@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Dec 2020 at 18:04:39 (+0530), Viresh Kumar wrote:
> On 10-12-20, 11:29, Ionela Voinescu wrote:
> > On Thursday 10 Dec 2020 at 16:25:06 (+0530), Viresh Kumar wrote:
> > > - But right after that we call static_branch_disable() if we aren't
> > >   invariant (call to topology_scale_freq_invariant()), and this will
> > >   happen if amu_fie_cpus doesn't have all the CPUs there. Isn't it? So
> > >   partial amu support is already disallowed, without cpufreq.
> > > 
> > 
> > This is the point that needs clarification:
> > 
> > topology_scale_freq_invariant()) = cpufreq_supports_freq_invariance() ||
> >                                    arch_freq_counters_available(cpu_online_mask);
> > 
> > This checks if the full system is invariant.
> > 
> > The possible scenarios are:
> > 
> >  - All online CPUs support AMUs - arch_freq_counters_available() will
> >    return true -> topology_scale_freq_invariant() will return true.
> > 
> >  - None of the CPUs support AMUs, or part of the CPUs support AMUs - the
> >    system is invariant only if cpufreq is invariant (dependent on
> >    whether the driver implements the proper callbacks that results in
> >    calling arch_set_freq_scale() in cpufreq core.
> > 
> >  - Either cpufreq does not support invariance or we don't have AMU
> >    support on all CPUs -> the system is not invariant so we disable
> >    the AMU static key that guards the calls to
> >    topology_scale_freq_tick() - we would not want to set a scale factor
> >    for only a part of the CPUs.
> > 
> > So whether were are or are not invariant does not depend only on the AMU
> > presence, but also on the cpufreq support for invariance. We have to
> > disable invariance altogether (including the AMU guarding static key)
> > if the system is not invariant (it no all CPUs have means to provide the
> > scale).
> 
> Okay, I think I mis-assumed that amu_fie_cpus will get set by
> enable_policy_freq_counters() even for CPUs where AMU support isn't
> there, it won't be though.
> 
> Having said that, this patch, along with the minor suggestion in the
> commit log, still stands fine, right ? The other patch which I sent is
> probably incorrect due to the above assumption I had.
> 

Yes, this one is good, although I would vote for the commit message
implementation. I'll wait for v2 for reviewed-by, in case you want to
push something for the second patch in the same series.

Ionela.

> -- 
> viresh
