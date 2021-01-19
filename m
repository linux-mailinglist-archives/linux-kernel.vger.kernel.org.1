Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2D2FC14F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbhASUkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:40:10 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54711 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbhASUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:37:58 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7A695C0006;
        Tue, 19 Jan 2021 20:37:10 +0000 (UTC)
Date:   Tue, 19 Jan 2021 21:37:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] reset: mchp: sparx5: add switch reset driver
Message-ID: <20210119203710.GP3666@piout.net>
References: <20210114162432.3039657-1-steen.hegelund@microchip.com>
 <20210114162432.3039657-3-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114162432.3039657-3-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This commit is also missing a commit message and you could probably get
some info from your cover letter here.

On 14/01/2021 17:24:31+0100, Steen Hegelund wrote:
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  drivers/reset/Kconfig                  |   8 ++
>  drivers/reset/Makefile                 |   1 +
>  drivers/reset/reset-microchip-sparx5.c | 120 +++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/reset/reset-microchip-sparx5.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 71ab75a46491..05c240c47a8a 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -101,6 +101,14 @@ config RESET_LPC18XX
>  	help
>  	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
>  
> +config RESET_MCHP_SPARX5
> +	bool "Microchip Sparx5 reset driver"
> +	depends on HAS_IOMEM || COMPILE_TEST
> +	default y if SPARX5_SWITCH
> +	select MFD_SYSCON
> +	help
> +	  This driver supports switch core reset for the Microchip Sparx5 SoC.
> +
>  config RESET_MESON
>  	tristate "Meson Reset Driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 1054123fd187..341fd9ab4bf6 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
> +obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>  obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
> new file mode 100644
> index 000000000000..0dbd2b6161ef
> --- /dev/null
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Microchip Sparx5 Switch Reset driver
> + *
> + * Copyright (c) 2020 Microchip Technology Inc. and its subsidiaries.
> + *
> + * The Sparx5 Chip Register Model can be browsed at this location:
> + * https://github.com/microchip-ung/sparx-5_reginfo
> + */
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#define PROTECT_REG    0x84
> +#define PROTECT_BIT    BIT(10)
> +#define SOFT_RESET_REG 0x08
> +#define SOFT_RESET_BIT BIT(1)
> +
> +struct mchp_reset_context {
> +	struct regmap *cpu_ctrl;
> +	struct regmap *gcb_ctrl;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct mchp_reset_context *ctx =
> +		container_of(rcdev, struct mchp_reset_context, rcdev);
> +	u32 val;
> +

I would ensure the reset only happens once here else I'm not sure how
you could do it from the individual drivers.

> +	/* Make sure the core is PROTECTED from reset */
> +	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
> +
> +	/* Start soft reset */
> +	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
> +
> +	/* Wait for soft reset done */
> +	return regmap_read_poll_timeout(ctx->gcb_ctrl, SOFT_RESET_REG, val,
> +					(val & SOFT_RESET_BIT) == 0,
> +					1, 100);
> +}
> +

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
