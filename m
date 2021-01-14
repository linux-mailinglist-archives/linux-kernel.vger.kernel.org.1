Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700AD2F6221
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbhANNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:37:34 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10923 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbhANNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610631453; x=1642167453;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pUYVCmrE+llwxZcJw7gxheQUOmoTu0/q2e3wa4sS/Zw=;
  b=Wwks1VbVhPoufw/YDCfY17CeXKG1vFW5p/rhwulLh55wIAl0HYqILleB
   XcLCQ7Z9fCURNzyBKhqyEYWeItdigTSboqfRbnnuFkV3dPUyTwskAYSWG
   LTFu+sizwl5LjsMqf1vi2KSl0y+qXVpV4vWuNWnTzhqUYca+vbQ5inQQR
   LY/UuAUuGNYoMfPyH5eLP7RQMbRRzfYdfMlXWhz1cLdIkiP7rYzKAvU3O
   d1j1U/m+as5JfWVMptLOFREk/FkuAdxRvWMZfaBeAMCQW+DOz8NXUuque
   84/7GUm0rIG3yCxl8cJU/FnhaTHkF0uU5EhBhVKc1JtaLbePqa/QdnVMJ
   A==;
IronPort-SDR: gjupmsIqQwLQSqG6VuW55tUMyJhgN12/qI2pbnwkIi+/TloFbM8w8pgxjiibA0Hns8qeU+3SZ7
 +ZRnbDC0wg2dYiXLAHaTuN7cTHxI8TiNCv9SSoK+kcxC/s77YLrES0ULcrwneXkb8+33uPwcbB
 Rmzj2beLNou43fy1jXwLH0MAWkcFIOPrdilhSlLsxvsdNuRt+jlzJZWJ+BwBi4LBDcDmfjDF47
 je38HFYJPrqdvCjJVyNLwsArIuw5g/TBpkV/hhEdWrqaHXTCXQdZq1CQbF8hFLzYPdIDeggsGd
 PAM=
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="105969549"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 06:36:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 06:36:17 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 06:36:15 -0700
Message-ID: <5e1f816b28938d531dccb216c193639c33194d8a.camel@microchip.com>
Subject: Re: [PATCH 2/3] reset: mchp: sparx5: add switch reset driver
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 14 Jan 2021 14:36:15 +0100
In-Reply-To: <3d02a239e485287884e23105376dcab2b5dc800e.camel@pengutronix.de>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
         <20210113201915.2734205-3-steen.hegelund@microchip.com>
         <3d02a239e485287884e23105376dcab2b5dc800e.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Thu, 2021-01-14 at 10:39 +0100, Philipp Zabel wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> Hi Steen,
> 
> thank you for the patch. In addition to Andrew's comments, I have a
> few
> more below:
> 
> On Wed, 2021-01-13 at 21:19 +0100, Steen Hegelund wrote:
> > Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> > ---
> >  drivers/reset/Kconfig                  |   8 ++
> >  drivers/reset/Makefile                 |   1 +
> >  drivers/reset/reset-microchip-sparx5.c | 145
> > +++++++++++++++++++++++++
> >  3 files changed, 154 insertions(+)
> >  create mode 100644 drivers/reset/reset-microchip-sparx5.c
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 71ab75a46491..05c240c47a8a 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -101,6 +101,14 @@ config RESET_LPC18XX
> >       help
> >         This enables the reset controller driver for NXP
> > LPC18xx/43xx SoCs.
> > 
> > +config RESET_MCHP_SPARX5
> > +     bool "Microchip Sparx5 reset driver"
> > +     depends on HAS_IOMEM || COMPILE_TEST
> > +     default y if SPARX5_SWITCH
> > +     select MFD_SYSCON
> > +     help
> > +       This driver supports switch core reset for the Microchip
> > Sparx5 SoC.
> > +
> >  config RESET_MESON
> >       tristate "Meson Reset Driver"
> >       depends on ARCH_MESON || COMPILE_TEST
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index 1054123fd187..341fd9ab4bf6 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> >  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> >  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> >  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
> > +obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
> >  obj-$(CONFIG_RESET_MESON) += reset-meson.o
> >  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
> >  obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
> > diff --git a/drivers/reset/reset-microchip-sparx5.c
> > b/drivers/reset/reset-microchip-sparx5.c
> > new file mode 100644
> > index 000000000000..bb636ebd22d2
> > --- /dev/null
> > +++ b/drivers/reset/reset-microchip-sparx5.c
> > @@ -0,0 +1,145 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Microchip Sparx5 Switch Reset driver
> > + *
> > + * Copyright (c) 2020 Microchip Technology Inc. and its
> > subsidiaries.
> > + *
> > + * The Sparx5 Chip Register Model can be browsed at this location:
> > + * https://github.com/microchip-ung/sparx-5_reginfo
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/notifier.h>
> 
> Please drop all unused headers.

Will do.

