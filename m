Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687332CF539
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgLDUAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:00:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E31C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:00:10 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e25so8140272wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CAWzGsfyPfGCv5+z3k1opSo9S7wVDL7zd1LnkXhp4GM=;
        b=qsnRjhsp1J6kJffLZyIF2Pk81+XGa4cVtwKxuCr6y1+0XmDu8q6XTMoHFDg9qtPbdJ
         krWlctCNRZqth+J8monaQ3d8/l+cERthV9tkDbvN4wAg4Wtcuh2vtQ/xhoVmuPc4GnCf
         IKI1upyoG9J7IPSLQfETJc4ibw6OF08L7EIoC3p2bMtcm0mTDf5OwgJhz9JJb5tDPV0n
         RnLrhhbhRhKSe5qnPfhG5PY+1vH104M9SIKevlda/nMcochXaK7hCF2QMArcdfwni2/5
         vvtpwsondTrg08jOZt23XEp6oN8lfciufTVOA31Ci6ghpoW4eio1RvQDJQ2VtjHADvkx
         km9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CAWzGsfyPfGCv5+z3k1opSo9S7wVDL7zd1LnkXhp4GM=;
        b=Rfcr0uAzHrFRtAzxRJhmTwVp0iuB0o5i9FFdldTaGeQn/h8hWz1uZMe1RsXqEejVwe
         Uzhntje24x1844KKsnAGvQdwuTg4HYzphV7FhxC1EACaKmAY5B1Vi9ZyxWigCZ2jUL3+
         FaP1h8pIJCo3Wjd9G2rawYwust3OjMAMiGamDQaPdhD0o6uOprE2BTuKPj9seVaRbFX2
         tMxhRPXIF7y14AbF6F82rPhYdYWZgRyDyCAUF5bm46Hmb8MfmvzX81dJHLbgNkLOH++j
         hsgi16kL4esFIs20nEZhtjNwQsfsFq1zXKI8P1UcQm05TJESmzXugv8JEm8+6KmgCp/A
         aVSw==
X-Gm-Message-State: AOAM533cBpT17smHqM8xOMBa9b0bbPxgh26wRiCRr3bUQJ650F0BMYK6
        lvySEkFkovuym+VsbblKH4cgeF1Lh5+jwQ==
X-Google-Smtp-Source: ABdhPJzucphtkKH4xcgMnGArv4S5E1jTpSlz/5ap+hffBoKrYK6Dp0YLg33KqpVEFZPewa1LHZ9jEg==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr5945265wmb.47.1607112008640;
        Fri, 04 Dec 2020 12:00:08 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8165:c1cc:d736:b53f? ([2a01:e34:ed2f:f020:8165:c1cc:d736:b53f])
        by smtp.googlemail.com with ESMTPSA id y130sm4567075wmc.22.2020.12.04.12.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:00:07 -0800 (PST)
Subject: Re: [PATCHv2] clocksource: dw_apb_timer_of: add error handling if no
 clock available
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, arnd@arndb.de
References: <20201204153643.129897-1-dinguyen@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b24fb09b-62ab-4459-8154-c9bccd3e48fc@linaro.org>
Date:   Fri, 4 Dec 2020 21:00:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204153643.129897-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2020 16:36, Dinh Nguyen wrote:
> commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added the
> support for the dw_apb_timer into the arm64 defconfig. However, for some
> platforms like the Intel Stratix10 and Agilex, the clock manager doesn't
> get loaded until after the timer driver get loaded. Thus, the driver hits
> the panic "No clock nor clock-frequency property for" because it cannot
> properly get the clock.
> 
> This patch adds the error handling needed for the timer driver so that
> the kernel can continue booting instead of just hitting the panic.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

Did you have time to test the different combinations ?

