Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216152D520B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgLJDug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:50:36 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:38031 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgLJDua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:50:30 -0500
Received: by mail-oo1-f68.google.com with SMTP id i18so962734ooh.5;
        Wed, 09 Dec 2020 19:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BCxJsQg1ul9QJzRyHjEilBFVKtIs8lkQBSz8/W5bH2A=;
        b=qHw/Q8uAOjTc0cOxct1DUXvAQuI2ADW1zv6biQAEwltmqKVl+8r5+e6RM/D9l1X4A1
         /gEtIuwzBmOeT2Ahvd+3JYKp0WKDArGMvxogrlGbxYCl09XxNCfRvTgoiWkSGDuw1G5U
         9Of2qZjV37cm5oH6jxCZlhbGJleXiFhfKe46/echbLtDGIpSWf7xWHxxcy61z1AkUfJc
         m565F2ZlQNiDSAx0Qp3wPMMMzOtgALsGUPOgQD+JszmAtvIYV+GzTlGHtQhA4JFKLeh4
         89LtyLzGJjsO+/c/oDUctKh+fwrXiJsgmO6tO3yoMf1LKyiMwEGpwlMq3kGjaBQFYRIb
         sLzA==
X-Gm-Message-State: AOAM530R0zH/Alb4dX2SVP8lyA86xOeGGyoeFzLcSgNMfjoAVZLP/kSf
        60QgatxS+T1de+FAw/qKzmYDRopbIA==
X-Google-Smtp-Source: ABdhPJzIfzWCH7XIrmZPqpuHZq9uqc/+VvK5Aie2DaCMeEOWzCR4gtIt6m7I99FYly/EEJk6512JTg==
X-Received: by 2002:a4a:d998:: with SMTP id k24mr1675770oou.23.1607572189367;
        Wed, 09 Dec 2020 19:49:49 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j73sm837962otj.37.2020.12.09.19.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:49:48 -0800 (PST)
Received: (nullmailer pid 1624587 invoked by uid 1000);
        Thu, 10 Dec 2020 03:49:47 -0000
Date:   Wed, 9 Dec 2020 21:49:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: add Unisoc's dpu bindings
Message-ID: <20201210034947.GA1622093@robh.at.kernel.org>
References: <1607352626-26088-1-git-send-email-kevin3.tang@gmail.com>
 <1607352626-26088-4-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607352626-26088-4-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:50:23PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
> 
> DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
> which transfers the image data from a video memory buffer to an internal
> LCD interface.
> 
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
> new file mode 100644
> index 0000000..a9052e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc Sharkl3 Display Processor Unit (DPU)
> +
> +maintainers:
> +  - Kevin Tang <kevin.tang@unisoc.com>
> +
> +description: |
> +  DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
> +  which transfers the image data from a video memory buffer to an internal
> +  LCD interface.
> +
> +properties:
> +  compatible:
> +    const: sprd,sharkl3-dpu
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Physical base address and length of the DPU registers set

Drop. Nothing unique about this.

> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      The interrupt signal from DPU

Drop.

> +
> +  clocks:
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: clk_src_128m
> +      - const: clk_src_384m
> +
> +  power-domains:
> +    maxItems: 1
> +    description: A phandle to DPU power domain node.

Drop.

> +
> +  iommus:
> +    maxItems: 1
> +    description: A phandle to DPU iommu node.

Drop.

With those,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  port:
> +    type: object
> +    description:
> +      A port node with endpoint definitions as defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt.
> +      That port should be the output endpoint, usually output to
> +      the associated DSI.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/sprd,sc9860-clk.h>
> +    dpu: dpu@63000000 {
> +        compatible = "sprd,sharkl3-dpu";
> +        reg = <0x63000000 0x1000>;
> +        interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +        clock-names = "clk_src_128m", "clk_src_384m";
> +
> +        clocks = <&pll CLK_TWPLL_128M>,
> +          <&pll CLK_TWPLL_384M>;
> +
> +        dpu_port: port {
> +            dpu_out: endpoint {
> +                remote-endpoint = <&dsi_in>;
> +            };
> +        };
> +    };
> -- 
> 2.7.4
> 
