Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5782D1805
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgLGR66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:58:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37071 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLGR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:58:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id o11so10613275ote.4;
        Mon, 07 Dec 2020 09:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1U1wRmmRbG4cz2cewZo/dAoV0iXRpDx9dgphW4iTmgI=;
        b=CgoMQxaEYIPkt/sAciCAmuSJaj5/qd6fkEf4i3NSUmYd/MKgCcBSH9/hdCk+ADjglE
         5Zst6c2/SzWvP45R+7Ku3cWC7r2N8FNXE7aO+hRtL01iXXZ6d4oKvsFgi15anCNobEAa
         FHsF1YfMjXf+4z3ViD5j7SiDyKyJUapaSPOxTmTXtFuw6+LzP6sW8NCfYfVeiL8yHEaU
         wNHc3nQSEcMT6dIPwrL0gNeeDpyvsiJQ4a9VgfbZ1lGQN8EyigKaajxRjuZvTguAOz/B
         4rj+prweaoliRRIohHjYVpR+7QrHMCvg+9m+LPB9qkM/ngRxoaz6RJkK/hUWiMwkzu2E
         vJCg==
X-Gm-Message-State: AOAM531m59Z11U83Dq76S4yegfOuJxlqxW6YUJJnPc1IpTRC8RGE3NMX
        T9o1BvjTCffE38+5S/g8oQ==
X-Google-Smtp-Source: ABdhPJzPKntM6EHNQRBkyqMOVJ0g7484x8Xiz7DEJ33Q8gpe43QD2hudB3F/wDiCQUHWEt8vdM4rJA==
X-Received: by 2002:a9d:7a59:: with SMTP id z25mr14283657otm.267.1607363890911;
        Mon, 07 Dec 2020 09:58:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d194sm3084194oig.3.2020.12.07.09.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 09:58:10 -0800 (PST)
Received: (nullmailer pid 515873 invoked by uid 1000);
        Mon, 07 Dec 2020 17:58:09 -0000
Date:   Mon, 7 Dec 2020 11:58:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V4 01/10] regulator: Update DA9121 dt-bindings
Message-ID: <20201207175809.GA503826@robh.at.kernel.org>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
 <0606d3ded5fef4c38760246146f197db4ce3a374.1606830377.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0606d3ded5fef4c38760246146f197db4ce3a374.1606830377.git.Adam.Ward.opensource@diasemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:52:27PM +0000, Adam Ward wrote:
