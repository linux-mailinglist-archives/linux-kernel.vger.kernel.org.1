Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B224826AC46
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgIORgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:36:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40445 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgIORL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:11:56 -0400
Received: by mail-io1-f65.google.com with SMTP id j2so4911736ioj.7;
        Tue, 15 Sep 2020 10:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HdyUkHyfoHz+Ydj+0d+phApcyEz0Lhr0b+TrGpjjawY=;
        b=Ni53oMyTgbr2a3dnjc7n3WrXICN9T7qywdjhTq1hHmlL7a8dRJxdSD5naYwr1Settk
         iuD4O3mCXZNbWXf8L7umt99iIYshK2tWufQribvxVthGN7Tll0zeFzxt2uHbaral2+/p
         emr4qnqtlOH3jdHxCemqR3MIDfwFM5Q2K5uYX5ZzOzRpCrJrKa2KXkeZgfiSoUaPFwQT
         /NNTTdN2h7GFqXvjbSsLv1dIb9DAw/cGnSNSqibaJgb7H7u0U58MkOKdqFWwASrG9qKg
         cDvsa7v+swWSUyf+JOgD1TZefQBR9swnGFfAJ5hxlR6zGxt/kdvSivOkKx5ungDHkWWB
         GxWA==
X-Gm-Message-State: AOAM531yZg1GUDygjzaSno/r1tmky7XhIrlRVmUXV5u6PdaH2PlRKPH4
        zs2eynTeVLnZR0ZC9PPHEw==
X-Google-Smtp-Source: ABdhPJyhjo1RhwrGJbaXNiqPxI2C3d+uVWxSg7tHYmnR/Uil5xXJNVenlZdKE7T+Qd3PCJ3pPAqnKQ==
X-Received: by 2002:a05:6638:cdc:: with SMTP id e28mr18804594jak.100.1600189914607;
        Tue, 15 Sep 2020 10:11:54 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w13sm7796046iox.10.2020.09.15.10.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:11:54 -0700 (PDT)
Received: (nullmailer pid 2141847 invoked by uid 1000);
        Tue, 15 Sep 2020 17:11:52 -0000
Date:   Tue, 15 Sep 2020 11:11:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH] dt-bindings: mfd: Convert rn5t618 to json-schema
Message-ID: <20200915171152.GA2124960@bogus>
References: <20200908201303.17271-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908201303.17271-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:13:03PM +0200, Andreas Kemnade wrote:
> Convert the RN5T618 binding to DT schema format. Also
> clearly state which regulators are available.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> I have noted myself here as maintainer because I wrote most of the
> code of the several subdevices, although not of the .txt-binding.
> Due to its .txt-format history BSD license was not added.
> I happily ignored the "does MAINTAINERS need updating" thing
> from checkpatch.pl, I do not know whether that PMIC should
> have a separate entry there.
> 
>  .../bindings/mfd/ricoh,rn5t618.yaml           | 113 ++++++++++++++++++
>  .../devicetree/bindings/mfd/rn5t618.txt       |  52 --------
>  2 files changed, 113 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> new file mode 100644
> index 000000000000..9596dde7a69a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> @@ -0,0 +1,113 @@
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

I prefer under 'regulators' below, you have all possible regulator 
names:

patternProperties:
  "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
     $ref: ../regulator/regulator.yaml

and then above you just need to restrict the possible names:

regulators:
  propertyNames:
    pattern: "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$"

(propertyNames schema is applied to all an object's properties and you 
don't need additionalProperties here.)

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
> +    description: |
> +      See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Drop the description.

> +
> +  system-power-controller:
> +    type: boolean
> +    description: |
> +      See Documentation/devicetree/bindings/power/power-controller.txt
> +
> +  regulators:
> +    type: object
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
