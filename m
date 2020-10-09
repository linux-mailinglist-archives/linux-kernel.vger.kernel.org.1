Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D42886D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgJIKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:25:24 -0400
Received: from foss.arm.com ([217.140.110.172]:47260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387599AbgJIKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:25:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 838C8D6E;
        Fri,  9 Oct 2020 03:25:23 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD263F66B;
        Fri,  9 Oct 2020 03:25:21 -0700 (PDT)
Subject: Re: [PATCH v4] arm64: Enable perf events based hard lockup detector
To:     Sumit Garg <sumit.garg@linaro.org>, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        swboyd@chromium.org, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org
References: <1602060704-10921-1-git-send-email-sumit.garg@linaro.org>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <33f53714-c069-3939-6fe3-000ec783dbf4@arm.com>
Date:   Fri, 9 Oct 2020 11:26:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1602060704-10921-1-git-send-email-sumit.garg@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/20 9:51 AM, Sumit Garg wrote:
> With the recent feature added to enable perf events to use pseudo NMIs
> as interrupts on platforms which support GICv3 or later, its now been
> possible to enable hard lockup detector (or NMI watchdog) on arm64
> platforms. So enable corresponding support.
>
> One thing to note here is that normally lockup detector is initialized
> just after the early initcalls but PMU on arm64 comes up much later as
> device_initcall(). So we need to re-initialize lockup detection once
> PMU has been initialized.

Has another look, the PMU bits looks alright. Just to be on the safe side, I did a
few quick boot tests on an espressobin with a kernel with CONFIG_ARM64_PSEUDO_NMI,
with nmis enabled and disabled from the command line, and without
CONFIG_ARM64_PSEUDO_NMI, found nothing out of the ordinary. For the PMU part:

Acked-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v4:
> - Rebased to latest pmu v7 NMI patch-set [1] and in turn use "has_nmi"
>   hook to know if PMU IRQ has been requested as an NMI.
> - Add check for return value prior to initializing hard-lockup detector.
>
> [1] https://lkml.org/lkml/2020/9/24/458
>
> Changes in v3:
> - Rebased to latest pmu NMI patch-set [1].
> - Addressed misc. comments from Stephen.
>
> [1] https://lkml.org/lkml/2020/8/19/671
>
> Changes since RFC:
> - Rebased on top of Alex's WIP-pmu-nmi branch.
> - Add comment for safe max. CPU frequency.
> - Misc. cleanup.
>
>  arch/arm64/Kconfig             |  2 ++
>  arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  drivers/perf/arm_pmu.c         |  5 +++++
>  include/linux/perf/arm_pmu.h   |  2 ++
>  4 files changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d23283..b5c2594 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -167,6 +167,8 @@ config ARM64
>  	select HAVE_NMI
>  	select HAVE_PATA_PLATFORM
>  	select HAVE_PERF_EVENTS
> +	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
> +	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index ef206fb..6ad5120 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -23,6 +23,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/sched_clock.h>
>  #include <linux/smp.h>
> +#include <linux/nmi.h>
> +#include <linux/cpufreq.h>
>  
>  /* ARMv8 Cortex-A53 specific event types. */
>  #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
> @@ -1224,10 +1226,21 @@ static struct platform_driver armv8_pmu_driver = {
>  
>  static int __init armv8_pmu_driver_init(void)
>  {
> +	int ret;
> +
>  	if (acpi_disabled)
> -		return platform_driver_register(&armv8_pmu_driver);
> +		ret = platform_driver_register(&armv8_pmu_driver);
>  	else
> -		return arm_pmu_acpi_probe(armv8_pmuv3_init);
> +		ret = arm_pmu_acpi_probe(armv8_pmuv3_init);
> +
> +	/*
> +	 * Try to re-initialize lockup detector after PMU init in
> +	 * case PMU events are triggered via NMIs.
> +	 */
> +	if (ret == 0 && arm_pmu_irq_is_nmi())
> +		lockup_detector_init();
> +
> +	return ret;
>  }
>  device_initcall(armv8_pmu_driver_init)
>  
> @@ -1285,3 +1298,27 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time_zero = 1;
>  	userpg->cap_user_time_short = 1;
>  }
> +
> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> +/*
> + * Safe maximum CPU frequency in case a particular platform doesn't implement
> + * cpufreq driver. Although, architecture doesn't put any restrictions on
> + * maximum frequency but 5 GHz seems to be safe maximum given the available
> + * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
> + * hand, we can't make it much higher as it would lead to a large hard-lockup
> + * detection timeout on parts which are running slower (eg. 1GHz on
> + * Developerbox) and doesn't possess a cpufreq driver.
> + */
> +#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
> +u64 hw_nmi_get_sample_period(int watchdog_thresh)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	unsigned long max_cpu_freq;
> +
> +	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> +	if (!max_cpu_freq)
> +		max_cpu_freq = SAFE_MAX_CPU_FREQ;
> +
> +	return (u64)max_cpu_freq * watchdog_thresh;
> +}
> +#endif
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index cb2f55f..794a37d 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -726,6 +726,11 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
>  	return per_cpu(hw_events->irq, cpu);
>  }
>  
> +bool arm_pmu_irq_is_nmi(void)
> +{
> +	return has_nmi;
> +}
> +
>  /*
>   * PMU hardware loses all context when a CPU goes offline.
>   * When a CPU is hotplugged back in, since some hardware registers are
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 5b616dd..5765069 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -160,6 +160,8 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
>  static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
>  #endif
>  
> +bool arm_pmu_irq_is_nmi(void);
> +
>  /* Internal functions only for core arm_pmu code */
>  struct arm_pmu *armpmu_alloc(void);
>  struct arm_pmu *armpmu_alloc_atomic(void);
