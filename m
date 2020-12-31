Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034B82E8121
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgLaP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 10:58:00 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33708 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLaP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 10:57:59 -0500
Received: by mail-ot1-f45.google.com with SMTP id b24so18331317otj.0;
        Thu, 31 Dec 2020 07:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ByUTKTXYsaKBw8iUInn/Gs7vPhqgWrVkrRV5lDm+3Hs=;
        b=ZtImf8c/QoUAxLTGjLhxN2SkgYwUjRPjtLQL9uW9l1IFWJ6RRI05D/HP9gNeBttJl1
         4iYMxNMaGOksNg/QarRo3ExHQsHzhTOuPO7cGsx56r27bVToKl67zR8lkX6hrdbqtT7c
         zmNJ54EUNcaaYen6IJHj9qA4wJ9VfcOflbUUpSctCCrPh43OYYP8vIy1bBVBLu1qPLF4
         bWHkPjtyKC5Yi2pJqcD8sZtVFz9wFApKSf6FBYoj2+AnZpcP0XvRt+7hHFmtc6OdIylC
         Raw5+tEdvezwQgFQ0UFPrINQ4nVLf1gbnVqEO5iImSur3KKzqb8LLTFLcIJum/MgG+Px
         yQdQ==
X-Gm-Message-State: AOAM533se+cHSr1BtI677CF14EYFSarBdWi7IRmfjulPt/Xi0mdeIFSE
        YGhgXRxeJWHCudanceyXvA==
X-Google-Smtp-Source: ABdhPJwmNEpry9jqQG2UErzq8jVGMxSNohDp/TpPtIPfqvpyd+3br4Z6s3jrNEp0ERAQ63zsjbI3Yw==
X-Received: by 2002:a9d:7cc9:: with SMTP id r9mr18633469otn.283.1609430237889;
        Thu, 31 Dec 2020 07:57:17 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l5sm11198656otj.57.2020.12.31.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 07:57:17 -0800 (PST)
Received: (nullmailer pid 1863518 invoked by uid 1000);
        Thu, 31 Dec 2020 15:57:15 -0000
Date:   Thu, 31 Dec 2020 08:57:15 -0700
From:   Rob Herring <robh@kernel.org>
To:     Nick Fan <Nick.Fan@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Convert Arm Mali Valhall GPU to DT
 schema
Message-ID: <20201231155715.GA1852831@robh.at.kernel.org>
References: <20201224123119.26504-1-Nick.Fan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224123119.26504-1-Nick.Fan@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 08:31:18PM +0800, Nick Fan wrote:
> Convert the Arm Valhall GPU binding to DT schema format.

Convert? There's no existing binding.

> 
> Define a compatible string for the Mali Valhall GPU
> for Mediatek's SoC platform.
> 
> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> ---
>  .../bindings/gpu/arm,mali-valhall.yaml        | 252 ++++++++++++++++++
>  1 file changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> new file mode 100644
> index 000000000000..3dba202bec95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> @@ -0,0 +1,252 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/arm,mali-vallhall.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Mali Valhall GPU
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +properties:
> +  $nodename:
> +    pattern: '^gpu@[a-f0-9]+$'
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8192-mali
> +      - const: arm,mali-valhall # Mali Valhall GPU model/revision is fully discoverable
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: GPU interrupt
> +      - description: MMU interrupt
> +      - description: Job interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: gpu
> +      - const: mmu
> +      - const: job
> +
> +  clocks:
> +    minItems: 1
> +
> +  power-domains:
> +    minItems: 1
> +    maxItems: 5
> +
> +  mali-supply: true
> +  sram-supply: true
> +
> +  operating-points-v2: true
> +
> +  "#cooling-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8192-mali
> +    then:
> +      properties:
> +        sram-supply: true

No need for this line.

> +        power-domains:
> +          description:
> +            List of phandle and PM domain specifier as documented in
> +            Documentation/devicetree/bindings/power/power_domain.txt

No need re-describe a common property.

> +          minItems: 5
> +          maxItems: 5

blank line between DT properties.

