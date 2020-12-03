Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610772CD337
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgLCKKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbgLCKKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:10:31 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35038C061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 02:09:51 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so1282927wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gEd36gj1zJ/biX3Vjpp2g0JgzMW7zWlAmNvTpbJ00Xs=;
        b=XtxPq77sVKvuHMWENPyCpnEsKsXn8eZUT1kD2bN320JYheUE3heE2s2h2Tu++cxAE7
         SOGyJmlath68lYhM8/Pr3O9L5aDa3VYL2hOdqy/sZTc9t9eOWLtGw4ZAvwNZeuVtNIIv
         STVReUEff34O2xAqRZrHW+Nq6xSW0F2a5d19zXWN+Bidn1efrnIHY51HptfjWgpMpF/W
         0WivkncR2dLeE4qgU5hiy5vKvjRa+aBAHgfo7XBbdWOXHT/YLZDDy8jC9EwBDOb9W1T3
         VxebGDhOG+cj8u5ukNg9/PB5um2jMnnxKPPnprxYauHomxRTwKg7cD+UlIgu6xVzPxCg
         enYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gEd36gj1zJ/biX3Vjpp2g0JgzMW7zWlAmNvTpbJ00Xs=;
        b=MGEg2rLvzVJQEZXaj4d6eBvCMSTGUWFkHsJCWPy60cZJ+QxtIRJfwUGqvmmd8W5J59
         R9hR8/Cf3tz0DVt9gpGltK9We0AQQojQgf50722eQI60GLiDY5kkZtiEbrUBuYuFRN+4
         hfjsvAskoG00uNU+xMKUtrMKKqV4OTyY3lM2kfZ+nKBi30eN0EhTyIuYi6JNLbTvy8jS
         0k2NqAJZcqjZI34JXjkut3jwABI/pMEtjEZ1ulmGBqJwOwJZwTHiCiXUUGv9HUBGS9R2
         vmOVkArIAFUy+dSdA6sVTlXTl13RHdxMnCptneU4GPrsVt2RKuVy15zf+7cqhehTKRlk
         UadQ==
X-Gm-Message-State: AOAM533W+ydPAdhbL4w1NpKQcfBdHnb/O1s4/YqEmny11MilMZW1P21j
        kHIW0iSwc0Wq6hlckz/LZ4XKTw==
X-Google-Smtp-Source: ABdhPJw1kQtpaZsEKHVzU+cpNCSvMmxj1sNtWWTvIaazTJg4fPO079JuekeaBmpb/EzNEB80RsM8vQ==
X-Received: by 2002:a5d:504f:: with SMTP id h15mr2763670wrt.402.1606990189773;
        Thu, 03 Dec 2020 02:09:49 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2? ([2a01:e34:ed2f:f020:1c7d:2d7a:9709:b9a2])
        by smtp.googlemail.com with ESMTPSA id c17sm1179871wro.19.2020.12.03.02.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 02:09:49 -0800 (PST)
Subject: Re: [PATCH] clocksource: dw_apb_timer_of: return EPROBE_DEFER if no
 clock available
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, p.zabel@pengutronix.de,
        Jisheng.Zhang@synaptics.com, arnd@arndb.de
References: <20201119121225.26536-1-dinguyen@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0b648a7d-98f7-dc54-99b0-4331379a65ba@linaro.org>
Date:   Thu, 3 Dec 2020 11:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119121225.26536-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dinh,

On 19/11/2020 13:12, Dinh Nguyen wrote:
> commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added the
> support for the dw_apb_timer into the arm64 defconfig. However, for some
> platforms like the Intel Stratix10 and Agilex, the clock manager doesn't
> get probed until after the timer driver is probed. Thus, the driver hits
> the panic "No clock nor clock-frequency property for %" because it cannot
> properly get the clock.
> 
> This patch adds support for EPROBE_DEFER so the kernel can come back to
> finish probing this timer driver after the clock driver is probed.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

A few comments below.

