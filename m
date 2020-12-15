Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF112DAD57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgLOMbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgLOMbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:31:06 -0500
Date:   Tue, 15 Dec 2020 12:30:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Drop the useless update to per-cpu
 cycles
Message-ID: <20201215123019.GB2511@gaia>
References: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
 <20201211064850.gsqsszwhxx5lzqgw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211064850.gsqsszwhxx5lzqgw@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:18:50PM +0530, Viresh Kumar wrote:
> On 10-12-20, 11:17, Viresh Kumar wrote:
> > The previous call to update_freq_counters_refs() has already updated the
> > per-cpu variables, don't overwrite them with the same value again.
> > 
> > Fixes: 4b9cf23c179a ("arm64: wrap and generalise counter read functions")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm64/kernel/topology.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index c8308befdb1e..f6faa697e83e 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -314,7 +314,7 @@ void topology_scale_freq_tick(void)
> >  
> >  	if (unlikely(core_cnt <= prev_core_cnt ||
> >  		     const_cnt <= prev_const_cnt))
> > -		goto store_and_exit;
> > +		return;
> >  
> >  	/*
> >  	 *	    /\core    arch_max_freq_scale
> > @@ -331,10 +331,6 @@ void topology_scale_freq_tick(void)
> >  
> >  	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> >  	this_cpu_write(freq_scale, (unsigned long)scale);
> > -
> > -store_and_exit:
> > -	this_cpu_write(arch_core_cycles_prev, core_cnt);
> > -	this_cpu_write(arch_const_cycles_prev, const_cnt);
> >  }
> >  
> >  #ifdef CONFIG_ACPI_CPPC_LIB
> 
> Catalin: Can you please pick this up for 5.11-rc1, the earlier patch
> (from fixes) is already in your tree. Thanks.

I will add it to the second pull request this merging window. Thanks.

-- 
Catalin
