Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA61EC4AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 23:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFBV4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 17:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgFBVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:55:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5106AC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:55:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so3153512wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pC4aWKB/tDCD8vk19vY98cQZrnpY1VLP07nYFKTadOU=;
        b=WhxoEIQrmXsVVkA1mZVZKHhKg98bXnh64aQouQ50aCjmPZ6Go6IUNqkNkmRLQtsbLz
         +8NZpw9RcHfUiShiva+naYN2YYMjHReQHnCpy4waamumHgcoQ/UijyjLt/TKis5pTg8i
         nb1O9KeHNB7EcwoVeXRMywsXvcUbbhlj84SoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pC4aWKB/tDCD8vk19vY98cQZrnpY1VLP07nYFKTadOU=;
        b=l9uUX73YXbKvomFm/zifOd4pGkQskE9tY/FrOvOdVp4v+JJNhlXBWLrSij+J9DdQHl
         +g2gls/JsrmtLLI1eWipFM9ObP+43SzUKx/oThw2yZbdgL1hV0EDLLy27nH8zJAUTxsS
         XbhtSYJFg2dNOcYOF4z8MRTXRJbODz1uDGj7e1lXEmp/tmr+zP7jtqJwg4xkfRMCFWXw
         Ji2zQzPYK9Clh5JCRvRWgNbXrQxPC9a6KiZTNVlLbR8YPT+j9qIzMAYeXC3fp2lx5p2n
         q+cR0JpuuKTtV+BNdpyeeB0srk3PuGtxK0qD1GwenMWyGzgjwg0mwUhbpHI7u8hAMBrM
         20NQ==
X-Gm-Message-State: AOAM530wQq0LOZUoOnkUcm6iuAUTwPj/545Xi5X9hzUoIGKka5eyjgmn
        UqkLCFnAhQ9A3XGYaTgcRncOMk0v57s9QxEJVkFZig==
X-Google-Smtp-Source: ABdhPJwV813+YIcH+IIsN44nF4R01Z3ZJCDnktHPUm8naM80EtbshruegyltyRNHVxPWX8Q2oaB7+zkMkg3Lra2ICo8=
X-Received: by 2002:a05:600c:280c:: with SMTP id m12mr6141691wmb.92.1591134957775;
 Tue, 02 Jun 2020 14:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200526191303.1492-4-james.quinlan@broadcom.com> <20200529174634.GA2630216@bogus>
 <CA+-6iNwWBFYHVKiwwJ95DYQ5zmc5uBo1cgZzd6rpD++aQWgGpw@mail.gmail.com> <CAL_JsqKtASTzACSNn8BgmEBqf0eyR8RB_tjY7aUnvK+2GYXTbg@mail.gmail.com>
In-Reply-To: <CAL_JsqKtASTzACSNn8BgmEBqf0eyR8RB_tjY7aUnvK+2GYXTbg@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 2 Jun 2020 17:55:44 -0400
Message-ID: <CA+-6iNxK7WaE2c_kwZDk3j7BiVkFdS-FaL5U1TP_DNvBNGgi3w@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] dt-bindings: PCI: Add bindings for more Brcmstb chips
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 5:41 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jun 2, 2020 at 2:53 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> >
> > On Fri, May 29, 2020 at 1:46 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, May 26, 2020 at 03:12:42PM -0400, Jim Quinlan wrote:
> > > > From: Jim Quinlan <jquinlan@broadcom.com>
> > > >
> > > > - Add compatible strings for three more Broadcom STB chips: 7278, 7216,
> > > >   7211 (STB version of RPi4).
> > > > - add new property 'brcm,scb-sizes'
> > > > - add new property 'resets'
> > > > - add new property 'reset-names'
> > > > - allow 'ranges' and 'dma-ranges' to have more than one item and update
> > > >   the example to show this.
> > > >
> > > > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > > > ---
> > > >  .../bindings/pci/brcm,stb-pcie.yaml           | 40 +++++++++++++++++--
> > > >  1 file changed, 36 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > index 8680a0f86c5a..66a7df45983d 100644
> > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > @@ -14,7 +14,13 @@ allOf:
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    const: brcm,bcm2711-pcie # The Raspberry Pi 4
> > > > +    items:
> > > > +      - enum:
> > >
> > > Don't need items here. Just change the const to enum.
> > >
> > > > +          - brcm,bcm2711-pcie # The Raspberry Pi 4
> > > > +          - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> > > > +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> > > > +          - brcm,bcm7216-pcie # Broadcom 7216 Arm
> > > > +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -34,10 +40,12 @@ properties:
> > > >        - const: msi
> > > >
> > > >    ranges:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 4
> > > >
> > > >    dma-ranges:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 6
> > > >
> > > >    clocks:
> > > >      maxItems: 1
> > > > @@ -58,8 +66,30 @@ properties:
> > > >
> > > >    aspm-no-l0s: true
> > > >
> > > > +  resets:
> > > > +    description: for "brcm,bcm7216-pcie", must be a valid reset
> > > > +      phandle pointing to the RESCAL reset controller provider node.
> > > > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > > > +
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: rescal
> > >
> > > These are going to need to be an if/then schema if they only apply to
> > > certain compatible(s).
> >
> > Why is that -- the code is general enough to handle its presence or
> > not (it is an optional compatibility)>
>
> Because an if/then schema expresses in a parse-able form what your
> 'description' does in free form text.
>
> Presumably a 'resets' property for !brcm,bcm7216-pcie is invalid, so
> we should check that. The schema shouldn't be just what some driver
> happens to currently allow. Also, it's not a driver's job to validate
> DT, so it shouldn't check any of this.
Got it, will fix.
>
> > > > +  brcm,scb-sizes:
> > > > +    description: (u32, u32) tuple giving the 64bit PCIe memory
> > > > +      viewport size of a memory controller.  There may be up to
> > > > +      three controllers, and each size must be a power of two
> > > > +      with a size greater or equal to the amount of memory the
> > > > +      controller supports.
> > >
> > > This sounds like what dma-ranges should express?
> >
> > There is some overlap but this contains information that is not in the
> > dma-ranges.  Believe me I tried.
>
> I don't understand. If you had 3 dma-ranges entries, you'd have 3
> sizes. Can you expand or show me what you tried?
Here is a simple example: suppose you have two dma-ranges.  This could
be from one of two cases:

- Both dma-ranges are from the same memory controller (the second
range is the "extended" region).
- One dma-range can be from memc0 and the other can be from memc1; the
extensions are not used.

The driver has to determine (a)  how many memory controllers there are
and (b) what the size should be for each of them.  It is impossible to
do this with the case above.

>
> > > If not, we do have 64-bit size if that what you need.
> >
> > IIRC I tried the 64-bit size but the YAML validator did not like it;
> > it wanted numbers like  <0x1122334455667788> while dtc wanted <
> > 0x11223344 0x55667788>.  I gave up trying and switched to u32.
>
> You used the /bits/ annotation for dtc?:
>
> /bits/ 64 <0x1122334455667788>
>
> I also made a recent fix to dt-schema around handling of 64-bit sizes,
> so update if you have problems still.
I didn't try the /bits/ so I'll pursue this.

Thanks,
Jim

>
> Rob
