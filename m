Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067392A1DDF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 13:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgKAM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 07:29:05 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:48760 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgKAM3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 07:29:05 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 39B0020022;
        Sun,  1 Nov 2020 13:29:02 +0100 (CET)
Date:   Sun, 1 Nov 2020 13:29:00 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: Add ABT Y030XX067A panel
 bindings
Message-ID: <20201101122900.GB1269759@ravnborg.org>
References: <20201101093150.8071-1-paul@crapouillou.net>
 <20201101093150.8071-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101093150.8071-3-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=gEfo2CItAAAA:8
        a=Lqvclo0UE7ZJoC8b96MA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=sptkURWiP4Gy88Gu7hUp:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 09:31:48AM +0000, Paul Cercueil wrote:
> The Asia Better Technology (ABT) Y030XX067A panel is a 3.0" 320x480
> 24-bit IPS LCD panel. Its particularity is that it has non-square pixels
> (as it is 4:3 for a resolution of 320x480), and that it requires odd
> lines to be sent as RGB and even lines to be sent as GRB on its 8-bit
> bus.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../display/panel/abt,y030xx067a.yaml         | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> new file mode 100644
> index 000000000000..6407e8bf45fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/abt,y030xx067a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Asia Better Technology 3.0" (320x480 pixels) 24-bit IPS LCD panel
> +
> +description: |
> +  The panel must obey the rules for a SPI slave device as specified in
> +  spi/spi-controller.yaml
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: abt,y030xx067a
> +
> +  backlight: true
> +  port: true
> +  power-supply: true
> +  reg: true
> +  reset-gpios: true

The binding is missing:
required:
  - compatible
  - reg
  - power-supply
  - reset-gpios
  - ...

additionalProperties: false

So r-b only with these added.

	Sam

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "abt,y030xx067a";
> +            reg = <0>;
> +
> +            spi-max-frequency = <3125000>;
> +
> +            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
> +
> +            backlight = <&backlight>;
> +            power-supply = <&vcc>;
> +
> +            port {
> +                panel_input: endpoint {
> +                    remote-endpoint = <&panel_output>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.28.0
