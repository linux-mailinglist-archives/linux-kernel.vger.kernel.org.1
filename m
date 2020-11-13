Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1D2B2097
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKMQhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:37:15 -0500
Received: from foss.arm.com ([217.140.110.172]:41182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKMQhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:37:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B5C1042;
        Fri, 13 Nov 2020 08:37:13 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AB1B3F718;
        Fri, 13 Nov 2020 08:37:13 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:37:12 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, will@kernel.org,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: implement CPPC FFH support using AMUs
Message-ID: <20201113163712.GA5058@arm.com>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201106125334.21570-4-ionela.voinescu@arm.com>
 <20201113141658.v2oq47nzerx3abga@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113141658.v2oq47nzerx3abga@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Friday 13 Nov 2020 at 14:16:58 (+0000), Sudeep Holla wrote:
[..]
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index b8cb16e3a2cc..7c9b6a0ecd6a 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -147,6 +147,9 @@ void update_freq_counters_refs(void)
> >
> >  static inline bool freq_counters_valid(int cpu)
> >  {
> > +	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> > +		return false;
> > +
> >  	if (!cpu_has_amu_feat(cpu)) {
> >  		pr_debug("CPU%d: counters are not supported.\n", cpu);
> >  		return false;
> > @@ -323,3 +326,64 @@ void topology_scale_freq_tick(void)
> >  	this_cpu_write(arch_core_cycles_prev, core_cnt);
> >  	this_cpu_write(arch_const_cycles_prev, const_cnt);
> >  }
> > +
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> > +#include <acpi/cppc_acpi.h>
> 
> Not sure what arm64 maintainers prefer, but this code has nothing to do
> with topolopy strictly speaking. I wonder if we can put it in separate

Yes, you are correct. I am/was wondering the same for all the
counters/AMU related functions, but given they were only used for
topology_scale_freq_tick() *until now*, it was okay to keep them in
topology.c.

But I might soon have at least one additional (to FIE and FFH) small
usecase for them in the implementation of arch_freq_get_on_cpu(), so all
these functions might be better off in a separate file as well.

Side note: I don't think frequency invariance is strictly speaking
related to topology either. Nether are other functions in the
arch_topology driver. It's likely we got used to placing all
arch function implementation in either the arch_topology driver or the
<arch>/kernel/topology.c.

> file conditionally compiled if CONFIG_ACPI_CPPC_LIB is enabled there
> by eliminating #ifdef(main reason for raising this point).
> 

I'm happy to split either one(FFH) or both(FFH and counters) in separate
files. Given the above, let me know if/how you guys prefer this done.

> Either way:
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Thank you for the reviews,
Ionela.

> --
> Regards,
> Sudeep
