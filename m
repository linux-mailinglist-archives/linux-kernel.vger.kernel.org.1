Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850E921CE76
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 06:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgGME7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 00:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGME7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:59:44 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D7E2073A;
        Mon, 13 Jul 2020 04:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594616384;
        bh=Uo3ZuWzbEoHlUPyhOZImPSSVLS7iqxNl2AlQNgt1NO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcqwQ7km3Q3UMyE91gFbM9UWbd4Gv6xVn+D2wz7LOZj1z51Z7/HbYQaeOhygYP5hv
         TOVd1ZRZ4hm3eY9OgpWx4J9XRrHv5mmPWGUZByY7VN8FKN5LTGwxwq/VlYE6L3dYcx
         ayOVfMIxg3B5mvpnfyYpQrzwseWhXjgMI6r5cGMw=
Date:   Mon, 13 Jul 2020 10:29:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add UniPhier AHCI PHY
 description
Message-ID: <20200713045940.GQ34333@vkoul-mobl>
References: <1593507574-10007-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1593507574-10007-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593507574-10007-2-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-20, 17:59, Kunihiko Hayashi wrote:
> Add DT bindings for PHY interface built into ahci controller implemented
> in UniPhier SoCs.

Rob ?

> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/phy/socionext,uniphier-ahci-phy.yaml  | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> new file mode 100644
> index 0000000..bab2ff4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/socionext,uniphier-ahci-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier AHCI PHY
> +
> +description: |
> +  This describes the deivcetree bindings for PHY interfaces built into
> +  AHCI controller implemented on Socionext UniPhier SoCs.
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - socionext,uniphier-pxs2-ahci-phy
> +      - socionext,uniphier-pxs3-ahci-phy
> +
> +  reg:
> +    description: PHY register region (offset and length)
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - items:          # for PXs2
> +        - const: link
> +      - items:          # for others
> +        - const: link
> +        - const: phy
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: link
> +      - const: phy
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ahci-glue@65700000 {
> +        compatible = "socionext,uniphier-pxs3-ahci-glue",
> +                     "simple-mfd";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x65700000 0x100>;
> +
> +        ahci_phy: phy@10 {
> +            compatible = "socionext,uniphier-pxs3-ahci-phy";
> +            reg = <0x10 0x10>;
> +            #phy-cells = <0>;
> +            clock-names = "link", "phy";
> +            clocks = <&sys_clk 28>, <&sys_clk 30>;
> +            reset-names = "link", "phy";
> +            resets = <&sys_rst 28>, <&sys_rst 30>;
> +        };
> +    };
> -- 
> 2.7.4

-- 
~Vinod
