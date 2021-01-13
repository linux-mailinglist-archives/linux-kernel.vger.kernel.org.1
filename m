Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC78C2F579A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbhANCCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:02:18 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39162 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbhAMXYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:24:42 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kzpUT-000Qg1-4B; Thu, 14 Jan 2021 00:23:49 +0100
Date:   Thu, 14 Jan 2021 00:23:49 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] reset: mchp: sparx5: add switch reset driver
Message-ID: <X/+BBaYqLciJ5PsA@lunn.ch>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
 <20210113201915.2734205-3-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113201915.2734205-3-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

dev_dbg()?

> +
> +	/* Start soft reset */
> +	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
> +
> +	/* Wait for soft reset done */
> +	return read_poll_timeout(sparx5_read_soft_rst, val,
> +				 (val & SOFT_RESET_BIT) == 0,
> +				 1, 100, false,
> +				 ctx);
> +}

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
> +
> +	syscon_np = of_parse_phandle(dn, "syscons", 1);
> +	if (!syscon_np)
> +		return -ENODEV;
> +	gcb_ctrl = syscon_node_to_regmap(syscon_np);
> +	if (IS_ERR(gcb_ctrl))
> +		goto err_gcb;
> +	of_node_put(syscon_np);
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
> +err_cpu:
> +	of_node_put(syscon_np);
> +	dev_err(&pdev->dev, "No cpu syscon map\n");
> +	return PTR_ERR(cpu_ctrl);
> +err_gcb:
> +	of_node_put(syscon_np);
> +	dev_err(&pdev->dev, "No gcb syscon map\n");
> +	return PTR_ERR(gcb_ctrl);

It would be normal to put the dev_err() before the goto, set err =
PTR_ERR() and then goto out;


> +}
> +
> +static int mchp_sparx5_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mchp_reset_context *ctx;
> +
> +	pr_info("%s:%d\n", __func__, __LINE__);

More left over debug.

> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	ctx->dev = dev;
> +	return mchp_sparx5_reset_config(pdev, ctx);
> +}
> +
> +static const struct of_device_id mchp_sparx5_reset_of_match[] = {
> +	{
> +		.compatible = "microchip,sparx5-switch-reset",
> +	},
> +	{ /*sentinel*/ }
> +};

> +static int __init mchp_sparx5_reset_init(void)
> +{
> +	return platform_driver_register(&mchp_sparx5_reset_driver);
> +}
> +
> +postcore_initcall(mchp_sparx5_reset_init);

Does it actually need to be postcore? The users of the reset should
look for -EPROBE_DEFER and try again later. And this then becomes just
a normal driver.

  Andrew
