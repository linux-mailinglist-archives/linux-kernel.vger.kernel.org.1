Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFDE25761A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHaJKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 05:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgHaJKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:10:17 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA14208CA;
        Mon, 31 Aug 2020 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598865017;
        bh=xkIiQZIfoQl2bQbnJEPjzxwz9aN+LEVkxm/utYNgnO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OO/lrWcWLd2jJyJXwQhbOQl9l2X8jz9y4rIm4eVp/ibKO4xYZPe0SUIBukIwQgNO7
         V8uf29qIyIg6XUydrpIvFZ0b5Ss9P2kwZeOjlJNIoqdEaVkUIoY8AFNJ+0KVQ+VQP6
         OOGUjYaTwASCtJmrcYq3TNk4kP2kK4fy1y87q+kQ=
Date:   Mon, 31 Aug 2020 14:40:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, andriy.shevchenko@intel.com,
        eswara.kota@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Message-ID: <20200831091013.GL2639@vkoul-mobl>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200821113747.2912-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821113747.2912-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-20, 19:37, Wan Ahmad Zainie wrote:
> Binding description for Intel Keem Bay eMMC PHY.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/phy/intel,keembay-emmc-phy.yaml  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> new file mode 100644
> index 000000000000..4cbbd3887c13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay eMMC PHY bindings

This seems same as
Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml, why not
add a new compatible in lgm binding, or did I miss a difference?

> +
> +maintainers:
> +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,keembay-emmc-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: emmcclk
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@20290000 {
> +          compatible = "intel,keembay-emmc-phy";
> +          reg = <0x20290000 0x54>;
> +          clocks = <&emmc>;
> +          clock-names = "emmcclk";
> +          #phy-cells = <0>;
> +    };
> -- 
> 2.17.1

-- 
~Vinod
