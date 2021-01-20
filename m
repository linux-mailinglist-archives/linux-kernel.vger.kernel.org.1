Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701402FCFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbhATLod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbhATLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:30:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F8C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:29:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ox12so8730413ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnrsVN//TIDOcnqF0pVgvunmK8pcB8N7qzTibSW7EHY=;
        b=JB7Q45Vm5TnatPGmRZnE8my5FmRJrit9/G7o7mjhzL8mlJskEsbgwhOpGa8OAJJDqe
         zW0T+E614flsWHgr7F9Gb2ne9Z3iiaZrm++DMjzdz6vfhH5KSxWkm9orI8r/815u+Tdw
         amkyO+4S+Fh2vpwkZZPfOxtuK8tmaet88pBUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnrsVN//TIDOcnqF0pVgvunmK8pcB8N7qzTibSW7EHY=;
        b=USi3a6JcTghNVxumFOqnyQPwTpWMCIY+Kw4mYI6QTiUSxudlVwTDzV3ceaLLk7hzZo
         Btr6I2fayUKzv8cQpYQsMLNMVvsKWWgxRYVolepg5bZ+WKE5/xu0riNONNYXH9zOuNe3
         3TiqavFbCFU8x90Y0ebL9T2er9bcpBosKr8EQhRvFOpXn0lkCADWWxEjqNtbhPeXP90g
         k38DfgRw/r6RguU9j3ZQ4/spp+LZOHjrCUjT7QO3OE2qAqwfpLGx/C5AzTTJAZZfGpKn
         fs+vP7E4w/frLaZVsuniXdlUs5PeMhrWYa6ZdWjR9cbqdVpISr9uj0jEJ77pIPRBx5HE
         0N3w==
X-Gm-Message-State: AOAM531VhJ3IDIcacBUU7TtH8MyXEDQgiMbDVcD6Pp2kbTyKW1nagGAd
        EKxZfQKKlfDHhiTc0EVWpZ7dvu1JeKrVi5Fwwc/jKA==
X-Google-Smtp-Source: ABdhPJzAbLp4INPMAcsyfkRAqwizY/CO/4q0V/3iUT61bS+XgGHJ+/Ksm6ZZQpFvuwqsV25Er9DMKN7Y09w6/wEp/Z0=
X-Received: by 2002:a17:906:690:: with SMTP id u16mr5963090ejb.186.1611142179473;
 Wed, 20 Jan 2021 03:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20210120112158.62109-1-jagan@amarulasolutions.com>
 <20210120112158.62109-2-jagan@amarulasolutions.com> <CAOf5uwnn0-89-hBDE3DTXACdTJG6u7jswAP9zfa=UiUeAz2ewA@mail.gmail.com>
