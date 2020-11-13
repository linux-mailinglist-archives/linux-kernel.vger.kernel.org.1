Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E252D2B2131
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgKMQ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:58:46 -0500
Received: from foss.arm.com ([217.140.110.172]:41464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgKMQ6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:58:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08F511042;
        Fri, 13 Nov 2020 08:58:45 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EB273F718;
        Fri, 13 Nov 2020 08:58:44 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:58:43 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: abort counter_read_on_cpu() when irqs_disabled()
Message-ID: <20201113165843.GA6973@arm.com>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201113155328.4194-1-ionela.voinescu@arm.com>
 <20201113160234.GB44988@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113160234.GB44988@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 Nov 2020 at 16:02:34 (+0000), Mark Rutland wrote:
> On Fri, Nov 13, 2020 at 03:53:28PM +0000, Ionela Voinescu wrote:
> > Given that smp_call_function_single() can deadlock when interrupts are
> > disabled, abort the SMP call if irqs_disabled(). This scenario is
> > currently not possible given the function's uses, but safeguard this for
> > potential future uses.
> 
> Sorry to contradict earlier feedback, but I think this is preferable
> as-is, since smp_call_function_single() will
> WARN_ON_ONCE(irqs_disabled())), but this will silently mask any dodgy
> usage.

Probably it only contradicts the chosen implementation.

> 
> If we want a separate check here, I reckon we should wrap it with a
> WARN_ON_ONCE(), and only relax that if/when we have a legitimate case
> for calling this with IRQs disabled.
> 

That's fair. I'll replace the condition below with:

	if (!cpu_has_amu_feat(cpu))
		return -EOPNOTSUPP;

	if (WARN_ON_ONCE(irqs_disabled())
		return -EPERM;

Thanks for your time,
Ionela.

> Thanks,
> Mark.
> 
> > 
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/topology.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 3a083a9a8ef2..e387188741f2 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -343,7 +343,11 @@ static void cpu_read_constcnt(void *val)
> >  static inline
> >  int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> >  {
> > -	if (!cpu_has_amu_feat(cpu))
> > +	/*
> > +	 * Abort call on counterless CPU or when interrupts are
> > +	 * disabled - can lead to deadlock in smp sync call.
> > +	 */
> > +	if (!cpu_has_amu_feat(cpu) || unlikely(irqs_disabled()))
> >  		return -EOPNOTSUPP;
> >  
> >  	smp_call_function_single(cpu, func, val, 1);
> > -- 
> > 2.17.1
> > 
