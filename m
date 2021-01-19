Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAC2FC12F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbhASUg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:36:57 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42595 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391495AbhASUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:36:02 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3617C40004;
        Tue, 19 Jan 2021 20:35:00 +0000 (UTC)
Date:   Tue, 19 Jan 2021 21:35:00 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: microchip sparx5 reset driver
 bindings
Message-ID: <20210119203500.GO3666@piout.net>
References: <20210114162432.3039657-1-steen.hegelund@microchip.com>
 <20210114162432.3039657-2-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114162432.3039657-2-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Every patches need a commit message, even if in this case it will be
very small.

On 14/01/2021 17:24:30+0100, Steen Hegelund wrote:
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  .../bindings/reset/microchip,rst.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> new file mode 100644
> index 000000000000..af01016e246f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/reset/microchip,rst.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Microchip Sparx5 Switch Reset Controller
> +
> +maintainers:
> +  - Steen Hegelund <steen.hegelund@microchip.com>
> +  - Lars Povlsen <lars.povlsen@microchip.com>
> +
> +description: |
> +  The Microchip Sparx5 Switch provides reset control and implements the following
> +  functions
> +    - One Time Switch Core Reset (Soft Reset)
> +
> +properties:
> +  $nodename:
> +    pattern: "^reset-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    const: microchip,sparx5-switch-reset
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  cpu-syscon:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: syscon used to access CPU reset
> +    maxItems: 1
> +
> +  gcb-syscon:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: syscon used to access Global Control Block
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#reset-cells"
> +  - cpu-syscon
> +  - gcb-syscon
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reset: reset-controller@0 {
> +        compatible = "microchip,sparx5-switch-reset";
> +        reg = <0x0 0x0>;
> +        #reset-cells = <1>;
> +        cpu-syscon = <&cpu_ctrl>;
> +        gcb-syscon = <&gcb_ctrl>;
> +    };
> +
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
