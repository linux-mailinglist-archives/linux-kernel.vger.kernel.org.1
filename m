Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F12295204
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503706AbgJUSMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:12:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48164 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438246AbgJUSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:12:03 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 2f19e6705ded5679; Wed, 21 Oct 2020 20:12:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, Mel Gorman <mgorman@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
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
        viresh.kumar@linaro.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
Date:   Wed, 21 Oct 2020 20:11:59 +0200
Message-ID: <6145907.dAfbsivgMF@kreacher>
In-Reply-To: <20201021131026.GY2651@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <20201021121950.GF2628@hirez.programming.kicks-ass.net> <20201021131026.GY2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 21, 2020 3:10:26 PM CEST Peter Zijlstra wrote:
> On Wed, Oct 21, 2020 at 02:19:50PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 21, 2020 at 01:56:55PM +0200, Julia Lawall wrote:
> > > Prior to 5.8, my machine was using intel_pstate and had few background
> > > tasks.  Thus the problem wasn't visible in practice.  Starting with 5.8
> > > the kernel decided that intel_cpufreq would be more appropriate, which
> > > introduced kworkers every 0.004 seconds on all cores.
> > 
> > That still doesn't make any sense. Are you running the legacy on-demand
> > thing or something?
> > 
> > Rafael, Srinivas, Viresh, how come it defaults to that?
> 
> Does we want something like this?
> 
> ---
>  arch/x86/configs/i386_defconfig   | 3 +--
>  arch/x86/configs/x86_64_defconfig | 3 +--
>  drivers/cpufreq/Kconfig           | 7 +++++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
> index 78210793d357..c343ad459737 100644
> --- a/arch/x86/configs/i386_defconfig
> +++ b/arch/x86/configs/i386_defconfig
> @@ -41,8 +41,7 @@ CONFIG_PM_DEBUG=y
>  CONFIG_PM_TRACE_RTC=y
>  CONFIG_ACPI_DOCK=y
>  CONFIG_ACPI_BGRT=y
> -CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> -CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
>  CONFIG_X86_ACPI_CPUFREQ=y
>  CONFIG_EFI_VARS=y
>  CONFIG_KPROBES=y
> diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
> index 9936528e1939..23e1ea85c1ec 100644
> --- a/arch/x86/configs/x86_64_defconfig
> +++ b/arch/x86/configs/x86_64_defconfig
> @@ -38,8 +38,7 @@ CONFIG_PM_DEBUG=y
>  CONFIG_PM_TRACE_RTC=y
>  CONFIG_ACPI_DOCK=y
>  CONFIG_ACPI_BGRT=y
> -CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> -CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
>  CONFIG_X86_ACPI_CPUFREQ=y
>  CONFIG_IA32_EMULATION=y
>  CONFIG_EFI_VARS=y
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2c7171e0b001..8dfca6e9b836 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -37,8 +37,7 @@ config CPU_FREQ_STAT
>  choice
>  	prompt "Default CPUFreq governor"
>  	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> +	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if SMP
>  	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>  	help
>  	  This option sets which CPUFreq governor shall be loaded at
> @@ -71,6 +70,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
>  
>  config CPU_FREQ_DEFAULT_GOV_ONDEMAND
>  	bool "ondemand"
> +	depends on !SMP
>  	select CPU_FREQ_GOV_ONDEMAND
>  	select CPU_FREQ_GOV_PERFORMANCE
>  	help
> @@ -83,6 +83,7 @@ config CPU_FREQ_DEFAULT_GOV_ONDEMAND
>  
>  config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
>  	bool "conservative"
> +	depends on !SMP
>  	select CPU_FREQ_GOV_CONSERVATIVE
>  	select CPU_FREQ_GOV_PERFORMANCE
>  	help

The changes above should work.

> @@ -144,6 +145,7 @@ config CPU_FREQ_GOV_USERSPACE
>  
>  config CPU_FREQ_GOV_ONDEMAND
>  	tristate "'ondemand' cpufreq policy governor"
> +	depends on !SMP

But I don't think that we can do this and the one below.

>  	select CPU_FREQ_GOV_COMMON
>  	help
>  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
> @@ -163,6 +165,7 @@ config CPU_FREQ_GOV_ONDEMAND
>  config CPU_FREQ_GOV_CONSERVATIVE
>  	tristate "'conservative' cpufreq governor"
>  	depends on CPU_FREQ
> +	depends on !SMP
>  	select CPU_FREQ_GOV_COMMON
>  	help
>  	  'conservative' - this driver is rather similar to the 'ondemand'
> 




