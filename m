Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC8B27D47C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgI2RaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2RaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:30:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30A9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:30:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so4420122pgf.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fFztEzSJ2rV1rMZN9OkJojf3DIgVoZo3w4SHkm4pQyk=;
        b=aeynrkEnHlUKQBiPgnMNPHfg0Nz/g4+4y8462gVE1P3bPzk3sGsp1nXqWgmTcx537r
         K7NYa5MGpJxLWQ/ElST1A5ZqgN+GdxSQwLJiXt3UDJIVJdAR/ChP3fkVCrpIRP+IdFXy
         8Yjieyth0CDInMoo2PGaIxgNGd8tsKCbAjF6QurEsgKr5SrrhLO5GkOZgn/9ePtPy+Q4
         /FAckVwJnbOUDfuknKlAEctofIK3BQaIJOd8FlKw0yn2dIZi0km/l7eBAEuvVvGSyBg7
         FeCjLtaeZjT2Zy52Sjl4EUXfOEO1I6G6g0x3Wkq7HI+szuz9JNYZsByWB7AwNGc+Qz8Q
         hmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fFztEzSJ2rV1rMZN9OkJojf3DIgVoZo3w4SHkm4pQyk=;
        b=PW2W+c2fMyVp4PRuKvLWOxAQ/BwOjBtAHUaVzBVyNlXx+GdIk8Tivf5AYIXh/dib1Y
         GHMcl4iTmuZjHuWyuenn/CZSCgmws8b7wSUCM272ePbI7AlP+00c+vp3Vt1VQSfi8BV2
         ksK3dFHLdJKE+GeDxQjI53KakTcLX0mRf9KS8h5HwJ8AHegP0Rn0zNRQj/wG50uSvTAN
         jm05TGP/VQcYNigW1Ul4MtwDzupwtRWnhTkw3aHIa30VxD5o9IZxUIAoOzbfSgPQwMTH
         m9lzxVVmvR63BgkNQFJfZVZFQTblE8yssjgTHPYzmDBLA6NLtk3rf7gu8mDxZWh94sbJ
         nRkg==
X-Gm-Message-State: AOAM532+zftnPOqcr9VHfTA07NTLvpLqLFHU4wDEj+SLnTnMuh1Jicvg
        gGiKtEQe2kc8/La5exPAdwqgRg==
X-Google-Smtp-Source: ABdhPJwYRq0qr3kl6y4PgVWlwBb8KVS0Fu4JKWsnWScQjJaKTexwp1yZHfnEDT2p1jBCWeNI6lFv2A==
X-Received: by 2002:a62:26c1:0:b029:142:2501:35ef with SMTP id m184-20020a6226c10000b0290142250135efmr4783468pfm.79.1601400606139;
        Tue, 29 Sep 2020 10:30:06 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n72sm6976829pfd.27.2020.09.29.10.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:30:05 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:30:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, gpain@baylibre.com
Subject: Re: [PATCH v2 1/4] dt bindings: remoteproc: Add bindings for MT8183
 APU
Message-ID: <20200929173003.GA124290@xps15>
References: <20200910130148.8734-1-abailon@baylibre.com>
 <20200910130148.8734-2-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910130148.8734-2-abailon@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 03:01:45PM +0200, Alexandre Bailon wrote:
> This adds dt bindings for the APU present in the MT8183.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../bindings/remoteproc/mtk,apu.yaml          | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> new file mode 100644
> index 000000000000..7a71d2f5c4e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +
> +---
> +$id: "http://devicetree.org/schemas/remoteproc/mtk,apu.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MT8183 AI Processor Unit (APU) a.k.a. Vision Processor Unit (VPU)
> +
> +description:
> +  This document defines the binding for the APU, a co-processor that could
> +  offload the CPU for machine learning and neural network.
> +
> +maintainers:
> +  - Alexandre Bailon <abailon@bayLibre.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8183-apu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Three clocks are expected for AXI, IPU and JTAG.
> +      The JTAG clock seems to be required to run the DSP,
> +      even when JTAG is not in use."
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: axi
> +      - const: ipu
> +      - const: jtag
> +
> +  iommus:
> +    maxItems: 3
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  pinctrl:
> +    description: pinctrl handles, required to configure pins for JTAG.
> +
> +  pinctrl-names:
> +    items:
> +      - const: jtag
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - iommus
> +  - memory-region
> +  - power-domains
> +
> +additionalProperties: false
> +

What about the pintctrl for the JTAG part?

> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt8183-larb-port.h>
> +    #include <dt-bindings/power/mt8183-power.h>
> +
> +    reserved-memory {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges;
> +
> +      apu_ram: apu_ram@0x60000000 {
> +        compatible = "shared-dma-pool";
> +        reg = <0x60000000 0x040000000>;
> +        no-map;
> +        linux,cma-default;
> +      };
> +    };
> +
> +    apu0: apu@19100000 {
> +      compatible = "mediatek,mt8183-apu";
> +      reg = <0x19180000 0x14000>;
> +      interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_LOW>;
> +
> +      iommus = <&iommu M4U_PORT_IMG_IPUO>,
> +         <&iommu M4U_PORT_IMG_IPU3O>,
> +         <&iommu M4U_PORT_IMG_IPUI>;
> +
> +      clocks = <&ipu_core0 CLK_IPU_CORE0_AXI>,
> +         <&ipu_core0 CLK_IPU_CORE0_IPU>,
> +         <&ipu_core0 CLK_IPU_CORE0_JTAG>;
> +
> +      clock-names = "axi", "ipu", "jtag";
> +
> +      power-domains = <&scpsys MT8183_POWER_DOMAIN_VPU_CORE0>;
> +      memory-region = <&apu_ram>;
> +    };
> +...
> -- 
> 2.26.2
> 
