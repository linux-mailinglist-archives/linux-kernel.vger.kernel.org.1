Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8035B2BBB87
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 02:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgKUB33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 20:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgKUB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 20:29:28 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7FAC061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 17:29:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so9550337pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 17:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=e9e+der4tiI8HJvByBrDgbWSHOA3bihkhP0KklSxXps=;
        b=KsX3/vfX4tgCr+LUHs0syqeb7gDiIoj2kC/UmfWj60UV+yF7bYZvU/GOl4HYg+bT9p
         sXNWXbokDTC2F/xZo+Y75rI54zvI1CpWeTpmIdXkKRcdhT1OFuzfRBCeoSMIG0ORflp+
         trO6FGmKfa6Bw82PAwgOaqsVigFfwZX77W0eO44ZdgopVkTRzTx4cq9OadH3axfhIWX9
         QpRP9NEpa26fh7Kz+l3p7fRKnFj4rj05N0I0xnWOh8i0gI2jPXoGBtXy6nDrYCQliUgm
         cIclBukuyr8rUEaHeo1DVSLH3SXksUj8LPutEuDJbYwL56rlB6PuxgeMUGlIouswm6cd
         NmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=e9e+der4tiI8HJvByBrDgbWSHOA3bihkhP0KklSxXps=;
        b=IW5MpnKoa0pNGZtaoxQuBD7ZU6a1kmkDJgtrny3itK1OboVUWcbh0G6R9ztPq8t+W1
         lhe2RkziMS8GeOSbT4vLpAKPGXH3JMxuSh3sK+SDPJeoviIhRC5qgUdFFDRvqf1f+aIS
         NfA9mUn3sJd9Gw2VmxKMAYlsrlqzq6xiTjAUjMhSdztVz7H1YowC/BlC6Pf7zc3TMnnf
         +q4UWpGiv7IoxNARHa6PcbHPfRKqmUyt1tzKiKis29sqyypMQC0CImFbQGcfyltwFbQT
         JSCDGvJtd1b29pG4pzeM6M7pGcuXnY3k1q9+DihT1ZuF09BRD5p+lYa55tWaTgiUFFR4
         x2XQ==
X-Gm-Message-State: AOAM530qbjiczbCwOQn8CWA8J3KG70WVSHry6qdBIMOyEwuEQ1DeX/Gg
        uh4VaapbRm372hrDM491K3Vs4g==
X-Google-Smtp-Source: ABdhPJy2vHOjVX0NAQyRf9EzyqxIHxAx88tnQehv6TPKwHu1Y9/c1H5mUD50zU5wKyhARRGCWWuO8w==
X-Received: by 2002:a62:17c8:0:b029:18b:5a97:a8d1 with SMTP id 191-20020a6217c80000b029018b5a97a8d1mr16393477pfx.15.1605922167939;
        Fri, 20 Nov 2020 17:29:27 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v7sm5010016pfu.39.2020.11.20.17.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:29:27 -0800 (PST)
Date:   Fri, 20 Nov 2020 17:29:27 -0800 (PST)
X-Google-Original-Date: Fri, 20 Nov 2020 17:21:04 PST (-0800)
Subject:     Re: [PATCH v4 3/4] clk: sifive: Add a driver for the SiFive FU740 PRCI IP block
In-Reply-To: <20201111100608.108842-4-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        zong.li@sifive.com, Pragnesh.patel@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, pragnesh.patel@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-b245fbc4-01df-4e10-accb-6d6a569a705b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 02:06:07 PST (-0800), zong.li@sifive.com wrote:
> Add driver code for the SiFive FU740 PRCI IP block. This IP block
> handles reset and clock control for the SiFive FU740 device and
> implements SoC-level clock tree controls and dividers.
>
> This driver contains bug fixes and contributions from
> Henry Styles <hes@sifive.com>
> Erik Danie <erik.danie@sifive.com>
> Pragnesh Patel <pragnesh.patel@sifive.com>

Is there a datasheet for this chip?  It's geneally best to link to one, in case
someone needs to sort out issues in the future.

