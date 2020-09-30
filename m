Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ABF27EB33
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgI3Oon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgI3Oon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:44:43 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5903D207C3;
        Wed, 30 Sep 2020 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601477082;
        bh=BOq6LyRCWyDbwgviicHXV9zK30oNwH9I4OjbgV2jSu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XR0RwAIPyQ/gwoNxiS88Uk+kAVw3+/FLiFaigjZLT4HV5VQy4Ww3O/g1jXuWikQzB
         axjW1dfGZqeWCCzdNQ6XaP0mZluNmin2ugM6f0bP5BYuoUoxuCvjwCrdqTFSL0yXKl
         an1D6qvzFpsL6App6vM17CZ0c760qmr7PMCWCUPM=
Received: by mail-ot1-f43.google.com with SMTP id g96so2032251otb.12;
        Wed, 30 Sep 2020 07:44:42 -0700 (PDT)
X-Gm-Message-State: AOAM533d9h10XEX0w2wLxklXpB5bU3PFcMIIcO/1mSFzae9Vn0E4Iijc
        598+QmRS2B0xeSP/roqmYLxLYJgp/iPXmha6sg==
X-Google-Smtp-Source: ABdhPJwNZ8YRYNRFl8N0imfJdwtVm0sAg6EbUrKo41F4WMvrHs3g9tMmeVkEIDtGWsvHj9HWx1E7yxbfEqO0Uhna7Hw=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr1646798otp.107.1601477081549;
 Wed, 30 Sep 2020 07:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus> <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu> <20200930124915.GA1826870@google.com>
In-Reply-To: <20200930124915.GA1826870@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 30 Sep 2020 09:44:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
Message-ID: <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 7:49 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Alan,
>
> On Tue, Sep 29, 2020 at 09:32:29PM -0400, Alan Stern wrote:
> > On Tue, Sep 29, 2020 at 03:09:12PM -0700, Matthias Kaehlcke wrote:
> > > Hi Rob,
> > >
> > > On Tue, Sep 29, 2020 at 03:17:01PM -0500, Rob Herring wrote:
> > > > As I said in prior version, this separate node and 'hub' phandle is not
> > > > going to work. You are doing this because you want a platform driver for
> > > > "realtek,rts5411". That may be convenient for Linux, but doesn't reflect
> > > > the h/w.
> > >
> > > I agree that the hardware representation isn't totally straightforward, however
> > > the description isn't limited to Linux:
> > >
> > > - there is a single IC (like the Realtek RTS5411)
> > > - the IC may require several resources to be initialized in a certain way
> > >   - this may require executing hardware specific code by some driver, which
> > >     isn't a USB device driver
> > > - the IC can 'contain' multiple USB hub devices, which can be connected to
> > >   separate USB busses
> > > - the IC doesn't have a control bus, which somewhat resembles the
> > >   'simple-audio-amplifier' driver, which also registers a platform device
> > >   to initialize its resources
> > >
> > > - to provide the functionality of powering down the hub conditionally during
> > >   system suspend the driver (whether it's a platform driver or something else)
> > >   needs know which USB (hub) devices correspond to it. This is a real world
> > >   problem, on hardware that might see wide distribution.
> > >
> > > There were several attempts to solve this problem in the past, but none of them
> > > was accepted. So far Alan Stern seems to think the driver (not necessarily the
> > > binding as is) is a suitable solution, Greg KH also spent time reviewing it,
> > > without raising conceptual concerns. So it seems we have solution that would
> > > be generally landable from the USB side.

Just as I spend no time reviewing the driver side typically, I don't
think Alan or Greg spend any time on the DT side.

> > > I understand that your goal is to keep the device tree sane, which I'm sure
> > > can be challenging. If you really can't be convinced that the binding might
> > > be acceptable in its current or similiar form then please offer guidance
> > > on possible alternatives which allow to achieve the same functionality.
> >
> > You're really trying to represent this special IC in DT, right?
>
> Yes
>
> > Maybe  if you don't call it a "hub" but instead something that better reflects
> > what it actually is and does, the description will be more palatable.

It's a hub. The name is not the problem.

> Thanks for your suggestion.
>
> Datasheets from different manufacturers refer to these ICs as "USB hub
> controller". Calling the node "usb-hub-controller" would indeed help to
> distinguish it from the USB hub devices and represent existing hardware.
> And the USB device could have a "hub-controller" property, which also
> would be clearer than the current "hub" property.

There aren't 2 (or 3) devices here. There's a single USB device (a
hub) and the DT representation should reflect that.

We already have hubs in DT. See [1][2][3][4]. What's new here? Simply,
vdd-supply needs to be enabled for the hub to be enumerated. That's
not a unique problem for USB, but common for all "discoverable" buses
with MDIO being the most recent example I pointed you to. I'm not sure
what happened with the previous attempt for USB[5]. It didn't look
like there was a major issue. 'generic' power sequencing can't really
handle every case, but as long as bindings allow doing something
device specific I don't care so much. The driver side can evolve. The
DT bindings can't.

So what should this look like? There are 2 issues here. First, how do
we represent a USB3 device if that means multiple ports. I'm not
really sure other than it needs to be defined and documented. I think
the choices are: ignore the USB3 part (USB2 is always there and what's
used for enumeration, right?) or allow multiple ports in reg. Do hubs
really have 2 ports for each connection?

The 2nd issue is where do extra properties for a device go. That's
nothing new nor special to USB. They go with the device node. We
already went thru that with the last attempt.

So for this case, we'd have something like this:

    usb_controller {
        dr_mode = "host";
        #address-cells = <1>;
        #size-cells = <0>;

        hub@1 {
            compatible = "usbbda,5411";
            reg = <1>;
            vdd-supply = <&pp3300_hub>;
        };
    };

This is no different than needing a reset line deasserted as the prior
attempt did.

Rob

[1] arch/arm/boot/dts/omap5-uevm.dts
[2] arch/arm/boot/dts/omap5-igep0050.dts
[3] arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
[4] arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
[5] https://lore.kernel.org/lkml/CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com/
