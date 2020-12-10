Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F532D5177
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgLJDg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:36:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36058 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbgLJDgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:36:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id y24so3635801otk.3;
        Wed, 09 Dec 2020 19:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+cWD5XLsqI7lFCqUDgKxUA9RUYuHMZwYGBvzxLkneg=;
        b=rnZs6NbjEd1Q2SZOUOQcaDKjDtS9Oio+Ejx+ynsf7nu1axmORhPlf6CXGOuogO0Sl6
         TJ6XMYKiBXkdJ91/VMFhmKz1mMDjVPlnTl1n1bgKgeOg7ojkVzZGuiRAsCAPHT7QA/II
         aBC7Q4o6HdbkSs5oreo6fo+gsP5/eEw06mdJHDuNmcaO1w1puWkllzond7g6dQPEoiey
         S8KjjyMDCawrQ56FOtKgXDzOuxTNB19lNNRwas1eK4c+gZh14+JeMF7Zm1I1q9cnwnjC
         2dLXle0dnpJ0fJkY0bKrP3YwkY3fiRxwqPBPQ/GtGNqlI+S03wnuGd/dDU3JNfBm1p5q
         /3TQ==
X-Gm-Message-State: AOAM530ia7MohY5SylR4ym029pNa4Byk94jZZUtASphKWpss0FylXZZD
        so5wv/vRWLkQy1vm0X2CLGpbFqURgQ==
X-Google-Smtp-Source: ABdhPJzUdFiQxwSP4rq7bkpTkkyZDsumaRe9BCTtsEy+PbXvMOWN9EGXY660snpJzmNp0GD2bY+xhw==
X-Received: by 2002:a05:6830:569:: with SMTP id f9mr4625464otc.312.1607571325505;
        Wed, 09 Dec 2020 19:35:25 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 43sm826233otf.28.2020.12.09.19.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:35:24 -0800 (PST)
Received: (nullmailer pid 1605470 invoked by uid 1000);
        Thu, 10 Dec 2020 03:35:23 -0000
Date:   Wed, 9 Dec 2020 21:35:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add pf8x00 regulator
Message-ID: <20201210033459.GA1596229@robh.at.kernel.org>
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206002629.12872-1-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 01:26:28AM +0100, Adrien Grassein wrote:
> Add dt-bindings for the pf8x00 driver.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../regulator/nxp,pf8x00-regulator.yaml       | 223 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 229 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> new file mode 100644
> index 000000000000..f4e4f545c5a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> @@ -0,0 +1,223 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/nxp,pf8x00-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PF8x00 Power Management Integrated Circuit regulators
> +
> +maintainers:
> +  - Adrien Grassein <adrien.grassein@gmail.com>
> +
> +description: |
> +  pf8x00 are a 12-chanel regulator PMIC family. Regulators nodes should
> +  be named to ldo<>, sw<> and vnss. The definition for each of these nodes
> +  is defined using the standard binding for regulators at
> +  Documentation/devicetree/bindings/regulator/regulator.txt.
> +  Datasheet is available at https://www.nxp.com/docs/en/data-sheet/PF8100_PF8200.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pf8x00
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    description: |

Don't need '|' if no formatting.

> +      list of regulators provided by this controller
> +
> +    patternProperties:
> +      "^ldo[1-4]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description: |
> +          Properties for single LDO regulator.
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^ldo[1-4]$"
> +            description: |
> +              should be ldo1", ..., "ldo4"
> +
> +          nxp,hw-en:
> +            $ref: /schemas/types.yaml#definitions/flag
> +            description: |
> +              Only available for ldo2. Used to enable or disable ld02.
> +
> +          nxp,vselect-en:
> +            $ref: /schemas/types.yaml#definitions/flag
> +            description: |
> +              Only available for ldo2. When specified, use the VSELECT pin
> +              of the chip to control the output voltage of the ldo02 regulator.
> +
> +        unevaluatedProperties: false
> +
> +      "^sw[1-7]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description: |
> +          Properties for single SW regulator.
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^sw[1-7]$"
> +            description: |
> +              should be sw1", ..., "sw7"
> +
> +          nxp,ilim-ma:

Use unit suffix defined in property-units.txt.

