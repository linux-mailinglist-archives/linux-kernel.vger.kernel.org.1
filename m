Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBA295DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502785AbgJVLp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:45:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42370 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438840AbgJVLp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:45:29 -0400
Received: from 89-64-87-167.dynamic.chello.pl (89.64.87.167) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 49394ccb93dbf3dd; Thu, 22 Oct 2020 13:45:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
Date:   Thu, 22 Oct 2020 13:45:25 +0200
Message-ID: <34115486.YmRjPRKJaA@kreacher>
In-Reply-To: <20201022104703.nw45dwor6wfn4ity@vireshk-i7>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <20201022071145.GM2628@hirez.programming.kicks-ass.net> <20201022104703.nw45dwor6wfn4ity@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 22, 2020 12:47:03 PM CEST Viresh Kumar wrote:
> On 22-10-20, 09:11, Peter Zijlstra wrote:
> > Well, but we need to do something to force people onto schedutil,
> > otherwise we'll get more crap like this thread.
> > 
> > Can we take the choice away? Only let Kconfig select which governors are
> > available and then set the default ourselves? I mean, the end goal being
> > to not have selectable governors at all, this seems like a good step
> > anyway.
> 
> Just to clarify and complete the point a bit here, the users can still
> pass the default governor from cmdline using
> cpufreq.default_governor=, which will take precedence over the one the
> below code is playing with. And later once the kernel is up, they can
> still choose a different governor from userspace.

Right.

Also some people simply set "performance" as the default governor and then
don't touch cpufreq otherwise (the idea is to get everything to the max
freq right away and stay in that mode forever).  This still needs to be
possible IMO.

> > ---
> > 
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 2c7171e0b001..3a9f54b382c0 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -34,77 +34,6 @@ config CPU_FREQ_STAT
> >  
> >  	  If in doubt, say N.
> >  
> > -choice
> > -	prompt "Default CPUFreq governor"
> > -	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> > -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> > -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> > -	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> > -	help
> > -	  This option sets which CPUFreq governor shall be loaded at
> > -	  startup. If in doubt, use the default setting.
> > -
> > -config CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> > -	bool "performance"
> > -	select CPU_FREQ_GOV_PERFORMANCE
> > -	help
> > -	  Use the CPUFreq governor 'performance' as default. This sets
> > -	  the frequency statically to the highest frequency supported by
> > -	  the CPU.
> > -
> > -config CPU_FREQ_DEFAULT_GOV_POWERSAVE
> > -	bool "powersave"
> > -	select CPU_FREQ_GOV_POWERSAVE
> > -	help
> > -	  Use the CPUFreq governor 'powersave' as default. This sets
> > -	  the frequency statically to the lowest frequency supported by
> > -	  the CPU.
> > -
> > -config CPU_FREQ_DEFAULT_GOV_USERSPACE
> > -	bool "userspace"
> > -	select CPU_FREQ_GOV_USERSPACE
> > -	help
> > -	  Use the CPUFreq governor 'userspace' as default. This allows
> > -	  you to set the CPU frequency manually or when a userspace 
> > -	  program shall be able to set the CPU dynamically without having
> > -	  to enable the userspace governor manually.
> > -
> > -config CPU_FREQ_DEFAULT_GOV_ONDEMAND
> > -	bool "ondemand"
> > -	select CPU_FREQ_GOV_ONDEMAND
> > -	select CPU_FREQ_GOV_PERFORMANCE
> > -	help
> > -	  Use the CPUFreq governor 'ondemand' as default. This allows
> > -	  you to get a full dynamic frequency capable system by simply
> > -	  loading your cpufreq low-level hardware driver.
> > -	  Be aware that not all cpufreq drivers support the ondemand
> > -	  governor. If unsure have a look at the help section of the
> > -	  driver. Fallback governor will be the performance governor.
> > -
> > -config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
> > -	bool "conservative"
> > -	select CPU_FREQ_GOV_CONSERVATIVE
> > -	select CPU_FREQ_GOV_PERFORMANCE
> > -	help
> > -	  Use the CPUFreq governor 'conservative' as default. This allows
> > -	  you to get a full dynamic frequency capable system by simply
> > -	  loading your cpufreq low-level hardware driver.
> > -	  Be aware that not all cpufreq drivers support the conservative
> > -	  governor. If unsure have a look at the help section of the
> > -	  driver. Fallback governor will be the performance governor.
> > -
> > -config CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
> > -	bool "schedutil"
> > -	depends on SMP
> > -	select CPU_FREQ_GOV_SCHEDUTIL
> > -	select CPU_FREQ_GOV_PERFORMANCE
> > -	help
> > -	  Use the 'schedutil' CPUFreq governor by default. If unsure,
> > -	  have a look at the help section of that governor. The fallback
> > -	  governor will be 'performance'.
> > -
> > -endchoice
> > -
> >  config CPU_FREQ_GOV_PERFORMANCE
> >  	tristate "'performance' governor"
> >  	help
> > @@ -145,6 +74,7 @@ config CPU_FREQ_GOV_USERSPACE
> >  config CPU_FREQ_GOV_ONDEMAND
> >  	tristate "'ondemand' cpufreq policy governor"
> >  	select CPU_FREQ_GOV_COMMON
> > +	select CPU_FREQ_GOV_PERFORMANCE
> >  	help
> >  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
> >  	  The governor does a periodic polling and 
> > @@ -164,6 +94,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
> >  	tristate "'conservative' cpufreq governor"
> >  	depends on CPU_FREQ
> >  	select CPU_FREQ_GOV_COMMON
> > +	select CPU_FREQ_GOV_PERFORMANCE
> >  	help
> >  	  'conservative' - this driver is rather similar to the 'ondemand'
> >  	  governor both in its source code and its purpose, the difference is
> > @@ -188,6 +119,7 @@ config CPU_FREQ_GOV_SCHEDUTIL
> >  	bool "'schedutil' cpufreq policy governor"
> >  	depends on CPU_FREQ && SMP
> >  	select CPU_FREQ_GOV_ATTR_SET
> > +	select CPU_FREQ_GOV_PERFORMANCE
> 
> And I am not really sure why we always wanted this backup performance
> governor to be there unless the said governors are built as module.

