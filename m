Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B8F2D8EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 17:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbgLMQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 11:45:58 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:58938 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgLMQp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 11:45:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id BF448FB05;
        Sun, 13 Dec 2020 17:45:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9o5ZzOY7uUL2; Sun, 13 Dec 2020 17:45:13 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BDA8543FDC; Sun, 13 Dec 2020 17:45:12 +0100 (CET)
Date:   Sun, 13 Dec 2020 17:45:12 +0100
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
Subject: Re: [PATCH v3 3/5] dt-bindings: phy: Convert mixel,mipi-dsi-phy to
 json-schema
Message-ID: <20201213164512.GC28272@bogon.m.sigxcpu.org>
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
 <1607651182-12307-4-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607651182-12307-4-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Dec 11, 2020 at 09:46:20AM +0800, Liu Ying wrote:
> This patch converts the mixel,mipi-dsi-phy binding to
> DT schema format using json-schema.
> 
> Comparing to the plain text version, the new binding adds
> the 'assigned-clocks', 'assigned-clock-parents' and
> 'assigned-clock-rates' properites, otherwise 'make dtbs_check'
> would complain that there are mis-matches.  Also, the new
> binding requires the 'power-domains' property since all potential
> SoCs that embed this PHY would provide a power domain for it.
> The example of the new binding takes reference to the latest
> dphy node in imx8mq.dtsi.
> 
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2->v3:
> * Improve the 'clock-names' property by dropping 'items:'.
> 
> v1->v2:
> * Newly introduced in v2.  (Guido)
> 
>  .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 29 ---------
>  .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> deleted file mode 100644
> index 9b23407..00000000
> --- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Mixel DSI PHY for i.MX8
> -
> -The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
> -MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
> -electrical signals for DSI.
> -
> -Required properties:
> -- compatible: Must be:
> -  - "fsl,imx8mq-mipi-dphy"
> -- clocks: Must contain an entry for each entry in clock-names.
> -- clock-names: Must contain the following entries:
> -  - "phy_ref": phandle and specifier referring to the DPHY ref clock
> -- reg: the register range of the PHY controller
> -- #phy-cells: number of cells in PHY, as defined in
> -  Documentation/devicetree/bindings/phy/phy-bindings.txt
> -  this must be <0>
> -
> -Optional properties:
> -- power-domains: phandle to power domain
> -
> -Example:
> -	dphy: dphy@30a0030 {
> -		compatible = "fsl,imx8mq-mipi-dphy";
> -		clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> -		clock-names = "phy_ref";
> -		reg = <0x30a00300 0x100>;
> -		power-domains = <&pd_mipi0>;
> -		#phy-cells = <0>;
> -        };
> diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
> new file mode 100644
> index 00000000..c34f2e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mixel,mipi-dsi-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mixel DSI PHY for i.MX8
> +
> +maintainers:
> +  - Guido Günther <agx@sigxcpu.org>
> +
> +description: |
> +  The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
> +  MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
> +  electrical signals for DSI.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mq-mipi-dphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: phy_ref
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-parents
> +  - assigned-clock-rates
> +  - "#phy-cells"
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    dphy: dphy@30a0030 {
> +        compatible = "fsl,imx8mq-mipi-dphy";
> +        reg = <0x30a00300 0x100>;
> +        clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +        clock-names = "phy_ref";
> +        assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +        assigned-clock-parents = <&clk IMX8MQ_VIDEO_PLL1_OUT>;
> +        assigned-clock-rates = <24000000>;
> +        #phy-cells = <0>;
> +        power-domains = <&pgc_mipi>;
> +    };


Reviewed-by: Guido Günther <agx@sigxcpu.org>

Thanks for the conversion!
 -- Guido



> -- 
> 2.7.4
> 
