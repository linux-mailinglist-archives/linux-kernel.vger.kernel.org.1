Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022C12F5DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbhANJkD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jan 2021 04:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbhANJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:39:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3DDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:39:25 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kzz66-00042x-Pv; Thu, 14 Jan 2021 10:39:18 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kzz66-0003kZ-6g; Thu, 14 Jan 2021 10:39:18 +0100
Message-ID: <3d02a239e485287884e23105376dcab2b5dc800e.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] reset: mchp: sparx5: add switch reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 14 Jan 2021 10:39:18 +0100
In-Reply-To: <20210113201915.2734205-3-steen.hegelund@microchip.com>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
         <20210113201915.2734205-3-steen.hegelund@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steen,

thank you for the patch. In addition to Andrew's comments, I have a few
more below:

On Wed, 2021-01-13 at 21:19 +0100, Steen Hegelund wrote:
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  drivers/reset/Kconfig                  |   8 ++
>  drivers/reset/Makefile                 |   1 +
>  drivers/reset/reset-microchip-sparx5.c | 145 +++++++++++++++++++++++++
>  3 files changed, 154 insertions(+)
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
> index 000000000000..bb636ebd22d2
> --- /dev/null
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Microchip Sparx5 Switch Reset driver
> + *
> + * Copyright (c) 2020 Microchip Technology Inc. and its subsidiaries.
> + *
> + * The Sparx5 Chip Register Model can be browsed at this location:
> + * https://github.com/microchip-ung/sparx-5_reginfo
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/notifier.h>

Please drop all unused headers.

> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
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
> +	struct device *dev;
> +	struct regmap *cpu_ctrl;
> +	struct regmap *gcb_ctrl;
> +	struct reset_controller_dev reset_ctrl;

For consistency, I'd like this to be called rcdev, or something else
that doesn't sound like this should be a struct reset_control.

> +};
> +
> +static u32 sparx5_read_soft_rst(struct mchp_reset_context *ctx)
> +{
> +	u32 val;
> +
> +	regmap_read(ctx->gcb_ctrl, SOFT_RESET_REG, &val);
> +	return val;
> +}

This can be dropped if you use regmap_read_poll_timeout() below.

> +static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
> +				      unsigned long id)
> +{
> +	struct mchp_reset_context *ctx =
> +		container_of(rcdev, struct mchp_reset_context, reset_ctrl);
> +	u32 val;
> +
> +	/* Make sure the core is PROTECTED from reset */
> +	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
> +
> +	dev_info(ctx->dev, "soft reset of switchcore\n");
> +
> +	/* Start soft reset */
> +	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
> +
> +	/* Wait for soft reset done */
> +	return read_poll_timeout(sparx5_read_soft_rst, val,
> +				 (val & SOFT_RESET_BIT) == 0,
> +				 1, 100, false,
> +				 ctx);

This looks like you could use regmap_read_poll_timeout() here.

> +}
> +
> +static const struct reset_control_ops sparx5_reset_ops = {
> +	.reset = sparx5_switch_reset,
> +};
> +
> +static int mchp_sparx5_reset_config(struct platform_device *pdev,
> +				    struct mchp_reset_context *ctx)
> +{
> +	struct device_node *dn = pdev->dev.of_node;
> +	struct regmap *cpu_ctrl, *gcb_ctrl;
> +	struct device_node *syscon_np;
> +	int err;
> +
> +	syscon_np = of_parse_phandle(dn, "syscons", 0);
> +	if (!syscon_np)
> +		return -ENODEV;
> +	cpu_ctrl = syscon_node_to_regmap(syscon_np);
> +	if (IS_ERR(cpu_ctrl))
> +		goto err_cpu;
> +	of_node_put(syscon_np);

If you move the of_node_put() up before the IS_ERR() check, you don't
have to repeat it at the err_cpu: label. In fact, if you also move the
error message up here, you can return here and drop the label.

> +
> +	syscon_np = of_parse_phandle(dn, "syscons", 1);
> +	if (!syscon_np)
> +		return -ENODEV;
> +	gcb_ctrl = syscon_node_to_regmap(syscon_np);
> +	if (IS_ERR(gcb_ctrl))
> +		goto err_gcb;
> +	of_node_put(syscon_np);

Same as above.

> +
> +	ctx->cpu_ctrl = cpu_ctrl;
> +	ctx->gcb_ctrl = gcb_ctrl;
> +
> +	ctx->reset_ctrl.owner = THIS_MODULE;
> +	ctx->reset_ctrl.nr_resets = 1;
> +	ctx->reset_ctrl.ops = &sparx5_reset_ops;
> +	ctx->reset_ctrl.of_node = dn;
> +
> +	err = devm_reset_controller_register(&pdev->dev, &ctx->reset_ctrl);
> +	if (err)
> +		dev_err(&pdev->dev, "could not register reset controller\n");
> +	pr_info("%s:%d\n", __func__, __LINE__);
> +	return err;

The only reason devm_reset_controller_register() can fail
unexpectedly is -ENOMEM. I think it would be fine to just
return devm_reset_controller_regster() here.

> +err_cpu:
> +	of_node_put(syscon_np);
> +	dev_err(&pdev->dev, "No cpu syscon map\n");
> +	return PTR_ERR(cpu_ctrl);
> +err_gcb:
> +	of_node_put(syscon_np);
> +	dev_err(&pdev->dev, "No gcb syscon map\n");
> +	return PTR_ERR(gcb_ctrl);
> +}
> +
> +static int mchp_sparx5_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mchp_reset_context *ctx;
> +
> +	pr_info("%s:%d\n", __func__, __LINE__);
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	ctx->dev = dev;
> +	return mchp_sparx5_reset_config(pdev, ctx);
> +}

You could fold the contents of mchp_sparx5_reset_config() into
mchp_sparx5_reset_probe() and replace all &pdev->dev with dev.

regards
Philipp
