Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED027EC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgI3P2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3P2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:28:38 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4512C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:28:36 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z19so598623uap.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI6flaN45h6c4S1U3iS1qLPc2mhSgihfQFoOlFOrNoM=;
        b=ARgjJDxIblSfCQxhmZ0tgJOwgQoXvkcDgIEd8BELIEsCD3a/b4+rIFKwD18gMYz1QV
         EgcLIbGZ0igKWTWOObPuByRRi8Y9K6D8sqUBo3QwYRPUtfi+wt/663tFcVI+fOx0aw8m
         38+eZxRGicAHtzfJtaWrqBcrmoZ6kcWFrKX2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI6flaN45h6c4S1U3iS1qLPc2mhSgihfQFoOlFOrNoM=;
        b=uA4g5Q+Z+9g3FK1V66Mcz7h4kXX3BgkTxcD+CjEGQVOhpdp0Gbq1JFbsYUGYDm08Kb
         Gm7AX8J4B9TpekzakCSFxWLSXDFTHzJw7gb9NT+qTbdiBwWPj9xlXrBNvpXl+r9se8f0
         exG72yG+7VS6w9fgXIfgw1V1aeQ30LyI6CmjW9TrrjEfX7UmiYg+XwXJfvfDNmOkT6JH
         T2IDE0N9m4tdILvebdcHi0zlM3eKMhzRAsiUNFRSYrEFaVi1xy1uJ3yR+mtpXwbeWx+l
         CQ5f4ne1ZSHjeJGAU0Ci71yycptJ5SuI5fELlsGRdb1cCZfOdAU1uW2PhUXdQHZSabjC
         jGBQ==
X-Gm-Message-State: AOAM531RSKC1d7lFxm9n1zGN4OcmpOIqcgZebWziIOivmLtoq48NjzVr
        F04iw8syjz4aNz2H7SQABRV1ki0llNDYcQ==
X-Google-Smtp-Source: ABdhPJxySiI/nIL/nOzafjQmOJp3lA+e2I7i5Bu7VUCExnQHqx+KRcR/P9DCV3G1o5M089m9Kc1MDQ==
X-Received: by 2002:ab0:6298:: with SMTP id z24mr2121997uao.105.1601479714893;
        Wed, 30 Sep 2020 08:28:34 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id r17sm312700vsf.25.2020.09.30.08.28.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 08:28:31 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id q13so469243vkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:28:30 -0700 (PDT)
X-Received: by 2002:ac5:c297:: with SMTP id h23mr1852218vkk.21.1601479710319;
 Wed, 30 Sep 2020 08:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus> <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu> <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
