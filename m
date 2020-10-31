Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B32A15C9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 12:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgJaLiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 07:38:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51160 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgJaLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 07:36:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id 13so5073378wmf.0;
        Sat, 31 Oct 2020 04:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5i7Xu4MHXboDXAyc173g9+q/jTnbwYy+UHkXY4eLZQ=;
        b=RoQVg9HNXhwh+HjTqkW0TWIMQJ2EvzrIUokJdfe7VUv+scL8zwAgAD1wWsMz3GaSiT
         VDA4HVPWuJT5NGpSyeWdVIn/dOdZQHDi8ZsuNA0sIdmefBGUjSHwE2mqP9NsXsnGL5+J
         x0SBDp2BV4pW6kl3wFfJMcplM2HteflDEENqbGmVB/7uqeFgwZ5OINWpIbL1kEJN/gfG
         Cr3/14FhprPtgPlN63+YfCmFRzaGphPkjqLw0bQpoyeo5qaMpW5ckr1y8VFnWYqUmOHH
         zbR7sWdRWyzDA4/Oxdv9G/ySqgQeqMTYHG8sqB8DYuFu6SRrl+EtnmcgqJM1iNupzw1a
         5Csg==
X-Gm-Message-State: AOAM5331IojhuDJmat04ymkeaijzKSA2Qp4/zeG/S7tZESx0rL2nYXt4
        hGGvq0jvuv6PgcI141LxnmM=
X-Google-Smtp-Source: ABdhPJznwM9PsqLHF7/6r60UZtYG2AF8oU/gvc2VY1jXfXhFCKNveN5CWCSXc4b2G/GpNroMyXVE2w==
X-Received: by 2002:a1c:9641:: with SMTP id y62mr7965533wmd.145.1604144187654;
        Sat, 31 Oct 2020 04:36:27 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e2sm15256658wrr.85.2020.10.31.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 04:36:26 -0700 (PDT)
Date:   Sat, 31 Oct 2020 12:36:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        ming-fan.chen@mediatek.com, Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
 schema
Message-ID: <20201031113623.GA4019@kozik-lap>
References: <20201030091254.26382-1-yong.wu@mediatek.com>
 <20201030091254.26382-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201030091254.26382-2-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 05:12:52PM +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> CC: Fabien Parent <fparent@baylibre.com>
> CC: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  50 -------
>  .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
>  .../memory-controllers/mediatek,smi-larb.yaml | 129 ++++++++++++++++
>  4 files changed, 269 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt

+Cc Honghui Zhang,

Your Ack is needed as you contributed descriptions to the bindings and
work is being relicensed to GPL-2.0-only OR BSD-2-Clause.


Best regards,
Krzysztof