> ---
> v2: address comments from Daniel Lezcano
>     update commit message
> ---
>  drivers/clocksource/dw_apb_timer_of.c | 60 ++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index ab3ddebe8344..809f4c9327f9 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -14,12 +14,13 @@
>  #include <linux/reset.h>
>  #include <linux/sched_clock.h>
>  
> -static void __init timer_get_base_and_rate(struct device_node *np,
> +static int __init timer_get_base_and_rate(struct device_node *np,
>  				    void __iomem **base, u32 *rate)
>  {
>  	struct clk *timer_clk;
>  	struct clk *pclk;
>  	struct reset_control *rstc;
> +	int ret;
>  
>  	*base = of_iomap(np, 0);
>  
> @@ -46,55 +47,68 @@ static void __init timer_get_base_and_rate(struct device_node *np,
>  			pr_warn("pclk for %pOFn is present, but could not be activated\n",
>  				np);
>  
> +	if (!of_property_read_u32(np, "clock-freq", rate) &&
> +	    !of_property_read_u32(np, "clock-frequency", rate))
> +		return 0;
> +
>  	timer_clk = of_clk_get_by_name(np, "timer");
> -	if (IS_ERR(timer_clk))
> -		goto try_clock_freq;
> +	ret = PTR_ERR(timer_clk);
> +	if (ret)
> +		return ret;
>  
> -	if (!clk_prepare_enable(timer_clk)) {
> -		*rate = clk_get_rate(timer_clk);
> -		return;
> -	}
> +	ret = clk_prepare_enable(timer_clk);
> +	if (ret)
> +		return ret;
> +
> +	*rate = clk_get_rate(timer_clk);
> +	if (!(*rate))
> +		return -EINVAL;
>  
> -try_clock_freq:
> -	if (of_property_read_u32(np, "clock-freq", rate) &&
> -	    of_property_read_u32(np, "clock-frequency", rate))
> -		panic("No clock nor clock-frequency property for %pOFn", np);
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
> +	ret = timer_get_base_and_rate(event_timer, &iobase, &rate);
> +	if (ret)
> +		return ret;
>  
>  	ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
>  				     rate);
>  	if (!ced)
> -		panic("Unable to initialise clockevent device");
> +		return -EINVAL;
>  
>  	dw_apb_clockevent_register(ced);
> +
> +	return 0;
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
> +	int ret;
>  
> -	timer_get_base_and_rate(source_timer, &iobase, &rate);
> +	ret = timer_get_base_and_rate(source_timer, &iobase, &rate);
> +	if (ret)
> +		return ret;
>  
>  	cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
>  	if (!cs)
> -		panic("Unable to initialise clocksource device");
> +		return -EINVAL;
>  
>  	dw_apb_clocksource_start(cs);
>  	dw_apb_clocksource_register(cs);
> @@ -106,6 +120,8 @@ static void __init add_clocksource(struct device_node *source_timer)
>  	 */
>  	sched_io_base = iobase + 0x04;
>  	sched_rate = rate;
> +
> +	return 0;
>  }
>  
>  static u64 notrace read_sched_clock(void)
> @@ -146,10 +162,14 @@ static struct delay_timer dw_apb_delay_timer = {
>  static int num_called;
>  static int __init dw_apb_timer_init(struct device_node *timer)
>  {
> +	int ret = 0;
> +
>  	switch (num_called) {
>  	case 1:
>  		pr_debug("%s: found clocksource timer\n", __func__);
> -		add_clocksource(timer);
> +		ret = add_clocksource(timer);
> +		if (ret)
> +			return ret;
>  		init_sched_clock();
>  #ifdef CONFIG_ARM
>  		dw_apb_delay_timer.freq = sched_rate;
> @@ -158,7 +178,9 @@ static int __init dw_apb_timer_init(struct device_node *timer)
>  		break;
>  	default:
>  		pr_debug("%s: found clockevent timer\n", __func__);
> -		add_clockevent(timer);
> +		ret = add_clockevent(timer);
> +		if (ret)
> +			return ret;
>  		break;
>  	}
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
