Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B255D2CC0EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgLBPew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgLBPev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:34:51 -0500
Subject: Re: [PATCH] clocksource: dw_apb_timer_of: return EPROBE_DEFER if no
 clock available
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606923250;
        bh=T1woLBXiYhVRdJ6CYfI7eDlHdeHCVbnDLMZ+xFRvOAY=;
        h=To:Cc:References:From:Date:In-Reply-To:From;
        b=zJQA6GBCHM6yOf4n9LXVoXPZ2mSBsfdYf8aSUxBXroYY7trZHIlB/buAgImOTydqV
         AUNSFCN47reilvUxH/jA6IUOPZfrt3kUrTw9NthDFXDo6eNprz8K9+MiNJ47yrj1uc
         nzjIYeBqvz4GkmTUin9AEBVNQv3SbYxYkGReLCCE=
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, p.zabel@pengutronix.de, arnd@arndb.de
References: <20201119121225.26536-1-dinguyen@kernel.org>
 <20201120180256.378bc429@xhacker.debian>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <b3374ada-22e0-7429-1738-6a50903f5305@kernel.org>
Date:   Wed, 2 Dec 2020 09:33:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120180256.378bc429@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping?

On 11/20/20 4:02 AM, Jisheng Zhang wrote:
> On Thu, 19 Nov 2020 06:12:25 -0600
> Dinh Nguyen <dinguyen@kernel.org> wrote:
> 
> 
>>
>>
>> commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added the
>> support for the dw_apb_timer into the arm64 defconfig. However, for some
>> platforms like the Intel Stratix10 and Agilex, the clock manager doesn't
>> get probed until after the timer driver is probed. Thus, the driver hits
>> the panic "No clock nor clock-frequency property for %" because it cannot
>> properly get the clock.
>>
>> This patch adds support for EPROBE_DEFER so the kernel can come back to
>> finish probing this timer driver after the clock driver is probed.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> 
> Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
>> ---
>>   drivers/clocksource/dw_apb_timer_of.c | 86 ++++++++++++++++-----------
>>   1 file changed, 51 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
>> index ab3ddebe8344..a8ce980c5146 100644
>> --- a/drivers/clocksource/dw_apb_timer_of.c
>> +++ b/drivers/clocksource/dw_apb_timer_of.c
>> @@ -14,7 +14,7 @@
>>   #include <linux/reset.h>
>>   #include <linux/sched_clock.h>
>>
>> -static void __init timer_get_base_and_rate(struct device_node *np,
>> +static int __init timer_get_base_and_rate(struct device_node *np,
>>                                      void __iomem **base, u32 *rate)
>>   {
>>          struct clk *timer_clk;
>> @@ -47,65 +47,77 @@ static void __init timer_get_base_and_rate(struct device_node *np,
>>                                  np);
>>
>>          timer_clk = of_clk_get_by_name(np, "timer");
>> -       if (IS_ERR(timer_clk))
>> -               goto try_clock_freq;
>> +       if (IS_ERR(timer_clk)) {
>> +               if (PTR_ERR(timer_clk) != -EPROBE_DEFER) {
>> +                       pr_err("Failed to get clock for %pOF\n", np);
>> +                       goto try_clock_freq;
>> +               }
>> +               return PTR_ERR(timer_clk);
>> +       }
>>
>>          if (!clk_prepare_enable(timer_clk)) {
>>                  *rate = clk_get_rate(timer_clk);
>> -               return;
>> +               return 0;
>>          }
>>
>>   try_clock_freq:
>>          if (of_property_read_u32(np, "clock-freq", rate) &&
>>              of_property_read_u32(np, "clock-frequency", rate))
>>                  panic("No clock nor clock-frequency property for %pOFn", np);
>> +       return 0;
>>   }
>>
>> -static void __init add_clockevent(struct device_node *event_timer)
>> +static int __init add_clockevent(struct device_node *event_timer)
>>   {
>>          void __iomem *iobase;
>>          struct dw_apb_clock_event_device *ced;
>>          u32 irq, rate;
>> +       int ret = 0;
>>
>>          irq = irq_of_parse_and_map(event_timer, 0);
>>          if (irq == 0)
>>                  panic("No IRQ for clock event timer");
>>
>> -       timer_get_base_and_rate(event_timer, &iobase, &rate);
>> -
>> -       ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
>> +       ret = timer_get_base_and_rate(event_timer, &iobase, &rate);
>> +       if (ret == 0) {
>> +               ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
>>                                       rate);
>> -       if (!ced)
>> -               panic("Unable to initialise clockevent device");
>> +               if (!ced)
>> +                       panic("Unable to initialise clockevent device");
>>
>> -       dw_apb_clockevent_register(ced);
>> +               dw_apb_clockevent_register(ced);
>> +       }
>> +       return ret;
>>   }
>>
>>   static void __iomem *sched_io_base;
>>   static u32 sched_rate;
>>
>> -static void __init add_clocksource(struct device_node *source_timer)
>> +static int __init add_clocksource(struct device_node *source_timer)
>>   {
>>          void __iomem *iobase;
>>          struct dw_apb_clocksource *cs;
>>          u32 rate;
>> -
>> -       timer_get_base_and_rate(source_timer, &iobase, &rate);
>> -
>> -       cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
>> -       if (!cs)
>> -               panic("Unable to initialise clocksource device");
>> -
>> -       dw_apb_clocksource_start(cs);
>> -       dw_apb_clocksource_register(cs);
>> -
>> -       /*
>> -        * Fallback to use the clocksource as sched_clock if no separate
>> -        * timer is found. sched_io_base then points to the current_value
>> -        * register of the clocksource timer.
>> -        */
>> -       sched_io_base = iobase + 0x04;
>> -       sched_rate = rate;
>> +       int ret;
>> +
>> +       ret = timer_get_base_and_rate(source_timer, &iobase, &rate);
>> +       if (ret == 0) {
>> +               cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
>> +               if (!cs)
>> +                       panic("Unable to initialise clocksource device");
>> +
>> +               dw_apb_clocksource_start(cs);
>> +               dw_apb_clocksource_register(cs);
>> +
>> +               /*
>> +                * Fallback to use the clocksource as sched_clock if no separate
>> +                * timer is found. sched_io_base then points to the current_value
>> +                * register of the clocksource timer.
>> +                */
>> +               sched_io_base = iobase + 0x04;
>> +               sched_rate = rate;
>> +       }
>> +       return ret;
>>   }
>>
>>   static u64 notrace read_sched_clock(void)
>> @@ -146,25 +158,29 @@ static struct delay_timer dw_apb_delay_timer = {
>>   static int num_called;
>>   static int __init dw_apb_timer_init(struct device_node *timer)
>>   {
>> +       int ret = 0;
>> +
>>          switch (num_called) {
>>          case 1:
>>                  pr_debug("%s: found clocksource timer\n", __func__);
>> -               add_clocksource(timer);
>> -               init_sched_clock();
>> +               ret = add_clocksource(timer);
>> +               if (ret == 0) {
>> +                       init_sched_clock();
>>   #ifdef CONFIG_ARM
>> -               dw_apb_delay_timer.freq = sched_rate;
>> -               register_current_timer_delay(&dw_apb_delay_timer);
>> +                       dw_apb_delay_timer.freq = sched_rate;
>> +                       register_current_timer_delay(&dw_apb_delay_timer);
>>   #endif
>> +               }
>>                  break;
>>          default:
>>                  pr_debug("%s: found clockevent timer\n", __func__);
>> -               add_clockevent(timer);
>> +               ret = add_clockevent(timer);
>>                  break;
>>          }
>>
>>          num_called++;
>>
>> -       return 0;
>> +       return ret;
>>   }
>>   TIMER_OF_DECLARE(pc3x2_timer, "picochip,pc3x2-timer", dw_apb_timer_init);
>>   TIMER_OF_DECLARE(apb_timer_osc, "snps,dw-apb-timer-osc", dw_apb_timer_init);
>> --
>> 2.17.1
>>
> 
