Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D953B26B63F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgIPABI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgIPAAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 20:00:10 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255EC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 17:00:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so2189997pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 17:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RX3pgRSaqwuA91vHSgRiOLr6fZp+r278bl7l934MXzo=;
        b=I182+EMgnVlXeJ47Jpn+7tZxBNwd0Q4oeX34HqBM9qVe+Kc3Ch8LGnghFtFaFDoiI+
         HGm8fXrJUu2L+YhOwQAi8t6WDe4uJ4ADZRBofop4MrMgBTQdJC1IICusIXpVTxM24MYu
         CHV5T8SHE9ZaD5FzAtY921nrac1crYXcu8ErQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RX3pgRSaqwuA91vHSgRiOLr6fZp+r278bl7l934MXzo=;
        b=DBaoR/tsBl1dnh6z08wHqz1Fz6jpjL5NcBMxCu83mtdwkGM4JuUyeba1wsFbSCH9Sl
         FyKQeaWMEs7gWDEcQYWHKMbkTtRqWha04pPVPE0Am6PZEzqzyr0LPAfbntkY5OMpLlgS
         EvcVuSN/1trMD6bHaXqYEip73gom4ESThssqLxa8Jp4GULZsQ8QD2gKXu08cVA75ZKti
         23CCqghSlaTnkIqopP8FI/kHOSTksVw/br3njHxgRiTWOhLi/udEukF9DB0gdZIF5KZB
         Xs1553+T6/Jp39zfZUTzP7czzDfU2FqYH3QKF5Wniwo1qB17VDl9DYJfJevHLvzsAd/+
         YzUg==
X-Gm-Message-State: AOAM532iXXbuJyicgIKfyZ6d9bBtsnkKTVcQhpJVLZ06wbmkQrXhGy3s
        TMxotZbK2Vr3Vl4pqUPczeITWQ==
X-Google-Smtp-Source: ABdhPJx2q0kjfen9gHcVuYxqbdmmHRWRJidwPFOESeIQIJnD+CHVVXk6+U17mQhEWN8yg8Sb2ToONw==
X-Received: by 2002:a17:90a:8981:: with SMTP id v1mr1640899pjn.54.1600214409487;
        Tue, 15 Sep 2020 17:00:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id e10sm542754pjj.32.2020.09.15.17.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 17:00:09 -0700 (PDT)
Date:   Tue, 15 Sep 2020 17:00:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for onboard USB hubs
Message-ID: <20200916000008.GG2771744@google.com>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200915142145.GA1861636@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915142145.GA1861636@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Sep 15, 2020 at 08:21:45AM -0600, Rob Herring wrote:
> On Mon, Sep 14, 2020 at 11:27:48AM -0700, Matthias Kaehlcke wrote:
> > Onboard USB hubs need to be powered and may require initiaization of
> > other resources (like GPIOs or clocks) to work properly. This adds
> > a device tree binding for these hubs.
> 
> We already have bindings for these. 2 in fact as I2C controlled hubs are 
> often described under the I2C bus.

Yes, these are I2C controlled hubs, which need hub specific drivers. This
driver is for hubs without an additional bus that share similar
initialization requirements and can benefit from common functionality.

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> >  .../bindings/usb/onboard_usb_hub.yaml         | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > new file mode 100644
> > index 000000000000..f82d8f459eed
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binding for onboard USB hubs
> > +
> > +maintainers:
> > +  - Matthias Kaehlcke <mka@chromium.org>
> > +
> > +allOf:
> > +  - $ref: /schemas/usb/onboard_usb_hub.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - onboard-usb-hub
> > +      - realtek,rts5411
> > +
> > +  power-off-in-suspend:
> > +    description:
> > +      The hub should be powered off during system suspend. When the
> > +      "wakeup-source" property is also provided the hub is only powered
> > +      off during suspend when no wakeup capable descendants are connected.
> > +    type: boolean
> > +
> > +  vdd-supply:
> > +    description:
> > +      phandle to the regulator that provides power to the hub.
> > +
> > +  wakeup-source:
> > +    description:
> > +      Wakeup capable USB devices connected to this hub can be used as
> > +      wakeup source.
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - vdd-supply
> > +
> > +examples:
> > +  - |
> > +    usb_hub: usb-hub {
> > +        compatible = "realtek,rts5411", "onboard-usb-hub";
> > +        vdd-supply = <&pp3300_hub>;
> > +        power-off-in-suspend;
> > +        wakeup-source;
> 
> This is the hub device?

This is the physical hub device on the platform bus, which is the
equivalent to this entry for a usb2512b hub on an I2C bus:

    usb2512b@2c {
        compatible = "microchip,usb2512b";
	reg = <0x2c>;
	reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
    };

(source: Documentation/devicetree/bindings/usb/usb251xb.txt)

It doesn't have an I2C, SPI or other bus, hence the platform bus is
used.

> > +    };
> > +
> > +    &usb_1_dwc3 {
> > +	dr_mode = "host";
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> > +	/* 2.0 hub on port 1 */
> > +	hub@1 {
> > +		compatible = "usbbda,5411";
> > +		reg = <1>;
> > +		hub = <&usb_hub>;
> 
> Or this node is?

It is the USB 2.0 part of the hub. The device is instantiated by
Linux even without this node, but the system associates the node
with the device, which suggests it 'exists'.

The usb2512b mentioned above implicitly also has a node here, it just
isn't specified since the USB controller autodetects it.

> > +	};
> > +
> > +	/* 3.0 hub on port 2 */
> > +	hub@2 {
> > +		compatible = "usbbda,411";
> > +		reg = <2>;
> > +		hub = <&usb_hub>;
> 
> Or this node is?

It is the USB 3.0 part of the hub.

> The hub node belongs here.

The platform device isn't probed when the node is inside the USB
controller node. I haven't investigated why that's the case.

> If you really have it connected to 2 upstream ports, then just do
> one node with 'reg = <1 2>;'.

Yes, it is connected to two upstream ports. The platform driver needs a
reference to both/all hubs, to be able to determine whether to keep the
hub powered during system suspend or not.

Technically the hub with product id 0x5411 is connected to port 1 and the
one with product id 0x411 to port 2, so I would say the above is more
accurate than pretending one of the hubs is connected to both ports.

I would argue that the two hub nodes are similar to a SDIO BT/WiFi combo,
where you have one chip/module with multiple functions. The DT has entries
for both functions, even though they reside in the same chip and share the
same bus.
