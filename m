Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C299C2FEC47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhAUNuC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jan 2021 08:50:02 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:60214 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbhAUNt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:49:29 -0500
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 53FBC15362;
        Thu, 21 Jan 2021 13:48:44 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 5168521A3D9; Thu, 21 Jan 2021 13:48:44 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH 2/4] timer: remove tango driver
References: <20210120131559.1971359-1-arnd@kernel.org>
        <20210120131559.1971359-3-arnd@kernel.org>
Date:   Thu, 21 Jan 2021 13:48:44 +0000
In-Reply-To: <20210120131559.1971359-3-arnd@kernel.org> (Arnd Bergmann's
        message of "Wed, 20 Jan 2021 14:15:57 +0100")
Message-ID: <yw1xo8hiz9hf.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The tango platform is getting removed, so the driver is no
> longer needed.
>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mans Rullgard <mans@mansr.com>

> ---
>  drivers/clocksource/Kconfig            |  8 ----
>  drivers/clocksource/Makefile           |  1 -
>  drivers/clocksource/timer-tango-xtal.c | 57 --------------------------
>  3 files changed, 66 deletions(-)
>  delete mode 100644 drivers/clocksource/timer-tango-xtal.c
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 824a0f6b77d4..1feadd067677 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -560,14 +560,6 @@ config CLKSRC_MIPS_GIC
>  	select CLOCKSOURCE_WATCHDOG
>  	select TIMER_OF
>
> -config CLKSRC_TANGO_XTAL
> -	bool "Clocksource for Tango SoC" if COMPILE_TEST
> -	depends on ARM
> -	select TIMER_OF
> -	select CLKSRC_MMIO
> -	help
> -	  This enables the clocksource for Tango SoC.
> -
>  config CLKSRC_PXA
>  	bool "Clocksource for PXA or SA-11x0 platform" if COMPILE_TEST
>  	depends on HAS_IOMEM
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 41c154478a1a..1089f2ed8560 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -72,7 +72,6 @@ obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
>  obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
>  obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
>  obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
> -obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= timer-tango-xtal.o
>  obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
>  obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
>  obj-$(CONFIG_TIMER_IMX_SYS_CTR)		+= timer-imx-sysctr.o
> diff --git a/drivers/clocksource/timer-tango-xtal.c b/drivers/clocksource/timer-tango-xtal.c
> deleted file mode 100644
> index 3f94e454ef99..000000000000
> --- a/drivers/clocksource/timer-tango-xtal.c
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/clocksource.h>
> -#include <linux/sched_clock.h>
> -#include <linux/of_address.h>
> -#include <linux/printk.h>
> -#include <linux/delay.h>
> -#include <linux/init.h>
> -#include <linux/clk.h>
> -
> -static void __iomem *xtal_in_cnt;
> -static struct delay_timer delay_timer;
> -
> -static unsigned long notrace read_xtal_counter(void)
> -{
> -	return readl_relaxed(xtal_in_cnt);
> -}
> -
> -static u64 notrace read_sched_clock(void)
> -{
> -	return read_xtal_counter();
> -}
> -
> -static int __init tango_clocksource_init(struct device_node *np)
> -{
> -	struct clk *clk;
> -	int xtal_freq, ret;
> -
> -	xtal_in_cnt = of_iomap(np, 0);
> -	if (xtal_in_cnt == NULL) {
> -		pr_err("%pOF: invalid address\n", np);
> -		return -ENXIO;
> -	}
> -
> -	clk = of_clk_get(np, 0);
> -	if (IS_ERR(clk)) {
> -		pr_err("%pOF: invalid clock\n", np);
> -		return PTR_ERR(clk);
> -	}
> -
> -	xtal_freq = clk_get_rate(clk);
> -	delay_timer.freq = xtal_freq;
> -	delay_timer.read_current_timer = read_xtal_counter;
> -
> -	ret = clocksource_mmio_init(xtal_in_cnt, "tango-xtal", xtal_freq, 350,
> -				    32, clocksource_mmio_readl_up);
> -	if (ret) {
> -		pr_err("%pOF: registration failed\n", np);
> -		return ret;
> -	}
> -
> -	sched_clock_register(read_sched_clock, 32, xtal_freq);
> -	register_current_timer_delay(&delay_timer);
> -
> -	return 0;
> -}
> -
> -TIMER_OF_DECLARE(tango, "sigma,tick-counter", tango_clocksource_init);
> -- 
>
> 2.29.2
>

-- 
Måns Rullgård