In-Reply-To: <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Sep 2020 08:28:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
Message-ID: <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Rob Herring <robh@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 30, 2020 at 7:44 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 30, 2020 at 7:49 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Alan,
> >
> > On Tue, Sep 29, 2020 at 09:32:29PM -0400, Alan Stern wrote:
> > > On Tue, Sep 29, 2020 at 03:09:12PM -0700, Matthias Kaehlcke wrote:
> > > > Hi Rob,
> > > >
> > > > On Tue, Sep 29, 2020 at 03:17:01PM -0500, Rob Herring wrote:
> > > > > As I said in prior version, this separate node and 'hub' phandle is not
> > > > > going to work. You are doing this because you want a platform driver for
> > > > > "realtek,rts5411". That may be convenient for Linux, but doesn't reflect
> > > > > the h/w.
> > > >
> > > > I agree that the hardware representation isn't totally straightforward, however
> > > > the description isn't limited to Linux:
> > > >
> > > > - there is a single IC (like the Realtek RTS5411)
> > > > - the IC may require several resources to be initialized in a certain way
> > > >   - this may require executing hardware specific code by some driver, which
> > > >     isn't a USB device driver
> > > > - the IC can 'contain' multiple USB hub devices, which can be connected to
> > > >   separate USB busses
> > > > - the IC doesn't have a control bus, which somewhat resembles the
> > > >   'simple-audio-amplifier' driver, which also registers a platform device
> > > >   to initialize its resources
> > > >
> > > > - to provide the functionality of powering down the hub conditionally during
> > > >   system suspend the driver (whether it's a platform driver or something else)
> > > >   needs know which USB (hub) devices correspond to it. This is a real world
> > > >   problem, on hardware that might see wide distribution.
> > > >
> > > > There were several attempts to solve this problem in the past, but none of them
> > > > was accepted. So far Alan Stern seems to think the driver (not necessarily the
> > > > binding as is) is a suitable solution, Greg KH also spent time reviewing it,
> > > > without raising conceptual concerns. So it seems we have solution that would
> > > > be generally landable from the USB side.
>
> Just as I spend no time reviewing the driver side typically, I don't
> think Alan or Greg spend any time on the DT side.
>
> > > > I understand that your goal is to keep the device tree sane, which I'm sure
> > > > can be challenging. If you really can't be convinced that the binding might
> > > > be acceptable in its current or similiar form then please offer guidance
> > > > on possible alternatives which allow to achieve the same functionality.
> > >
> > > You're really trying to represent this special IC in DT, right?
> >
> > Yes
> >
> > > Maybe  if you don't call it a "hub" but instead something that better reflects
> > > what it actually is and does, the description will be more palatable.
>
> It's a hub. The name is not the problem.
>
> > Thanks for your suggestion.
> >
> > Datasheets from different manufacturers refer to these ICs as "USB hub
> > controller". Calling the node "usb-hub-controller" would indeed help to
> > distinguish it from the USB hub devices and represent existing hardware.
> > And the USB device could have a "hub-controller" property, which also
> > would be clearer than the current "hub" property.
>
> There aren't 2 (or 3) devices here. There's a single USB device (a
> hub) and the DT representation should reflect that.

That's not completely true, though, is it?  As I understand it, a USB
3 port is defined as containing both a USB 2 controller and a USB 3
controller.  While it's one port, it's still conceptually two
(separable) things.  The fact that they are on the same physical chip
doesn't mean that they are one thing any more than a SoC (one chip)
needs to be represented by one thing in the device tree.  Though, of
course, I'm not the expert here, the argument that this IC is a USB 2
hub, a USB 3 hub, and some control logic doesn't seem totally
insane...


> We already have hubs in DT. See [1][2][3][4]. What's new here? Simply,
> vdd-supply needs to be enabled for the hub to be enumerated. That's
> not a unique problem for USB, but common for all "discoverable" buses
> with MDIO being the most recent example I pointed you to. I'm not sure
> what happened with the previous attempt for USB[5]. It didn't look
> like there was a major issue. 'generic' power sequencing can't really
> handle every case, but as long as bindings allow doing something
> device specific I don't care so much. The driver side can evolve. The
> DT bindings can't.
>
> So what should this look like? There are 2 issues here. First, how do
> we represent a USB3 device if that means multiple ports. I'm not
> really sure other than it needs to be defined and documented. I think
> the choices are: ignore the USB3 part (USB2 is always there and what's
> used for enumeration, right?) or allow multiple ports in reg.

Interesting question, that one.  When trying to optimize board designs
we have certainly talked about separating out the USB 2 and USB 3 [1].
For instance, we could take the USB 3 lines from the root hub and send
them off to a high speed camera and then take the USB 2 lines and
route them to a hub which then went to some low speed devices.  We
chickened out and didn't do this, but we believed that it would work.


> Do hubs
> really have 2 ports for each connection?

Yup.  It's really two hubs.

localhost ~ # lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M

localhost ~ # lsusb
Bus 002 Device 002: ID 0bda:0411 Realtek Semiconductor Corp.
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 0bda:5411 Realtek Semiconductor Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

I think this means that we're already forced to split this one device
across two nodes in the device tree, right?  Oh, or I guess you said
we could change the binding to allow more than one port in one reg?
What would that look like?  You'd have more than one VID/PID listed in
the compatible string and more than one "reg"?


> The 2nd issue is where do extra properties for a device go. That's
> nothing new nor special to USB. They go with the device node. We
> already went thru that with the last attempt.
>
> So for this case, we'd have something like this:
>
>     usb_controller {
>         dr_mode = "host";
>         #address-cells = <1>;
>         #size-cells = <0>;
>
>         hub@1 {
>             compatible = "usbbda,5411";
>             reg = <1>;
>             vdd-supply = <&pp3300_hub>;
>         };
>     };
>
> This is no different than needing a reset line deasserted as the prior
> attempt did.

I'd believe that the above could be made to work with enough software
change in the USB stack.  Presumably we wouldn't want to actually do a
full probe of the device until USB actually enumerated it, but I guess
you could add some type of optional "pre-probe" step where a driver is
called?  So you'd call a pre-probe on whatever driver implements
"usbbda,5411" and it would turn on the power supply.  ...then, if the
device is actually there, the normal probe would be called?  I guess
that'd work...

One thing that strikes me as a possible problem, though, is that I
totally envision HW guys coming back and saying: "oh, we want to
second source that USB hub and randomly stuff a different hub on some
boards".  In theory that's a reasonable suggestion, right?  USB is a
probable bus.  We turn on power to the USB hub (and the regulator to
turn on power is the same no matter which hub is stuffed) and then we
can just check which device got enumerated.  It's likely that both
hubs would behave the same from a software point of view, but they
would have different VID/PID.

As far as I understand the current USB bindings account for the fact
that the device(s) specified in the device tree might or might not be
there.  Adding a node under the controller like you show above means:
"if something is plugged into port 1 of this USB hub and if that thing
matches 0x0bda/0x5411 then here are the extra properties (vdd-supply)
for it".  With your proposal I believe we're changing it to mean
"there will definitely be a device plugged into port 1 of this USB hub
and it will match 0x0bda/0x5411."  Unless I'm mistaken, that will have
potential impacts on the ability to second source things.  I guess
both pre-probe functions could be called and (since there can be
multiple users of a regulator) it'd be OK, but if we get into reset
lines it's not much fun.  However, describing the device more like
Matthias has done it will be nicely compatible with second sourcing.


[1] https://lore.kernel.org/r/CAHNYxRzH3F7r4A3hOJYWw8fwoSLBESyyN7XQ4HYfw1Y3qoNbJg@mail.gmail.com
