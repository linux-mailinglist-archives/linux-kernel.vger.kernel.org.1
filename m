Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89A274D68
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 01:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgIVXjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 19:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVXjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:39:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C308C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:39:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so2201755pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YdQxshBh2RtrMI4Cvgd8CBgFJUrFSJgFFAEH5ZRL7+Q=;
        b=kNeuRrgh44mt3gizs9oxyhE7HFnwdZdJeoUNjj+xpzYl4OARE7t5Z+MnbaK4/BE52o
         rsJ/aWkYyxk9UVVcV3M1cF1oyklbunWAg/BQkZNPDCjdm4O4fMV3LNeTvNTOrBztBqvJ
         ZahUcRsAtHJOMWA1VZE4uImle1KbHQ2ctReqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YdQxshBh2RtrMI4Cvgd8CBgFJUrFSJgFFAEH5ZRL7+Q=;
        b=JMRq+Nr2aPL/9/4MO4VeluTted+83qUhvFc6bXy3NQ4+DHTh6r+ZLMKNmUOZ7/eu/T
         ki9y2kPTSnjpSbnjHQU6JzXDhT4w555m+aUVxo4tceV21lt90W4YV1PVoJ4T24dapVMc
         x65QHNm3drclTDJ1AKexfj9/tlTOSJLSdeer3c7rXMxjfRm3S783AxDPkSvgq5aUwpua
         rSGfNoR1baukWBZyKnEwmxd8AgiicVlSr/WzL/kSbTc0ius4gy6jkPTstleVBvhnm5hm
         Jk/xYOkMY8jDu/NExSGLAOCjWMU3BlO774dyBF4+lxqsj7OTadNzXZGVVmt9g9jHr+tY
         b+Sw==
X-Gm-Message-State: AOAM5318yjW70OpMIJRLg8rGsVr/5etOkpHoFmI/LtxSkjeawmsb1fCH
        Orzwi0DjL7p7ct9/oKKXY5284g==
X-Google-Smtp-Source: ABdhPJz5gZt3QVAP16hjKl8dT+dhKzNOIX3Mm0gNuvpZWc1eh795nEzJOkRE5gRGTcESRaV0sdzlCA==
X-Received: by 2002:a17:902:9006:b029:d2:341:6520 with SMTP id a6-20020a1709029006b02900d203416520mr7034633plp.37.1600817972370;
        Tue, 22 Sep 2020 16:39:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id v21sm3316074pjn.4.2020.09.22.16.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 16:39:31 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:39:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for onboard USB hubs
Message-ID: <20200922233930.GA2105328@google.com>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200915142145.GA1861636@bogus>
 <20200916000008.GG2771744@google.com>
 <CAL_JsqLN=+icsQiyBJ98S2nGcRueUfkeRsR16o1zAQ36+DvAkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqLN=+icsQiyBJ98S2nGcRueUfkeRsR16o1zAQ36+DvAkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Sep 18, 2020 at 10:05:21AM -0600, Rob Herring wrote:
> +Florian
> 
> On Tue, Sep 15, 2020 at 6:00 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > On Tue, Sep 15, 2020 at 08:21:45AM -0600, Rob Herring wrote:
> > > On Mon, Sep 14, 2020 at 11:27:48AM -0700, Matthias Kaehlcke wrote:
> > > > Onboard USB hubs need to be powered and may require initiaization of
> > > > other resources (like GPIOs or clocks) to work properly. This adds
> > > > a device tree binding for these hubs.
> > >
> > > We already have bindings for these. 2 in fact as I2C controlled hubs are
> > > often described under the I2C bus.
> >
> > Yes, these are I2C controlled hubs, which need hub specific drivers. This
> > driver is for hubs without an additional bus that share similar
> > initialization requirements and can benefit from common functionality.
> 
> Yes, as I said, there's already 2 ways to do this. The second is
> defining the USB bus under the USB host. I'm sure there's some
> examples in the tree.

I suppose you refer to something like the hub@1 and hub@2 nodes in the
example of this patch. This alone is not a suitable method in this case,
since the hub needs to be powered/initialized before it can be detected
by the USB bus and a driver could perform any initialization (a
chicken-egg problem)

> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > >
> > > >  .../bindings/usb/onboard_usb_hub.yaml         | 70 +++++++++++++++++++
> > > >  1 file changed, 70 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > > new file mode 100644
> > > > index 000000000000..f82d8f459eed
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > > @@ -0,0 +1,70 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Binding for onboard USB hubs
> > > > +
> > > > +maintainers:
> > > > +  - Matthias Kaehlcke <mka@chromium.org>
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/usb/onboard_usb_hub.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - onboard-usb-hub
> > > > +      - realtek,rts5411
> > > > +
> > > > +  power-off-in-suspend:
> > > > +    description:
> > > > +      The hub should be powered off during system suspend. When the
> > > > +      "wakeup-source" property is also provided the hub is only powered
> > > > +      off during suspend when no wakeup capable descendants are connected.
> > > > +    type: boolean
> > > > +
> > > > +  vdd-supply:
> > > > +    description:
> > > > +      phandle to the regulator that provides power to the hub.
> > > > +
> > > > +  wakeup-source:
> > > > +    description:
> > > > +      Wakeup capable USB devices connected to this hub can be used as
> > > > +      wakeup source.
> > > > +    type: boolean
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - vdd-supply
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    usb_hub: usb-hub {
> > > > +        compatible = "realtek,rts5411", "onboard-usb-hub";
> > > > +        vdd-supply = <&pp3300_hub>;
> > > > +        power-off-in-suspend;
> > > > +        wakeup-source;
> > >
> > > This is the hub device?
> >
> > This is the physical hub device on the platform bus, which is the
> 
> How is a USB hub connected to the 'platform bus'? There's no such
> thing as 'platform bus' in DT.

I suppose in DT lingo you would say the 'system bus'. Under Linux
such devices are often represented as platform devices, 'connected'
to the pseudo 'platform' bus. It is the physical chip that has pins
to supply power, assert a reset or receive an input clock.

> > equivalent to this entry for a usb2512b hub on an I2C bus:
> >
> >     usb2512b@2c {
> >         compatible = "microchip,usb2512b";
> >         reg = <0x2c>;
> >         reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> >     };
> >
> > (source: Documentation/devicetree/bindings/usb/usb251xb.txt)
> >
> > It doesn't have an I2C, SPI or other bus, hence the platform bus is
> > used.
> >
> > > > +    };
> > > > +
> > > > +    &usb_1_dwc3 {
> > > > +   dr_mode = "host";
> > > > +   #address-cells = <1>;
> > > > +   #size-cells = <0>;
> > > > +
> > > > +   /* 2.0 hub on port 1 */
> > > > +   hub@1 {
> > > > +           compatible = "usbbda,5411";
> > > > +           reg = <1>;
> > > > +           hub = <&usb_hub>;
> > >
> > > Or this node is?
> >
> > It is the USB 2.0 part of the hub. The device is instantiated by
> > Linux even without this node, but the system associates the node
> > with the device, which suggests it 'exists'.
> >
> > The usb2512b mentioned above implicitly also has a node here, it just
> > isn't specified since the USB controller autodetects it.
> 
> Like other probe-able buses, we describe the devices in DT when they
> have extra resources/config which are not probe-able.

The problem is that the device is not probe-able without being
powered first.

> > > > +   };
> > > > +
> > > > +   /* 3.0 hub on port 2 */
> > > > +   hub@2 {
> > > > +           compatible = "usbbda,411";
> > > > +           reg = <2>;
> > > > +           hub = <&usb_hub>;
> > >
> > > Or this node is?
> >
> > It is the USB 3.0 part of the hub.
> >
> > > The hub node belongs here.
> >
> > The platform device isn't probed when the node is inside the USB
> > controller node. I haven't investigated why that's the case.
> 
> It shouldn't be a platform device, but associating a device_node with
> the usb device. I think at least that is there in the kernel.
> 
> Though if you need setup to happen before the device is probe-able
> which appears to be the case here, then that is a common problem which
> isn't really a solved issue. There's the mmc-pwrseq stuff, but I don't
> want to see a repeat of that. There was an #armlinux irc discussion I
> had with Florian on this just 2 days ago[1]. If the only thing you
> have to configure is 'reset-gpios', then you probably can do that
> generically scanning all the child USB DT devices and deassert reset.
> But as soon as you have device specific things and need specific
> ordering and timing, then you'll need device specific code to handle
> it.

Yeah, there have been a few attempts to solve this in the past,
unfortunately none of them was accepted, hopefully we can break this
pattern :)

For my specific use case only a single regulator needs to be turned on,
however that could be different for other hubs/configurations. So yes,
I think device specific code will be needed, but preferably not a
driver for every hub model/family.

Also the driver can optionally turn the power of the hub off during
system suspend, either always or only when no wakeup capable
descendants are connected, hence the driver needs to be aware of all
the USB hub devices that correspond to the hub chip.

> >
> > > If you really have it connected to 2 upstream ports, then just do
> > > one node with 'reg = <1 2>;'.
> >
> > Yes, it is connected to two upstream ports. The platform driver needs a
> > reference to both/all hubs, to be able to determine whether to keep the
> > hub powered during system suspend or not.
> >
> > Technically the hub with product id 0x5411 is connected to port 1 and the
> > one with product id 0x411 to port 2, so I would say the above is more
> > accurate than pretending one of the hubs is connected to both ports.
> >
> > I would argue that the two hub nodes are similar to a SDIO BT/WiFi combo,
> > where you have one chip/module with multiple functions. The DT has entries
> > for both functions, even though they reside in the same chip and share the
> > same bus.
> 
> That has generally worked because little is shared between BT and WiFi
> and what is shared is refcounted (clks for example). That could work
> here, we just have to be careful.

The USB portion of the driver is currently a very thin layer, it essentially
(un)registers the USB devices with the main driver (the platform device)
and that's it. I received some feedback related with refcounting on the driver
patch, which I will incorporate.

Thanks

Matthias