> 
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset-controller.h>
> > +
> > +#define PROTECT_REG    0x84
> > +#define PROTECT_BIT    BIT(10)
> > +#define SOFT_RESET_REG 0x08
> > +#define SOFT_RESET_BIT BIT(1)
> > +
> > +struct mchp_reset_context {
> > +     struct device *dev;
> > +     struct regmap *cpu_ctrl;
> > +     struct regmap *gcb_ctrl;
> > +     struct reset_controller_dev reset_ctrl;
> 
> For consistency, I'd like this to be called rcdev, or something else
> that doesn't sound like this should be a struct reset_control.

OK.  

> 
> > +};
> > +
> > +static u32 sparx5_read_soft_rst(struct mchp_reset_context *ctx)
> > +{
> > +     u32 val;
> > +
> > +     regmap_read(ctx->gcb_ctrl, SOFT_RESET_REG, &val);
> > +     return val;
> > +}
> 
> This can be dropped if you use regmap_read_poll_timeout() below.

Yes.

> 
> > +static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
> > +                                   unsigned long id)
> > +{
> > +     struct mchp_reset_context *ctx =
> > +             container_of(rcdev, struct mchp_reset_context,
> > reset_ctrl);
> > +     u32 val;
> > +
> > +     /* Make sure the core is PROTECTED from reset */
> > +     regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT,
> > PROTECT_BIT);
> > +
> > +     dev_info(ctx->dev, "soft reset of switchcore\n");
> > +
> > +     /* Start soft reset */
> > +     regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
> > +
> > +     /* Wait for soft reset done */
> > +     return read_poll_timeout(sparx5_read_soft_rst, val,
> > +                              (val & SOFT_RESET_BIT) == 0,
> > +                              1, 100, false,
> > +                              ctx);
> 
> This looks like you could use regmap_read_poll_timeout() here.

Yes - did not remember that function...
> 
> > +}
> > +
> > +static const struct reset_control_ops sparx5_reset_ops = {
> > +     .reset = sparx5_switch_reset,
> > +};
> > +
> > +static int mchp_sparx5_reset_config(struct platform_device *pdev,
> > +                                 struct mchp_reset_context *ctx)
> > +{
> > +     struct device_node *dn = pdev->dev.of_node;
> > +     struct regmap *cpu_ctrl, *gcb_ctrl;
> > +     struct device_node *syscon_np;
> > +     int err;
> > +
> > +     syscon_np = of_parse_phandle(dn, "syscons", 0);
> > +     if (!syscon_np)
> > +             return -ENODEV;
> > +     cpu_ctrl = syscon_node_to_regmap(syscon_np);
> > +     if (IS_ERR(cpu_ctrl))
> > +             goto err_cpu;
> > +     of_node_put(syscon_np);
> 
> If you move the of_node_put() up before the IS_ERR() check, you don't
> have to repeat it at the err_cpu: label. In fact, if you also move
> the
> error message up here, you can return here and drop the label.

Yes.  I will change this.

> 
> > +
> > +     syscon_np = of_parse_phandle(dn, "syscons", 1);
> > +     if (!syscon_np)
> > +             return -ENODEV;
> > +     gcb_ctrl = syscon_node_to_regmap(syscon_np);
> > +     if (IS_ERR(gcb_ctrl))
> > +             goto err_gcb;
> > +     of_node_put(syscon_np);
> 
> Same as above.

Yes.

> 
> > +
> > +     ctx->cpu_ctrl = cpu_ctrl;
> > +     ctx->gcb_ctrl = gcb_ctrl;
> > +
> > +     ctx->reset_ctrl.owner = THIS_MODULE;
> > +     ctx->reset_ctrl.nr_resets = 1;
> > +     ctx->reset_ctrl.ops = &sparx5_reset_ops;
> > +     ctx->reset_ctrl.of_node = dn;
> > +
> > +     err = devm_reset_controller_register(&pdev->dev, &ctx-
> > >reset_ctrl);
> > +     if (err)
> > +             dev_err(&pdev->dev, "could not register reset
> > controller\n");
> > +     pr_info("%s:%d\n", __func__, __LINE__);
> > +     return err;
> 
> The only reason devm_reset_controller_register() can fail
> unexpectedly is -ENOMEM. I think it would be fine to just
> return devm_reset_controller_regster() here.

OK - simpler => nicer

> 
> > +err_cpu:
> > +     of_node_put(syscon_np);
> > +     dev_err(&pdev->dev, "No cpu syscon map\n");
> > +     return PTR_ERR(cpu_ctrl);
> > +err_gcb:
> > +     of_node_put(syscon_np);
> > +     dev_err(&pdev->dev, "No gcb syscon map\n");
> > +     return PTR_ERR(gcb_ctrl);
> > +}
> > +
> > +static int mchp_sparx5_reset_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct mchp_reset_context *ctx;
> > +
> > +     pr_info("%s:%d\n", __func__, __LINE__);
> > +     ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +     if (!ctx)
> > +             return -ENOMEM;
> > +     ctx->dev = dev;
> > +     return mchp_sparx5_reset_config(pdev, ctx);
> > +}
> 
> You could fold the contents of mchp_sparx5_reset_config() into
> mchp_sparx5_reset_probe() and replace all &pdev->dev with dev.

Yes.  I will change that.

> 
> regards
> Philipp

Thanks for your comments.

BR
Steen

