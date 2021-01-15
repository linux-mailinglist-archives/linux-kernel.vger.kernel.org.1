Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BCE2F7034
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbhAOBtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:49:19 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:32577 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbhAOBtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:49:18 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10F1fQeI052501;
        Fri, 15 Jan 2021 09:41:26 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from aspeedtech.com (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Jan
 2021 09:46:31 +0800
Date:   Fri, 15 Jan 2021 01:46:31 +0000
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "leetroy@gmail.com" <leetroy@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
Message-ID: <20210115014631.GA1391@aspeedtech.com>
References: <20210113070850.1184506-1-troy_lee@aspeedtech.com>
 <20210113070850.1184506-2-troy_lee@aspeedtech.com>
 <20210114141317.GA2823834@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210114141317.GA2823834@robh.at.kernel.org>
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10F1fQeI052501
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for reviewing.

The 01/14/2021 22:13, Rob Herring wrote:
> On Wed, Jan 13, 2021 at 07:08:45AM +0000, Troy Lee wrote:
> > We add binding for supporting a new AST2600 PWM/Fan hwmon driver.
> > 
> > Changes since v1:
> > - dt binding with DT schema format
> > 
> > Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> > ---
> >  .../hwmon/aspeed,ast2600-pwm-tachometer.yaml  | 137 ++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> > new file mode 100644
> > index 000000000000..b84076a4a338
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> > @@ -0,0 +1,137 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-pwm-tachometer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED AST2600 PWM and Fan Tacho controller device driver
> > +
> > +maintainers:
> > +  - Ryan Chen <ryan_chen@aspeedtech.com>
> > +
> > +description: |
> > +  The ASPEED PWM controller can support upto 16 PWM outputs. The ASPEED Fan Tacho
> > +  controller can support upto 16 Fan tachometer inputs.
> > +  There can be upto 16 fans supported. Each fan can have one PWM output and
> > +  one Fan tach inputs.
> > +
> > +properties:
> > +  compatible:
> > +    const: aspeed,ast2600-pwm-tachometer
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  "#cooling-cells":
> > +    const: 2
> > +
> > +  reg:
> > +    description:
> > +      Address and length of the register set for the device.
> 
> No need for generic descriptions. That's every 'reg'.
> 
> What you need is how many entries and what each one is if more than 1. 
> If only 1, then just 'maxItems: 1'
> 
> > +
> > +  clocks:
> > +    description:
> > +      phandle to clock provider with the clock number in the second cell
> 
> Same here.
> 
> > +
> > +  resets:
> > +    description:
> > +      phandle to reset controller with the reset number in the second cell
> 
> And here.
> 
> > +
> > +patternProperties:
> > +  "@[0-9]+$":
> 
> If every node is a fan and there are up to 16:
> 
> ^fan@[0-9a-f]$
> 
I will update these in v3 patch set.

> > +    type: object
> > +    description:
> > +      Under fan subnode there can upto 16 child nodes, with each child node
> > +      representing a fan. There are 16 fans each fan can have one PWM port and one
> > +      Fan tach inputs.
> > +      For PWM port can be configured cooling-levels to create cooling device.
> > +      Cooling device could be bound to a thermal zone for the thermal control.
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 15
> > +        description:
> > +          This property identify the PWM control channel of this fan.
> > +
> > +      fan-tach-ch:
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> > +        minimum: 0
> > +        maximum: 15
> > +        description:
> > +          This property identify the fan tach input channel.
> > +
> > +      pulses-per-revolution:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        default: 2
> > +        minimum: 1
> > +        description:
> > +          Specify tacho pulse per revolution of the fan.
> > +
> > +      cooling-levels:
> > +        description:
> > +          PWM duty cycle values in a range from 0 to 255
> > +          which correspond to thermal cooling states.
> > +
> > +      aspeed,pwm-freq:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        default: 25000
> > +        minimum: 24
> > +        maximum: 780000
> > +        description:
> > +          Specify the frequency of PWM.
> 
> Units? Use a unit suffix and then drop the $ref.
> 
I'll change it to pwm-freq-hz.

> > +
> > +      aspeed,inverse-pin:
> > +        type: boolean
> > +        description:
> > +          Inverse PWM output signal.
> > +
> > +      aspeed,falling-point:
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> > +        default: 10
> > +        minimum: 0
> > +        maximum: 255
> 
> 0-255 is already the range of uint8, so drop.
> 
I'll drop it in v3.

Thanks,
Troy Lee
> > +        description:
> > +          Initialize the pulse width.
> > +
> > +    required:
> > +      - fan-tach-ch
> > +      - reg
> > +
> > +    additionalProperties: true
> > +
> > +required:
> > + - compatible
> > + - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm_tacho: pwm-tacho-controller@1e610000 {
> > +        compatible = "aspeed,ast2600-pwm-tachometer";
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        reg = <0x1e610000 0x100>;
> > +
> > +        fan@1 {
> > +            reg = <0x00>;
> > +            aspeed,pwm-freq = <25000>;
> > +            cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
> > +            fan-tach-ch = /bits/ 8 <0x00>;
> > +            pulses-per-revolution = <2>;
> > +        };
> > +
> > +        fan@2 {
> > +            reg = <0x01>;
> > +            aspeed,pwm-freq = <25000>;
> > +            cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
> > +            fan-tach-ch = /bits/ 8 <0x01>;
> > +            pulses-per-revolution = <2>;
> > +        };
> > +    };
> > +...
> > -- 
> > 2.25.1
> > 
