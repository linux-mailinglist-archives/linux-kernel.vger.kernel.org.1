Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD47B2D26DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgLHJDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:03:46 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:60302 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgLHJDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:03:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 32A11FB03;
        Tue,  8 Dec 2020 10:02:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RGlDGe6CXV_f; Tue,  8 Dec 2020 10:02:44 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5EA9D4068D; Tue,  8 Dec 2020 10:02:44 +0100 (CET)
Date:   Tue, 8 Dec 2020 10:02:44 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: Re: [PATCH 0/4] phy: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp LVDS PHY
 mode support
Message-ID: <20201208090244.GA20575@bogon.m.sigxcpu.org>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,
On Fri, Dec 04, 2020 at 03:33:40PM +0800, Liu Ying wrote:
> Hi,
> 
> This series adds i.MX8qxp LVDS PHY mode support for the Mixel PHY in the
> Freescale i.MX8qxp SoC.

This looks good to me from the NWL and actual phy driver part. I'll
comment in the individual patches but leave comments on the extension
of the generic phy struct to someone knowledgeable with that part.

What display controllers do you intend to drive that with?
Cheers,
 -- Guido

> 
> The Mixel PHY is MIPI DPHY + LVDS PHY combo, which can works in either
> MIPI DPHY mode or LVDS PHY mode.  The PHY mode is controlled by i.MX8qxp
> SCU firmware.  The PHY driver would call a SCU function to configure the
> mode.
> 
> The PHY driver is already supporting the Mixel MIPI DPHY in i.MX8mq SoC,
> where it appears to be a single MIPI DPHY.
> 
> 
> Patch 1/4 sets PHY mode in the Northwest Logic MIPI DSI host controller
> bridge driver, since i.MX8qxp SoC embeds this controller IP to support
> MIPI DSI displays together with the Mixel PHY.
> 
> Patch 2/4 allows LVDS PHYs to be configured through the generic PHY functions
> and through a custom structure added to the generic PHY configuration union.
> 
> Patch 3/4 adds dt binding support for the Mixel combo PHY in i.MX8qxp SoC.
> 
> Patch 4/4 adds the i.MX8qxp LVDS PHY mode support in the Mixel PHY driver.
> 
> 
> Welcome comments, thanks.
> 
> 
> Liu Ying (4):
>   drm/bridge: nwl-dsi: Set PHY mode in nwl_dsi_enable()
>   phy: Add LVDS configuration options
>   dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel combo PHY support for
>     i.MX8qxp
>   phy: freescale: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp LVDS PHY mode
>     support
> 
>  .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt |   8 +-
>  drivers/gpu/drm/bridge/nwl-dsi.c                   |   6 +
>  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     | 266 ++++++++++++++++++++-
>  include/linux/phy/phy-lvds.h                       |  48 ++++
>  include/linux/phy/phy.h                            |   4 +
>  5 files changed, 320 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/phy/phy-lvds.h
> 
> -- 
> 2.7.4
> 