> Update bindings for the Dialog Semiconductor DA9121 voltage regulator to
> add device variants.
> Because several variants have multiple regulators, and to regard potential
> to add GPIO support in future, the 'regulators' sub-node is added,
> following the precedent set by other multi-regulator devices, including
> the DA9211 family. This breaks compatibility with the original submission
> by Vincent Whitchurch - but as this is still in for-next, the alignment
> could be made before upstreaming occurs.
> 
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
> ---
>  .../devicetree/bindings/regulator/dlg,da9121.yaml  | 164 +++++++++++++++++++--
>  MAINTAINERS                                        |   2 +
>  .../dt-bindings/regulator/dlg,da9121-regulator.h   |  22 +++
>  3 files changed, 177 insertions(+), 11 deletions(-)
>  create mode 100644 include/dt-bindings/regulator/dlg,da9121-regulator.h
> 
> diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> index 2ece46e..6f2164f 100644
> --- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> +++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> @@ -7,41 +7,183 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Dialog Semiconductor DA9121 voltage regulator
>  
>  maintainers:
> -  - Vincent Whitchurch <vincent.whitchurch@axis.com>
> +  - Adam Ward <Adam.Ward.opensource@diasemi.com>
> +
> +description: |
> +  Dialog Semiconductor DA9121 Single-channel 10A double-phase buck converter
> +  Dialog Semiconductor DA9122 Double-channel  5A single-phase buck converter
> +  Dialog Semiconductor DA9220 Double-channel  3A single-phase buck converter
> +  Dialog Semiconductor DA9217 Single-channel  6A double-phase buck converter
> +  Dialog Semiconductor DA9130 Single-channel 10A double-phase buck converter
> +  Dialog Semiconductor DA9131 Double-channel  5A single-phase buck converter
> +  Dialog Semiconductor DA9132 Double-channel  3A single-phase buck converter
> +
> +  Current limits
> +
> +  This is PER PHASE, and the current limit setting in the devices reflect
> +  that with a maximum 10A limit. Allowing for transients at/near double
> +  the rated current, this translates across the device range to per
> +  channel figures as so...
> +
> +                               | DA9121    DA9122     DA9220    DA9217   DA9140
> +                               | /DA9130   /DA9131    /DA9132
> +    -----------------------------------------------------------------------------
> +    Output current / channel   | 10000000   5000000   3000000   6000000  40000000
> +    Output current / phase     |  5000000   5000000   3000000   3000000   9500000
> +    -----------------------------------------------------------------------------
> +    Min regulator-min-microvolt|   300000    300000    300000    300000    500000
> +    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000   1000000
> +    Device hardware default    |  1000000   1000000   1000000   1000000   1000000
> +    -----------------------------------------------------------------------------
> +    Min regulator-min-microamp |  7000000   3500000   3500000   7000000  26000000
> +    Max regulator-max-microamp | 20000000  10000000   6000000  12000000  78000000
> +    Device hardware default    | 15000000   7500000   5500000  11000000  58000000
>  
>  properties:
> +  $nodename:
> +    pattern: "pmic@[0-9a-f]{1,2}"
>    compatible:
> -    const: dlg,da9121
> +    enum:
> +      - dlg,da9121
> +      - dlg,da9122
> +      - dlg,da9220
> +      - dlg,da9217
> +      - dlg,da9130
> +      - dlg,da9131
> +      - dlg,da9132
> +      - dlg,da9140
>  
>    reg:
>      maxItems: 1
> +    description: Specifies the I2C slave address.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: IRQ line information.
> +
> +  dlg,irq-polling-delay-passive-ms:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Don't need a type with a standard unit suffix.

> +    minimum: 1000
> +    maximum: 10000
> +    description: |
> +      Specify the polling period, measured in milliseconds, between interrupt status
> +      update checks. Range 1000-10000 ms.
>  
> -  buck1:
> -    description:
> -      Initial data for the Buck1 regulator.
> -    $ref: "regulator.yaml#"
> +  regulators:
>      type: object
> +    $ref: regulator.yaml#

'regulators' node is not a regulator, so this line should be dropped.

> +    description: |
> +      This node defines the settings for the BUCK. The content of the
> +      sub-node is defined by the standard binding for regulators; see regulator.yaml.
> +      The DA9121 regulator is bound using their names listed below
> +      buck1 - BUCK1
> +      buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only
>  
> -additionalProperties: false
> +    patternProperties:
> +      "^buck([1-2])$":
> +        type: object
> +        $ref: regulator.yaml#
> +
> +        properties:
> +          regulator-mode:
> +            maxItems: 1
> +            description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h

'regulator-mode' is defined as a property of a 
'regulator-state-(standby|mem|disk)' child node. I don't see how you 
would use this with 'regulator-initial-mode' either.

> +
> +          regulator-initial-mode:
> +            maxItems: 1

'maxItems' applies to arrays and this is not an array. What you should 
have is constraints on the values:

enum: [ 0, 1, 2, 3 ]

> +            description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
> +
> +          enable-gpios:
> +            maxItems: 1
> +            description: Specify a valid GPIO for platform control of the regulator
> +
> +          dlg,ripple-cancel:
> +            $ref: "/schemas/types.yaml#/definitions/uint32"
> +            description: |
> +              Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
> +              Only present on multi-channel devices (DA9122, DA9220, DA9131, DA9132)

enum: [ 0, 1, 2, 3 ]