>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> deleted file mode 100644
> index dbafffe3f41e..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -SMI (Smart Multimedia Interface) Common
> -
> -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> -
> -Mediatek SMI have two generations of HW architecture, here is the list
> -which generation the SoCs use:
> -generation 1: mt2701 and mt7623.
> -generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
> -
> -There's slight differences between the two SMI, for generation 2, the
> -register which control the iommu port is at each larb's register base. But
> -for generation 1, the register is at smi ao base(smi always on register
> -base). Besides that, the smi async clock should be prepared and enabled for
> -SMI generation 1 to transform the smi clock into emi clock domain, but that is
> -not needed for SMI generation 2.
> -
> -Required properties:
> -- compatible : must be one of :
> -	"mediatek,mt2701-smi-common"
> -	"mediatek,mt2712-smi-common"
> -	"mediatek,mt6779-smi-common"
> -	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
> -	"mediatek,mt8167-smi-common"
> -	"mediatek,mt8173-smi-common"
> -	"mediatek,mt8183-smi-common"
> -- reg : the register and size of the SMI block.
> -- power-domains : a phandle to the power domain of this local arbiter.
> -- clocks : Must contain an entry for each entry in clock-names.
> -- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
> -  for generation 2 smi HW as follows:
> -  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
> -	    the register.
> -  - "smi" : It's the clock for transfer data and command.
> -	    They may be the same if both source clocks are the same.
> -  - "async" : asynchronous clock, it help transform the smi clock into the emi
> -	      clock domain, this clock is only needed by generation 1 smi HW.
> -  and these 2 option clocks for generation 2 smi HW:
> -  - "gals0": the path0 clock of GALS(Global Async Local Sync).
> -  - "gals1": the path1 clock of GALS(Global Async Local Sync).
> -  Here is the list which has this GALS: mt6779 and mt8183.
> -
> -Example:
> -	smi_common: smi@14022000 {
> -		compatible = "mediatek,mt8173-smi-common";
> -		reg = <0 0x14022000 0 0x1000>;
> -		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> -		clocks = <&mmsys CLK_MM_SMI_COMMON>,
> -			 <&mmsys CLK_MM_SMI_COMMON>;
> -		clock-names = "apb", "smi";
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> new file mode 100644
> index 000000000000..e050a0c2aed6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SMI (Smart Multimedia Interface) Common
> +
> +maintainers:
> +  - Yong Wu <yong.wu@mediatek.com>
> +
> +description: |+
> +  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
> +
> +  MediaTek SMI have two generations of HW architecture, here is the list
> +  which generation the SoCs use:
> +  generation 1: mt2701 and mt7623.
> +  generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
> +
> +  There's slight differences between the two SMI, for generation 2, the
> +  register which control the iommu port is at each larb's register base. But
> +  for generation 1, the register is at smi ao base(smi always on register
> +  base). Besides that, the smi async clock should be prepared and enabled for
> +  SMI generation 1 to transform the smi clock into emi clock domain, but that is
> +  not needed for SMI generation 2.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-smi-common
> +          - mediatek,mt2712-smi-common
> +          - mediatek,mt6779-smi-common
> +          - mediatek,mt8167-smi-common
> +          - mediatek,mt8173-smi-common
> +          - mediatek,mt8183-smi-common
> +
> +      - description: for mt7623
> +        items:
> +          - const: mediatek,mt7623-smi-common
> +          - const: mediatek,mt2701-smi-common
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> +      gals(global async local sync) also is optional, see below.
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> +          setting the register.
> +      - description: smi is the clock for transfer data and command.
> +      - description: async is asynchronous clock, it help transform the smi clock
> +          into the emi clock domain.
> +      - description: gals0 is the path0 clock of gals.
> +      - description: gals1 is the path1 clock of gals.
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if: #only for gen1 HW
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt2701-smi-common
> +    then:
> +       properties:
> +         clock:
> +           items:
> +             minItems: 3
> +             maxItems: 3
> +         clock-names:
> +           items:
> +             - const: apb
> +             - const: smi
> +             - const: async
> +
> +  - if: #for gen2 HW that have gals
> +      properties:
> +        compatible:
> +            enum:
> +              - mediatek,mt6779-smi-common
> +              - mediatek,mt8183-smi-common
> +
> +    then:
> +      properties:
> +        clock:
> +          items:
> +            minItems: 4
> +            maxItems: 4
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +            - const: gals0
> +            - const: gals1
> +
> +    else: #for gen2 HW that don't have gals
> +      properties:
> +        clock:
> +          items:
> +            minItems: 2
> +            maxItems: 2
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/power/mt8173-power.h>
> +
> +    smi_common: smi@14022000 {
> +            compatible = "mediatek,mt8173-smi-common";
> +            reg = <0x14022000 0x1000>;
> +            power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> +            clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +                     <&mmsys CLK_MM_SMI_COMMON>;
> +            clock-names = "apb", "smi";
> +    };
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> deleted file mode 100644
> index 0c5de12b5496..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -SMI (Smart Multimedia Interface) Local Arbiter
> -
> -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> -
> -Required properties:
> -- compatible : must be one of :
> -		"mediatek,mt2701-smi-larb"
> -		"mediatek,mt2712-smi-larb"
> -		"mediatek,mt6779-smi-larb"
> -		"mediatek,mt7623-smi-larb", "mediatek,mt2701-smi-larb"
> -		"mediatek,mt8167-smi-larb"
> -		"mediatek,mt8173-smi-larb"
> -		"mediatek,mt8183-smi-larb"
> -- reg : the register and size of this local arbiter.
> -- mediatek,smi : a phandle to the smi_common node.
> -- power-domains : a phandle to the power domain of this local arbiter.
> -- clocks : Must contain an entry for each entry in clock-names.
> -- clock-names: must contain 2 entries, as follows:
> -  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
> -	    the register.
> -  - "smi" : It's the clock for transfer data and command.
> -  and this optional clock name:
> -  - "gals": the clock for GALS(Global Async Local Sync).
> -  Here is the list which has this GALS: mt8183.
> -
> -Required property for mt2701, mt2712, mt6779, mt7623 and mt8167:
> -- mediatek,larb-id :the hardware id of this larb.
> -
> -Example:
> -	larb1: larb@16010000 {
> -		compatible = "mediatek,mt8173-smi-larb";
> -		reg = <0 0x16010000 0 0x1000>;
> -		mediatek,smi = <&smi_common>;
> -		power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> -		clocks = <&vdecsys CLK_VDEC_CKEN>,
> -			 <&vdecsys CLK_VDEC_LARB_CKEN>;
> -		clock-names = "apb", "smi";
> -	};
> -
> -Example for mt2701:
> -	larb0: larb@14010000 {
> -		compatible = "mediatek,mt2701-smi-larb";
> -		reg = <0 0x14010000 0 0x1000>;
> -		mediatek,smi = <&smi_common>;
> -		mediatek,larb-id = <0>;
> -		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> -			 <&mmsys CLK_MM_SMI_LARB0>;
> -		clock-names = "apb", "smi";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> new file mode 100644
> index 000000000000..a11a105e872f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-larb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SMI (Smart Multimedia Interface) Local Arbiter
> +
> +maintainers:
> +  - Yong Wu <yong.wu@mediatek.com>
> +
> +description: |+
> +  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-smi-larb
> +          - mediatek,mt2712-smi-larb
> +          - mediatek,mt6779-smi-larb
> +          - mediatek,mt8167-smi-larb
> +          - mediatek,mt8173-smi-larb
> +          - mediatek,mt8183-smi-larb
> +
> +      - description: for mt7623
> +        items:
> +          - const: mediatek,mt7623-smi-larb
> +          - const: mediatek,mt2701-smi-larb
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      apb and smi are mandatory. gals(global async local sync) is optional.
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +       - description: apb is Advanced Peripheral Bus clock, It's the clock for
> +           setting the register.
> +       - description: smi is the clock for transfer data and command.
> +       - description: the clock for gals.
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mediatek,smi:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: a phandle to the smi_common node.
> +
> +  mediatek,larb-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 31
> +    description: the hardware id of this larb.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +allOf:
> +  - if: # HW has gals
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8183-smi-larb
> +
> +    then:
> +      properties:
> +        clock:
> +          items:
> +            minItems: 3
> +            maxItems: 3
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +            - const: gals
> +
> +    else:
> +      properties:
> +        clock:
> +          items:
> +            minItems: 2
> +            maxItems: 2
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt2701-smi-larb
> +              - mediatek,mt2712-smi-larb
> +              - mediatek,mt6779-smi-larb
> +              - mediatek,mt8167-smi-larb
> +
> +    then:
> +      required:
> +        - mediatek,larb-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/power/mt8173-power.h>
> +
> +    larb1: larb@16010000 {
> +      compatible = "mediatek,mt8173-smi-larb";
> +      reg = <0x16010000 0x1000>;
> +      mediatek,smi = <&smi_common>;
> +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> +      clocks = <&vdecsys CLK_VDEC_CKEN>,
> +               <&vdecsys CLK_VDEC_LARB_CKEN>;
> +      clock-names = "apb", "smi";
> +    };
> -- 
> 2.18.0