In-Reply-To: <CAOf5uwnn0-89-hBDE3DTXACdTJG6u7jswAP9zfa=UiUeAz2ewA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 20 Jan 2021 16:59:28 +0530
Message-ID: <CAMty3ZAFUyoSAZXkcjs86_Y_3cLiJz=hR4Y0FM73G9uj=O1Fgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: bridge: Add SN65DSI84 DSI to LVDS bridge
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 4:55 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Jagan
>
> On Wed, Jan 20, 2021 at 12:22 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > SN65DSI84 is a Single Channel DSI to Dual-link LVDS bridge from
> > Texas Instruments.
> >
> > SN65DSI83, SN65DSI85 are variants of the same family of bridge
> > controllers.
> >
> > Right now the bridge driver is supporting a single link, dual-link
> > support requires to initiate I2C Channel B registers.
> >
> > Tested with STM32MP1 MIPI DSI host design configuration.
> >
> > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  MAINTAINERS                           |   6 +
> >  drivers/gpu/drm/bridge/Kconfig        |  19 +
> >  drivers/gpu/drm/bridge/Makefile       |   1 +
> >  drivers/gpu/drm/bridge/ti-sn65dsi84.c | 488 ++++++++++++++++++++++++++
> >  4 files changed, 514 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/ti-sn65dsi84.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 12dd1fff2a39..44750ff7640c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5984,6 +5984,12 @@ S:       Maintained
> >  F:     Documentation/devicetree/bindings/display/ti/
> >  F:     drivers/gpu/drm/omapdrm/
> >
> > +DRM DRIVERS FOR TI SN65DSI84 DSI TO LVDS BRIDGE
> > +M:     Jagan Teki <jagan@amarulasolutions.com>
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml
> > +F:     drivers/gpu/drm/bridge/ti-sn65dsi84.c
> > +
> >  DRM DRIVERS FOR V3D
> >  M:     Eric Anholt <eric@anholt.net>
> >  S:     Supported
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index e4110d6ca7b3..6494881bffb3 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -232,6 +232,25 @@ config DRM_TI_TFP410
> >         help
> >           Texas Instruments TFP410 DVI/HDMI Transmitter driver
> >
> > +config DRM_TI_SN65DSI84
> > +       tristate "TI SN65DSI84 DSI to LVDS bridge"
> > +       depends on OF
> > +       select DRM_KMS_HELPER
> > +       select REGMAP_I2C
> > +       select DRM_PANEL
> > +       select DRM_MIPI_DSI
> > +       help
> > +         Texas Instruments SN65DSI84 Single Channel DSI to Dual-link LVDS
> > +         bridge driver.
> > +
> > +         Bridge decodes MIPI DSI 18bpp RGB666 and 240bpp RG888 packets and
> > +         converts the formatted video data stream to a FlatLink compatible
> > +         LVDS output operating at pixel clocks operating from 25 MHx to
> > +         154 MHz.
> > +
> > +         SN65DSI84 offers a Dual-Link LVDS, Single-Link LVDS interface with
> > +         four data lanes per link.
> > +
> >  config DRM_TI_SN65DSI86
> >         tristate "TI SN65DSI86 DSI to eDP bridge"
> >         depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > index 86e7acc76f8d..3906052ef639 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358768) += tc358768.o
> >  obj-$(CONFIG_DRM_TOSHIBA_TC358775) += tc358775.o
> >  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
> > +obj-$(CONFIG_DRM_TI_SN65DSI84) += ti-sn65dsi84.o
> >  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
> >  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
> >  obj-$(CONFIG_DRM_TI_TPD12S015) += ti-tpd12s015.o
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi84.c b/drivers/gpu/drm/bridge/ti-sn65dsi84.c
> > new file mode 100644
> > index 000000000000..3ed1f9a7d898
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi84.c
> > @@ -0,0 +1,488 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021 Engicam srl
> > + * Copyright (C) 2021 Amarula Solutions(India)
> > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_panel.h>
> > +#include <drm/drm_print.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +/* sn65dsi84 registers */
> > +#define SN65DSI_SOFT_RESET             0x09
> > +#define SN65DSI_LVDS_CLK               0x0a
> > +#define SN65DSI_CLK_DIV                        0x0b
> > +#define SN65DSI_CLK_PLL                        0x0d
> > +#define SN65DSI_DSI_CFG                        0x10
> > +#define SN65DSI_DSI_CLK_EQ             0x11
> > +#define SN65DSI_DSI_CLK_RANGE          0x12
> > +#define SN65DSI_LVDS_MODE              0x18
> > +#define SN65DSI_CHA_LINE_LO            0x20
> > +#define SN65DSI_CHA_LINE_HI            0x21
> > +#define SN65DSI_CHA_VIRT_LO            0x24
> > +#define SN65DSI_CHA_VIRT_HI            0x25
> > +#define SN65DSI_CHA_SYNC_DELAY_LO      0x28
> > +#define SN65DSI_CHA_SYNC_DELAY_HI      0x29
> > +#define SN65DSI_CHA_HSYNC_WIDTH_LO     0x2c
> > +#define SN65DSI_CHA_HSYNC_WIDTH_HI     0x2d
> > +#define SN65DSI_CHA_VSYNC_WIDTH_LO     0x30
> > +#define SN65DSI_CHA_VSYNC_WIDTH_HI     0x31
> > +#define SN65DSI_CHA_HBACK_PORCH                0x34
> > +#define SN65DSI_CHA_VBACK_PORCH                0x36
> > +#define SN65DSI_CHA_HFRONT_PORCH       0x38
> > +#define SN65DSI_CHA_VFRONT_PORCH       0x3a
> > +#define SN65DSI_CHA_ERR                        0xe5
> > +
> > +/* sn65dsi register bits */
> > +#define SN65DSI_RESET_EN               BIT(0)
> > +#define SN65DSI_PLL_EN                 BIT(0)
> > +#define SN65DSI_LVDS_CLK_MASK          GENMASK(3, 1)
> > +#define SN65DSI_LVDS_CLK_SHIFT         1
> > +#define SN65DSI_LVDS_CLK_SRC_DSI       BIT(0)
> > +#define SN65DSI_CLK_DIV_MASK           GENMASK(7, 3)
> > +#define SN65DSI_CLK_DIV_SHIFT          3
> > +#define SN65DSI_DSI_LANE_MASK          GENMASK(4, 3)
> > +#define SN65DSI_DSI_LANE_SHIFT         3
> > +#define SN65DSI_LVDS_LINK_CFG          BIT(4)
> > +#define SN65DSI_LVDS_CHA_24BPP         BIT(3)
> > +#define SN65DSI_CHA_LOW_SYNC_DELAY     0x20
> > +#define SN65DSI_CHA_HIGH_SYNC_DELAY    0x00
> > +
> > +struct sn65dsi {
> > +       struct device                   *dev;
> > +       struct drm_bridge               bridge;
> > +       struct drm_bridge               *panel_bridge;
> > +
> > +       struct device_node              *host_node;
> > +       struct mipi_dsi_device          *dsi;
> > +       u8                              dsi_lanes;
> > +
> > +       struct regmap                   *regmap;
> > +       struct gpio_desc                *enable;
> > +};
> > +
> > +static const struct regmap_config sn65dsi_regmap_config = {
> > +       .reg_bits = 8,
> > +       .val_bits = 8,
> > +       .max_register = SN65DSI_CHA_ERR,
> > +       .name = "sn65dsi",
> > +       .cache_type = REGCACHE_RBTREE,
> > +};
> > +
> > +static inline struct sn65dsi *bridge_to_sn65dsi(struct drm_bridge *bridge)
> > +{
> > +       return container_of(bridge, struct sn65dsi, bridge);
> > +}
> > +
> > +static struct drm_display_mode *bridge_to_mode(struct drm_bridge *bridge)
> > +{
> > +       return &bridge->encoder->crtc->state->mode;
> > +}
> > +
> > +static void sn65dsi_setup_channels(struct sn65dsi *sn,
> > +                                  struct drm_display_mode *mode)
> > +{
> > +       u32 hsync_len, hfront_porch, hback_porch;
> > +       u32 vsync_len, vfront_porch, vback_porch;
> > +
> > +       hfront_porch = mode->hsync_start - mode->hdisplay;
> > +       hsync_len = mode->hsync_end - mode->hsync_start;
> > +       hback_porch = mode->htotal - mode->hsync_end;
> > +
> > +       vfront_porch = mode->vsync_start - mode->vdisplay;
> > +       vsync_len = mode->vsync_end - mode->vsync_start;
> > +       vback_porch = mode->vtotal - mode->vsync_end;
> > +
> > +       /* cha, lower 8-bits of hdisplay */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_LINE_LO, mode->hdisplay & 0xff);
> > +
> > +       msleep(10);
> > +
>
> I don't find any reason for those msleep. I don't have on my setup
> with the same bridge