>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Pragnesh Patel <Pragnesh.patel@sifive.com>
> Cc: Henry Styles <hes@sifive.com>
> Cc: Erik Danie <erik.danie@sifive.com>
> Cc: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>  drivers/clk/sifive/Kconfig                    |   4 +-
>  drivers/clk/sifive/Makefile                   |   1 +
>  drivers/clk/sifive/fu740-prci.c               | 122 ++++++++++++++++++
>  drivers/clk/sifive/fu740-prci.h               |  21 +++
>  drivers/clk/sifive/sifive-prci.c              | 120 +++++++++++++++++
>  drivers/clk/sifive/sifive-prci.h              |  88 +++++++++++++
>  include/dt-bindings/clock/sifive-fu740-prci.h |  23 ++++
>  7 files changed, 377 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/sifive/fu740-prci.c
>  create mode 100644 drivers/clk/sifive/fu740-prci.h
>  create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h
>
> diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
> index ab48cf7e0105..1c14eb20c066 100644
> --- a/drivers/clk/sifive/Kconfig
> +++ b/drivers/clk/sifive/Kconfig
> @@ -13,7 +13,7 @@ config CLK_SIFIVE_PRCI
>  	select CLK_ANALOGBITS_WRPLL_CLN28HPC
>  	help
>  	  Supports the Power Reset Clock interface (PRCI) IP block found in
> -	  FU540 SoCs. If this kernel is meant to run on a SiFive FU540 SoC,
> -	  enable this driver.
> +	  FU540/FU740 SoCs. If this kernel is meant to run on a SiFive FU540/
> +	  FU740 SoCs, enable this driver.
>
>  endif
> diff --git a/drivers/clk/sifive/Makefile b/drivers/clk/sifive/Makefile
> index fe3e2cb4c4d8..2c05798e4ba4 100644
> --- a/drivers/clk/sifive/Makefile
> +++ b/drivers/clk/sifive/Makefile
> @@ -2,3 +2,4 @@
>  obj-y += sifive-prci.o
>
>  obj-$(CONFIG_CLK_SIFIVE_PRCI)	+= fu540-prci.o
> +obj-$(CONFIG_CLK_SIFIVE_PRCI)	+= fu740-prci.o
> diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
> new file mode 100644
> index 000000000000..3b87e273c3eb
> --- /dev/null
> +++ b/drivers/clk/sifive/fu740-prci.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018-2019 SiFive, Inc.
> + * Wesley Terpstra
> + * Paul Walmsley
> + * Zong Li

Presumably it's copyright 2020 as well, as that's the current year?  Also, IIUC
the copyright lines should be independent from each other.  In other words,
rather than


   C ... 2020 SiFive
   Zong

this should be 

   C ... 2020 SiFive
   C ... 2020 Zong

