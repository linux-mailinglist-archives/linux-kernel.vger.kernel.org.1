Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ACB2B1B77
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgKMMyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKMMyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:54:38 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6713E206D9;
        Fri, 13 Nov 2020 12:54:36 +0000 (UTC)
Date:   Fri, 13 Nov 2020 12:54:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mark.rutland@arm.com, sudeep.holla@arm.com, will@kernel.org,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: implement CPPC FFH support using AMUs
Message-ID: <20201113125432.GE3212@gaia>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201106125334.21570-4-ionela.voinescu@arm.com>
 <20201112180045.GO29613@gaia>
 <20201113122846.GA31212@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113122846.GA31212@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:28:46PM +0000, Ionela Voinescu wrote:
> On Thursday 12 Nov 2020 at 18:00:46 (+0000), Catalin Marinas wrote:
> > On Fri, Nov 06, 2020 at 12:53:34PM +0000, Ionela Voinescu wrote:
> > > +static inline
> > > +int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> > > +{
> > > +	if (!cpu_has_amu_feat(cpu))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	smp_call_function_single(cpu, func, val, 1);
> > > +
> > > +	return 0;
> > > +}
> > 
> > I got lost in the cpufreq call chains. Can this function ever be called
> > with interrupts disabled?
> 
> The short answer is: not with the current implementation of its only
> user, the cppc_cpufreq driver (given the current cpufreq implementation).
> 
> The long answer is: there is a case where the cpufreq .get function is
> called with local interrupts disabled - cpufreq_quick_get(), but there
> are a few "if"s in between this becoming a problem:
> 
>  1. If cppc_cpufreq ever implements .setpolicy or,
>     1.1 Current implementation of cpufreq_quick_get() changes.
>  2. If one of the few users of cpufreq_quick_get() is used: cppc_cpufreq
>     ends up being used as CPU cooling device(+IPA governor) or
>     devfreq/tegra30 is used.
> 
>  In this potential case, smp_call_function_single() will warn us of call
>  with irqs_disable() and if the stars align there could be a potential
>  deadlock if two CPUs try to IPI (get counter reads of) each other.
> 
> So it could be called with irqs disabled, but a few code changes are
> needed before that happens.
> 
> I can bail out of counters_read_on_cpu() if irqs_disabled() to be on the
> safe side.

Thanks for the explanation. In case we forget two years from now and the
core code changes, I think it's safe to bail out early with an error.
You can add a patch on top of this series, no need to resend the whole.

-- 
Catalin