> ---
>  drivers/clocksource/dw_apb_timer_of.c | 86 ++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index ab3ddebe8344..a8ce980c5146 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -14,7 +14,7 @@
>  #include <linux/reset.h>
>  #include <linux/sched_clock.h>
>  
> -static void __init timer_get_base_and_rate(struct device_node *np,
> +static int __init timer_get_base_and_rate(struct device_node *np,
>  				    void __iomem **base, u32 *rate)
>  {
>  	struct clk *timer_clk;
> @@ -47,65 +47,77 @@ static void __init timer_get_base_and_rate(struct device_node *np,
>  				np);
>  
>  	timer_clk = of_clk_get_by_name(np, "timer");
> -	if (IS_ERR(timer_clk))
> -		goto try_clock_freq;
> +	if (IS_ERR(timer_clk)) {
> +		if (PTR_ERR(timer_clk) != -EPROBE_DEFER) {
> +			pr_err("Failed to get clock for %pOF\n", np);
> +			goto try_clock_freq;
> +		}
> +		return PTR_ERR(timer_clk);
> +	}

May be massage the changes by moving the of-rate check first

 	if (!of_property_read_u32(np, "clock-freq", rate) &&
  	    !of_property_read_u32(np, "clock-frequency", rate))
		return 0;

	timer_clk = of_clk_get_by_name(np, "timer");

	/*
	 * Whatever the result, we return
	 */
	ret = PTR_ERR(timer_clk);
	if (ret)
		return ret;

	ret = clk_prepare_enable(timer_clk);
	if (ret)
		return ret;

	*rate = clk_get_rate(timer_clk);
	if (!(*rate))
		return -EINVAL;

	return 0;

>  
>  	if (!clk_prepare_enable(timer_clk)) {
>  		*rate = clk_get_rate(timer_clk);
> -		return;
> +		return 0;
>  	}
>  
>  try_clock_freq:
>  	if (of_property_read_u32(np, "clock-freq", rate) &&
>  	    of_property_read_u32(np, "clock-frequency", rate))
>  		panic("No clock nor clock-frequency property for %pOFn", np);
>
> +	return 0;
>  }
>  
> -static void __init add_clockevent(struct device_node *event_timer)
> +static int __init add_clockevent(struct device_node *event_timer)
>  {
>  	void __iomem *iobase;
>  	struct dw_apb_clock_event_device *ced;
>  	u32 irq, rate;
> +	int ret = 0;
>  
>  	irq = irq_of_parse_and_map(event_timer, 0);
>  	if (irq == 0)
>  		panic("No IRQ for clock event timer");
>  
> -	timer_get_base_and_rate(event_timer, &iobase, &rate);
> -
> -	ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
> +	ret = timer_get_base_and_rate(event_timer, &iobase, &rate);
> +	if (ret == 0) {
> +		ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
>  				     rate);
> -	if (!ced)
> -		panic("Unable to initialise clockevent device");
> +		if (!ced)
> +			panic("Unable to initialise clockevent device");

	ret = timer_get_base_and_rate(event_timer, &iobase, &rate);
	if (ret)
		return ret;

	ced = dw_apb_clockevent_init(-1, event_timer->name, 300,
				iobase, irq, rate);
	if (!ced)
		return -EINVAL;

	dw_apb_clockevent_register(ced);

	return 0;

> -	dw_apb_clockevent_register(ced);
> +		dw_apb_clockevent_register(ced);
> +	}
> +	return ret;
>  }
>  
>  static void __iomem *sched_io_base;
>  static u32 sched_rate;
>  
> -static void __init add_clocksource(struct device_node *source_timer)
> +static int __init add_clocksource(struct device_node *source_timer)
>  {
>  	void __iomem *iobase;
>  	struct dw_apb_clocksource *cs;
>  	u32 rate;
> -
> -	timer_get_base_and_rate(source_timer, &iobase, &rate);
> -
> -	cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
> -	if (!cs)
> -		panic("Unable to initialise clocksource device");
> -
> -	dw_apb_clocksource_start(cs);
> -	dw_apb_clocksource_register(cs);
> -
> -	/*
> -	 * Fallback to use the clocksource as sched_clock if no separate
> -	 * timer is found. sched_io_base then points to the current_value
> -	 * register of the clocksource timer.
> -	 */
> -	sched_io_base = iobase + 0x04;
> -	sched_rate = rate;
> +	int ret;
> +
> +	ret = timer_get_base_and_rate(source_timer, &iobase, &rate);
> +	if (ret == 0) {
> +		cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
> +		if (!cs)
> +			panic("Unable to initialise clocksource device");
> +
> +		dw_apb_clocksource_start(cs);
> +		dw_apb_clocksource_register(cs);
> +
> +		/*
> +		 * Fallback to use the clocksource as sched_clock if no separate
> +		 * timer is found. sched_io_base then points to the current_value
> +		 * register of the clocksource timer.
> +		 */
> +		sched_io_base = iobase + 0x04;
> +		sched_rate = rate;
> +	}
> +	return ret;

Same suggestion as above

>  }
>  
>  static u64 notrace read_sched_clock(void)
> @@ -146,25 +158,29 @@ static struct delay_timer dw_apb_delay_timer = {
>  static int num_called;
>  static int __init dw_apb_timer_init(struct device_node *timer)
>  {
> +	int ret = 0;
> +
>  	switch (num_called) {
>  	case 1:
>  		pr_debug("%s: found clocksource timer\n", __func__);
> -		add_clocksource(timer);
> -		init_sched_clock();
> +		ret = add_clocksource(timer);
> +		if (ret == 0) {
> +			init_sched_clock();

		ret = add_clocksource(timer);
		if (ret)
			return ret;

		init_sched_clock();
		dw_apb_delay_timer.freq = sched_rate;
		register_current_timer_delay(&dw_apb_delay_timer);

>  #ifdef CONFIG_ARM
> -		dw_apb_delay_timer.freq = sched_rate;
> -		register_current_timer_delay(&dw_apb_delay_timer);
> +			dw_apb_delay_timer.freq = sched_rate;
> +			register_current_timer_delay(&dw_apb_delay_timer);
>  #endif
> +		}
>  		break;
>  	default:
>  		pr_debug("%s: found clockevent timer\n", __func__);
> -		add_clockevent(timer);
> +		ret = add_clockevent(timer);

		ret = add_clockevent(timer);
		if (ret)
			return ret;

>  		break;
>  	}
>  
>  	num_called++;
>  
> -	return 0;
> +	return ret;

	return 0;

>  }
>  TIMER_OF_DECLARE(pc3x2_timer, "picochip,pc3x2-timer", dw_apb_timer_init);
>  TIMER_OF_DECLARE(apb_timer_osc, "snps,dw-apb-timer-osc", dw_apb_timer_init);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
