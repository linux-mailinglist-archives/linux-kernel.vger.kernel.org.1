Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1AF2A281B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgKBKTj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 05:19:39 -0500
Received: from aposti.net ([89.234.176.197]:47056 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgKBKTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:19:38 -0500
Date:   Mon, 02 Nov 2020 10:19:21 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/4] dt-bindings: display: Add ABT Y030XX067A
 =?UTF-8?Q?panel=0D=0A?= bindings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <9CZ5JQ.CWYPSJ8EDOW4@crapouillou.net>
In-Reply-To: <20201101122900.GB1269759@ravnborg.org>
References: <20201101093150.8071-1-paul@crapouillou.net>
        <20201101093150.8071-3-paul@crapouillou.net>
        <20201101122900.GB1269759@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 1 nov. 2020 à 13:29, Sam Ravnborg <sam@ravnborg.org> a écrit :
> On Sun, Nov 01, 2020 at 09:31:48AM +0000, Paul Cercueil wrote:
>>  The Asia Better Technology (ABT) Y030XX067A panel is a 3.0" 320x480
>>  24-bit IPS LCD panel. Its particularity is that it has non-square 
>> pixels
>>  (as it is 4:3 for a resolution of 320x480), and that it requires odd
>>  lines to be sent as RGB and even lines to be sent as GRB on its 
>> 8-bit
>>  bus.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../display/panel/abt,y030xx067a.yaml         | 54 
>> +++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml 
>> b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
>>  new file mode 100644
>>  index 000000000000..6407e8bf45fa
>>  --- /dev/null
>>  +++ 
>> b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
>>  @@ -0,0 +1,54 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: 
>> http://devicetree.org/schemas/display/panel/abt,y030xx067a.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Asia Better Technology 3.0" (320x480 pixels) 24-bit IPS LCD 
>> panel
>>  +
>>  +description: |
>>  +  The panel must obey the rules for a SPI slave device as 
>> specified in
>>  +  spi/spi-controller.yaml
>>  +
>>  +maintainers:
>>  +  - Paul Cercueil <paul@crapouillou.net>
>>  +
>>  +allOf:
>>  +  - $ref: panel-common.yaml#
>>  +
>>  +properties:
>>  +  compatible:
>>  +    const: abt,y030xx067a
>>  +
>>  +  backlight: true
>>  +  port: true
>>  +  power-supply: true
>>  +  reg: true
>>  +  reset-gpios: true
> 
> The binding is missing:
> required:
>   - compatible
>   - reg
>   - power-supply
>   - reset-gpios
>   - ...
> 
> additionalProperties: false
> 
> So r-b only with these added.

Stupid mistake, sorry about that.

I'll V2.

-Paul

> 
> 	Sam
> 
>>  +
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/gpio/gpio.h>
>>  +
>>  +    spi {
>>  +        #address-cells = <1>;
>>  +        #size-cells = <0>;
>>  +
>>  +        panel@0 {
>>  +            compatible = "abt,y030xx067a";
>>  +            reg = <0>;
>>  +
>>  +            spi-max-frequency = <3125000>;
>>  +
>>  +            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
>>  +
>>  +            backlight = <&backlight>;
>>  +            power-supply = <&vcc>;
>>  +
>>  +            port {
>>  +                panel_input: endpoint {
>>  +                    remote-endpoint = <&panel_output>;
>>  +                };
>>  +            };
>>  +        };
>>  +    };
>>  --
>>  2.28.0


