Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FF2D4ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgLIXgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:36:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39617 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgLIXgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:36:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id w124so576251oia.6;
        Wed, 09 Dec 2020 15:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PVgIBz0dC5zSxbL7VjWdsB6I3qlutAYuDDq6KKlLILs=;
        b=ruCMxGm6+hzRjbYAAZYan8utT0HFIt2XoSSHZ8aOY+ufQYgGybVxKGhgIeLARaawUM
         9jKl8ygPn/a3VWqzPMoOPMvSu31MlL301H2ModabaNTOUwSm9RjFr+w+lzxNIVDWm6ET
         HA2W509X460ABOFOzmAQhMqZhspidK0ybUWxC/5vCJbi2P1m6cjZ63HoOrd3kaKaoUyv
         IIBm7Wndi0j2vKBHv4sCSsCpWahpl/19zm+StIskL5LFWXMqAX+GSU8PIZWI1WB4fesm
         +T0UC74LA79katDMLduTWLvmd3PdSEs6EI0T8jksYYpFd54ZJ34VGmtoFd0B4rUz8Psz
         G61A==
X-Gm-Message-State: AOAM531eyvkW5gwKcF6/aDsR4umzbB0fm6m38eQQUUt4WpdsAWsNZ7D0
        rm1ZGpjFXrIqGJbvvsKiiw==
X-Google-Smtp-Source: ABdhPJxpmlPVdUWC7PEVdHagBWoWCcgT/SANJgWU6jfY7UBGWfDADp5TYHLGMjAUdTx6KOUFJZmmvg==
X-Received: by 2002:aca:2301:: with SMTP id e1mr3567890oie.8.1607556935621;
        Wed, 09 Dec 2020 15:35:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y84sm657027oig.36.2020.12.09.15.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 15:35:34 -0800 (PST)
Received: (nullmailer pid 1288138 invoked by uid 1000);
        Wed, 09 Dec 2020 23:35:33 -0000
Date:   Wed, 9 Dec 2020 17:35:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: reset: document Broadcom's BCM4908 USB
 reset binding
Message-ID: <20201209233533.GA1281321@robh.at.kernel.org>
References: <20201204093704.11359-1-zajec5@gmail.com>
 <0cc54a35-7d70-8a2f-0c1f-da124136a66d@gmail.com>
 <cb2c0545-a1f6-4b85-6f9f-15813f74e323@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb2c0545-a1f6-4b85-6f9f-15813f74e323@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 05:39:14PM +0100, Rafał Miłecki wrote:
> On 04.12.2020 17:32, Florian Fainelli wrote:
> > On 12/4/2020 1:37 AM, Rafał Miłecki wrote:
> > > From: Rafał Miłecki <rafal@milecki.pl>
> > > 
> > > Document binding of block responsible for initializing USB controllers
> > > (OHCI, EHCI, XHCI).
> > > 
> > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > > ---
> > >   .../reset/brcm,bcm4908-usb-reset.yaml         | 60 +++++++++++++++++++
> > >   1 file changed, 60 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
> > > new file mode 100644
> > > index 000000000000..31beb1c8f3cd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/reset/brcm,bcm4908-usb-reset.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Broadcom BCM4908 USB host controller reset
> > > +
> > > +description: >
> > > +  BCM4908 has a separated block controlling all USB controllers. It handles the
> > > +  whole setup process and takes care of initializing PHYs at the right time
> > > +  (state).
> > > +
> > > +maintainers:
> > > +  - Rafał Miłecki <rafal@milecki.pl>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - brcm,bcm4908-usb-reset
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +
> > > +  phys:
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +
> > > +  phy-names:
> > > +    items:
> > > +      - const: usb2
> > > +      - const: usb3
> > > +
> > > +  "#reset-cells":
> > > +    const: 0
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - phys
> > > +  - phy-names
> > > +  - "#reset-cells"
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    reset-controller@8000c200 {
> > > +        compatible = "brcm,bcm4908-usb-reset";
> > > +        reg = <0x8000c200 0x100>;
> > > +
> > > +        phys = <&usb2_phy>, <&usb3_phy>;
> > > +        phy-names = "usb2", "usb3";
> > 
> > This looks quite unusual, usually the *HCI controllers would be
> > consumers of the PHY and the PHY may be a consumer of the reset controller.
> > 
> > (still going through my emails have not fully read your separate email
> > on the topic, so pardon me if this is being discussed twice).
> 
> I agree, it's the the best solution I found for this specific design.
> 
> This specific hw block perform various operations before, in the middle and
> after PHY initialization. That made me make reset controlller initialize PHYs.
> 
> I'm happy to implement a more proper design if someone can just suggest how.
> I don't have any better idea :(

So the reset controller block has more than just resets? I'd hide all 
this in the phy driver rather than hide the phy in the reset driver. So 
for DT provide the phy a phandle to the reset block to poke the 
registers directly.

Rob
