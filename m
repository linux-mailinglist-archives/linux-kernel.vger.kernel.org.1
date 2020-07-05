Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D63214C7C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGEM67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 08:58:59 -0400
Received: from crapouillou.net ([89.234.176.41]:37312 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgGEM66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593953935; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Np1aXXqV7wWnnd/eJpq9luKQPSbI+VI+bR1lF7M/GNU=;
        b=sbcRMx16UQBqnkVuvD0mK+mw9wemQf2FgGKW0TsHgDPoKHVG7kfk87JFqnyQuac+HDnpUa
        M29V+PJ/ufylgjho0dAqNWoD3SutbN1IKJg51cLYTj/o/W0iwUwpeYgFEYydmbaOxsYBhu
        M/S4ORRXaU5OOdReyfU2EkArQuQboN0=
Date:   Sun, 05 Jul 2020 14:58:45 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 2/2] clocksource: Ingenic: Add support for the Ingenic
 X1000 OST.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org,
        =?UTF-8?b?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>
Message-Id: <XPYZCQ.OUZSDPZBJ2IC@crapouillou.net>
In-Reply-To: <20200705123420.20045-3-zhouyanjie@wanyeetech.com>
References: <20200705123420.20045-1-zhouyanjie@wanyeetech.com>
        <20200705123420.20045-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le dim. 5 juil. 2020 =C3=A0 20:34, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie=
)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> X1000 and SoCs after X1000 (such as X1500 and X1830) had a separate
> OST, it no longer belongs to TCU. This driver will register both a
> clocksource and a sched_clock to the system.
>=20
> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Co-developed-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ing=
enic.com>
> Signed-off-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ingen=
ic.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>=20
> Notes:
>     v1->v2:
>     Fix compile warnings.
>     Reported-by: kernel test robot <lkp@intel.com>
>=20
>     v2->v3:
>     No change.
>=20
>     v3->v4:
>     1.Remove unrelated changes.
>     2.Remove ost_clock_parent enum.
>     3.Remove ost->percpu_timer_channel/ost->global_timer_channel.
>     4.Set up independent .recalc_rate/.set_rate for percpu/global=20
> timer.
>     5.No longer call functions in variable declarations.
>=20
>  drivers/clocksource/Kconfig          |  11 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/ingenic-sysost.c | 539=20
> +++++++++++++++++++++++++++++++++++
>  3 files changed, 551 insertions(+)
>  create mode 100644 drivers/clocksource/ingenic-sysost.c
>=20
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 91418381fcd4..1bca8b8fb30f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -696,6 +696,17 @@ config INGENIC_TIMER
>  	help
>  	  Support for the timer/counter unit of the Ingenic JZ SoCs.
>=20
> +config INGENIC_SYSOST
> +	bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
> +	default MACH_INGENIC
> +	depends on MIPS || COMPILE_TEST
> +	depends on COMMON_CLK
> +	select MFD_SYSCON
> +	select TIMER_OF
> +	select IRQ_DOMAIN
> +	help
> +	  Support for the SYSOST of the Ingenic X Series SoCs.
> +
>  config INGENIC_OST
>  	bool "Clocksource for Ingenic OS Timer"
>  	depends on MIPS || COMPILE_TEST
> diff --git a/drivers/clocksource/Makefile=20
> b/drivers/clocksource/Makefile
> index bdda1a2e4097..3994e221e262 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_H8300_TMR8)		+=3D h8300_timer8.o
>  obj-$(CONFIG_H8300_TMR16)		+=3D h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)			+=3D h8300_tpu.o
>  obj-$(CONFIG_INGENIC_OST)		+=3D ingenic-ost.o
> +obj-$(CONFIG_INGENIC_SYSOST)	+=3D ingenic-sysost.o
>  obj-$(CONFIG_INGENIC_TIMER)		+=3D ingenic-timer.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+=3D numachip.o
> diff --git a/drivers/clocksource/ingenic-sysost.c=20
> b/drivers/clocksource/ingenic-sysost.c
> new file mode 100644
> index 000000000000..f6dab3da68fb
> --- /dev/null
> +++ b/drivers/clocksource/ingenic-sysost.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Ingenic XBurst SoCs SYSOST clocks driver
> + * Copyright (c) 2020 =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=20
> <zhouyanjie@wanyeetech.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +#include <linux/slab.h>
> +#include <linux/syscore_ops.h>
> +
> +#include <dt-bindings/clock/ingenic,sysost.h>
> +
> +/* OST register offsets */
> +#define OST_REG_OSTCCR			0x00
> +#define OST_REG_OSTCR			0x08
> +#define OST_REG_OSTFR			0x0c
> +#define OST_REG_OSTMR			0x10
> +#define OST_REG_OST1DFR			0x14
> +#define OST_REG_OST1CNT			0x18
> +#define OST_REG_OST2CNTL		0x20
> +#define OST_REG_OSTCNT2HBUF		0x24
> +#define OST_REG_OSTESR			0x34
> +#define OST_REG_OSTECR			0x38
> +
> +/* bits within the OSTCCR register */
> +#define OSTCCR_PRESCALE1_MASK	0x3
> +#define OSTCCR_PRESCALE2_MASK	0xc
> +#define OSTCCR_PRESCALE1_LSB	0
> +#define OSTCCR_PRESCALE2_LSB	2
> +
> +/* bits within the OSTCR register */
> +#define OSTCR_OST1CLR			BIT(0)
> +#define OSTCR_OST2CLR			BIT(1)
> +
> +/* bits within the OSTFR register */
> +#define OSTFR_FFLAG				BIT(0)
> +
> +/* bits within the OSTMR register */
> +#define OSTMR_FMASK				BIT(0)
> +
> +/* bits within the OSTESR register */
> +#define OSTESR_OST1ENS			BIT(0)
> +#define OSTESR_OST2ENS			BIT(1)
> +
> +/* bits within the OSTECR register */
> +#define OSTECR_OST1ENC			BIT(0)
> +#define OSTECR_OST2ENC			BIT(1)
> +
> +struct ingenic_soc_info {
> +	unsigned int num_channels;
> +};
> +
> +struct ingenic_ost_clk_info {
> +	struct clk_init_data init_data;
> +	u8 ostccr_reg;
> +};
> +
> +struct ingenic_ost_clk {
> +	struct clk_hw hw;
> +	unsigned int idx;
> +	struct ingenic_ost *ost;
> +	const struct ingenic_ost_clk_info *info;
> +};
> +
> +struct ingenic_ost {
> +	void __iomem *base;
> +	const struct ingenic_soc_info *soc_info;
> +	struct clk *clk, *percpu_timer_clk, *global_timer_clk;
> +	struct clock_event_device cevt;
> +	struct clocksource cs;
> +	char name[20];
> +
> +	struct clk_hw_onecell_data *clocks;
> +};
> +
> +static struct ingenic_ost *ingenic_ost;
> +
> +static inline struct ingenic_ost_clk *to_ost_clk(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ingenic_ost_clk, hw);
> +}
> +
> +static unsigned long ingenic_ost_percpu_timer_recalc_rate(struct=20
> clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct ingenic_ost_clk *ost_clk =3D to_ost_clk(hw);
> +	const struct ingenic_ost_clk_info *info =3D ost_clk->info;
> +	unsigned int prescale;
> +
> +	prescale =3D readl(ost_clk->ost->base + info->ostccr_reg);
> +
> +	prescale =3D (prescale & OSTCCR_PRESCALE1_MASK) >>=20
> OSTCCR_PRESCALE1_LSB;
> +
> +	return parent_rate >> (prescale * 2);
> +}
> +
> +static unsigned long ingenic_ost_global_timer_recalc_rate(struct=20
> clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct ingenic_ost_clk *ost_clk =3D to_ost_clk(hw);
> +	const struct ingenic_ost_clk_info *info =3D ost_clk->info;
> +	unsigned int prescale;
> +
> +	prescale =3D readl(ost_clk->ost->base + info->ostccr_reg);
> +
> +	prescale =3D (prescale & OSTCCR_PRESCALE2_MASK) >>=20
> OSTCCR_PRESCALE2_LSB;
> +
> +	return parent_rate >> (prescale * 2);
> +}
> +
> +static u8 ingenic_ost_get_prescale(unsigned long rate, unsigned long=20
> req_rate)
> +{
> +	u8 prescale;
> +
> +	for (prescale =3D 0; prescale < 2; prescale++)
> +		if ((rate >> (prescale * 2)) <=3D req_rate)
> +			return prescale;
> +
> +	return 2; /* /16 divider */
> +}
> +
> +static long ingenic_ost_round_rate(struct clk_hw *hw, unsigned long=20
> req_rate,
> +		unsigned long *parent_rate)
> +{
> +	unsigned long rate =3D *parent_rate;
> +	u8 prescale;
> +
> +	if (req_rate > rate)
> +		return rate;
> +
> +	prescale =3D ingenic_ost_get_prescale(rate, req_rate);
> +
> +	return rate >> (prescale * 2);
> +}
> +
> +static int ingenic_ost_percpu_timer_set_rate(struct clk_hw *hw,=20
> unsigned long req_rate,
> +		unsigned long parent_rate)
> +{
> +	struct ingenic_ost_clk *ost_clk =3D to_ost_clk(hw);
> +	const struct ingenic_ost_clk_info *info =3D ost_clk->info;
> +	u8 prescale =3D ingenic_ost_get_prescale(parent_rate, req_rate);
> +	int val;
> +
> +	val =3D readl(ost_clk->ost->base + info->ostccr_reg);
> +	val =3D (val & ~OSTCCR_PRESCALE1_MASK) | (prescale <<=20
> OSTCCR_PRESCALE1_LSB);
> +	writel(val, ost_clk->ost->base + info->ostccr_reg);
> +
> +	return 0;
> +}
> +
> +static int ingenic_ost_global_timer_set_rate(struct clk_hw *hw,=20
> unsigned long req_rate,
> +		unsigned long parent_rate)
> +{
> +	struct ingenic_ost_clk *ost_clk =3D to_ost_clk(hw);
> +	const struct ingenic_ost_clk_info *info =3D ost_clk->info;
> +	u8 prescale =3D ingenic_ost_get_prescale(parent_rate, req_rate);
> +	int val;
> +
> +	val =3D readl(ost_clk->ost->base + info->ostccr_reg);
> +	val =3D (val & ~OSTCCR_PRESCALE2_MASK) | (prescale <<=20
> OSTCCR_PRESCALE2_LSB);
> +	writel(val, ost_clk->ost->base + info->ostccr_reg);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops ingenic_ost_percpu_timer_ops =3D {
> +	.recalc_rate	=3D ingenic_ost_percpu_timer_recalc_rate,
> +	.round_rate		=3D ingenic_ost_round_rate,
> +	.set_rate		=3D ingenic_ost_percpu_timer_set_rate,
> +};
> +
> +static const struct clk_ops ingenic_ost_global_timer_ops =3D {
> +	.recalc_rate	=3D ingenic_ost_global_timer_recalc_rate,
> +	.round_rate		=3D ingenic_ost_round_rate,
> +	.set_rate		=3D ingenic_ost_global_timer_set_rate,
> +};
> +
> +static const char * const ingenic_ost_clk_parents[] =3D { "ext" };
> +
> +static const struct ingenic_ost_clk_info ingenic_ost_clk_info[] =3D {
> +	[OST_CLK_PERCPU_TIMER] =3D {
> +		.init_data =3D {
> +			.name =3D "percpu timer",
> +			.parent_names =3D ingenic_ost_clk_parents,
> +			.num_parents =3D ARRAY_SIZE(ingenic_ost_clk_parents),
> +			.ops =3D &ingenic_ost_percpu_timer_ops,
> +			.flags =3D CLK_SET_RATE_UNGATE,
> +		},
> +		.ostccr_reg =3D OST_REG_OSTCCR,
> +	},
> +
> +	[OST_CLK_GLOBAL_TIMER] =3D {
> +		.init_data =3D {
> +			.name =3D "global timer",
> +			.parent_names =3D ingenic_ost_clk_parents,
> +			.num_parents =3D ARRAY_SIZE(ingenic_ost_clk_parents),
> +			.ops =3D &ingenic_ost_global_timer_ops,
> +			.flags =3D CLK_SET_RATE_UNGATE,
> +		},
> +		.ostccr_reg =3D OST_REG_OSTCCR,
> +	},
> +};
> +
> +static u64 notrace ingenic_ost_global_timer_read_cntl(void)
> +{
> +	struct ingenic_ost *ost =3D ingenic_ost;
> +	unsigned int count;
> +
> +	count =3D readl(ost->base + OST_REG_OST2CNTL);
> +
> +	return count;
> +}
> +
> +static u64 notrace ingenic_ost_clocksource_read(struct clocksource=20
> *cs)
> +{
> +	return ingenic_ost_global_timer_read_cntl();
> +}
> +
> +static inline struct ingenic_ost *to_ingenic_ost(struct=20
> clock_event_device *evt)
> +{
> +	return container_of(evt, struct ingenic_ost, cevt);
> +}
> +
> +static int ingenic_ost_cevt_set_state_shutdown(struct=20
> clock_event_device *evt)
> +{
> +	struct ingenic_ost *ost =3D to_ingenic_ost(evt);
> +
> +	writel(OSTECR_OST1ENC, ost->base + OST_REG_OSTECR);
> +
> +	return 0;
> +}
> +
> +static int ingenic_ost_cevt_set_next(unsigned long next,
> +				     struct clock_event_device *evt)
> +{
> +	struct ingenic_ost *ost =3D to_ingenic_ost(evt);
> +
> +	writel((u32)~OSTFR_FFLAG, ost->base + OST_REG_OSTFR);
> +	writel(next, ost->base + OST_REG_OST1DFR);
> +	writel(OSTCR_OST1CLR, ost->base + OST_REG_OSTCR);
> +	writel(OSTESR_OST1ENS, ost->base + OST_REG_OSTESR);
> +	writel((u32)~OSTMR_FMASK, ost->base + OST_REG_OSTMR);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ingenic_ost_cevt_cb(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt =3D dev_id;
> +	struct ingenic_ost *ost =3D to_ingenic_ost(evt);
> +
> +	writel(OSTECR_OST1ENC, ost->base + OST_REG_OSTECR);
> +
> +	if (evt->event_handler)
> +		evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init ingenic_ost_register_clock(struct ingenic_ost *ost,
> +			unsigned int idx, const struct ingenic_ost_clk_info *info,
> +			struct clk_hw_onecell_data *clocks)
> +{
> +	struct ingenic_ost_clk *ost_clk;
> +	int val, err;
> +
> +	ost_clk =3D kzalloc(sizeof(*ost_clk), GFP_KERNEL);
> +	if (!ost_clk)
> +		return -ENOMEM;
> +
> +	ost_clk->hw.init =3D &info->init_data;
> +	ost_clk->idx =3D idx;
> +	ost_clk->info =3D info;
> +	ost_clk->ost =3D ost;
> +
> +	/* Reset clock divider */
> +	val =3D readl(ost->base + info->ostccr_reg);
> +	val &=3D ~(OSTCCR_PRESCALE1_MASK | OSTCCR_PRESCALE2_MASK);
> +	writel(val, ost->base + info->ostccr_reg);
> +
> +	err =3D clk_hw_register(NULL, &ost_clk->hw);
> +	if (err) {
> +		kfree(ost_clk);
> +		return err;
> +	}
> +
> +	clocks->hws[idx] =3D &ost_clk->hw;
> +
> +	return 0;
> +}
> +
> +static struct clk * __init ingenic_ost_get_clock(struct device_node=20
> *np, int id)
> +{
> +	struct of_phandle_args args;
> +
> +	args.np =3D np;
> +	args.args_count =3D 1;
> +	args.args[0] =3D id;
> +
> +	return of_clk_get_from_provider(&args);
> +}
> +
> +static int __init ingenic_ost_percpu_timer_init(struct device_node=20
> *np,
> +					 struct ingenic_ost *ost)
> +{
> +	unsigned int timer_virq, channel =3D OST_CLK_PERCPU_TIMER;
> +	unsigned long rate;
> +	int err;
> +
> +	ost->percpu_timer_clk =3D ingenic_ost_get_clock(np, channel);
> +	if (IS_ERR(ost->percpu_timer_clk))
> +		return PTR_ERR(ost->percpu_timer_clk);
> +
> +	err =3D clk_prepare_enable(ost->percpu_timer_clk);
> +	if (err)
> +		goto err_clk_put;
> +
> +	rate =3D clk_get_rate(ost->percpu_timer_clk);
> +	if (!rate) {
> +		err =3D -EINVAL;
> +		goto err_clk_disable;
> +	}
> +
> +	timer_virq =3D of_irq_get(np, 0);
> +	if (!timer_virq) {
> +		err =3D -EINVAL;
> +		goto err_clk_disable;
> +	}
> +
> +	snprintf(ost->name, sizeof(ost->name), "OST percpu timer");
> +
> +	err =3D request_irq(timer_virq, ingenic_ost_cevt_cb, IRQF_TIMER,
> +			  ost->name, &ost->cevt);
> +	if (err)
> +		goto err_irq_dispose_mapping;
> +
> +	ost->cevt.cpumask =3D cpumask_of(smp_processor_id());
> +	ost->cevt.features =3D CLOCK_EVT_FEAT_ONESHOT;
> +	ost->cevt.name =3D ost->name;
> +	ost->cevt.rating =3D 400;
> +	ost->cevt.set_state_shutdown =3D ingenic_ost_cevt_set_state_shutdown;
> +	ost->cevt.set_next_event =3D ingenic_ost_cevt_set_next;
> +
> +	clockevents_config_and_register(&ost->cevt, rate, 4, 0xffffffff);
> +
> +	return 0;
> +
> +err_irq_dispose_mapping:
> +	irq_dispose_mapping(timer_virq);
> +err_clk_disable:
> +	clk_disable_unprepare(ost->percpu_timer_clk);
> +err_clk_put:
> +	clk_put(ost->percpu_timer_clk);
> +	return err;
> +}
> +
> +static int __init ingenic_ost_global_timer_init(struct device_node=20
> *np,
> +					       struct ingenic_ost *ost)
> +{
> +	unsigned int channel =3D OST_CLK_GLOBAL_TIMER;
> +	struct clocksource *cs =3D &ost->cs;
> +	unsigned long rate;
> +	int err;
> +
> +	ost->global_timer_clk =3D ingenic_ost_get_clock(np, channel);
> +	if (IS_ERR(ost->global_timer_clk))
> +		return PTR_ERR(ost->global_timer_clk);
> +
> +	err =3D clk_prepare_enable(ost->global_timer_clk);
> +	if (err)
> +		goto err_clk_put;
> +
> +	rate =3D clk_get_rate(ost->global_timer_clk);
> +	if (!rate) {
> +		err =3D -EINVAL;
> +		goto err_clk_disable;
> +	}
> +
> +	/* Clear counter CNT registers */
> +	writel(OSTCR_OST2CLR, ost->base + OST_REG_OSTCR);
> +
> +	/* Enable OST channel */
> +	writel(OSTESR_OST2ENS, ost->base + OST_REG_OSTESR);
> +
> +	cs->name =3D "ingenic-ost";
> +	cs->rating =3D 400;
> +	cs->flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
> +	cs->mask =3D CLOCKSOURCE_MASK(32);
> +	cs->read =3D ingenic_ost_clocksource_read;
> +
> +	err =3D clocksource_register_hz(cs, rate);
> +	if (err)
> +		goto err_clk_disable;
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(ost->global_timer_clk);
> +err_clk_put:
> +	clk_put(ost->global_timer_clk);
> +	return err;
> +}
> +
> +static const struct ingenic_soc_info x1000_soc_info =3D {
> +	.num_channels =3D 2,
> +};
> +
> +static const struct of_device_id __maybe_unused=20
> ingenic_ost_of_match[] __initconst =3D {
> +	{ .compatible =3D "ingenic,x1000-ost", .data =3D &x1000_soc_info, },
> +	{ /* sentinel */ }
> +};
> +
> +static int __init ingenic_ost_probe(struct device_node *np)
> +{
> +	const struct of_device_id *id =3D of_match_node(ingenic_ost_of_match,=20
> np);
> +	struct ingenic_ost *ost;
> +	unsigned int i;
> +	int ret;
> +
> +	ost =3D kzalloc(sizeof(*ost), GFP_KERNEL);
> +	if (!ost)
> +		return -ENOMEM;
> +
> +	ost->base =3D of_iomap(np, 0);

I think you should use of_io_request_and_map().

The rest looks good. So with that fixed:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> +	if (IS_ERR(ost->base)) {
> +		pr_err("%s: Failed to map OST registers\n", __func__);
> +		ret =3D PTR_ERR(ost->base);
> +		goto err_free_ost;
> +	}
> +
> +	ost->clk =3D of_clk_get_by_name(np, "ost");
> +	if (IS_ERR(ost->clk)) {
> +		ret =3D PTR_ERR(ost->clk);
> +		pr_crit("%s: Cannot get OST clock\n", __func__);
> +		goto err_free_ost;
> +	}
> +
> +	ret =3D clk_prepare_enable(ost->clk);
> +	if (ret) {
> +		pr_crit("%s: Unable to enable OST clock\n", __func__);
> +		goto err_put_clk;
> +	}
> +
> +	ost->soc_info =3D id->data;
> +
> +	ost->clocks =3D kzalloc(struct_size(ost->clocks, hws,=20
> ost->soc_info->num_channels),
> +			      GFP_KERNEL);
> +	if (!ost->clocks) {
> +		ret =3D -ENOMEM;
> +		goto err_clk_disable;
> +	}
> +
> +	ost->clocks->num =3D ost->soc_info->num_channels;
> +
> +	for (i =3D 0; i < ost->clocks->num; i++) {
> +		ret =3D ingenic_ost_register_clock(ost, i, &ingenic_ost_clk_info[i],=20
> ost->clocks);
> +		if (ret) {
> +			pr_crit("%s: Cannot register clock %d\n", __func__, i);
> +			goto err_unregister_ost_clocks;
> +		}
> +	}
> +
> +	ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get,=20
> ost->clocks);
> +	if (ret) {
> +		pr_crit("%s: Cannot add OF clock provider\n", __func__);
> +		goto err_unregister_ost_clocks;
> +	}
> +
> +	ingenic_ost =3D ost;
> +
> +	return 0;
> +
> +err_unregister_ost_clocks:
> +	for (i =3D 0; i < ost->clocks->num; i++)
> +		if (ost->clocks->hws[i])
> +			clk_hw_unregister(ost->clocks->hws[i]);
> +	kfree(ost->clocks);
> +err_clk_disable:
> +	clk_disable_unprepare(ost->clk);
> +err_put_clk:
> +	clk_put(ost->clk);
> +err_free_ost:
> +	kfree(ost);
> +	return ret;
> +}
> +
> +static int __init ingenic_ost_init(struct device_node *np)
> +{
> +	struct ingenic_ost *ost;
> +	unsigned long rate;
> +	int ret;
> +
> +	ret =3D ingenic_ost_probe(np);
> +	if (ret) {
> +		pr_crit("%s: Failed to initialize OST clocks: %d\n", __func__,=20
> ret);
> +		return ret;
> +	}
> +
> +	of_node_clear_flag(np, OF_POPULATED);
> +
> +	ost =3D ingenic_ost;
> +	if (IS_ERR(ost))
> +		return PTR_ERR(ost);
> +
> +	ret =3D ingenic_ost_global_timer_init(np, ost);
> +	if (ret) {
> +		pr_crit("%s: Unable to init global timer: %x\n", __func__, ret);
> +		goto err_free_ingenic_ost;
> +	}
> +
> +	ret =3D ingenic_ost_percpu_timer_init(np, ost);
> +	if (ret)
> +		goto err_ost_global_timer_cleanup;
> +
> +	/* Register the sched_clock at the end as there's no way to undo it=20
> */
> +	rate =3D clk_get_rate(ost->global_timer_clk);
> +	sched_clock_register(ingenic_ost_global_timer_read_cntl, 32, rate);
> +
> +	return 0;
> +
> +err_ost_global_timer_cleanup:
> +	clocksource_unregister(&ost->cs);
> +	clk_disable_unprepare(ost->global_timer_clk);
> +	clk_put(ost->global_timer_clk);
> +err_free_ingenic_ost:
> +	kfree(ost);
> +	return ret;
> +}
> +
> +TIMER_OF_DECLARE(x1000_ost,  "ingenic,x1000-ost",  ingenic_ost_init);
> --
> 2.11.0
>=20