As recommended by 8.2.2.1 Example Script from the datasheet.

https://www.ti.com/product/SN65DSI84

>
> > +       /* cha, upper 4-bits of hdisplay */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_LINE_HI, (mode->hdisplay >> 8) & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, lower 8-bits of vdisplay */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_VIRT_LO, mode->vdisplay & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, upper 4-bits of vdisplay */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_VIRT_HI, (mode->vdisplay >> 8) & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /*cha, lower sync delay */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_SYNC_DELAY_LO, SN65DSI_CHA_LOW_SYNC_DELAY);
> > +
> > +       msleep(10);
> > +
> > +       /*cha, upper sync delay */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_SYNC_DELAY_HI, SN65DSI_CHA_HIGH_SYNC_DELAY);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, lower 8-bits of hsync_len */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_HSYNC_WIDTH_LO, hsync_len & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, upper 2-bits of hsync_len */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_HSYNC_WIDTH_HI, (hsync_len >> 8) & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, lower 8-bits of vsync_len */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_VSYNC_WIDTH_LO, vsync_len & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, upper 2-bits of vsync_len */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_VSYNC_WIDTH_HI, (vsync_len >> 8) & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, hback_porch */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_HBACK_PORCH, hback_porch & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, vback_porch */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_VBACK_PORCH, vback_porch & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, hfront_porch */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_HFRONT_PORCH, hfront_porch & 0xff);
> > +
> > +       msleep(10);
> > +
> > +       /* cha, vfront_porch */
> > +       regmap_write(sn->regmap, SN65DSI_CHA_VFRONT_PORCH, vfront_porch & 0xff);
> > +
> > +       msleep(10);
> > +}
> > +
> > +static int sn65dsi_get_clk_range(int min, int max, unsigned long clock,
> > +                                unsigned long start, unsigned long diff)
> > +{
> > +       unsigned long next;
> > +       int i;
> > +
> > +       for (i = min; i <= max; i++) {
> > +               next = start + diff;
> > +               if (start <= clock && clock < next)
> > +                       return i;
> > +
> > +               start += diff;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static void sn65dsi_enable(struct drm_bridge *bridge)
> > +{
> > +       struct sn65dsi *sn = bridge_to_sn65dsi(bridge);
> > +       struct drm_display_mode *mode = bridge_to_mode(bridge);
> > +       int bpp = mipi_dsi_pixel_format_to_bpp(sn->dsi->format);
> > +       unsigned int lanes = sn->dsi->lanes;
> > +       unsigned int pixel_clk = mode->clock * 1000;
> > +       unsigned int dsi_clk = pixel_clk * bpp / (lanes * 2);
> > +       unsigned int val;
> > +
> > +       /* set SOFT_RESET bit */
> > +       regmap_write(sn->regmap, SN65DSI_SOFT_RESET, SN65DSI_RESET_EN);
> > +
> > +       msleep(10);
> > +
> > +       /* set PLL_EN bit */
> > +       regmap_write(sn->regmap, SN65DSI_CLK_PLL, 0x0);
> > +
> > +       msleep(10);
> > +
> > +       /* setup lvds clock */
> > +       val = sn65dsi_get_clk_range(0, 5, pixel_clk, 25000000, 25000000);
> > +       if (val < 0) {
> > +               DRM_DEV_ERROR(sn->dev, "invalid LVDS clock range %d\n", val);
> > +               return;
> > +       }
> > +
> > +       regmap_update_bits(sn->regmap, SN65DSI_LVDS_CLK,
> > +                          SN65DSI_LVDS_CLK_MASK,
> > +                          val << SN65DSI_LVDS_CLK_SHIFT);
> > +
> > +       regmap_update_bits(sn->regmap, SN65DSI_LVDS_CLK,
> > +                          SN65DSI_LVDS_CLK_SRC_DSI,
> > +                          SN65DSI_LVDS_CLK_SRC_DSI);
> > +
> > +       msleep(10);
> > +
> > +       /* setup bridge clock divider */
> > +       val = (dsi_clk / pixel_clk) - 1;
> > +       regmap_update_bits(sn->regmap, SN65DSI_CLK_DIV,
> > +                          SN65DSI_CLK_DIV_MASK,
> > +                          val << SN65DSI_CLK_DIV_SHIFT);
> > +       msleep(10);
> > +
> > +       /* configure dsi */
> > +       regmap_update_bits(sn->regmap, SN65DSI_DSI_CFG,
> > +                          SN65DSI_DSI_LANE_MASK,
> > +                          lanes << SN65DSI_DSI_LANE_SHIFT);
> > +       msleep(10);
> > +
>
> Most of those, look like. I don't know why it does not work without.
> Where is mention in datasheet?
>
> > +       /* dsi clock range */
> > +       val = sn65dsi_get_clk_range(8, 100, dsi_clk, 40000000, 5000000);
> > +       if (val < 0) {
> > +               DRM_DEV_ERROR(sn->dev, "invalid DSI clock range %d\n", val);
> > +               return;
> > +       }
> > +
> > +       regmap_write(sn->regmap, SN65DSI_DSI_CLK_RANGE, val);
> > +
> > +       msleep(10);
> > +
> > +       /* setup lvds channels */
> > +       regmap_read(sn->regmap, SN65DSI_LVDS_MODE, &val);
> > +       if (bpp == 24)
> > +               val |= SN65DSI_LVDS_CHA_24BPP;
> > +       regmap_write(sn->regmap, SN65DSI_LVDS_MODE, val);
> > +
> > +       msleep(10);
> > +
> > +       /* TODO Channel B required to set up for dual-link LVDS */
> > +       sn65dsi_setup_channels(sn, mode);
> > +
>
> If you are supporting 84 this code can be drop.

Right now the above function is setting up channel A for single-link
LVDS. 84 support Single and Dual link LVDS.

Jagan.