> +            $ref: /schemas/types.yaml#definitions/uint32
> +            minimum: 2100
> +            maximum: 4500
> +            default: 2100
> +            enum: [ 2100, 2600, 3000, 4500 ]
> +            description: |
> +              Defines the maximum current delivered by the regulator (in mA).
> +
> +          nxp,phase:
> +            $ref: /schemas/types.yaml#definitions/uint32
> +            minimum: 0
> +            maximum: 315
> +            default: 0
> +            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
> +            description: |
> +               This controls the phase shift of the switching frequency.
> +
> +          nxp,fsl,fast-slew:

nxp or fsl?

> +            $ref: /schemas/types.yaml#definitions/flag
> +            description: |
> +              Controls the DVS ramp of the regulator.
> +
> +          nxp,quad-phase:
> +            $ref: /schemas/types.yaml#definitions/flag
> +            description: |
> +              This allow regulators  sw1 and sw2, or sw3 and sw4 or sw4 and sw5
> +              to work together to deliver a maximum 10A current.
> +
> +          nxp,dual-phase:
> +            $ref: /schemas/types.yaml#definitions/flag
> +            description: |
> +              This allow regulators  sw1, sw2, sw3 and sw4 to work together
> +              to deliver a maximum 5A current.
> +
> +        unevaluatedProperties: false
> +
> +      "^vsnvs$":

Move to 'properties', not a pattern.

> +        type: object
> +        $ref: regulator.yaml#
> +        description: |
> +          Properties for vsnvs regulator.
> +
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic: pf8100@8 {

pmic@8

> +        compatible = "nxp,pf8x00";
> +        reg = <0x08>;
> +
> +        regulators {
> +            reg_ldo1: ldo1 {
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <5000000>;
> +              regulator-min-microvolt = <1500000>;
> +            };
> +
> +            reg_ldo2: ldo2 {
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <5000000>;
> +              regulator-min-microvolt = <1500000>;
> +            };
> +
> +            reg_ldo3: ldo3 {
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <5000000>;
> +              regulator-min-microvolt = <1500000>;
> +            };
> +
> +            reg_ldo4: ldo4 {
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <5000000>;
> +              regulator-min-microvolt = <1500000>;
> +            };
> +
> +            reg_sw1: sw1 {
> +              nxp,phase = <0>;
> +              nxp,ilim-ma = <4500>;
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <1800000>;
> +              regulator-min-microvolt =  <400000>;
> +            };
> +
> +            reg_sw2: sw2 {
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <1800000>;
> +              regulator-min-microvolt =  <400000>;
> +            };
> +
> +            reg_sw3: sw3 {
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <1800000>;
> +              regulator-min-microvolt =  <400000>;
> +              nxp,fast-slew = <1>;
> +            };
> +
> +            reg_sw4: sw4 {
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <1800000>;
> +              regulator-min-microvolt =  <400000>;
> +              nxp,fast-slew = <1>;
> +            };
> +
> +            reg_sw5: sw5 {
> +              regulator-always-on;
> +              regulator-boot-on;
> +              regulator-max-microvolt = <1800000>;
> +              regulator-min-microvolt =  <400000>;
> +            };
> +
> +           reg_sw6: sw6 {
> +             regulator-always-on;
> +             regulator-boot-on;
> +             regulator-max-microvolt = <1800000>;
> +             regulator-min-microvolt =  <400000>;
> +           };
> +
> +           reg_sw7: sw7 {
> +             regulator-always-on;
> +             regulator-boot-on;
> +             regulator-max-microvolt = <4100000>;
> +             regulator-min-microvolt = <1000000>;
> +           };
> +
> +          reg_vsnvs: vsnvs {
> +            regulator-always-on;
> +            regulator-boot-on;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-min-microvolt = <1800000>;
> +          };
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebe4829cdd4d..4e266f1e9a2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13730,6 +13730,12 @@ S:	Maintained
>  F:	include/linux/personality.h
>  F:	include/uapi/linux/personality.h
>  
> +PF8x00 PMIC REGULATORS DRIVERS
> +M:	Adrien Grassein <adrien.grassein@gmail.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> +
>  PHOENIX RC FLIGHT CONTROLLER ADAPTER
>  M:	Marcus Folkesson <marcus.folkesson@gmail.com>
>  L:	linux-input@vger.kernel.org
> -- 
> 2.20.1
> 
