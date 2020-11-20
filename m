Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FA2BA6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgKTKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:03:14 -0500
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:16737
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbgKTKDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:03:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6T7ZQbI0EjBvAPR1xxym1rFyHIfDRsrLpEmyiU3wqxFQQi29RYpL8MjaY4KYbi3sumel7/j/6GiYHoq+uLVSoUY4jvL68myH5R8dgcwCg9pT1MV6FpT9nxNdcdL1EFESUKyMKeJGNAly3YirzRmJWhvVhlHWKPVtI9nnFCAPY5P75UjjvajCLSILsSzMY1yaSyntJ4UlIGnJqLk2rXHD2PoPG7TR7eGVsnfu4SewqJG3q1kkQT2NylA5BhnXQx7QuchSVAUO4iAWn0eTI0YFW6fGV17IsysL2bJdD1zdhgnRpegU+Kf1UMPIuRnlorGBaiKj3F+Cw8GmHTJIZVsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kKEgVkE6BYjsp0UNZCY57ihsBsG64WHHyMV16ckXmo=;
 b=CxLZxF3zZyCrjo9Rx+fOoPclvITeooz9O9C5W+wsT9kufrDYVdqGfivbbpfyzlnuRna7lXScFzmzBWGDp8XkwmiIJxLNfFqerzyyIr4jLStPVXwjRRGCA8msLeXj1PhDGKF8zqhB13LpEn3N1MoXsFDQIUgKsU6H/TePh0o7Dtr4UHXis/6eUYjiyo9e25qE6bzENWiGWraSbzi/W0ZSgOT7ijNnliwCKfOQJfmlgF8TsSfF1pigh/VqLrl25L6D4LCIqC40tIaXfCKj0RL6gCOt4MT4wsm4D6y04Y2TUxDRtd1c9UaXPEjL0WA2YgABDKaZHccMhYlQs3WnAy09UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kKEgVkE6BYjsp0UNZCY57ihsBsG64WHHyMV16ckXmo=;
 b=D55fouObYO84iBR3NmYugxMGn0W7rt6N75p+57xhB2ZddTNbCRZ3Dvc6/S9DOauD5GothwCEMIuiaQ9QZ6I8g9Rb2niYAe5i5XD5KmoGR40VNBThr7fJfCRR2NTSunYaHv+6Stx+ZXYA3NiqqS5nNBYd7HiA1CKLf9Awl0IFHxg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SN2PR03MB2144.namprd03.prod.outlook.com (2603:10b6:804:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 10:03:08 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 10:03:08 +0000
Date:   Fri, 20 Nov 2020 18:02:56 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, p.zabel@pengutronix.de, arnd@arndb.de
Subject: Re: [PATCH] clocksource: dw_apb_timer_of: return EPROBE_DEFER if no
 clock available
Message-ID: <20201120180256.378bc429@xhacker.debian>
In-Reply-To: <20201119121225.26536-1-dinguyen@kernel.org>
References: <20201119121225.26536-1-dinguyen@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:a03:333::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 10:03:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 213cc052-1f36-4a56-b6a9-08d88d3b7b2b
X-MS-TrafficTypeDiagnostic: SN2PR03MB2144:
X-Microsoft-Antispam-PRVS: <SN2PR03MB21444C2BD98B9A4CFFB966A9EDFF0@SN2PR03MB2144.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5br7gWLoU7m4tg5sE0McaRmzMvPFzzYHvfCgzSmq0vIUtddavNEtq4XRxmeTLnyL0c9IPnCQxktpxWwCIzoP9SDniMqmQ0l8p+0MDzO9mnl3+dodr/DhZUESCSfuu6yxeZs4xwT1MOPiZolOBpYuTfNxfLFBMBXiF1H9FLmfXrrWELjkk3GPJesJqXxoMcaptfYJ0x7uZ6PSM2e2CqSyapsSSnj4xDOPZJKe8O1T4IifEKaetckBLAe/e9On5bPFcwbHoYtXMe74ztLRFzXybZO5LA7eq1csZ6PN6/vsUZUu5BUncDD4KI3jlDqJf1rRipowyFeSZ8qJ5rVkNiz9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(186003)(956004)(8936002)(66556008)(52116002)(83380400001)(8676002)(7696005)(66946007)(66476007)(316002)(16526019)(26005)(6916009)(478600001)(6506007)(2906002)(5660300002)(4326008)(6666004)(86362001)(1076003)(55016002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ojXsZnoI6BNkVR17O5eF+C/F5qMAfKfBMnMfQkslrmx9vQ0cY8Jp9IRtaFcypp2qiaDycIijaNE2fyuaCPDGEhLEaz2G5pabhqjWOWmvHHWPdUUMfR6uH920XSXs2o+/vUk+GTDIw+OTbludNDVmvLeEbGS0EPcJuTOqkFg/PUDZ2DpR8MS5RoMYPrw+YdonUq0JxeoalS4bjdQVp0OrG5LDfFVTkBfk4kx6oB0hH3HWGYpdsJhsAtgJ+nFHDHsOmGz0l1gkNbrkjMZBsWlh+rdS9j9t5IAgVr2qhvlwb5gNUYiwGvkkor6RD7XKvUIMD7pkcKkyLJ/SUFPk48QyQ0R02TrWMa+PllMrCvuDU/QMxfwz5mbQlrrIUBxLqG2XXGR048yoeKmIAKQe5mbnzSCdoybDWdfglqbNre0mMBg2pUbKYDYRi3VEZUcAvVvL7cpRTLsW5zHBrzuV0Am4M9UasZ8d6+MOlPj2aonqIIzQ8hB2oWIFuiIQWo1xR+g4Sw+ME/VVOhqejHsmMIs9XrxWe01KfQVTzL4d55xm3y3J4RJxJBMk47DJqeTNjhVC2z1JM+V28jPmi+MRvRlnFLD9+ccMXGptRIcWVgznuHDXQrY6TkDI8shaLmOr0kTodsk3w4dIX6AbnSDImq/Nhg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213cc052-1f36-4a56-b6a9-08d88d3b7b2b
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:03:08.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pGrLn1s9QEmr7v/zI0Mj+3Tr5z+eyFre3ZSZWsEuGyvnt/QUqALnRL9IjlxBOAy8jDB0Ke6RA7H2rhgvKE4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 06:12:25 -0600
Dinh Nguyen <dinguyen@kernel.org> wrote:


> 
> 
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

Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

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
>                                     void __iomem **base, u32 *rate)
>  {
>         struct clk *timer_clk;
> @@ -47,65 +47,77 @@ static void __init timer_get_base_and_rate(struct device_node *np,
>                                 np);
> 
>         timer_clk = of_clk_get_by_name(np, "timer");
> -       if (IS_ERR(timer_clk))
> -               goto try_clock_freq;
> +       if (IS_ERR(timer_clk)) {
> +               if (PTR_ERR(timer_clk) != -EPROBE_DEFER) {
> +                       pr_err("Failed to get clock for %pOF\n", np);
> +                       goto try_clock_freq;
> +               }
> +               return PTR_ERR(timer_clk);
> +       }
> 
>         if (!clk_prepare_enable(timer_clk)) {
>                 *rate = clk_get_rate(timer_clk);
> -               return;
> +               return 0;
>         }
> 
>  try_clock_freq:
>         if (of_property_read_u32(np, "clock-freq", rate) &&
>             of_property_read_u32(np, "clock-frequency", rate))
>                 panic("No clock nor clock-frequency property for %pOFn", np);
> +       return 0;
>  }
> 
> -static void __init add_clockevent(struct device_node *event_timer)
> +static int __init add_clockevent(struct device_node *event_timer)
>  {
>         void __iomem *iobase;
>         struct dw_apb_clock_event_device *ced;
>         u32 irq, rate;
> +       int ret = 0;
> 
>         irq = irq_of_parse_and_map(event_timer, 0);
>         if (irq == 0)
>                 panic("No IRQ for clock event timer");
> 
> -       timer_get_base_and_rate(event_timer, &iobase, &rate);
> -
> -       ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
> +       ret = timer_get_base_and_rate(event_timer, &iobase, &rate);
> +       if (ret == 0) {
> +               ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
>                                      rate);
> -       if (!ced)
> -               panic("Unable to initialise clockevent device");
> +               if (!ced)
> +                       panic("Unable to initialise clockevent device");
> 
> -       dw_apb_clockevent_register(ced);
> +               dw_apb_clockevent_register(ced);
> +       }
> +       return ret;
>  }
> 
>  static void __iomem *sched_io_base;
>  static u32 sched_rate;
> 
> -static void __init add_clocksource(struct device_node *source_timer)
> +static int __init add_clocksource(struct device_node *source_timer)
>  {
>         void __iomem *iobase;
>         struct dw_apb_clocksource *cs;
>         u32 rate;
> -
> -       timer_get_base_and_rate(source_timer, &iobase, &rate);
> -
> -       cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
> -       if (!cs)
> -               panic("Unable to initialise clocksource device");
> -
> -       dw_apb_clocksource_start(cs);
> -       dw_apb_clocksource_register(cs);
> -
> -       /*
> -        * Fallback to use the clocksource as sched_clock if no separate
> -        * timer is found. sched_io_base then points to the current_value
> -        * register of the clocksource timer.
> -        */
> -       sched_io_base = iobase + 0x04;
> -       sched_rate = rate;
> +       int ret;
> +
> +       ret = timer_get_base_and_rate(source_timer, &iobase, &rate);
> +       if (ret == 0) {
> +               cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
> +               if (!cs)
> +                       panic("Unable to initialise clocksource device");
> +
> +               dw_apb_clocksource_start(cs);
> +               dw_apb_clocksource_register(cs);
> +
> +               /*
> +                * Fallback to use the clocksource as sched_clock if no separate
> +                * timer is found. sched_io_base then points to the current_value
> +                * register of the clocksource timer.
> +                */
> +               sched_io_base = iobase + 0x04;
> +               sched_rate = rate;
> +       }
> +       return ret;
>  }
> 
>  static u64 notrace read_sched_clock(void)
> @@ -146,25 +158,29 @@ static struct delay_timer dw_apb_delay_timer = {
>  static int num_called;
>  static int __init dw_apb_timer_init(struct device_node *timer)
>  {
> +       int ret = 0;
> +
>         switch (num_called) {
>         case 1:
>                 pr_debug("%s: found clocksource timer\n", __func__);
> -               add_clocksource(timer);
> -               init_sched_clock();
> +               ret = add_clocksource(timer);
> +               if (ret == 0) {
> +                       init_sched_clock();
>  #ifdef CONFIG_ARM
> -               dw_apb_delay_timer.freq = sched_rate;
> -               register_current_timer_delay(&dw_apb_delay_timer);
> +                       dw_apb_delay_timer.freq = sched_rate;
> +                       register_current_timer_delay(&dw_apb_delay_timer);
>  #endif
> +               }
>                 break;
>         default:
>                 pr_debug("%s: found clockevent timer\n", __func__);
> -               add_clockevent(timer);
> +               ret = add_clockevent(timer);
>                 break;
>         }
> 
>         num_called++;
> 
> -       return 0;
> +       return ret;
>  }
>  TIMER_OF_DECLARE(pc3x2_timer, "picochip,pc3x2-timer", dw_apb_timer_init);
>  TIMER_OF_DECLARE(apb_timer_osc, "snps,dw-apb-timer-osc", dw_apb_timer_init);
> --
> 2.17.1
> 

