Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683B52B250B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKMUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgKMUD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:03:56 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E316122242;
        Fri, 13 Nov 2020 20:03:53 +0000 (UTC)
Date:   Fri, 13 Nov 2020 20:03:51 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, mark.rutland@arm.com,
        will@kernel.org, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: implement CPPC FFH support using AMUs
Message-ID: <20201113200351.GB20519@gaia>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201106125334.21570-4-ionela.voinescu@arm.com>
 <20201113141658.v2oq47nzerx3abga@bogus>
 <20201113163712.GA5058@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113163712.GA5058@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:37:12PM +0000, Ionela Voinescu wrote:
> On Friday 13 Nov 2020 at 14:16:58 (+0000), Sudeep Holla wrote:
> [..]
> > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > > index b8cb16e3a2cc..7c9b6a0ecd6a 100644
> > > --- a/arch/arm64/kernel/topology.c
> > > +++ b/arch/arm64/kernel/topology.c
> > > @@ -147,6 +147,9 @@ void update_freq_counters_refs(void)
> > >
> > >  static inline bool freq_counters_valid(int cpu)
> > >  {
> > > +	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> > > +		return false;
> > > +
> > >  	if (!cpu_has_amu_feat(cpu)) {
> > >  		pr_debug("CPU%d: counters are not supported.\n", cpu);
> > >  		return false;
> > > @@ -323,3 +326,64 @@ void topology_scale_freq_tick(void)
> > >  	this_cpu_write(arch_core_cycles_prev, core_cnt);
> > >  	this_cpu_write(arch_const_cycles_prev, const_cnt);
> > >  }
> > > +
> > > +#ifdef CONFIG_ACPI_CPPC_LIB
> > > +#include <acpi/cppc_acpi.h>
> > 
> > Not sure what arm64 maintainers prefer, but this code has nothing to do
> > with topolopy strictly speaking. I wonder if we can put it in separate
> 
> Yes, you are correct. I am/was wondering the same for all the
> counters/AMU related functions, but given they were only used for
> topology_scale_freq_tick() *until now*, it was okay to keep them in
> topology.c.
> 
> But I might soon have at least one additional (to FIE and FFH) small
> usecase for them in the implementation of arch_freq_get_on_cpu(), so all
> these functions might be better off in a separate file as well.
> 
> Side note: I don't think frequency invariance is strictly speaking
> related to topology either. Nether are other functions in the
> arch_topology driver. It's likely we got used to placing all
> arch function implementation in either the arch_topology driver or the
> <arch>/kernel/topology.c.

Yeah, it looks like these topology files became a dumping ground for
whatever power related ;).

I'm ok with these patches as they are for now but it would be good to do
some refactoring on top and maybe move them to an amu.c file (it's not
urgent, it can be for 5.12 or when you plan to add more stuff next). I
don't have an opinion for arch_topology.c, so far it doesn't seem to
have any AMU stuff in it.

-- 
Catalin
