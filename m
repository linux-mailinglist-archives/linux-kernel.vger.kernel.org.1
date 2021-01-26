Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB330400B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392682AbhAZOTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405821AbhAZOTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:19:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35068206CA;
        Tue, 26 Jan 2021 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611670703;
        bh=HqfHwhbZBK5xiHvXp5C9+ogNeGqfuvAe3Vf7RYfRot8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5cLsJBZ2/6AfrJIf8RnsX0mjtHPfEGjh9g/zcq5EMbGYon1u/Cop336pOf0l5fll
         gUTG3sIYoaSmkqEGL6ruXkskSbEsEde8d71U4L0EVVmFHgxxP00Cx/VBbhUrcAYWwZ
         wYGiQGIRIT+98vCPNRYL0Jqil4rMrhDq99E9qRz2JMb/mICEr3ceyyt6S+eHM0Zg0j
         fW4sysPt6efCBz4ml2INunDaxVTD52L3cF2msMk8JOE9b7YvrRiyf0eGnsFNL6OHeV
         S0jLb/Fot4F2tGd87XBhjf8ufo3jdklrZ8Yk2N8ibmJaLkoYFQ1DGWdf3122IHTB62
         /WjXO0/HYTbbw==
Date:   Tue, 26 Jan 2021 14:18:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     mark.rutland@arm.com, lecopzer.chen@mediatek.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        alexandru.elisei@arm.com, swboyd@chromium.org,
        dianders@chromium.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] arm64: Enable perf events based hard lockup detector
Message-ID: <20210126141818.GC29956@willie-the-truck>
References: <1610712101-14929-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610712101-14929-1-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Fri, Jan 15, 2021 at 05:31:41PM +0530, Sumit Garg wrote:
> With the recent feature added to enable perf events to use pseudo NMIs
> as interrupts on platforms which support GICv3 or later, its now been
> possible to enable hard lockup detector (or NMI watchdog) on arm64
> platforms. So enable corresponding support.
> 
> One thing to note here is that normally lockup detector is initialized
> just after the early initcalls but PMU on arm64 comes up much later as
> device_initcall(). So we need to re-initialize lockup detection once
> PMU has been initialized.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---

[...]

> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 3605f77a..bafb7c8 100644
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
> @@ -1246,12 +1248,30 @@ static struct platform_driver armv8_pmu_driver = {
>  	.probe		= armv8_pmu_device_probe,
>  };
>  
> +static int __init lockup_detector_init_fn(void *data)
> +{
> +	lockup_detector_init();
> +	return 0;
> +}
> +
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
> +		smp_call_on_cpu(raw_smp_processor_id(), lockup_detector_init_fn,
> +				NULL, false);
> +
> +	return ret;

What's wrong with the alternative approach outlined by Mark:

https://lore.kernel.org/r/20210113130235.GB19011@C02TD0UTHF1T.local

?

Will
