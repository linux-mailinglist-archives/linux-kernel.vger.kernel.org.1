Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461892D8EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 17:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgLMQpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 11:45:41 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:58880 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgLMQpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 11:45:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0A57EFB04;
        Sun, 13 Dec 2020 17:44:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6srKoaZvHBUF; Sun, 13 Dec 2020 17:44:33 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2107743FDC; Sun, 13 Dec 2020 17:44:33 +0100 (CET)
Date:   Sun, 13 Dec 2020 17:44:33 +0100
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
Subject: Re: [PATCH v3 4/5] dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel
 combo PHY support for i.MX8qxp
Message-ID: <20201213164433.GB28272@bogon.m.sigxcpu.org>
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
 <1607651182-12307-5-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607651182-12307-5-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Dec 11, 2020 at 09:46:21AM +0800, Liu Ying wrote:
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
> v2->v3:
> * No change.
> 
> v1->v2:
> * Add the binding for i.MX8qxp Mixel combo PHY based on the converted binding.
>   (Guido)
> 
>  .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 41 ++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
> index c34f2e6..786cfd7 100644
> --- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
> @@ -14,10 +14,14 @@ description: |
>    MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
>    electrical signals for DSI.
>  
> +  The Mixel PHY IP block found on i.MX8qxp is a combo PHY that can work
> +  in either MIPI-DSI PHY mode or LVDS PHY mode.
> +
>  properties:
>    compatible:
>      enum:
>        - fsl,imx8mq-mipi-dphy
> +      - fsl,imx8qxp-mipi-dphy
>  
>    reg:
>      maxItems: 1
> @@ -40,6 +44,11 @@ properties:
>    "#phy-cells":
>      const: 0
>  
> +  fsl,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      A phandle which points to Control and Status Registers(CSR) module.
> +
>    power-domains:
>      maxItems: 1
>  
> @@ -48,12 +57,38 @@ required:
>    - reg
>    - clocks
>    - clock-names
> -  - assigned-clocks
> -  - assigned-clock-parents
> -  - assigned-clock-rates
>    - "#phy-cells"
>    - power-domains
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8mq-mipi-dphy
> +    then:
> +      properties:
> +        fsl,syscon: false
> +
> +      required:
> +        - assigned-clocks
> +        - assigned-clock-parents
> +        - assigned-clock-rates
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qxp-mipi-dphy
> +    then:
> +      properties:
> +        assigned-clocks: false
> +        assigned-clock-parents: false
> +        assigned-clock-rates: false
> +
> +      required:
> +        - fsl,syscon
> +
>  additionalProperties: false
>  
>  examples:

Reviewed-by: Guido Günther <agx@sigxcpu.org>
Cheers,
 -- Guido

> -- 
> 2.7.4
> 
