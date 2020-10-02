Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9C2810E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgJBLEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:04:34 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:35113 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgJBLEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:04:31 -0400
Received: by mail-ej1-f67.google.com with SMTP id u21so1388023eja.2;
        Fri, 02 Oct 2020 04:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=56tAhYBdNf3KNX8Oab3+P5svy0t0kpZJMlSJZcWZN34=;
        b=k1bXMpe8vUGzf2FOQwS2IVHjzb0fnEWgv9h/s3IlamGTJ8BxDXB+XPUBCI5lCHv0Nb
         OtGchFCPB2OFvzS+hrieBbwNnq8jHAIZNPH13nyaeoni7EWLh2H9mnCPMc7+wdg5V08t
         /Vywq78WUHGa09VhbgwzGdlIU3jm2jZhEhEXHcc/1E5ndFQLKdyeC1ZzdrlAKDaJgZEj
         nVkkgZa9NCtYKiMYg7Yj9xp7T43MFH9SNG/KuAJjvxwE8PJbDzjteR2Z+C6kVbqtvFiU
         VUsxfZYciH7w/PZpCkOtPcHgNuy+IcpLGkfMgM3m9yDgvd5sE5gjbu5WJCZvIuilM4tp
         Bruw==
X-Gm-Message-State: AOAM531oQRlgmKGweKNsXsqOR0U+ygbcLmvBdgnA4cBA93yC+w224aSR
        E6aUvZoYUJvo6k06+u9bKAg=
X-Google-Smtp-Source: ABdhPJz8JVKuuqO6jwLTNtxzltCz4QZ0ABVNv87BKmR6ouVGmjyGL9JMc7xLOHcn7riQZyRBrmknaQ==
X-Received: by 2002:a17:906:a4e:: with SMTP id x14mr1659945ejf.112.1601636666973;
        Fri, 02 Oct 2020 04:04:26 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id g11sm936712edj.85.2020.10.02.04.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 04:04:26 -0700 (PDT)
Date:   Fri, 2 Oct 2020 13:04:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
Message-ID: <20201002110423.GB6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  49 ---------
>  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
>  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
>  4 files changed, 191 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> deleted file mode 100644
> index b64573680b42..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -SMI (Smart Multimedia Interface) Common
> -
> -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> -
> -Mediatek SMI have two generations of HW architecture, here is the list
> -which generation the SoCs use:
> -generation 1: mt2701 and mt7623.
> -generation 2: mt2712, mt6779, mt8173 and mt8183.
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
> index 000000000000..76ecc7205438
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

You relicense existing GPLv2 work. Please CC all contributors and
collect their acks/SoB.

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
> +  generation 2: mt2712, mt6779, mt8173 and mt8183.
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
> +  clocks:
> +    description: |
> +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> +      gals(global async local sync) also is optional, here is the list which
> +      require gals: mt6779 and mt8183.
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

You put here five items, but max are four. Does it really work as
intended?

> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: apb
> +          - const: smi
> +      - items:
> +          - const: apb
> +          - const: smi
> +          - const: async
> +      - items:
> +          - const: apb
> +          - const: smi
> +          - const: gals0
> +          - const: gals1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
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
> index 8f19dfe7d80e..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
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
> -Required property for mt2701, mt2712, mt6779 and mt7623:
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
> index 000000000000..50793a0e6759
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

The same - you need to collect licensing change agreements.

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
> +      apb and smi are mandatory. gals(global async local sync) is optional,
> +      here is the list which require gals: mt8183.
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +       - description: apb is Advanced Peripheral Bus clock, It's the clock for
> +           setting the register.
> +       - description: smi is the clock for transfer data and command.
> +       - description: the clock for gals.
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +         - const: apb
> +         - const: smi
> +      - items:
> +         - const: apb
> +         - const: smi
> +         - const: gals
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
> +    maximum: 15
> +    description: the hardware id of this larb.
> +      Required property for mt2701, mt2712, mt6779 and mt7623.

You need if-then-required for this. See
Documentation/devicetree/bindings/example-schema.yaml for example.

Best regards,
Krzysztof
