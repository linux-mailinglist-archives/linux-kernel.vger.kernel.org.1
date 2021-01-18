Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5432FA68C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405677AbhARQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405640AbhARPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:18:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84359C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:18:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a12so16793504wrv.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qjv19k04grVyL++mTjxAHL93Qat5biYKcYp1ydD3ptI=;
        b=I1zpemq8aCg+0SDHGJY0EEKfjaQcKt+Q+zB2gCM1YtR08I9dJpgey+b4+paKPk+qC0
         tEvlVLfUZ0v76TT0Ul+GVuTtqsRxcTk15iVRtT2QZXBvfJkDecHKYvFbmqcDEdCy4vqf
         SGmgMRfzldXkvH0uQggHwTS8Yq3CJc5uJ1YNK5YGWG7lCqROV4HdjBFZd0aZN2ILoUJP
         PTysyygdtsa4K0UBwJ1qr6Ax/NoxRcns3QvUiRY1PH2dXJnUfnm/E9OSbWKlj+U7hK1A
         1jQXryzulBA12ChwV6lwQrUCArj5Aw4NwTQd8L50s/VQDh59NfWXCaPkV6dtP7agWnJr
         LOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qjv19k04grVyL++mTjxAHL93Qat5biYKcYp1ydD3ptI=;
        b=rbVb0wDyBGDIG5YBIg+k9Xrg4oiCT71fYU0N5oIfqoGAYn9jbJwtzWEo/X+5hieU+V
         G9ri9IsiuiJjJzpjjDtO0bD5UPVvGZoQua9emYwRvBYd5wBsEqa0XDYmukhPJOSk0BuF
         YqvtTX5F/lWHZidcDLUy/4JzV42hyotImGEK68wIJAG1CAoWEU/5Zd8yhvlciOBiGG1b
         2wvvYdBRcQDWBpqmtujy+UlzjDjaZxBey8Nf582xYjXEryXzUJDZIysyS+GbEpnCxrLo
         9r5h2oCEIvD3erLVyrIcn2eBIac70MUYQuncUopTs6XD+jcUuhnpTut9k4xj6fmfrsi4
         ZfsQ==
X-Gm-Message-State: AOAM533mOIgeO856A7NsUyQtZW7tow1lpHtdhj6gxz5jH+66quG1bBCw
        gGM9uN1OB3iuvvsX9DPxQ+hgjORswzUQhQ==
X-Google-Smtp-Source: ABdhPJwVHHQHp310ADSltNPgvjnrJmusCQ/7Hb54/nsBkXvHxD5fLzlVJ/FN/rWwpNex5WPhTvXEcw==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr26699271wrq.359.1610983093752;
        Mon, 18 Jan 2021 07:18:13 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:2095:8614:d69:136f? ([2a01:e34:ed2f:f020:2095:8614:d69:136f])
        by smtp.googlemail.com with ESMTPSA id l8sm7169275wmi.8.2021.01.18.07.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:18:13 -0800 (PST)
Subject: Re: [PATCH v2 3/7] clocksource: Drop unused efm32 timer code
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210115155130.185010-1-u.kleine-koenig@pengutronix.de>
 <20210115155130.185010-4-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8293fc1b-20fb-58e9-d610-86eefd218ee9@linaro.org>
Date:   Mon, 18 Jan 2021 16:18:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115155130.185010-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2021 16:51, Uwe Kleine-König wrote:
> Support for this machine was just removed, so drop the now unused timer
> code, too.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Shall I take it through my tree ?

