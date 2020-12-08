Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226882D272B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgLHJH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:07:56 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:60552 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbgLHJH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:07:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6A30FFB03;
        Tue,  8 Dec 2020 10:07:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oKdTZMLSUwOv; Tue,  8 Dec 2020 10:07:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BBC234068D; Tue,  8 Dec 2020 10:07:10 +0100 (CET)
Date:   Tue, 8 Dec 2020 10:07:10 +0100
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
Subject: Re: [PATCH 3/4] dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel
 combo PHY support for i.MX8qxp
Message-ID: <20201208090710.GC20575@bogon.m.sigxcpu.org>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
 <1607067224-15616-4-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607067224-15616-4-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,
Since we now gain optional properties validation would become even more
useful. Could you look into converting to YAML before adding more
values?
Cheers,
 -- Guido

On Fri, Dec 04, 2020 at 03:33:43PM +0800, Liu Ying wrote:
> Add support for Mixel MIPI DPHY + LVDS PHY combo IP
> as found on Freescale i.MX8qxp SoC.
> 
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> index 9b23407..0afce99 100644
> --- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> @@ -4,9 +4,13 @@ The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
>  MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
>  electrical signals for DSI.
>  
> +The Mixel PHY IP block found on i.MX8qxp is a combo PHY that can work
> +in either MIPI-DSI PHY mode or LVDS PHY mode.
> +
>  Required properties:
> -- compatible: Must be:
> +- compatible: Should be one of:
>    - "fsl,imx8mq-mipi-dphy"
> +  - "fsl,imx8qxp-mipi-dphy"
>  - clocks: Must contain an entry for each entry in clock-names.
>  - clock-names: Must contain the following entries:
>    - "phy_ref": phandle and specifier referring to the DPHY ref clock
> @@ -14,6 +18,8 @@ Required properties:
>  - #phy-cells: number of cells in PHY, as defined in
>    Documentation/devicetree/bindings/phy/phy-bindings.txt
>    this must be <0>
> +- fsl,syscon: Phandle to a system controller, as required by the PHY
> +  in i.MX8qxp SoC.
>  
>  Optional properties:
>  - power-domains: phandle to power domain
> -- 
> 2.7.4
> 
