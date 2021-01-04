Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877EE2E9987
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbhADQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbhADQA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:00:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4C912250E;
        Mon,  4 Jan 2021 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609776016;
        bh=AIuEZ3LHAXEEk/KvPhHnhOfNMQh/X1KomltrocF0mlU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqHe4WQHpP25Ngo+jwV12H3qzepBowPE/LANYIYqflI5xAsp0lP7WxPJ6++n40wc/
         h2bwQc9SZjAZjdFuFVvzpgR8ET/aa/h6oFXKWOmGQqCJTGuS0oEhLjxQwxGLvKlyn2
         sAkmtj2I1SCX++0GDq4JgHgbpSDv9fLrFdQ3tyzesRCQVLGgHkSbzaBpd2VaK/S4dd
         wFkFtwT9O+SbgZEzsj/BmAagTSPRcpjSplsB8tftgaiTtcIfDbVegHQUZmZuzrbgZp
         4Eccllj32U36xnH+yVbB9MQx5Bs8GU3WHRS56dYW2ckHMqtaCbtiDVO2oTK569fEym
         mbkyNc2rckEIg==
Received: by mail-ed1-f53.google.com with SMTP id cm17so27852970edb.4;
        Mon, 04 Jan 2021 08:00:15 -0800 (PST)
X-Gm-Message-State: AOAM530wjqIr9w9NLIwhr6kYnwGNOHWiPrfATDjoDLZTaenWqVTx4LX0
        Tw3dO/k/a/2NDknuXkdFX7jtYtBvKHgw1VxM1A==
X-Google-Smtp-Source: ABdhPJz09bY6nrB961xN80l+39gUo+ZFgThja3sbx0kYfIMB3BU4C9ORV1WMuUDWx/iDN3uaOw6cOlCUml1MpR4z0oA=
X-Received: by 2002:a05:6402:352:: with SMTP id r18mr70216121edw.373.1609776014373;
 Mon, 04 Jan 2021 08:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20210104071114.23657-1-Nick.Fan@mediatek.com>
In-Reply-To: <20210104071114.23657-1-Nick.Fan@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Jan 2021 09:00:02 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLBCWNqkQZWNXABLffVCPPW0FQ_8G8dXP+yrzw2Xf0dUw@mail.gmail.com>
Message-ID: <CAL_JsqLBCWNqkQZWNXABLffVCPPW0FQ_8G8dXP+yrzw2Xf0dUw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: Convert Arm Mali Valhall GPU to DT schema
To:     Nick Fan <Nick.Fan@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 12:11 AM Nick Fan <Nick.Fan@mediatek.com> wrote:
>
> Convert the Arm Valhall GPU binding to DT schema format.

This is the 2nd v1 you've sent. Please address my comments on the 1st v1.

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
> index 000000000000..436294c032ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> @@ -0,0 +1,252 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/arm,mali-valhall.yaml#
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
> +      - const: arm,mali-valhall
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
> +        power-domains:
> +          description:
> +            List of phandle and PM domain specifier as documented in
> +            Documentation/devicetree/bindings/power/power_domain.txt
> +          minItems: 5
> +          maxItems: 5
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
> +      compatible = "operating-points-v2";
> +      opp-shared;
> +
> +      opp-358000000 {
> +              opp-hz = /bits/ 64 <358000000>;
> +              opp-hz-real = /bits/ 64 <358000000>,
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
