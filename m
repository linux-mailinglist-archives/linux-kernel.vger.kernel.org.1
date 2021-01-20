Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F872FCC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbhATH5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:57:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:65513 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbhATHzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611129315; x=1642665315;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CkJlVqbpTdtd3JsrnDe3dxd7i0LW5V/8b1MPHc1MloE=;
  b=cP71WjV/uopzGBBxgFPdjZOXQifHDIB4rdawjhdMjAqspMm0zzlD4Qqh
   8ipTNm4mIBYAi2BwPeMpxBBQ52kwkL3pJ1FLd4czEjKfq+Czuyuqly5Sv
   BvefHaXt9lTYua/8XjPc5LbGTBThC8FVlX+Kg5F/zevTUwCqsE4dURD/R
   bwqHs7ip89M3r6obYc3DZsebCDBHpT9RpW/Zp5o9BqY1uZWVxlkoH6WUs
   /v4pNGwB/a0waCkPWS6VABatP9gc0tXDx99Mt8sugmkatxGr5LElkMg3q
   apm6w485KfR0/0F63+2UQXxIjSdWywXHBaDUXoFghsG/YUveKDVAA+8F8
   g==;
IronPort-SDR: 5L4e+3f5IHLLmjeVKrCD6oJh2Qe9uwwzg3q2GVCSdU0Lw6yjuNNsO804KsXyMQ0Wl2K9yQnv9p
 pu7x+rFaIeJ921Ti+MMy0nUCrCV2gy5qgCcaxfwR2PzLK5qKnIG1IopVkGfT4O5SIAEriQ3YGH
 EoymU9wBqjerAJnMoVUqKebs/u0GZ19pXjz4gOFwSSqTHi4F9yQOVTqXgtcKzMPmK2SccS14QB
 eJTxy+lyvzQBik3XvNpLdrbXNxBilqVsSAPzbDh3SAVEeKy3XHW1ZoRQDe0+xRHorvjaDJ9E2M
 A/E=
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="106599413"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 00:53:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 00:53:56 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 20 Jan 2021 00:53:54 -0700
Message-ID: <a3f079e05e5175929298dcfc3dc0ef1172bcf08c.camel@microchip.com>
Subject: Re: [PATCH v3 2/3] reset: mchp: sparx5: add switch reset driver
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 20 Jan 2021 08:53:53 +0100
In-Reply-To: <20210119203710.GP3666@piout.net>
References: <20210114162432.3039657-1-steen.hegelund@microchip.com>
         <20210114162432.3039657-3-steen.hegelund@microchip.com>
         <20210119203710.GP3666@piout.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, 2021-01-19 at 21:37 +0100, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> Hi,
> 
> This commit is also missing a commit message and you could probably
> get
> some info from your cover letter here.

I will do that.

> 
> On 14/01/2021 17:24:31+0100, Steen Hegelund wrote:
> > Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> > ---
> >  drivers/reset/Kconfig                  |   8 ++
> >  drivers/reset/Makefile                 |   1 +
> >  drivers/reset/reset-microchip-sparx5.c | 120
> > +++++++++++++++++++++++++
> >  3 files changed, 129 insertions(+)
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
> > index 000000000000..0dbd2b6161ef
> > --- /dev/null
> > +++ b/drivers/reset/reset-microchip-sparx5.c
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Microchip Sparx5 Switch Reset driver
> > + *
> > + * Copyright (c) 2020 Microchip Technology Inc. and its
> > subsidiaries.
> > + *
> > + * The Sparx5 Chip Register Model can be browsed at this location:
> > + * https://github.com/microchip-ung/sparx-5_reginfo
> > + */
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_device.h>
> > +#include <linux/module.h>
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
> > +     struct regmap *cpu_ctrl;
> > +     struct regmap *gcb_ctrl;
> > +     struct reset_controller_dev rcdev;
> > +};
> > +
> > +static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
> > +                            unsigned long id)
> > +{
> > +     struct mchp_reset_context *ctx =
> > +             container_of(rcdev, struct mchp_reset_context,
> > rcdev);
> > +     u32 val;
> > +
> 
> I would ensure the reset only happens once here else I'm not sure how
> you could do it from the individual drivers.

The framework handles that automatically.

> 
> > +     /* Make sure the core is PROTECTED from reset */
> > +     regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT,
> > PROTECT_BIT);
> > +
> > +     /* Start soft reset */
> > +     regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
> > +
> > +     /* Wait for soft reset done */
> > +     return regmap_read_poll_timeout(ctx->gcb_ctrl,
> > SOFT_RESET_REG, val,
> > +                                     (val & SOFT_RESET_BIT) == 0,
> > +                                     1, 100);
> > +}
> > +
> 
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Thanks for your comments
BR
Steen