> ---
>  drivers/clocksource/Kconfig       |   9 -
>  drivers/clocksource/Makefile      |   1 -
>  drivers/clocksource/timer-efm32.c | 278 ------------------------------
>  3 files changed, 288 deletions(-)
>  delete mode 100644 drivers/clocksource/timer-efm32.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 14c7c4712478..1416a32140c5 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -242,15 +242,6 @@ config INTEGRATOR_AP_TIMER
>  	help
>  	  Enables support for the Integrator-AP timer.
>  
> -config CLKSRC_EFM32
> -	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
> -	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
> -	select CLKSRC_MMIO
> -	default ARCH_EFM32
> -	help
> -	  Support to use the timers of EFM32 SoCs as clock source and clock
> -	  event device.
> -
>  config CLKSRC_LPC32XX
>  	bool "Clocksource for LPC32XX" if COMPILE_TEST
>  	depends on HAS_IOMEM
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 3c75cbbf8533..08173383f2d9 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -43,7 +43,6 @@ obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
>  obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
>  obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
>  obj-$(CONFIG_CADENCE_TTC_TIMER)	+= timer-cadence-ttc.o
> -obj-$(CONFIG_CLKSRC_EFM32)	+= timer-efm32.o
>  obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
>  obj-$(CONFIG_CLKSRC_STM32_LP)	+= timer-stm32-lp.o
>  obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
> diff --git a/drivers/clocksource/timer-efm32.c b/drivers/clocksource/timer-efm32.c
> deleted file mode 100644
> index 441a4b916841..000000000000
> --- a/drivers/clocksource/timer-efm32.c
> +++ /dev/null
> @@ -1,278 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2013 Pengutronix
> - * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> - */
> -
> -#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> -
> -#include <linux/kernel.h>
> -#include <linux/clocksource.h>
> -#include <linux/clockchips.h>
> -#include <linux/irq.h>
> -#include <linux/interrupt.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
> -#include <linux/clk.h>
> -
> -#define TIMERn_CTRL			0x00
> -#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
> -#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
> -#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
> -#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
> -#define TIMERn_CTRL_OSMEN			0x00000010
> -#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
> -#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
> -#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
> -
> -#define TIMERn_CMD			0x04
> -#define TIMERn_CMD_START			0x00000001
> -#define TIMERn_CMD_STOP				0x00000002
> -
> -#define TIMERn_IEN			0x0c
> -#define TIMERn_IF			0x10
> -#define TIMERn_IFS			0x14
> -#define TIMERn_IFC			0x18
> -#define TIMERn_IRQ_UF				0x00000002
> -
> -#define TIMERn_TOP			0x1c
> -#define TIMERn_CNT			0x24
> -
> -struct efm32_clock_event_ddata {
> -	struct clock_event_device evtdev;
> -	void __iomem *base;
> -	unsigned periodic_top;
> -};
> -
> -static int efm32_clock_event_shutdown(struct clock_event_device *evtdev)
> -{
> -	struct efm32_clock_event_ddata *ddata =
> -		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
> -
> -	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
> -	return 0;
> -}
> -
> -static int efm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
> -{
> -	struct efm32_clock_event_ddata *ddata =
> -		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
> -
> -	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
> -	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
> -		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
> -		       TIMERn_CTRL_OSMEN |
> -		       TIMERn_CTRL_MODE_DOWN,
> -		       ddata->base + TIMERn_CTRL);
> -	return 0;
> -}
> -
> -static int efm32_clock_event_set_periodic(struct clock_event_device *evtdev)
> -{
> -	struct efm32_clock_event_ddata *ddata =
> -		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
> -
> -	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
> -	writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
> -	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
> -		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
> -		       TIMERn_CTRL_MODE_DOWN,
> -		       ddata->base + TIMERn_CTRL);
> -	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
> -	return 0;
> -}
> -
> -static int efm32_clock_event_set_next_event(unsigned long evt,
> -					    struct clock_event_device *evtdev)
> -{
> -	struct efm32_clock_event_ddata *ddata =
> -		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
> -
> -	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
> -	writel_relaxed(evt, ddata->base + TIMERn_CNT);
> -	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
> -
> -	return 0;
> -}
> -
> -static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
> -{
> -	struct efm32_clock_event_ddata *ddata = dev_id;
> -
> -	writel_relaxed(TIMERn_IRQ_UF, ddata->base + TIMERn_IFC);
> -
> -	ddata->evtdev.event_handler(&ddata->evtdev);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static struct efm32_clock_event_ddata clock_event_ddata = {
> -	.evtdev = {
> -		.name = "efm32 clockevent",
> -		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
> -		.set_state_shutdown = efm32_clock_event_shutdown,
> -		.set_state_periodic = efm32_clock_event_set_periodic,
> -		.set_state_oneshot = efm32_clock_event_set_oneshot,
> -		.set_next_event = efm32_clock_event_set_next_event,
> -		.rating = 200,
> -	},
> -};
> -
> -static int __init efm32_clocksource_init(struct device_node *np)
> -{
> -	struct clk *clk;
> -	void __iomem *base;
> -	unsigned long rate;
> -	int ret;
> -
> -	clk = of_clk_get(np, 0);
> -	if (IS_ERR(clk)) {
> -		ret = PTR_ERR(clk);
> -		pr_err("failed to get clock for clocksource (%d)\n", ret);
> -		goto err_clk_get;
> -	}
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		pr_err("failed to enable timer clock for clocksource (%d)\n",
> -		       ret);
> -		goto err_clk_enable;
> -	}
> -	rate = clk_get_rate(clk);
> -
> -	base = of_iomap(np, 0);
> -	if (!base) {
> -		ret = -EADDRNOTAVAIL;
> -		pr_err("failed to map registers for clocksource\n");
> -		goto err_iomap;
> -	}
> -
> -	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
> -		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
> -		       TIMERn_CTRL_MODE_UP, base + TIMERn_CTRL);
> -	writel_relaxed(TIMERn_CMD_START, base + TIMERn_CMD);
> -
> -	ret = clocksource_mmio_init(base + TIMERn_CNT, "efm32 timer",
> -				    DIV_ROUND_CLOSEST(rate, 1024), 200, 16,
> -				    clocksource_mmio_readl_up);
> -	if (ret) {
> -		pr_err("failed to init clocksource (%d)\n", ret);
> -		goto err_clocksource_init;
> -	}
> -
> -	return 0;
> -
> -err_clocksource_init:
> -
> -	iounmap(base);
> -err_iomap:
> -
> -	clk_disable_unprepare(clk);
> -err_clk_enable:
> -
> -	clk_put(clk);
> -err_clk_get:
> -
> -	return ret;
> -}
> -
> -static int __init efm32_clockevent_init(struct device_node *np)
> -{
> -	struct clk *clk;
> -	void __iomem *base;
> -	unsigned long rate;
> -	int irq;
> -	int ret;
> -
> -	clk = of_clk_get(np, 0);
> -	if (IS_ERR(clk)) {
> -		ret = PTR_ERR(clk);
> -		pr_err("failed to get clock for clockevent (%d)\n", ret);
> -		goto err_clk_get;
> -	}
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		pr_err("failed to enable timer clock for clockevent (%d)\n",
> -		       ret);
> -		goto err_clk_enable;
> -	}
> -	rate = clk_get_rate(clk);
> -
> -	base = of_iomap(np, 0);
> -	if (!base) {
> -		ret = -EADDRNOTAVAIL;
> -		pr_err("failed to map registers for clockevent\n");
> -		goto err_iomap;
> -	}
> -
> -	irq = irq_of_parse_and_map(np, 0);
> -	if (!irq) {
> -		ret = -ENOENT;
> -		pr_err("failed to get irq for clockevent\n");
> -		goto err_get_irq;
> -	}
> -
> -	writel_relaxed(TIMERn_IRQ_UF, base + TIMERn_IEN);
> -
> -	clock_event_ddata.base = base;
> -	clock_event_ddata.periodic_top = DIV_ROUND_CLOSEST(rate, 1024 * HZ);
> -
> -	clockevents_config_and_register(&clock_event_ddata.evtdev,
> -					DIV_ROUND_CLOSEST(rate, 1024),
> -					0xf, 0xffff);
> -
> -	ret = request_irq(irq, efm32_clock_event_handler, IRQF_TIMER,
> -			  "efm32 clockevent", &clock_event_ddata);
> -	if (ret) {
> -		pr_err("Failed setup irq\n");
> -		goto err_setup_irq;
> -	}
> -
> -	return 0;
> -
> -err_setup_irq:
> -err_get_irq:
> -
> -	iounmap(base);
> -err_iomap:
> -
> -	clk_disable_unprepare(clk);
> -err_clk_enable:
> -
> -	clk_put(clk);
> -err_clk_get:
> -
> -	return ret;
> -}
> -
> -/*
> - * This function asserts that we have exactly one clocksource and one
> - * clock_event_device in the end.
> - */
> -static int __init efm32_timer_init(struct device_node *np)
> -{
> -	static int has_clocksource, has_clockevent;
> -	int ret = 0;
> -
> -	if (!has_clocksource) {
> -		ret = efm32_clocksource_init(np);
> -		if (!ret) {
> -			has_clocksource = 1;
> -			return 0;
> -		}
> -	}
> -
> -	if (!has_clockevent) {
> -		ret = efm32_clockevent_init(np);
> -		if (!ret) {
> -			has_clockevent = 1;
> -			return 0;
> -		}
> -	}
> -
> -	return ret;
> -}
> -TIMER_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
> -TIMER_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
