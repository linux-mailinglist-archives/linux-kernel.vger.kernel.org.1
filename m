Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208B827018F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRQFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:05:36 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B24F23888;
        Fri, 18 Sep 2020 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445135;
        bh=/jtGzaSFhcML7gFvXOyrFp8wXpuiZ4YoqvXopimAccI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GLtkFh5wrmceJ7iejRuEt1MN9S2gXSwvTcrTICrtpxNVkFqquRJaLisDl1nL2UIcP
         htZZ/V6gga3tFmVGNcDV/FOxCtQ4jn0IFIJ/LtdSNXl8JGWEF35Ln1cXMOCQjk8G1V
         qipgCUE1mCP4GjdxlfBt4vI5gmK6dPM153uvMX+o=
Received: by mail-oi1-f170.google.com with SMTP id y6so7619233oie.5;
        Fri, 18 Sep 2020 09:05:35 -0700 (PDT)
X-Gm-Message-State: AOAM531QxreOGsselNmvVINVHeiENMtxIwwOob3DEEnIKxFQg3YTB3/O
        LlN4sHtYcysjicBNm5IReer1fOwpmwXozCf7sA==
X-Google-Smtp-Source: ABdhPJwnYBIiziuhSIY6yUU90RmySa/cL8llmX10i6r7vnjVrfFCaxstEbq1Bz9fJdOwUsoKCn42Ro80P1onG6ooQdY=
X-Received: by 2002:aca:4d58:: with SMTP id a85mr9246503oib.147.1600445134520;
 Fri, 18 Sep 2020 09:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200915142145.GA1861636@bogus> <20200916000008.GG2771744@google.com>
In-Reply-To: <20200916000008.GG2771744@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Sep 2020 10:05:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLN=+icsQiyBJ98S2nGcRueUfkeRsR16o1zAQ36+DvAkg@mail.gmail.com>
Message-ID: <CAL_JsqLN=+icsQiyBJ98S2nGcRueUfkeRsR16o1zAQ36+DvAkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for onboard USB hubs
To:     Matthias Kaehlcke <mka@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Florian

On Tue, Sep 15, 2020 at 6:00 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Rob,
>
> On Tue, Sep 15, 2020 at 08:21:45AM -0600, Rob Herring wrote:
> > On Mon, Sep 14, 2020 at 11:27:48AM -0700, Matthias Kaehlcke wrote:
> > > Onboard USB hubs need to be powered and may require initiaization of
> > > other resources (like GPIOs or clocks) to work properly. This adds
> > > a device tree binding for these hubs.
> >
> > We already have bindings for these. 2 in fact as I2C controlled hubs are
> > often described under the I2C bus.
>
> Yes, these are I2C controlled hubs, which need hub specific drivers. This
> driver is for hubs without an additional bus that share similar
> initialization requirements and can benefit from common functionality.

Yes, as I said, there's already 2 ways to do this. The second is
defining the USB bus under the USB host. I'm sure there's some
examples in the tree.

> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >
> > >  .../bindings/usb/onboard_usb_hub.yaml         | 70 +++++++++++++++++++
> > >  1 file changed, 70 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > new file mode 100644
> > > index 000000000000..f82d8f459eed
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > @@ -0,0 +1,70 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Binding for onboard USB hubs
> > > +
> > > +maintainers:
> > > +  - Matthias Kaehlcke <mka@chromium.org>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/usb/onboard_usb_hub.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - onboard-usb-hub
> > > +      - realtek,rts5411
> > > +
> > > +  power-off-in-suspend:
> > > +    description:
> > > +      The hub should be powered off during system suspend. When the
> > > +      "wakeup-source" property is also provided the hub is only powered
> > > +      off during suspend when no wakeup capable descendants are connected.
> > > +    type: boolean
> > > +
> > > +  vdd-supply:
> > > +    description:
> > > +      phandle to the regulator that provides power to the hub.
> > > +
> > > +  wakeup-source:
> > > +    description:
> > > +      Wakeup capable USB devices connected to this hub can be used as
> > > +      wakeup source.
> > > +    type: boolean
> > > +
> > > +required:
> > > +  - compatible
> > > +  - vdd-supply
> > > +
> > > +examples:
> > > +  - |
> > > +    usb_hub: usb-hub {
> > > +        compatible = "realtek,rts5411", "onboard-usb-hub";
> > > +        vdd-supply = <&pp3300_hub>;
> > > +        power-off-in-suspend;
> > > +        wakeup-source;
> >
> > This is the hub device?
>
> This is the physical hub device on the platform bus, which is the

How is a USB hub connected to the 'platform bus'? There's no such
thing as 'platform bus' in DT.

> equivalent to this entry for a usb2512b hub on an I2C bus:
>
>     usb2512b@2c {
>         compatible = "microchip,usb2512b";
>         reg = <0x2c>;
>         reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
>     };
>
> (source: Documentation/devicetree/bindings/usb/usb251xb.txt)
>
> It doesn't have an I2C, SPI or other bus, hence the platform bus is
> used.
>
> > > +    };
> > > +
> > > +    &usb_1_dwc3 {
> > > +   dr_mode = "host";
> > > +   #address-cells = <1>;
> > > +   #size-cells = <0>;
> > > +
> > > +   /* 2.0 hub on port 1 */
> > > +   hub@1 {
> > > +           compatible = "usbbda,5411";
> > > +           reg = <1>;
> > > +           hub = <&usb_hub>;
> >
> > Or this node is?
>
> It is the USB 2.0 part of the hub. The device is instantiated by
> Linux even without this node, but the system associates the node
> with the device, which suggests it 'exists'.
>
> The usb2512b mentioned above implicitly also has a node here, it just
> isn't specified since the USB controller autodetects it.

Like other probe-able buses, we describe the devices in DT when they
have extra resources/config which are not probe-able.

> > > +   };
> > > +
> > > +   /* 3.0 hub on port 2 */
> > > +   hub@2 {
> > > +           compatible = "usbbda,411";
> > > +           reg = <2>;
> > > +           hub = <&usb_hub>;
> >
> > Or this node is?
>
> It is the USB 3.0 part of the hub.
>
> > The hub node belongs here.
>
> The platform device isn't probed when the node is inside the USB
> controller node. I haven't investigated why that's the case.

It shouldn't be a platform device, but associating a device_node with
the usb device. I think at least that is there in the kernel.

Though if you need setup to happen before the device is probe-able
which appears to be the case here, then that is a common problem which
isn't really a solved issue. There's the mmc-pwrseq stuff, but I don't
want to see a repeat of that. There was an #armlinux irc discussion I
had with Florian on this just 2 days ago[1]. If the only thing you
have to configure is 'reset-gpios', then you probably can do that
generically scanning all the child USB DT devices and deassert reset.
But as soon as you have device specific things and need specific
ordering and timing, then you'll need device specific code to handle
it.

>
> > If you really have it connected to 2 upstream ports, then just do
> > one node with 'reg = <1 2>;'.
>
> Yes, it is connected to two upstream ports. The platform driver needs a
> reference to both/all hubs, to be able to determine whether to keep the
> hub powered during system suspend or not.
>
> Technically the hub with product id 0x5411 is connected to port 1 and the
> one with product id 0x411 to port 2, so I would say the above is more
> accurate than pretending one of the hubs is connected to both ports.
>
> I would argue that the two hub nodes are similar to a SDIO BT/WiFi combo,
> where you have one chip/module with multiple functions. The DT has entries
> for both functions, even though they reside in the same chip and share the
> same bus.

That has generally worked because little is shared between BT and WiFi
and what is shared is refcounted (clks for example). That could work
here, we just have to be careful.

Rob

[1] https://pastebin.com/iepyfe9c