> +
> +        unevaluatedProperties: false
>  
>  required:
>    - compatible
>    - reg
> +  - regulators
> +
> +additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/regulator/dlg,da9121-regulator.h>
>      i2c {
>        #address-cells = <1>;
>        #size-cells = <0>;
> -      regulator@68 {
> +      pmic@68 {
>          compatible = "dlg,da9121";
>          reg = <0x68>;
>  
> -        buck1 {
> -          regulator-min-microvolt = <680000>;
> -          regulator-max-microvolt = <820000>;
> +        interrupt-parent = <&gpio6>;
> +        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +
> +        dlg,irq-polling-delay-passive-ms = <2000>;
> +
> +        regulators {
> +          DA9121_BUCK1: buck1 {
> +            regulator-name = "BUCK1";
> +            regulator-min-microvolt = <300000>;
> +            regulator-max-microvolt = <1900000>;
> +            regulator-min-microamp = <7000000>;
> +            regulator-max-microamp = <20000000>;
> +            regulator-boot-on;
> +            regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
> +            enable-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
> +          };
>          };
>        };
>      };
>  
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/regulator/dlg,da9121-regulator.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic@68 {
> +        compatible = "dlg,da9122";
> +        reg = <0x68>;
> +
> +        interrupt-parent = <&gpio6>;
> +        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +
> +        dlg,irq-polling-delay-passive-ms = <2000>;
> +
> +        regulators {
> +          DA9122_BUCK1: buck1 {
> +            regulator-name = "BUCK1";
> +            regulator-min-microvolt = <300000>;
> +            regulator-max-microvolt = <1900000>;
> +            regulator-min-microamp = <3500000>;
> +            regulator-max-microamp = <10000000>;
> +            regulator-boot-on;
> +            regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
> +            enable-gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
> +            dlg,ripple-cancel = <DA9121_BUCK_RIPPLE_CANCEL_NONE>;
> +          };
> +          DA9122_BUCK2: buck2 {
> +            regulator-name = "BUCK2";
> +            regulator-min-microvolt = <300000>;
> +            regulator-max-microvolt = <1900000>;
> +            regulator-min-microamp = <3500000>;
> +            regulator-max-microamp = <10000000>;
> +            regulator-boot-on;
> +            regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
> +            enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
> +            dlg,ripple-cancel = <DA9121_BUCK_RIPPLE_CANCEL_NONE>;
> +          };
> +        };
> +      };
> +    };
>  ...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bff945..1e5b756 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5118,6 +5118,7 @@ S:	Supported
>  W:	http://www.dialog-semiconductor.com/products
>  F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
>  F:	Documentation/devicetree/bindings/mfd/da90*.txt
> +F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
>  F:	Documentation/devicetree/bindings/regulator/da92*.txt
>  F:	Documentation/devicetree/bindings/regulator/slg51000.txt
>  F:	Documentation/devicetree/bindings/sound/da[79]*.txt
> @@ -5142,6 +5143,7 @@ F:	drivers/rtc/rtc-da90??.c
>  F:	drivers/thermal/da90??-thermal.c
>  F:	drivers/video/backlight/da90??_bl.c
>  F:	drivers/watchdog/da90??_wdt.c
> +F:	include/dt-bindings/regulator/dlg,da9*-regulator.h
>  F:	include/linux/mfd/da903x.h
>  F:	include/linux/mfd/da9052/
>  F:	include/linux/mfd/da9055/
> diff --git a/include/dt-bindings/regulator/dlg,da9121-regulator.h b/include/dt-bindings/regulator/dlg,da9121-regulator.h
> new file mode 100644
> index 0000000..954edf6
> --- /dev/null
> +++ b/include/dt-bindings/regulator/dlg,da9121-regulator.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _DT_BINDINGS_REGULATOR_DLG_DA9121_H
> +#define _DT_BINDINGS_REGULATOR_DLG_DA9121_H
> +
> +/*
> + * These buck mode constants may be used to specify values in device tree
> + * properties (e.g. regulator-initial-mode).
> + * A description of the following modes is in the manufacturers datasheet.
> + */
> +
> +#define DA9121_BUCK_MODE_FORCE_PFM		0
> +#define DA9121_BUCK_MODE_FORCE_PWM		1
> +#define DA9121_BUCK_MODE_FORCE_PWM_SHEDDING	2
> +#define DA9121_BUCK_MODE_AUTO			3
> +
> +#define DA9121_BUCK_RIPPLE_CANCEL_NONE		0
> +#define DA9121_BUCK_RIPPLE_CANCEL_SMALL		1
> +#define DA9121_BUCK_RIPPLE_CANCEL_MID		2
> +#define DA9121_BUCK_RIPPLE_CANCEL_LARGE		3
> +
> +#endif
> -- 
> 1.9.1
> 
