Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9A281EE9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgJBXJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:09:47 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95877C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:09:45 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p11so1261230vsg.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mf1FoiYU4G/x7Fh/AUuVYd/Q7xB4dNl/wqMxJ3II+Go=;
        b=CZhMbY4m3JYGzaGF1q8sERQvBW37tilH8AIaWxKuOiFh04SjNc+DQOvQSZtnnJNWi2
         Yin28a+QcmAs9Qxzu5gACcIw0Iezn5WNxcdR8dZ648TT6Vzxgq+8CJvE5QjHI45dSdRz
         U3nW3KaUR07MECdK+lsk8rr85SHHVTorLP4IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mf1FoiYU4G/x7Fh/AUuVYd/Q7xB4dNl/wqMxJ3II+Go=;
        b=Hmk8/G0GtOtk0qmUJyjxHljddZjCTm1LPMckl5kTPsCBy/U3pqGI3VykYEyKp51Ho4
         h2GuK+3kB0i0Px2LFIQimHUmzEZ4TXuDhUXhT4v5AgAPWwE+57FEN81Ca1k+zRcU7LTO
         C2A0vHe4duV8uJDx45n4YuoBzD8vmTE3zknyioFn7k7SGtHWUANvLOSoQm/yTu3jjjYe
         n+iTqrfVs1iIYr563lkTt2VkyewkwlsE7da+a9CF91TC1KLd6KDVfwSCbZFrkrkNaZcE
         ZA7vAPIXBEHDloaPDPjqxD6W6JXIdxlKmfOMkUny7tGmfyjTdqSgqkLYFfbauTXz4r5p
         wP9A==
X-Gm-Message-State: AOAM5336Je7yUTWTV/v1SHGAxaJOs0AF8wEPL2SinUGDc4e35GDIeMVX
        1F+n4+OB/6wkivqjdT9FCkU7dSOcXUWq8Q==
X-Google-Smtp-Source: ABdhPJwWRRxRsnoEMqSBdygXlrJCB3XdvatOExR15/TcEPh6eL5nN+guVZl75RVeeFjI1k21aPQgLQ==
X-Received: by 2002:a05:6102:3d7:: with SMTP id n23mr2675870vsq.29.1601680184048;
        Fri, 02 Oct 2020 16:09:44 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id t17sm470327vkt.53.2020.10.02.16.09.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:09:43 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id e2so1368707vsr.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:09:42 -0700 (PDT)
X-Received: by 2002:a67:f4c2:: with SMTP id s2mr2751530vsn.4.1601680182332;
 Fri, 02 Oct 2020 16:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus> <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu> <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com> <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
In-Reply-To: <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Oct 2020 16:09:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
Message-ID: <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
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

On Fri, Oct 2, 2020 at 3:28 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 2, 2020 at 12:08 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Sep 30, 2020 at 1:20 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > > > > Datasheets from different manufacturers refer to these ICs as "USB hub
> > > > > > controller". Calling the node "usb-hub-controller" would indeed help to
> > > > > > distinguish it from the USB hub devices and represent existing hardware.
> > > > > > And the USB device could have a "hub-controller" property, which also
> > > > > > would be clearer than the current "hub" property.
> > > > >
> > > > > There aren't 2 (or 3) devices here. There's a single USB device (a
> > > > > hub) and the DT representation should reflect that.
> > > >
> > > > That's not completely true, though, is it?
> > >
> > > I was referring to the hub. I only see 1 datasheet, 1 IC and 1 block
> > > diagram... Lots of devices have more than one interface though usually
> > > not different speeds of the same thing.
> >
> > Right, there is certainly more than one way to look at it and the way
> > to look at it is based on how it's most convenient, I guess.  I mean,
> > an SoC often has 1 (very long) datasheet, 1 IC, and 1 block diagram
> > too...
> >
> > As a more similar example of single device that is listed in more than
> > one location in the device tree, we can also look at embedded SDIO
> > BT/WiFi combo cards.  This single device often provides WiFi under an
> > SDIO bus and BT under a serial / USB bus.  I'm not 100% sure there are
> > actually cases were the same board provides device tree data to both
> > at the same time, but "brcm,bcm43540-bt" is an example of providing
> > data to the Bluetooth (connected over serial port) and
> > "brcm,bcm4329-fmac" to the WiFi (connected over the SDIO bus).  Of
> > course WiFi/BT cheat in that the control logic is represented by the
> > SDIO power sequencing stuff...
>
> I figured you would mention this and it was brought up in the prior
> version. We've gotten lucky on these that the BT and WiFi are almost
> completely independent and any shared resources are easily shared
> (refcounted). I don't know if this case is the same. It seems less so
> to me. In any case, 2 independent devices is not what's been done here
> so far. The question is does representing USB2 and USB3 buses
> independently make sense, not whether just representing this hub as 2
> devices makes sense.