and the rest of this should be dropped in favor of the SPDX.

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <dt-bindings/clock/sifive-fu740-prci.h>
> +#include <linux/module.h>
> +#include "sifive-prci.h"
> +
> +/* PRCI integration data for each WRPLL instance */
> +
> +static struct __prci_wrpll_data __prci_corepll_data = {
> +	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
> +	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
> +	.disable_bypass = sifive_prci_coreclksel_use_final_corepll,
> +};
> +
> +static struct __prci_wrpll_data __prci_ddrpll_data = {
> +	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
> +};
> +
> +static struct __prci_wrpll_data __prci_gemgxlpll_data = {
> +	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
> +};
> +
> +static struct __prci_wrpll_data __prci_dvfscorepll_data = {
> +	.cfg0_offs = PRCI_DVFSCOREPLLCFG0_OFFSET,
> +	.enable_bypass = sifive_prci_corepllsel_use_corepll,
> +	.disable_bypass = sifive_prci_corepllsel_use_dvfscorepll,
> +};
> +
> +static struct __prci_wrpll_data __prci_hfpclkpll_data = {
> +	.cfg0_offs = PRCI_HFPCLKPLLCFG0_OFFSET,
> +	.enable_bypass = sifive_prci_hfpclkpllsel_use_hfclk,
> +	.disable_bypass = sifive_prci_hfpclkpllsel_use_hfpclkpll,
> +};
> +
> +static struct __prci_wrpll_data __prci_cltxpll_data = {
> +	.cfg0_offs = PRCI_CLTXPLLCFG0_OFFSET,
> +};
> +
> +/* Linux clock framework integration */
> +
> +static const struct clk_ops sifive_fu740_prci_wrpll_clk_ops = {
> +	.set_rate = sifive_prci_wrpll_set_rate,
> +	.round_rate = sifive_prci_wrpll_round_rate,
> +	.recalc_rate = sifive_prci_wrpll_recalc_rate,
> +};
> +
> +static const struct clk_ops sifive_fu740_prci_wrpll_ro_clk_ops = {
> +	.recalc_rate = sifive_prci_wrpll_recalc_rate,
> +};
> +
> +static const struct clk_ops sifive_fu740_prci_tlclksel_clk_ops = {
> +	.recalc_rate = sifive_prci_tlclksel_recalc_rate,
> +};
> +
> +static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
> +	.recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,
> +};
> +
> +/* List of clock controls provided by the PRCI */
> +struct __prci_clock __prci_init_clocks_fu740[] = {
> +	[PRCI_CLK_COREPLL] = {
> +		.name = "corepll",
> +		.parent_name = "hfclk",
> +		.ops = &sifive_fu740_prci_wrpll_clk_ops,
> +		.pwd = &__prci_corepll_data,
> +	},
> +	[PRCI_CLK_DDRPLL] = {
> +		.name = "ddrpll",
> +		.parent_name = "hfclk",
> +		.ops = &sifive_fu740_prci_wrpll_ro_clk_ops,
> +		.pwd = &__prci_ddrpll_data,
> +	},
> +	[PRCI_CLK_GEMGXLPLL] = {
> +		.name = "gemgxlpll",
> +		.parent_name = "hfclk",
> +		.ops = &sifive_fu740_prci_wrpll_clk_ops,
> +		.pwd = &__prci_gemgxlpll_data,
> +	},
> +	[PRCI_CLK_DVFSCOREPLL] = {
> +		.name = "dvfscorepll",
> +		.parent_name = "hfclk",
> +		.ops = &sifive_fu740_prci_wrpll_clk_ops,
> +		.pwd = &__prci_dvfscorepll_data,
> +	},
> +	[PRCI_CLK_HFPCLKPLL] = {
> +		.name = "hfpclkpll",
> +		.parent_name = "hfclk",
> +		.ops = &sifive_fu740_prci_wrpll_clk_ops,
> +		.pwd = &__prci_hfpclkpll_data,
> +	},
> +	[PRCI_CLK_CLTXPLL] = {
> +		.name = "cltxpll",
> +		.parent_name = "hfclk",
> +		.ops = &sifive_fu740_prci_wrpll_clk_ops,
> +		.pwd = &__prci_cltxpll_data,
> +	},
> +	[PRCI_CLK_TLCLK] = {
> +		.name = "tlclk",
> +		.parent_name = "corepll",
> +		.ops = &sifive_fu740_prci_tlclksel_clk_ops,
> +	},
> +	[PRCI_CLK_PCLK] = {
> +		.name = "pclk",
> +		.parent_name = "hfpclkpll",
> +		.ops = &sifive_fu740_prci_hfpclkplldiv_clk_ops,
> +	},
> +};
> diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
> new file mode 100644
> index 000000000000..13ef971f7764
> --- /dev/null
> +++ b/drivers/clk/sifive/fu740-prci.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 SiFive, Inc.
> + * Zong Li
> + */
> +
> +#ifndef __SIFIVE_CLK_FU740_PRCI_H
> +#define __SIFIVE_CLK_FU740_PRCI_H
> +
> +#include "sifive-prci.h"
> +
> +#define NUM_CLOCK_FU740	8
> +
> +extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
> +
> +static const struct prci_clk_desc prci_clk_fu740 = {
> +	.clks = __prci_init_clocks_fu740,
> +	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu740),
> +};
> +
> +#endif /* __SIFIVE_CLK_FU740_PRCI_H */
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> index 0ac729eeb71b..4098dbc5881a 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_device.h>
>  #include "sifive-prci.h"
>  #include "fu540-prci.h"
> +#include "fu740-prci.h"
>
>  /*
>   * Private functions
> @@ -242,6 +243,18 @@ unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
>  	return div_u64(parent_rate, div);
>  }
>
> +/* HFPCLK clock integration */
> +
> +unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct clk_hw *hw,
> +						   unsigned long parent_rate)
> +{
> +	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
> +	struct __prci_data *pd = pc->pd;
> +	u32 div = __prci_readl(pd, PRCI_HFPCLKPLLDIV_OFFSET);
> +
> +	return div_u64(parent_rate, div + 2);
> +}
> +
>  /*
>   * Core clock mux control
>   */
> @@ -287,6 +300,112 @@ void sifive_prci_coreclksel_use_corepll(struct __prci_data *pd)
>  	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);	/* barrier */
>  }
>
> +/**
> + * sifive_prci_coreclksel_use_final_corepll() - switch the CORECLK mux to output
> + * FINAL_COREPLL
> + * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
> + *
> + * Switch the CORECLK mux to the final COREPLL output clock; return once
> + * complete.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_CORECLKSEL_OFFSET register.
> + */
> +void sifive_prci_coreclksel_use_final_corepll(struct __prci_data *pd)
> +{
> +	u32 r;
> +
> +	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
> +	r &= ~PRCI_CORECLKSEL_CORECLKSEL_MASK;
> +	__prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
> +
> +	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);	/* barrier */
> +}
> +
> +/**
> + * sifive_prci_corepllsel_use_dvfscorepll() - switch the COREPLL mux to
> + * output DVFS_COREPLL
> + * @pd: struct __prci_data * for the PRCI containing the COREPLL mux reg
> + *
> + * Switch the COREPLL mux to the DVFSCOREPLL output clock; return once complete.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_COREPLLSEL_OFFSET register.
> + */
> +void sifive_prci_corepllsel_use_dvfscorepll(struct __prci_data *pd)
> +{
> +	u32 r;
> +
> +	r = __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);
> +	r |= PRCI_COREPLLSEL_COREPLLSEL_MASK;
> +	__prci_writel(r, PRCI_COREPLLSEL_OFFSET, pd);
> +
> +	r = __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);	/* barrier */
> +}
> +
> +/**
> + * sifive_prci_corepllsel_use_corepll() - switch the COREPLL mux to
> + * output COREPLL
> + * @pd: struct __prci_data * for the PRCI containing the COREPLL mux reg
> + *
> + * Switch the COREPLL mux to the COREPLL output clock; return once complete.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_COREPLLSEL_OFFSET register.
> + */
> +void sifive_prci_corepllsel_use_corepll(struct __prci_data *pd)
> +{
> +	u32 r;
> +
> +	r = __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);
> +	r &= ~PRCI_COREPLLSEL_COREPLLSEL_MASK;
> +	__prci_writel(r, PRCI_COREPLLSEL_OFFSET, pd);
> +
> +	r = __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);	/* barrier */
> +}
> +
> +/**
> + * sifive_prci_hfpclkpllsel_use_hfclk() - switch the HFPCLKPLL mux to
> + * output HFCLK
> + * @pd: struct __prci_data * for the PRCI containing the HFPCLKPLL mux reg
> + *
> + * Switch the HFPCLKPLL mux to the HFCLK input source; return once complete.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_HFPCLKPLLSEL_OFFSET register.
> + */
> +void sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd)
> +{
> +	u32 r;
> +
> +	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);
> +	r |= PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK;
> +	__prci_writel(r, PRCI_HFPCLKPLLSEL_OFFSET, pd);
> +
> +	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
> +}
> +
> +/**
> + * sifive_prci_hfpclkpllsel_use_hfpclkpll() - switch the HFPCLKPLL mux to
> + * output HFPCLKPLL
> + * @pd: struct __prci_data * for the PRCI containing the HFPCLKPLL mux reg
> + *
> + * Switch the HFPCLKPLL mux to the HFPCLKPLL output clock; return once complete.
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PRCI_HFPCLKPLLSEL_OFFSET register.
> + */
> +void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd)
> +{
> +	u32 r;
> +
> +	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);
> +	r &= ~PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK;
> +	__prci_writel(r, PRCI_HFPCLKPLLSEL_OFFSET, pd);
> +
> +	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
> +}
> +
>  /**
>   * __prci_register_clocks() - register clock controls in the PRCI
>   * @dev: Linux struct device *
> @@ -391,6 +510,7 @@ static int sifive_prci_probe(struct platform_device *pdev)
>
>  static const struct of_device_id sifive_prci_of_match[] = {
>  	{.compatible = "sifive,fu540-c000-prci", .data = &prci_clk_fu540},
> +	{.compatible = "sifive,fu740-c000-prci", .data = &prci_clk_fu740},
>  	{}
>  };
>
> diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
> index 025f717bc053..802fc8fb9c09 100644
> --- a/drivers/clk/sifive/sifive-prci.h
> +++ b/drivers/clk/sifive/sifive-prci.h
> @@ -117,6 +117,87 @@
>  #define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_MASK			\
>  		(0x1 << PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT)
>
> +/* CLTXPLLCFG0 */
> +#define PRCI_CLTXPLLCFG0_OFFSET		0x30
> +#define PRCI_CLTXPLLCFG0_DIVR_SHIFT	0
> +#define PRCI_CLTXPLLCFG0_DIVR_MASK	(0x3f << PRCI_CLTXPLLCFG0_DIVR_SHIFT)
> +#define PRCI_CLTXPLLCFG0_DIVF_SHIFT	6
> +#define PRCI_CLTXPLLCFG0_DIVF_MASK	(0x1ff << PRCI_CLTXPLLCFG0_DIVF_SHIFT)
> +#define PRCI_CLTXPLLCFG0_DIVQ_SHIFT	15
> +#define PRCI_CLTXPLLCFG0_DIVQ_MASK	(0x7 << PRCI_CLTXPLLCFG0_DIVQ_SHIFT)
> +#define PRCI_CLTXPLLCFG0_RANGE_SHIFT	18
> +#define PRCI_CLTXPLLCFG0_RANGE_MASK	(0x7 << PRCI_CLTXPLLCFG0_RANGE_SHIFT)
> +#define PRCI_CLTXPLLCFG0_BYPASS_SHIFT	24
> +#define PRCI_CLTXPLLCFG0_BYPASS_MASK	(0x1 << PRCI_CLTXPLLCFG0_BYPASS_SHIFT)
> +#define PRCI_CLTXPLLCFG0_FSE_SHIFT	25
> +#define PRCI_CLTXPLLCFG0_FSE_MASK	(0x1 << PRCI_CLTXPLLCFG0_FSE_SHIFT)
> +#define PRCI_CLTXPLLCFG0_LOCK_SHIFT	31
> +#define PRCI_CLTXPLLCFG0_LOCK_MASK	(0x1 << PRCI_CLTXPLLCFG0_LOCK_SHIFT)
> +
> +/* CLTXPLLCFG1 */
> +#define PRCI_CLTXPLLCFG1_OFFSET		0x34
> +#define PRCI_CLTXPLLCFG1_CKE_SHIFT	31
> +#define PRCI_CLTXPLLCFG1_CKE_MASK	(0x1 << PRCI_CLTXPLLCFG1_CKE_SHIFT)
> +
> +/* DVFSCOREPLLCFG0 */
> +#define PRCI_DVFSCOREPLLCFG0_OFFSET	0x38
> +
> +/* DVFSCOREPLLCFG1 */
> +#define PRCI_DVFSCOREPLLCFG1_OFFSET	0x3c
> +#define PRCI_DVFSCOREPLLCFG1_CKE_SHIFT	31
> +#define PRCI_DVFSCOREPLLCFG1_CKE_MASK	(0x1 << PRCI_DVFSCOREPLLCFG1_CKE_SHIFT)
> +
> +/* COREPLLSEL */
> +#define PRCI_COREPLLSEL_OFFSET			0x40
> +#define PRCI_COREPLLSEL_COREPLLSEL_SHIFT	0
> +#define PRCI_COREPLLSEL_COREPLLSEL_MASK					\
> +		(0x1 << PRCI_COREPLLSEL_COREPLLSEL_SHIFT)
> +
> +/* HFPCLKPLLCFG0 */
> +#define PRCI_HFPCLKPLLCFG0_OFFSET		0x50
> +#define PRCI_HFPCLKPLL_CFG0_DIVR_SHIFT		0
> +#define PRCI_HFPCLKPLL_CFG0_DIVR_MASK					\
> +		(0x3f << PRCI_HFPCLKPLLCFG0_DIVR_SHIFT)
> +#define PRCI_HFPCLKPLL_CFG0_DIVF_SHIFT		6
> +#define PRCI_HFPCLKPLL_CFG0_DIVF_MASK					\
> +		(0x1ff << PRCI_HFPCLKPLLCFG0_DIVF_SHIFT)
> +#define PRCI_HFPCLKPLL_CFG0_DIVQ_SHIFT		15
> +#define PRCI_HFPCLKPLL_CFG0_DIVQ_MASK					\
> +		(0x7 << PRCI_HFPCLKPLLCFG0_DIVQ_SHIFT)
> +#define PRCI_HFPCLKPLL_CFG0_RANGE_SHIFT		18
> +#define PRCI_HFPCLKPLL_CFG0_RANGE_MASK					\
> +		(0x7 << PRCI_HFPCLKPLLCFG0_RANGE_SHIFT)
> +#define PRCI_HFPCLKPLL_CFG0_BYPASS_SHIFT	24
> +#define PRCI_HFPCLKPLL_CFG0_BYPASS_MASK					\
> +		(0x1 << PRCI_HFPCLKPLLCFG0_BYPASS_SHIFT)
> +#define PRCI_HFPCLKPLL_CFG0_FSE_SHIFT		25
> +#define PRCI_HFPCLKPLL_CFG0_FSE_MASK					\
> +		(0x1 << PRCI_HFPCLKPLLCFG0_FSE_SHIFT)
> +#define PRCI_HFPCLKPLL_CFG0_LOCK_SHIFT		31
> +#define PRCI_HFPCLKPLL_CFG0_LOCK_MASK					\
> +		(0x1 << PRCI_HFPCLKPLLCFG0_LOCK_SHIFT)
> +
> +/* HFPCLKPLLCFG1 */
> +#define PRCI_HFPCLKPLLCFG1_OFFSET		0x54
> +#define PRCI_HFPCLKPLLCFG1_CKE_SHIFT		31
> +#define PRCI_HFPCLKPLLCFG1_CKE_MASK					\
> +		(0x1 << PRCI_HFPCLKPLLCFG1_CKE_SHIFT)
> +
> +/* HFPCLKPLLSEL */
> +#define PRCI_HFPCLKPLLSEL_OFFSET		0x58
> +#define PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_SHIFT	0
> +#define PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK				\
> +		(0x1 << PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_SHIFT)
> +
> +/* HFPCLKPLLDIV */
> +#define PRCI_HFPCLKPLLDIV_OFFSET		0x5c
> +
> +/* PRCIPLL */
> +#define PRCI_PRCIPLL_OFFSET			0xe0
> +
> +/* PROCMONCFG */
> +#define PRCI_PROCMONCFG_OFFSET			0xf0
> +
>  /*
>   * Private structures
>   */
> @@ -187,6 +268,11 @@ struct prci_clk_desc {
>  /* Core clock mux control */
>  void sifive_prci_coreclksel_use_hfclk(struct __prci_data *pd);
>  void sifive_prci_coreclksel_use_corepll(struct __prci_data *pd);
> +void sifive_prci_coreclksel_use_final_corepll(struct __prci_data *pd);
> +void sifive_prci_corepllsel_use_dvfscorepll(struct __prci_data *pd);
> +void sifive_prci_corepllsel_use_corepll(struct __prci_data *pd);
> +void sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd);
> +void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd);
>
>  /* Linux clock framework integration */
>  long sifive_prci_wrpll_round_rate(struct clk_hw *hw, unsigned long rate,
> @@ -197,5 +283,7 @@ unsigned long sifive_prci_wrpll_recalc_rate(struct clk_hw *hw,
>  					    unsigned long parent_rate);
>  unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
>  					       unsigned long parent_rate);
> +unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct clk_hw *hw,
> +						   unsigned long parent_rate);
>
>  #endif /* __SIFIVE_CLK_SIFIVE_PRCI_H */
> diff --git a/include/dt-bindings/clock/sifive-fu740-prci.h b/include/dt-bindings/clock/sifive-fu740-prci.h
> new file mode 100644
> index 000000000000..cd7706ea5677
> --- /dev/null
> +++ b/include/dt-bindings/clock/sifive-fu740-prci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (C) 2019 SiFive, Inc.
> + * Wesley Terpstra
> + * Paul Walmsley
> + * Zong Li
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H
> +#define __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H
> +
> +/* Clock indexes for use by Device Tree data and the PRCI driver */
> +
> +#define PRCI_CLK_COREPLL	       0
> +#define PRCI_CLK_DDRPLL		       1
> +#define PRCI_CLK_GEMGXLPLL	       2
> +#define PRCI_CLK_DVFSCOREPLL	       3
> +#define PRCI_CLK_HFPCLKPLL	       4
> +#define PRCI_CLK_CLTXPLL	       5
> +#define PRCI_CLK_TLCLK		       6
> +#define PRCI_CLK_PCLK		       7
> +
> +#endif	/* __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H */
