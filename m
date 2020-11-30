Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785FD2C8E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgK3Tj4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Nov 2020 14:39:56 -0500
Received: from aposti.net ([89.234.176.197]:48400 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgK3Tjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:39:55 -0500
Date:   Mon, 30 Nov 2020 19:39:01 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/4] dt-bindings: display: Add ABT Y030XX067A panel
 bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1XJMKQ.YER47WG3D7R41@crapouillou.net>
In-Reply-To: <CAL_JsqLSGMFibm8tVKqNe1SFBzXTU2=M2jZmpfrHeGUqS3foRg@mail.gmail.com>
References: <20201101093150.8071-1-paul@crapouillou.net>
        <20201101093150.8071-3-paul@crapouillou.net>
        <20201101122900.GB1269759@ravnborg.org>
        <9CZ5JQ.CWYPSJ8EDOW4@crapouillou.net>
        <CAL_JsqLSGMFibm8tVKqNe1SFBzXTU2=M2jZmpfrHeGUqS3foRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le lun. 30 nov. 2020 à 7:32, Rob Herring <robh+dt@kernel.org> a écrit 
:
> On Mon, Nov 2, 2020 at 3:19 AM Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> 
>> 
>> 
>>  Le dim. 1 nov. 2020 à 13:29, Sam Ravnborg <sam@ravnborg.org> a 
>> écrit :
>>  > On Sun, Nov 01, 2020 at 09:31:48AM +0000, Paul Cercueil wrote:
>>  >>  The Asia Better Technology (ABT) Y030XX067A panel is a 3.0" 
>> 320x480
>>  >>  24-bit IPS LCD panel. Its particularity is that it has 
>> non-square
>>  >> pixels
>>  >>  (as it is 4:3 for a resolution of 320x480), and that it 
>> requires odd
>>  >>  lines to be sent as RGB and even lines to be sent as GRB on its
>>  >> 8-bit
>>  >>  bus.
>>  >>
>>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  ---
>>  >>   .../display/panel/abt,y030xx067a.yaml         | 54
>>  >> +++++++++++++++++++
>>  >>   1 file changed, 54 insertions(+)
>>  >>   create mode 100644
>>  >> 
>> Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
>>  >>
>>  >>  diff --git
>>  >> 
>> a/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
>>  >> 
>> b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
>>  >>  new file mode 100644
>>  >>  index 000000000000..6407e8bf45fa
>>  >>  --- /dev/null
>>  >>  +++
>>  >> 
>> b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
>>  >>  @@ -0,0 +1,54 @@
>>  >>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  >>  +%YAML 1.2
>>  >>  +---
>>  >>  +$id:
>>  >> http://devicetree.org/schemas/display/panel/abt,y030xx067a.yaml#
>>  >>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  >>  +
>>  >>  +title: Asia Better Technology 3.0" (320x480 pixels) 24-bit IPS 
>> LCD
>>  >> panel
>>  >>  +
>>  >>  +description: |
>>  >>  +  The panel must obey the rules for a SPI slave device as
>>  >> specified in
>>  >>  +  spi/spi-controller.yaml
>>  >>  +
>>  >>  +maintainers:
>>  >>  +  - Paul Cercueil <paul@crapouillou.net>
>>  >>  +
>>  >>  +allOf:
>>  >>  +  - $ref: panel-common.yaml#
>>  >>  +
>>  >>  +properties:
>>  >>  +  compatible:
>>  >>  +    const: abt,y030xx067a
>>  >>  +
>>  >>  +  backlight: true
>>  >>  +  port: true
>>  >>  +  power-supply: true
>>  >>  +  reg: true
>>  >>  +  reset-gpios: true
>>  >
>>  > The binding is missing:
>>  > required:
>>  >   - compatible
>>  >   - reg
>>  >   - power-supply
>>  >   - reset-gpios
>>  >   - ...
>>  >
>>  > additionalProperties: false
>>  >
>>  > So r-b only with these added.
>> 
>>  Stupid mistake, sorry about that.
>> 
>>  I'll V2.
> 
> I don't have any V2 in my inbox, but looks like it is in linux-next 
> now:

Yes, Sam told me on IRC I could fix it while applying and avoid the V2.

> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.example.dt.yaml:
> panel@0: 'spi-max-frequency' does not match any of the regexes:
> 'pinctrl-[0-9]+'
>  From schema: 
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml

"make dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml" 
doesn't complain here :(

-Paul