It feels like we have to accept that we are going to represent the USB
2 and USB 3 parts separately?  From Alan's response it sounds as if,
at least in theory, there can be different hierarchies leading up to
them.  That kind of thing seems like it'll be hard to deal with unless
we accept that the USB2 and USB3 nodes are separate, right?


> > Back to our case, though.  I guess the issue here is that we're the
> > child of more than one bus.  Let's first pretend that the i2c lines of
> > this hub are actually hooked up and establish how that would look
> > first.  Then we can think about how it looks if this same device isn't
> > hooked up via i2c.  In this case, it sounds as if you still don't want
> > the device split among two nodes.  So I guess you'd prefer something
> > like:
> >
> > i2c {
> >   usb-hub@xx {
> >     reg = <xx>;
> >     compatible = "realtek,rts5411", "onboard-usb-hub";
> >     vdd-supply = <&pp3300_hub>;
> >     usb-devices = <&usb_controller 1>;
>
> Why would you even need this prop? What it's attached to may not be
> the host controller nor even represented in DT. You've just defined a
> 2nd way to represent USB devices in DT (there's always 2 ways: a tree
> of nodes or a 'linked list' of phandles).

I'm certainly not wedded to the above representation, so let's drop it.


> >   };
> > };
> >
> > ...and then you wouldn't have anything under the USB controller
> > itself.  Is that correct?
>
> Right, as the examples you pointed out do. They just avoid the issue
> of representing USB bus in DT which probably was not defined at the
> time at least the first one was done. It works as long as you only
> have the hub that needs special setup. If you have child devices
> hanging off the hub too, then you need to represent the USB bus
> structure.
>
> >  So even though there are existing bindings
> > saying that a USB device should be listed via VID/PID, the desire to
> > represent this as a single node overrides that, right?  (NOTE: this is
> > similar to what Matthias proposed in his response except that I've
> > added an index so that we don't need _anything_ under the controller).
> >
> > Having this primarily listed under the i2c bus makes sense because the
> > control logic for the hub is hooked up via i2c.  Having the power
> > supply associated with it also makes some amount of sense since it's a
> > control signal.  It's also convenient that i2c devices have their
> > probe called _before_ we try to detect if they're there because it's
> > common that i2c devices need power applied first.
> >
> > Now, just because we don't have the i2c bus hooked up doesn't change
> > the fact that there is control logic.  We also certainly wouldn't want
> > two ways of describing this same hub: one way if the i2c is hooked up
> > and one way if it's not hooked up.  To me this means that the we
> > should be describing this hub as a top-level node if i2c isn't hooked
> > up, just like we do with "smsc,usb3503a"
> >
> > Said another way, we have these points:
> >
> > a) The control logic for this bus could be hooked up to an i2c bus.
> >
> > b) If the control logic is hooked up to an i2c bus it feels like
> > that's where the device's primary node should be placed, not under the
> > USB controller.
> >
> > c) To keep the i2c and non-i2c case as similar as possible, if the i2c
> > bus isn't hooked up the hub's primary node should be a top-level node,
> > not under the USB controller.
>
> If that was the goal,

Are you saying that's not a goal?  I'd still be happiest with allowing
it to be split amongst multiple nodes.


> then I'd say the device *always* belongs under
> the USB bus as that is the primary interface.

So in the case that it's under the USB bus, how do you envision the
i2c part probing?  I guess you'd add a "i2c-bus" property and provide
a phandle to the i2c bus?  ...and, presumably, the device address on
that i2c bus?  I know you pointed to examples of "ddc-i2c-bus" but I
don't think this is exactly the same because we need to specify a bus
plus a device address.  Did I miss an example where something like
this is already done, or are we inventing something new?


> As soon as someone wants to describe a device hanging off a
> "smsc,usb3503a" port, they're going to need to describe it all as a
> USB bus, not under I2C. I could be wrong, but I think all the cases so
> far do this. And it's not just devices, but possibly connectors (which
> is a whole other set of binding issues :)), too.

I mean, the thing that would make me happiest is to allow the
different parts of this device to be described in different places, as
Matthias's patch does.  In other words, I agree with you that the best
solution is to have nodes for hubs under the USB bus.  I'm still of
the opinion that the device is best described by _also_ having a
separate node for the control logic part of the IC either under the
i2c bus or at the top level.  In the i2c case, at least, this avoids
coming up with a different way to specify a device that is a child of
an i2c bus.


So, just to summarize, I guess options still being discussed:

a) Only represent the hub under the USB controller, not anywhere else.
If the hub is also on an i2c bus, invent a new way to specify which
bus it's under and what address it's using.  Add some sort of
pre-probe stage and have the hub driver register for it so it can turn
on the power, which might be needed in order for the USB devices to be
detected and probed normally.

b) Give up trying to model this and just whack in a regulator and some
logic in the xhci-platform driver to do this.

c) Decide that it's OK to represent the control logic as a separate
node, either under an i2c bus or at the top level.  Use phandles to
link.  Basically, I think this is nearly Matthias's current patch.


Did I miss anything that's currently under proposal?


-Doug
