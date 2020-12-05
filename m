Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7C2CFA72
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgLEIFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgLEIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:05:40 -0500
Date:   Sat, 5 Dec 2020 13:34:55 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607155499;
        bh=9PjLV9MsP9K+cGD91+0hW5yFXhRvKI8seWclNH3MucU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6vE5mDrnq4WYbg4/sZKPP8eA3yukG74/1auvCgaBU7AurwAeMJ3fS4nvLidOCnSL
         hZ/iOvwPqJnidcZLoOGY+XsqXuHBsQ70yBuOClCLfy9ZOPw5ZZNS6OqJWrfI+ZiGm3
         p4RosQXdKba7Awf2CdrWHorKdcAH8G8F9QX+w9AQ+9sQFkLfp1LlwanaUeNkxIggIg
         fal8I4zn722n0HiamAqIxuMF33Hk92YzHDtTyZD+4tetW8DSOW0VgTmzcUmXItFid5
         4Zi3WuDT4Pu4/2ueCcCHkUtBJ89FflYQDwPCnz5tDwYsodSW055ucgwMHAsOqerRhu
         q3wdjzKYfUHNg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY
 bindings
Message-ID: <20201205080455.GU8403@vkoul-mobl>
References: <20201123145157.300456-1-narmstrong@baylibre.com>
 <20201123145157.300456-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123145157.300456-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-20, 15:51, Neil Armstrong wrote:
> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
> 
> This Analog D-PHY works with a separate Digital MIPI D-PHY.

Pls cc Rob on dt binding patches (hint get_maintainer.pl would tell you
do so)

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> new file mode 100644
> index 000000000000..28663552f05b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic G12A MIPI analog PHY
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |+
> +  The Everything-Else Power Domains node should be the child of a syscon
> +  node with the required property:
> +
> +  - compatible: Should be the following:
> +                "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
> +
> +  Refer to the the bindings described in
> +  Documentation/devicetree/bindings/mfd/syscon.yaml
> +
> +properties:
> +  compatible:
> +    const: amlogic,g12a-mipi-dphy-analog
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mpphy: phy {
> +          compatible = "amlogic,g12a-mipi-dphy-analog";
> +          #phy-cells = <0>;
> +    };
> -- 
> 2.25.1

-- 
~Vinod
