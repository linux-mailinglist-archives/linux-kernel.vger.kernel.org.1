Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A602B1A90E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 04:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392944AbgDOCTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 22:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392934AbgDOCTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:19:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63563C061A0C;
        Tue, 14 Apr 2020 19:19:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F2032D1;
        Wed, 15 Apr 2020 04:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586917160;
        bh=tCMsVdkuBTSbuG7qe/D7439fgOuKvf3pWe38yt2askU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o50zeO4qyxrwgUTYWstmx1eDr+CAlNSTP2/NiSOJfIPnOmSkv+SlIVvT371fZARqC
         4zIjXj3sJCYSDvQzEsKvP+5+Baw6xQKDD7FR/RQ1+TCav8euezJcqBp/rKaAtokOax
         hD7KAwe4UJsWDzYcZ4ZENZ+YAprPDA4osxNqGGPU=
Date:   Wed, 15 Apr 2020 05:19:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 1/2] dt-bindings: display/bridge: Add binding for NWL
 mipi dsi host controller
Message-ID: <20200415021908.GH19819@pendragon.ideasonboard.com>
References: <cover.1586427783.git.agx@sigxcpu.org>
 <147ffc1e4dee3a623e5dca25d84565d386a34112.1586427783.git.agx@sigxcpu.org>
 <20200410112342.GB4751@pendragon.ideasonboard.com>
 <20200410124516.GA27532@bogon.m.sigxcpu.org>
 <20200410125732.GE4751@pendragon.ideasonboard.com>
 <20200412163835.GB4007@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200412163835.GB4007@bogon.m.sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Sun, Apr 12, 2020 at 06:38:35PM +0200, Guido Günther wrote:
> On Fri, Apr 10, 2020 at 03:57:32PM +0300, Laurent Pinchart wrote:
> > On Fri, Apr 10, 2020 at 02:45:16PM +0200, Guido Günther wrote:
> >> On Fri, Apr 10, 2020 at 02:23:42PM +0300, Laurent Pinchart wrote:
> >>> On Thu, Apr 09, 2020 at 12:42:01PM +0200, Guido Günther wrote:
> >>>> The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
> >>>> 
> >>>> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> >>>> Tested-by: Robert Chiras <robert.chiras@nxp.com>
> >>>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> >>>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> >>>> ---
> >>>>  .../bindings/display/bridge/nwl-dsi.yaml      | 226 ++++++++++++++++++
> >>>>  1 file changed, 226 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> >>>> 
> >>>> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..8aff2d68fc33
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> >>>> @@ -0,0 +1,226 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/display/bridge/nwl-dsi.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Northwest Logic MIPI-DSI controller on i.MX SoCs
> >>>> +
> >>>> +maintainers:
> >>>> +  - Guido Gúnther <agx@sigxcpu.org>
> >>>> +  - Robert Chiras <robert.chiras@nxp.com>
> >>>> +
> >>>> +description: |
> >>>> +  NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
> >>>> +  the SOCs NWL MIPI-DSI host controller.
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    const: fsl,imx8mq-nwl-dsi
> >>>> +
> >>>> +  reg:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  interrupts:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  '#address-cells':
> >>>> +    const: 1
> >>>> +
> >>>> +  '#size-cells':
> >>>> +    const: 0
> >>>> +
> >>>> +  clocks:
> >>>> +    items:
> >>>> +      - description: DSI core clock
> >>>> +      - description: RX_ESC clock (used in escape mode)
> >>>> +      - description: TX_ESC clock (used in escape mode)
> >>>> +      - description: PHY_REF clock
> >>>> +      - description: LCDIF clock
> >>>> +
> >>>> +  clock-names:
> >>>> +    items:
> >>>> +      - const: core
> >>>> +      - const: rx_esc
> >>>> +      - const: tx_esc
> >>>> +      - const: phy_ref
> >>>> +      - const: lcdif
> >>>> +
> >>>> +  mux-controls:
> >>>> +    description:
> >>>> +      mux controller node to use for operating the input mux
> >>>> +
> >>>> +  phys:
> >>>> +    maxItems: 1
> >>>> +    description:
> >>>> +      A phandle to the phy module representing the DPHY
> >>>> +
> >>>> +  phy-names:
> >>>> +    items:
> >>>> +      - const: dphy
> >>>> +
> >>>> +  power-domains:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  resets:
> >>>> +    items:
> >>>> +      - description: dsi byte reset line
> >>>> +      - description: dsi dpi reset line
> >>>> +      - description: dsi esc reset line
> >>>> +      - description: dsi pclk reset line
> >>>> +
> >>>> +  reset-names:
> >>>> +    items:
> >>>> +      - const: byte
> >>>> +      - const: dpi
> >>>> +      - const: esc
> >>>> +      - const: pclk
> >>>> +
> >>>> +  ports:
> >>>> +    type: object
> >>>> +    description:
> >>>> +      A node containing DSI input & output port nodes with endpoint
> >>>> +      definitions as documented in
> >>>> +      Documentation/devicetree/bindings/graph.txt.
> >>>> +    properties:
> >>>> +      port@0:
> >>>> +        type: object
> >>>> +        description:
> >>>> +          Input port node to receive pixel data from the
> >>>> +          display controller. Exactly one endpoint must be
> >>>> +          specified.
> >>>> +        properties:
> >>>> +          '#address-cells':
> >>>> +            const: 1
> >>>> +
> >>>> +          '#size-cells':
> >>>> +            const: 0
> >>>> +
> >>>> +          endpoint@0:
> >>>> +            description: sub-node describing the input from LCDIF
> >>>> +            type: object
> >>>> +
> >>>> +          endpoint@1:
> >>>> +            description: sub-node describing the input from DCSS
> >>>> +            type: object
> >>> 
> >>> This models the two inputs to the IP core, that are connected to a mux
> >>> internally, controlled through mux-controls, right ? Why is a single
> >>> endpoint supported then, if there are two connections at the hardware
> >>> level, and why is this using endpoints instead of ports as there are
> >>> really two input ports ?
> >> 
> >> That came out of
> >> 
> >> https://lore.kernel.org/linux-arm-kernel/c86b7ca2-7799-eafd-c380-e4b551520837@samsung.com/
> >> 
> >> # If the ip has separate lines for DCSS and LCDIF you should distinguish
> >> # by port number. If they are shared
> >> # you can use endpoint number to specify DCSS or LCDIF, in both cases
> >> # bindings should be adjusted.
> >> 
> >> I read that as
> >> 
> >> - distinguish by endpoint number:
> >> 
> >>     eLCDIF--\    |
> >>              ----| nwl
> >>     DCSS----/    |
> >> 
> >> - distinguish by port number:
> >> 
> >>     eLCDIF-------|
> >>                  | nwl
> >>     DCSS --------|
> > 
> > I fully agree with you here, but in the first case I would expect the
> > mux to be outside of the NWL, while in the second case it would be
> > inside. If I understand the issue correctly, the mux is not part of the
> > NWL, right ? The endpoint model would then be good, but leaves the issue
> > Documentation/devicetree/bindings/media/video-mux.txt, but that would
> > require some support on the driver side. Do you think it would be a good
> > way forward ?
> 
> Binding wise that looks like a good fit. I then thought about the
> implementation and figured we'd end up with something like a bridge that
> basically muxes inputs - or did you have something different in mind? That
> sounds generally useful when we e.g. look at runtime switching the input
> display controller.

That's exactly what I have in mind. There's a video-mux driver in V4L2
that does exactly this, we would need something similar for DRM/KMS.
There's an additional challenge in that bridges are supposed to have a
single input and a single output at the moment, so API extensions would
be needed, which could take some time to get right. Shortcuts may be
possible to achieve a first implementation that would hardcode a
particular input, as long as the DT bindings are fine.

> > The alternative is to consider the mux + NWL as one device (more or less
> > an i.MX8M-specific integration wrapper of the NWL), but in that case
> > there should be two ports I believe.
> 
> I'd go with that for the moment and fold in the above at a later
> point if needed. I'm happy to work on that but would like to work on
> some parts of the imx8mq display stack first.

There's no specific urgency on my side, if not for the fact that DT
bindings are supposed to be a stable ABI. If we have to change this, it
would be best to do it before v5.7-rc6 in order to get the changes in
v5.8. A delay until v5.8-rcX may still be acceptable as this could be
considered as a fix, but the more we wait, the bigger the risk is.