Apparently, some old drivers had problems with switching frequencies fast enough
for ondemand to be used with them and the fallback was for those cases.  AFAICS.

> >  	select IRQ_WORK
> >  	help
> >  	  This governor makes decisions based on the utilization data provided
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 1877f5e2e5b0..6848e3337b65 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -626,6 +626,49 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
> >  	return NULL;
> >  }
> >  
> > +static struct cpufreq_governor *cpufreq_default_governor(void)
> > +{
> > +	struct cpufreq_governor *gov = NULL;
> > +
> > +#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > +	gov = find_governor("schedutil");
> > +	if (gov)
> > +		return gov;
> > +#endif
> > +
> > +#ifdef CONFIG_CPU_FREQ_GOV_ONDEMAND
> > +	gov = find_governor("ondemand");
> > +	if (gov)
> > +		return gov;
> > +#endif
> > +
> > +#ifdef CONFIG_CPU_FREQ_GOV_CONSERVATIVE
> > +	gov = find_governor("conservative");
> > +	if (gov)
> > +		return gov;
> > +#endif
> > +
> > +#ifdef CONFIG_CPU_FREQ_GOV_USERSPACE
> > +	gov = find_governor("userspace");
> > +	if (gov)
> > +		return gov;
> > +#endif
> > +
> > +#ifdef CONFIG_CPU_FREQ_GOV_POWERSAVE
> > +	gov = find_governor("powersave");
> > +	if (gov)
> > +		return gov;
> > +#endif
> > +
> > +#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE
> > +	gov = find_governor("performance");
> > +	if (gov)
> > +		return gov;
> > +#endif
> > +
> > +	return gov;
> > +}
> 
> I think that would be fine with me. Though we would be required to
> update couple of defconfigs here to make sure they keep working the
> way they wanted to.

Generally agreed, but see the point about the "performance" governor above.



