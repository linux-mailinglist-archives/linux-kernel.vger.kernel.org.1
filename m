Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE85A282564
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 18:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgJCQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 12:47:43 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:55998 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgJCQrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 12:47:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id EE66DFB03;
        Sat,  3 Oct 2020 18:47:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O1SgnQLk12Z5; Sat,  3 Oct 2020 18:47:37 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 7489845D0C; Sat,  3 Oct 2020 18:47:36 +0200 (CEST)
Date:   Sat, 3 Oct 2020 18:47:36 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Yannick Fertre <yannick.fertre@st.com>
Subject: Re: [PATCH] dt-bindings: display: Add dsi-controller.yaml in DSI
 controller schemas
Message-ID: <20201003164736.GA2773@bogon.m.sigxcpu.org>
References: <20201002225924.3513700-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002225924.3513700-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Oct 02, 2020 at 05:59:24PM -0500, Rob Herring wrote:
> Some DSI controllers are missing a reference to the recently added
> dsi-controller.yaml schema. Add it and we can drop the duplicate
> parts.

For the NWL part:

Reviewed-by: Guido Günther <agx@sigxcpu.org> 

> 
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: "Guido Gúnther" <agx@sigxcpu.org>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Philippe Cornu <philippe.cornu@st.com>
> Cc: Yannick Fertre <yannick.fertre@st.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 11 ++-------
>  .../bindings/display/brcm,bcm2835-dsi0.yaml   |  3 +++
>  .../bindings/display/bridge/nwl-dsi.yaml      | 11 ++++-----
>  .../bindings/display/st,stm32-dsi.yaml        | 23 ++++---------------
>  4 files changed, 14 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> index 63f948175239..7aa330dabc44 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> @@ -11,9 +11,6 @@ maintainers:
>    - Maxime Ripard <mripard@kernel.org>
>  
>  properties:
> -  "#address-cells": true
> -  "#size-cells": true
> -
>    compatible:
>      enum:
>        - allwinner,sun6i-a31-mipi-dsi
> @@ -57,12 +54,7 @@ properties:
>        port should be the input endpoint, usually coming from the
>        associated TCON.
>  
> -patternProperties:
> -  "^panel@[0-9]+$": true
> -
>  required:
> -  - "#address-cells"
> -  - "#size-cells"
>    - compatible
>    - reg
>    - interrupts
> @@ -74,6 +66,7 @@ required:
>    - port
>  
>  allOf:
> +  - $ref: dsi-controller.yaml#
>    - if:
>        properties:
>          compatible:
> @@ -99,7 +92,7 @@ allOf:
>          clocks:
>            minItems: 1
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> index 3c643b227a70..eb44e072b6e5 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> @@ -9,6 +9,9 @@ title: Broadcom VC4 (VideoCore4) DSI Controller
>  maintainers:
>    - Eric Anholt <eric@anholt.net>
>  
> +allOf:
> +  - $ref: dsi-controller.yaml#
> +
>  properties:
>    "#clock-cells":
>      const: 1
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> index b8ba6eb482a1..a125b2dd3a2f 100644
> --- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -14,6 +14,9 @@ description: |
>    NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
>    the SOCs NWL MIPI-DSI host controller.
>  
> +allOf:
> +  - $ref: ../dsi-controller.yaml#
> +
>  properties:
>    compatible:
>      const: fsl,imx8mq-nwl-dsi
> @@ -144,10 +147,6 @@ properties:
>  
>      additionalProperties: false
>  
> -patternProperties:
> -  "^panel@[0-9]+$":
> -    type: object
> -
>  required:
>    - '#address-cells'
>    - '#size-cells'
> @@ -163,7 +162,7 @@ required:
>    - reset-names
>    - resets
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> @@ -172,7 +171,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/reset/imx8mq-reset.h>
>  
> -    mipi_dsi: mipi_dsi@30a00000 {
> +    dsi@30a00000 {
>                #address-cells = <1>;
>                #size-cells = <0>;
>                compatible = "fsl,imx8mq-nwl-dsi";
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
> index 69cc7e8bf15a..327a14d85df8 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
> @@ -13,6 +13,9 @@ maintainers:
>  description:
>    The STMicroelectronics STM32 DSI controller uses the Synopsys DesignWare MIPI-DSI host controller.
>  
> +allOf:
> +  - $ref: dsi-controller.yaml#
> +
>  properties:
>    compatible:
>      const: st,stm32-dsi
> @@ -65,24 +68,6 @@ properties:
>          description:
>            DSI output port node, connected to a panel or a bridge input port"
>  
> -patternProperties:
> -  "^(panel|panel-dsi)@[0-9]$":
> -    type: object
> -    description:
> -      A node containing the panel or bridge description as documented in
> -      Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
> -    properties:
> -      port:
> -        type: object
> -        description:
> -          Panel or bridge port node, connected to the DSI output port (port@1)
> -
> -  "#address-cells":
> -    const: 1
> -
> -  "#size-cells":
> -    const: 0
> -
>  required:
>    - "#address-cells"
>    - "#size-cells"
> @@ -92,7 +77,7 @@ required:
>    - clock-names
>    - ports
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.25.1
> 