> +        power-domain-names:
> +          items:
> +            - const: core0
> +            - const: core1
> +            - const: core2
> +            - const: core3
> +            - const: core4
> +
> +      required:
> +        - sram-supply
> +        - power-domains
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpu@13000000 {
> +           compatible = "mediatek,mt8192-mali", "arm,mali-valhall";
> +           reg = <0x13000000 0x4000>;
> +           interrupts =
> +                   <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
> +                   <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
> +                   <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>;
> +           interrupt-names =
> +                   "gpu",
> +                   "mmu",
> +                   "job";
> +
> +           clocks = <&mfgcfg 0>;
> +
> +           power-domains =
> +                   <&scpsys 4>,
> +                   <&scpsys 5>,
> +                   <&scpsys 6>,
> +                   <&scpsys 7>,
> +                   <&scpsys 8>;
> +
> +           operating-points-v2 = <&gpu_opp_table>;
> +           mali-supply = <&mt6315_7_vbuck1>;
> +           sram-supply = <&mt6359_vsram_others_ldo_reg>;
> +    };
> +
> +    gpu_opp_table: opp_table0 {

Make this a child of the gpu node. Node name should be just 'opp-table'.

> +      compatible = "operating-points-v2";
> +      opp-shared;
> +
> +      opp-358000000 {
> +              opp-hz = /bits/ 64 <358000000>;
> +              opp-hz-real = /bits/ 64 <358000000>,

I don't recall this being an OPP property.

> +                            /bits/ 64 <358000000>;
> +              opp-microvolt = <606250>,
> +                              <750000>;
> +      };
> +
> +      opp-399000000 {
> +              opp-hz = /bits/ 64 <399000000>;
> +              opp-hz-real = /bits/ 64 <399000000>,
> +                            /bits/ 64 <399000000>;
> +              opp-microvolt = <618750>,
> +                              <750000>;
> +      };
> +
> +      opp-440000000 {
> +              opp-hz = /bits/ 64 <440000000>;
> +              opp-hz-real = /bits/ 64 <440000000>,
> +                            /bits/ 64 <440000000>;
> +              opp-microvolt = <631250>,
> +                              <750000>;
> +      };
> +
> +      opp-482000000 {
> +              opp-hz = /bits/ 64 <482000000>;
> +              opp-hz-real = /bits/ 64 <482000000>,
> +                            /bits/ 64 <482000000>;
> +              opp-microvolt = <643750>,
> +                              <750000>;
> +      };
> +
> +      opp-523000000 {
> +              opp-hz = /bits/ 64 <523000000>;
> +              opp-hz-real = /bits/ 64 <523000000>,
> +                            /bits/ 64 <523000000>;
> +              opp-microvolt = <656250>,
> +                              <750000>;
> +      };
> +
> +      opp-564000000 {
> +              opp-hz = /bits/ 64 <564000000>;
> +              opp-hz-real = /bits/ 64 <564000000>,
> +                            /bits/ 64 <564000000>;
> +              opp-microvolt = <668750>,
> +                              <750000>;
> +      };
> +
> +      opp-605000000 {
> +              opp-hz = /bits/ 64 <605000000>;
> +              opp-hz-real = /bits/ 64 <605000000>,
> +                            /bits/ 64 <605000000>;
> +              opp-microvolt = <681250>,
> +                              <750000>;
> +      };
> +
> +      opp-647000000 {
> +              opp-hz = /bits/ 64 <647000000>;
> +              opp-hz-real = /bits/ 64 <647000000>,
> +                            /bits/ 64 <647000000>;
> +              opp-microvolt = <693750>,
> +                              <750000>;
> +      };
> +
> +      opp-688000000 {
> +              opp-hz = /bits/ 64 <688000000>;
> +              opp-hz-real = /bits/ 64 <688000000>,
> +                            /bits/ 64 <688000000>;
> +              opp-microvolt = <706250>,
> +                              <750000>;
> +      };
> +
> +      opp-724000000 {
> +              opp-hz = /bits/ 64 <724000000>;
> +              opp-hz-real = /bits/ 64 <724000000>,
> +                            /bits/ 64 <724000000>;
> +              opp-microvolt = <725000>,
> +                              <750000>;
> +      };
> +
> +      opp-760000000 {
> +              opp-hz = /bits/ 64 <760000000>;
> +              opp-hz-real = /bits/ 64 <760000000>,
> +                            /bits/ 64 <760000000>;
> +              opp-microvolt = <743750>,
> +                              <750000>;
> +      };
> +
> +      opp-795000000 {
> +              opp-hz = /bits/ 64 <795000000>;
> +              opp-hz-real = /bits/ 64 <795000000>,
> +                            /bits/ 64 <795000000>;
> +              opp-microvolt = <762500>,
> +                              <762500>;
> +      };
> +
> +      opp-831000000 {
> +              opp-hz = /bits/ 64 <831000000>;
> +              opp-hz-real = /bits/ 64 <831000000>,
> +                            /bits/ 64 <831000000>;
> +              opp-microvolt = <781250>,
> +                              <781250>;
> +      };
> +
> +      opp-855000000 {
> +              opp-hz = /bits/ 64 <855000000>;
> +              opp-hz-real = /bits/ 64 <855000000>,
> +                            /bits/ 64 <855000000>;
> +              opp-microvolt = <793750>,
> +                              <793750>;
> +      };
> +
> +      opp-902000000 {
> +              opp-hz = /bits/ 64 <902000000>;
> +              opp-hz-real = /bits/ 64 <902000000>,
> +                            /bits/ 64 <902000000>;
> +              opp-microvolt = <818750>,
> +                              <818750>;
> +      };
> +
> +      opp-950000000 {
> +              opp-hz = /bits/ 64 <950000000>;
> +              opp-hz-real = /bits/ 64 <950000000>,
> +                            /bits/ 64 <950000000>;
> +              opp-microvolt = <843750>,
> +                              <843750>;
> +      };
> +    };
> +...
> -- 
> 2.18.0
> 