> >> From the imx8mq ref manual i didn't see separate input lines for DCSS vs
> >> eLCDIF the the NWL IP so i went with endpoints instead of ports.  I'm
> >> happy to change that if i got it wrong.
> >> 
> >>> Apart from that the bindings look ok to me.
> >>> 
> >>>> +
> >>>> +          reg:
> >>>> +            const: 0
> >>>> +
> >>>> +        required:
> >>>> +          - '#address-cells'
> >>>> +          - '#size-cells'
> >>>> +          - reg
> >>>> +
> >>>> +        oneOf:
> >>>> +          - required:
> >>>> +              - endpoint@0
> >>>> +          - required:
> >>>> +              - endpoint@1
> >>>> +
> >>>> +        additionalProperties: false
> >>>> +
> >>>> +      port@1:
> >>>> +        type: object
> >>>> +        description:
> >>>> +          DSI output port node to the panel or the next bridge
> >>>> +          in the chain
> >>>> +
> >>>> +      '#address-cells':
> >>>> +        const: 1
> >>>> +
> >>>> +      '#size-cells':
> >>>> +        const: 0
> >>>> +
> >>>> +    required:
> >>>> +      - '#address-cells'
> >>>> +      - '#size-cells'
> >>>> +      - port@0
> >>>> +      - port@1
> >>>> +
> >>>> +    additionalProperties: false
> >>>> +
> >>>> +patternProperties:
> >>>> +  "^panel@[0-9]+$":
> >>>> +    type: object
> >>>> +
> >>>> +required:
> >>>> +  - '#address-cells'
> >>>> +  - '#size-cells'
> >>>> +  - clock-names
> >>>> +  - clocks
> >>>> +  - compatible
> >>>> +  - interrupts
> >>>> +  - mux-controls
> >>>> +  - phy-names
> >>>> +  - phys
> >>>> +  - ports
> >>>> +  - reg
> >>>> +  - reset-names
> >>>> +  - resets
> >>>> +
> >>>> +additionalProperties: false
> >>>> +
> >>>> +examples:
> >>>> + - |
> >>>> +
> >>>> +   #include <dt-bindings/clock/imx8mq-clock.h>
> >>>> +   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>>> +   #include <dt-bindings/reset/imx8mq-reset.h>
> >>>> +
> >>>> +   mipi_dsi: mipi_dsi@30a00000 {
> >>>> +              #address-cells = <1>;
> >>>> +              #size-cells = <0>;
> >>>> +              compatible = "fsl,imx8mq-nwl-dsi";
> >>>> +              reg = <0x30A00000 0x300>;
> >>>> +              clocks = <&clk IMX8MQ_CLK_DSI_CORE>,
> >>>> +                       <&clk IMX8MQ_CLK_DSI_AHB>,
> >>>> +                       <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
> >>>> +                       <&clk IMX8MQ_CLK_DSI_PHY_REF>,
> >>>> +                       <&clk IMX8MQ_CLK_LCDIF_PIXEL>;
> >>>> +              clock-names = "core", "rx_esc", "tx_esc", "phy_ref", "lcdif";
> >>>> +              interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> >>>> +              mux-controls = <&mux 0>;
> >>>> +              power-domains = <&pgc_mipi>;
> >>>> +              resets = <&src IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N>,
> >>>> +                       <&src IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N>,
> >>>> +                       <&src IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N>,
> >>>> +                       <&src IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N>;
> >>>> +              reset-names = "byte", "dpi", "esc", "pclk";
> >>>> +              phys = <&dphy>;
> >>>> +              phy-names = "dphy";
> >>>> +
> >>>> +              panel@0 {
> >>>> +                      #address-cells = <1>;
> >>>> +                      #size-cells = <0>;
> >>>> +                      compatible = "rocktech,jh057n00900";
> >>>> +                      reg = <0>;
> >>>> +                      port@0 {
> >>>> +                           reg = <0>;
> >>>> +                           panel_in: endpoint {
> >>>> +                                     remote-endpoint = <&mipi_dsi_out>;
> >>>> +                           };
> >>>> +                      };
> >>>> +              };
> >>>> +
> >>>> +              ports {
> >>>> +                    #address-cells = <1>;
> >>>> +                    #size-cells = <0>;
> >>>> +
> >>>> +                    port@0 {
> >>>> +                           #size-cells = <0>;
> >>>> +                           #address-cells = <1>;
> >>>> +                           reg = <0>;
> >>>> +                           mipi_dsi_in: endpoint@0 {
> >>>> +                                        reg = <0>;
> >>>> +                                        remote-endpoint = <&lcdif_mipi_dsi>;
> >>>> +                           };
> >>>> +                    };
> >>>> +                    port@1 {
> >>>> +                           reg = <1>;
> >>>> +                           mipi_dsi_out: endpoint {
> >>>> +                                         remote-endpoint = <&panel_in>;
> >>>> +                           };
> >>>> +                    };
> >>>> +              };
> >>>> +      };

-- 
Regards,

Laurent Pinchart
