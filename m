Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1A2B85A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgKRUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:34:14 -0500
Received: from mail.v3.sk ([167.172.186.51]:42664 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgKRUeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:34:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A5A35DEE80;
        Wed, 18 Nov 2020 20:31:30 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wnFH9mvu5HhT; Wed, 18 Nov 2020 20:31:29 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 02C52DFAD9;
        Wed, 18 Nov 2020 20:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 218FZNQk0lq7; Wed, 18 Nov 2020 20:31:28 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8E9A4DEE80;
        Wed, 18 Nov 2020 20:31:28 +0000 (UTC)
Date:   Wed, 18 Nov 2020 21:34:08 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: display: himax,hx8837: Add Himax
 HX8837 bindings
Message-ID: <20201118203408.GA6797@demiurge.local>
References: <20201030030800.1036888-1-lkundrak@v3.sk>
 <20201030030800.1036888-2-lkundrak@v3.sk>
 <20201101163922.GA3971@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101163922.GA3971@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 06:39:22PM +0200, Laurent Pinchart wrote:
> Hi Lubomir,
> 
> Thank you for the patch.

Thanks for the message. Some responses inline below.

> On Fri, Oct 30, 2020 at 04:07:59AM +0100, Lubomir Rintel wrote:
> > Himax HX8837 is a secondary display controller used to drive the panel
> > on OLPC platforms.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > ---
> > Changes since v4:
> > - Rob's Reviewed-by
> > 
> > Changes since v3:
> > - Moved to bindings/display/
> > - Added the ports
> > - Converted to YAML
> > - Removed Pavel's Ack, because the changes are substantial
> > 
> > Changes since v2:
> > - s/betweend/between/
> > 
> > Changes since v1:
> > - s/load-gpio/load-gpios/
> > - Use interrupt bindings instead of gpio for the IRQ
> > 
> >  .../bindings/display/bridge/himax,hx8837.yaml | 96 +++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/himax,hx8837.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/himax,hx8837.yaml b/Documentation/devicetree/bindings/display/bridge/himax,hx8837.yaml
> > new file mode 100644
> > index 0000000000000..f5b0a00f5089d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/himax,hx8837.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2018,2019,2020 Lubomir Rintel <lkundrak@v3.sk>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/himax,hx8837.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HX8837 Display Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Lubomir Rintel <lkundrak@v3.sk>
> > +
> > +properties:
> > +  compatible:
> > +    const: himax,hx8837
> > +
> > +  reg:
> > +    const: 0xd
> > +
> > +  load-gpios:
> > +    maxItems: 1
> > +    description: GPIO specifier of DCON_LOAD pin (active high)
> > +
> > +  stat-gpios:
> > +    minItems: 2
> > +    description: GPIO specifier of DCON_STAT0 and DCON_STAT1 pins (active high)
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Interrupt specifier of DCON_IRQ pin (edge falling)
> > +
> > +  ports:
> > +    type: object
> > +
> > +    properties:
> > +      port@0:
> > +        type: object
> > +        description: |
> > +          Video port for RGB input.
> > +
> > +      port@1:
> > +        type: object
> > +        description: |
> > +          Video port connected to the panel.
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> 
> No regulators ?

There are four.

On the OLPC platform they're controlled together by the EC.

I've added the supplies to the EC driver and looked into supporting them 
properly in the driver and am finding it somehow tricky to do it properly.

I couldn't figure out what is the proper place to enable and disable the
regulators. Also drm_bridge_remove() just mercilessly tearing down the
bridge without ensuring it's not used anymore doesn't help us on driver
unbind.

I'm wondering if it's okay if I leave the driver without explicit
support for the power supplies for now, assuming that EC just takes
care of enabling the power and never disable it?

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - load-gpios
> > +  - stat-gpios
> 
> Do stat-gpios need to be mandatory ? The driver in patch 2/2 doesn't
> seem to use them, could we have boards where those signals are not
> connected to GPIOs ?

Perhaps not, in theory.

Pretty sure the OLPC machines are the only ones that utilize this
silicon though.

> > +  - interrupts
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        
> 
> Could you please avoid spaces or tabs at end of lines ? There are three
> other occurrences below.

Ugh, I was sure I ran checkpatch.pl, but apparently not.
Sorry for that.

> > +        lcd-controller@d {
> > +            compatible = "himax,hx8837";
> > +            reg = <0x0d>;
> > +            stat-gpios = <&gpio 100 GPIO_ACTIVE_HIGH>,
> > +                         <&gpio 101 GPIO_ACTIVE_HIGH>;
> > +            load-gpios = <&gpio 142 GPIO_ACTIVE_HIGH>;
> > +            interrupts = <&gpio 124 IRQ_TYPE_EDGE_FALLING>;
> > +    
> > +            ports {
> > +                #address-cells = <0x01>;
> > +                #size-cells = <0x00>;
> > +    
> > +                port@0 {
> > +                    reg = <0x00>;
> 
> reg = <0> should be fine. Same below.
> 
> With thse small issues addressed,
> 
> > +                    dcon_rgb_in: endpoint {
> > +                        remote-endpoint = <&lcd0_rgb_out>;
> > +                    };
> > +                };
> > +    
> > +                port@1 {
> > +                    reg = <0x01>;
> > +                    dcon_gettl_out: endpoint {
> > +                        remote-endpoint = <&panel_dettl_in>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> 
> It's customary to end bindings with
> 
> ...
> 
> (not sure why though, given that it seems to work find without)

Okay, will add that.

Thank you
Lubo

> 
> -- 
> Regards,
> 
> Laurent Pinchart
