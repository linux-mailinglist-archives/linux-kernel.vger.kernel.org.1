Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560582EA4AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 06:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbhAEFQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 00:16:20 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:60932 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAEFQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 00:16:19 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 474E43D7;
        Tue,  5 Jan 2021 06:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609823736;
        bh=FNG1uOwG3LpbJXAdfWblkwR1yXexRcL+HDcTRT4pMHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwAR47nlD0TS1yszfYfxAS0L6gid9Q3h2G130z5X7fW1llDKCkNobebFfAomqdGyv
         dPFhYzYF51rZ8sMixnI/aZBAEC9pc/BgpoDAZIOupRCxTEIPuftQV32DAuv1xs/y/d
         vgih62SKApg91wWcRUsF8HC2SyNE9ZECdUjmfsOc=
Date:   Tue, 5 Jan 2021 07:15:24 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] dt-bindings: display: Use OF graph schema
Message-ID: <X/P17LVCwd/GPpIi@pendragon.ideasonboard.com>
References: <20210104180724.2275098-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104180724.2275098-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Mon, Jan 04, 2021 at 11:07:23AM -0700, Rob Herring wrote:
> Now that we have a graph schema, rework the display related schemas to use
> it. Mostly this is adding a reference to graph.yaml and dropping duplicate
> parts from schemas.
> 
> In panel-common.yaml, 'ports' is dropped. Any binding using 'ports'
> should be one with more than 1 port node, and the binding must define
> what each port is.
> 
> Note that ti,sn65dsi86.yaml, ti,tfp410,yaml and toshiba,tc358768.yaml will
> need further updates to use video-interfaces.yaml once that lands.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3:
>  - Rework based on graph.yaml changes. 'port' nodes now have a $ref and
>    endpoint nodes do too if they define additional properties.
>  - Convert ste,mcde.yaml
> 
> v2:
>  - Drop 'type: object' where we have a $ref
>  - Drop any common properties like 'reg', '#address-cells', "#size-cells',
>    'remote-endpoint'
>  - Keep description in ti,k2g-dss.yaml
> ---
>  .../allwinner,sun4i-a10-display-backend.yaml  |  23 +---
>  .../allwinner,sun4i-a10-display-frontend.yaml |  19 +--
>  .../display/allwinner,sun4i-a10-hdmi.yaml     |  19 +--
>  .../display/allwinner,sun4i-a10-tcon.yaml     |  25 +---
>  .../allwinner,sun4i-a10-tv-encoder.yaml       |   6 +-
>  .../display/allwinner,sun6i-a31-drc.yaml      |  19 +--
>  .../display/allwinner,sun6i-a31-mipi-dsi.yaml |   6 +-
>  .../allwinner,sun8i-a83t-de2-mixer.yaml       |  19 +--
>  .../display/allwinner,sun8i-a83t-dw-hdmi.yaml |  19 +--
>  .../display/allwinner,sun8i-r40-tcon-top.yaml | 110 ++----------------
>  .../display/allwinner,sun9i-a80-deu.yaml      |  19 +--
>  .../display/amlogic,meson-dw-hdmi.yaml        |   4 +-
>  .../bindings/display/amlogic,meson-vpu.yaml   |   4 +-
>  .../bindings/display/brcm,bcm2835-dpi.yaml    |   7 +-
>  .../display/bridge/analogix,anx7625.yaml      |   6 +-
>  .../display/bridge/analogix,anx7814.yaml      |  19 +--
>  .../bindings/display/bridge/anx6345.yaml      |  18 +--
>  .../display/bridge/cdns,mhdp8546.yaml         |  22 +---
>  .../display/bridge/chrontel,ch7033.yaml       |   6 +-
>  .../display/bridge/intel,keembay-dsi.yaml     |  14 +--
>  .../bindings/display/bridge/ite,it6505.yaml   |   2 +-
>  .../display/bridge/lontium,lt9611.yaml        |  70 ++---------
>  .../bindings/display/bridge/lvds-codec.yaml   |  18 +--
>  .../bindings/display/bridge/nwl-dsi.yaml      |  41 ++-----
>  .../bindings/display/bridge/ps8640.yaml       |  24 +---
>  .../bindings/display/bridge/renesas,lvds.yaml |  18 +--
>  .../display/bridge/simple-bridge.yaml         |  18 +--
>  .../display/bridge/snps,dw-mipi-dsi.yaml      |   7 +-
>  .../display/bridge/thine,thc63lvd1024.yaml    |  21 +---
>  .../bindings/display/bridge/ti,sn65dsi86.yaml |  45 +------
>  .../bindings/display/bridge/ti,tfp410.yaml    |  24 +---
>  .../display/bridge/toshiba,tc358762.yaml      |  52 +--------
>  .../display/bridge/toshiba,tc358768.yaml      |  48 +-------
>  .../display/bridge/toshiba,tc358775.yaml      |  19 +--
>  .../connector/analog-tv-connector.yaml        |   1 +
>  .../display/connector/dvi-connector.yaml      |   1 +
>  .../display/connector/hdmi-connector.yaml     |   1 +
>  .../display/connector/vga-connector.yaml      |   1 +
>  .../bindings/display/imx/nxp,imx8mq-dcss.yaml |   2 +-
>  .../bindings/display/ingenic,lcd.yaml         |  10 +-
>  .../display/intel,keembay-display.yaml        |   2 +-
>  .../display/panel/advantech,idk-2121wr.yaml   |  21 ++--
>  .../bindings/display/panel/panel-common.yaml  |  11 +-
>  .../rockchip/rockchip,rk3066-hdmi.yaml        |  16 +--
>  .../display/rockchip/rockchip-vop.yaml        |   5 +-
>  .../bindings/display/st,stm32-dsi.yaml        |  12 +-
>  .../bindings/display/st,stm32-ltdc.yaml       |   8 +-
>  .../devicetree/bindings/display/ste,mcde.yaml |   5 +-
>  .../bindings/display/ti/ti,am65x-dss.yaml     |  19 +--
>  .../bindings/display/ti/ti,j721e-dss.yaml     |  23 +---
>  .../bindings/display/ti/ti,k2g-dss.yaml       |   3 +-
>  51 files changed, 185 insertions(+), 747 deletions(-)

-- 
Regards,

Laurent Pinchart
