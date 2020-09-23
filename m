Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4211274E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgIWBkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:40:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44869 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIWBko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:40:44 -0400
Received: by mail-io1-f67.google.com with SMTP id g128so21908790iof.11;
        Tue, 22 Sep 2020 18:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mxMwa5Bv4+zsk+i5Sc+qh/J0hy+h3RkkxMGekvbHQWE=;
        b=QdlIGaUNWp7ABehajLtjP6dCuf52gjNncSizNflt0uWAwjgmmllPKXzLN6gHKeSDep
         uGJumnhSO2ypaHmpO0jqJ7+3NjoYenclVlYrYqkwczMNyQ/6CUMoi5Wm+rWhk4LS2JoM
         rW6XvDWZb75xEDGF0C47X8NQZsNXIHe+435Q3yLVW3uER9bYAfHeGB3qdShePsZpzBMB
         Mv3Q9vuZho6w4/7lJM1kEmNeAMj+YVXFqklDE309FUeq++3x3yMDuewKSSzbA8976bTT
         bnuEdO+dotEHXFaNu+dUhXcTzvMRGTcnPBMR2GBMTH4l57SnlpAto1Ge7aePg4xaV9me
         VfVA==
X-Gm-Message-State: AOAM531csx1ihuv30FuUa62Lev8yLI4/73RSbS97MD7WS/VpWNxu+igD
        cvi1cQ1BdUsKfXBsg1pxOg==
X-Google-Smtp-Source: ABdhPJy5X+/g/SHWag9zFo+7OD64cKDwFkw8xsvYYc/JucU7bVITUADBsq4myv6RAdQWNy9f5XzKCQ==
X-Received: by 2002:a02:a498:: with SMTP id d24mr6496830jam.137.1600825242974;
        Tue, 22 Sep 2020 18:40:42 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b12sm9826513ilq.53.2020.09.22.18.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:40:42 -0700 (PDT)
Received: (nullmailer pid 3676234 invoked by uid 1000);
        Wed, 23 Sep 2020 01:40:41 -0000
Date:   Tue, 22 Sep 2020 19:40:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH v2] dt-bindings: mfd: Convert rn5t618 to json-schema
Message-ID: <20200923014041.GA3669674@bogus>
References: <20200916061757.32144-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916061757.32144-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 08:17:57AM +0200, Andreas Kemnade wrote:
> Convert the RN5T618 binding to DT schema format. Also
> clearly state which regulators are available.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - drop irq description
> 
> Due to its .txt-format history BSD license was not added.
>  .../bindings/mfd/ricoh,rn5t618.yaml           | 111 ++++++++++++++++++
>  .../devicetree/bindings/mfd/rn5t618.txt       |  52 --------
>  2 files changed, 111 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> new file mode 100644
> index 000000000000..d70e85a09c84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ricoh,rn5t618.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ricoh RN5T567/RN5T618/RC5T619 PMIC
> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +description: |
> +  Ricoh RN5T567/RN5T618/RC5T619 is a power management IC family which
> +  integrates 3 to 5 step-down DCDC converters, 7 to 10 low-dropout regulators,
> +  GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
> +  The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
> +  fuel gauge, and an ADC.
> +  The RC5T619 additionnally includes USB charger detection and an RTC.
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ricoh,rn5t567
> +    then:
> +      properties:
> +        regulators:
> +          patternProperties:
> +            "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$":
> +              $ref: ../regulator/regulator.yaml
> +          additionalProperties: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ricoh,rn5t618
> +    then:
> +      properties:
> +        regulators:
> +          patternProperties:
> +            "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$":
> +              $ref: ../regulator/regulator.yaml
> +          additionalProperties: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ricoh,rc5t619
> +    then:
> +      properties:
> +        regulators:
> +          patternProperties:
> +            "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
> +              $ref: ../regulator/regulator.yaml
> +          additionalProperties: false
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ricoh,rn5t567
> +      - ricoh,rn5t618
> +      - ricoh,rc5t619
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  system-power-controller:
> +    type: boolean
> +    description: |
> +      See Documentation/devicetree/bindings/power/power-controller.txt
> +
> +  regulators:
> +    type: object

Add here:

$ref: ../regulator/regulator.yaml

And then the occurrances up above can be just 'true'.


> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@32 {
> +        compatible = "ricoh,rn5t618";
> +        reg = <0x32>;
> +        interrupt-parent = <&gpio5>;
> +        interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +        system-power-controller;
> +
> +        regulators {
> +          DCDC1 {
> +            regulator-min-microvolt = <1050000>;
> +            regulator-max-microvolt = <1050000>;
> +          };
> +
> +          DCDC2 {
> +            regulator-min-microvolt = <1175000>;
> +            regulator-max-microvolt = <1175000>;
> +          };
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
> deleted file mode 100644
> index 16778ea00dbc..000000000000
> --- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -* Ricoh RN5T567/RN5T618 PMIC
> -
> -Ricoh RN5T567/RN5T618/RC5T619 is a power management IC family which
> -integrates 3 to 5 step-down DCDC converters, 7 to 10 low-dropout regulators,
> -GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
> -The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
> -fuel gauge, and an ADC.
> -The RC5T619 additionnally includes USB charger detection and an RTC.
> -
> -Required properties:
> - - compatible: must be one of
> -		"ricoh,rn5t567"
> -		"ricoh,rn5t618"
> -		"ricoh,rc5t619"
> - - reg: the I2C slave address of the device
> -
> -Optional properties:
> - - interrupts: interrupt mapping for IRQ
> -   See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> - - system-power-controller:
> -   See Documentation/devicetree/bindings/power/power-controller.txt
> -
> -Sub-nodes:
> - - regulators: the node is required if the regulator functionality is
> -   needed. The valid regulator names are: DCDC1, DCDC2, DCDC3, DCDC4
> -   (RN5T567/RC5T619), LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7, LDO8,
> -   LDO9, LDO10, LDORTC1 and LDORTC2.
> -   LDO7-10 are specific to RC5T619.
> -   The common bindings for each individual regulator can be found in:
> -   Documentation/devicetree/bindings/regulator/regulator.txt
> -
> -Example:
> -
> -	pmic@32 {
> -		compatible = "ricoh,rn5t618";
> -		reg = <0x32>;
> -		interrupt-parent = <&gpio5>;
> -		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> -		system-power-controller;
> -
> -		regulators {
> -			DCDC1 {
> -				regulator-min-microvolt = <1050000>;
> -				regulator-max-microvolt = <1050000>;
> -			};
> -
> -			DCDC2 {
> -				regulator-min-microvolt = <1175000>;
> -				regulator-max-microvolt = <1175000>;
> -			};
> -		};
> -	};
> -- 
> 2.20.1
> 
