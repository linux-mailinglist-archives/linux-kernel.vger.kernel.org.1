Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40442C7143
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbgK1Vzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:55:36 -0500
Received: from foss.arm.com ([217.140.110.172]:37564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387671AbgK1UTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:19:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14D4730E;
        Sat, 28 Nov 2020 12:18:34 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BD613F23F;
        Sat, 28 Nov 2020 12:18:32 -0800 (PST)
Subject: Re: [RESEND PATCH 12/19] dt-bindings: Add bindings for USB phy on
 Allwinner A100
To:     Rob Herring <robh@kernel.org>, Frank Lee <frank@allwinnertech.com>
Cc:     devicetree@vger.kernel.org, tiny.windzz@gmail.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <1ce71bac2732620f8fe77b23ca84e062385e7e8a.1604988979.git.frank@allwinnertech.com>
 <20201111225039.GA2185181@bogus>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <a52f7350-b7b5-290c-c43a-020fecd58874@arm.com>
Date:   Sat, 28 Nov 2020 20:18:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201111225039.GA2185181@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 22:50, Rob Herring wrote:

Hi,

> On Tue, Nov 10, 2020 at 02:39:42PM +0800, Frank Lee wrote:
>> From: Yangtao Li <frank@allwinnertech.com>
>>
>> Add a device tree binding for the A100's USB PHY.

Not your fault, Yangto, but why do we actually have a separate binding
document per SoC, when the differences between the PHYs are so minimal
that we get away with some flags in the compatible match, in one driver
file?

For a start this file is basically identical to the A64 one (apart from
the example), so can you just add the A100 compatible string to that
one, instead?

Cheers,
Andre

>>
>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>> ---
>>  .../phy/allwinner,sun50i-a100-usb-phy.yaml    | 105 ++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml
>> new file mode 100644
>> index 000000000000..cc9bbebe2bd7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml
>> @@ -0,0 +1,105 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license new bindings. checkpatch.pl will tell you which ones.
> 
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/allwinner,sun50i-a100-usb-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allwinner A100 USB PHY Device Tree Bindings
>> +
>> +maintainers:
>> +  - Yangtao Li <tiny.windzz@gmail.com>
>> +
>> +properties:
>> +  "#phy-cells":
>> +    const: 1
>> +
>> +  compatible:
>> +    const: allwinner,sun50i-a100-usb-phy
>> +
>> +  reg:
>> +    items:
>> +      - description: PHY Control registers
>> +      - description: PHY PMU0 registers
>> +      - description: PHY PMU1 registers
>> +
>> +  reg-names:
>> +    items:
>> +      - const: phy_ctrl
>> +      - const: pmu0
>> +      - const: pmu1
>> +
>> +  clocks:
>> +    items:
>> +      - description: USB OTG PHY bus clock
>> +      - description: USB Host 0 PHY bus clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: usb0_phy
>> +      - const: usb1_phy
>> +
>> +  resets:
>> +    items:
>> +      - description: USB OTG reset
>> +      - description: USB Host 1 Controller reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: usb0_reset
>> +      - const: usb1_reset
>> +
>> +  usb0_id_det-gpios:
>> +    description: GPIO to the USB OTG ID pin
> 
> Needs 'maxItems: 1'
> 
>> +
>> +  usb0_vbus_det-gpios:
>> +    description: GPIO to the USB OTG VBUS detect pin
>> +
>> +  usb0_vbus_power-supply:
>> +    description: Power supply to detect the USB OTG VBUS
>> +
>> +  usb0_vbus-supply:
>> +    description: Regulator controlling USB OTG VBUS
>> +
>> +  usb1_vbus-supply:
>> +    description: Regulator controlling USB1 Host controller
> 
> Are ID and VBus actually connected to the phy h/w? Really, all this 
> should be in a USB connector node for which we have bindings.
> 
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - reg
>> +  - reg-names
>> +  - resets
>> +  - reset-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/clock/sun50i-a100-ccu.h>
>> +    #include <dt-bindings/reset/sun50i-a100-ccu.h>
>> +
>> +    phy@5100400 {
>> +        #phy-cells = <1>;
>> +        compatible = "allwinner,sun50i-a100-usb-phy";
>> +        reg = <0x05100400 0x14>,
>> +              <0x05101800 0x4>,
>> +              <0x05200800 0x4>;
>> +        reg-names = "phy_ctrl",
>> +                    "pmu0",
>> +                    "pmu1";
>> +        clocks = <&ccu CLK_USB_PHY0>,
>> +                 <&ccu CLK_USB_PHY1>;
>> +        clock-names = "usb0_phy",
>> +                      "usb1_phy";
>> +        resets = <&ccu RST_USB_PHY0>,
>> +                 <&ccu RST_USB_PHY1>;
>> +        reset-names = "usb0_reset",
>> +                      "usb1_reset";
>> +        usb0_id_det-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
>> +        usb0_vbus_power-supply = <&usb_power_supply>;
>> +        usb0_vbus-supply = <&reg_drivevbus>;
>> +        usb1_vbus-supply = <&reg_usb1_vbus>;
>> +    };
>> -- 
>> 2.28.0
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

