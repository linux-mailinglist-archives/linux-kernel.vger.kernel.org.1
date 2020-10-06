Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88747284374
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgJFApP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgJFApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:45:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B840C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 17:45:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bb1so363432plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 17:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wH+oGjHyWJvEH/uHeK7lHu7j8UmD/Ph9zNXOPzqXtY=;
        b=bLUJ1YeTZg2WCWXfhNYVwY9TJM6/AvhKvPLZ2Nn+TiqqLJLuGrO+ZV8NuKNvGtcA5p
         0ZfhNww1D2y6IzC5XIDN34tP4bB95LOOHuac5C5ABD6XcnSJVq0humjybyn4oQ9frNx4
         166iHyCEPi8C2JhhLiY6/SYHFoecoDgRGr15o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wH+oGjHyWJvEH/uHeK7lHu7j8UmD/Ph9zNXOPzqXtY=;
        b=U0kYk6Oj7m8VQ8eL0NA6vqwCe4TBzZcfl6LLcoWyDjhtVA92HdNDat+hy4YhFzv6vZ
         i5QC6o7+DaO4k1H/RwPnJoRQ5pGOuou8jAljRmzYcoDTzVVxI4mET5tZ7KCwVj5XfCfw
         G6h3crx7wMzbjkUIz+hMln5VuO1vAkUVglcUkbUQn4cNf5lHrXoNfQ0Kdxs6TsJo1Di7
         GElOP8ub6uVpirtCXdwVy0FstBkE1Jhi+35MS1zSmUx9VHYWTXMzpsVGmhefvUabQIb3
         0EiqLcld+MPYGw+jJZlHuEb4zjxptsa/s+g+XK9Mm7OBY26z/vpCPqNLEVIHH3tLmSLL
         W9bg==
X-Gm-Message-State: AOAM532STNfNRVBxaoEf5KTgwggjgwwH7hH6tD6+Vs0WbynBNp8S933f
        zRJWs0mCCcvWvrlF8iyb4KXplw==
X-Google-Smtp-Source: ABdhPJw6KeqBLP2WM6eD31OsGDNcTWkLFuFHgumIgjquR7/kQ1/1Wz93OZiHNqH5RwTpoPgtglaqVA==
X-Received: by 2002:a17:902:c697:b029:d3:df24:163e with SMTP id r23-20020a170902c697b02900d3df24163emr980258plx.18.1601945112563;
        Mon, 05 Oct 2020 17:45:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id s67sm1203696pfb.35.2020.10.05.17.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 17:45:11 -0700 (PDT)
Date:   Mon, 5 Oct 2020 17:45:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20201006004510.GD4135817@google.com>
References: <20200929201701.GA1080459@bogus>
 <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
 <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 04:09:30PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 2, 2020 at 3:28 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Oct 2, 2020 at 12:08 PM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Sep 30, 2020 at 1:20 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > > > > Datasheets from different manufacturers refer to these ICs as "USB hub
> > > > > > > controller". Calling the node "usb-hub-controller" would indeed help to
> > > > > > > distinguish it from the USB hub devices and represent existing hardware.
> > > > > > > And the USB device could have a "hub-controller" property, which also
> > > > > > > would be clearer than the current "hub" property.
> > > > > >
> > > > > > There aren't 2 (or 3) devices here. There's a single USB device (a
> > > > > > hub) and the DT representation should reflect that.
> > > > >
> > > > > That's not completely true, though, is it?
> > > >
> > > > I was referring to the hub. I only see 1 datasheet, 1 IC and 1 block
> > > > diagram... Lots of devices have more than one interface though usually
> > > > not different speeds of the same thing.
> > >
> > > Right, there is certainly more than one way to look at it and the way
> > > to look at it is based on how it's most convenient, I guess.  I mean,
> > > an SoC often has 1 (very long) datasheet, 1 IC, and 1 block diagram
> > > too...
> > >
> > > As a more similar example of single device that is listed in more than
> > > one location in the device tree, we can also look at embedded SDIO
> > > BT/WiFi combo cards.  This single device often provides WiFi under an
> > > SDIO bus and BT under a serial / USB bus.  I'm not 100% sure there are
> > > actually cases were the same board provides device tree data to both
> > > at the same time, but "brcm,bcm43540-bt" is an example of providing
> > > data to the Bluetooth (connected over serial port) and
> > > "brcm,bcm4329-fmac" to the WiFi (connected over the SDIO bus).  Of
> > > course WiFi/BT cheat in that the control logic is represented by the
> > > SDIO power sequencing stuff...
> >
> > I figured you would mention this and it was brought up in the prior
> > version. We've gotten lucky on these that the BT and WiFi are almost
> > completely independent and any shared resources are easily shared
> > (refcounted). I don't know if this case is the same. It seems less so
> > to me. In any case, 2 independent devices is not what's been done here
> > so far. The question is does representing USB2 and USB3 buses
> > independently make sense, not whether just representing this hub as 2
> > devices makes sense.
> 
> It feels like we have to accept that we are going to represent the USB
> 2 and USB 3 parts separately?  From Alan's response it sounds as if,
> at least in theory, there can be different hierarchies leading up to
> them.  That kind of thing seems like it'll be hard to deal with unless
> we accept that the USB2 and USB3 nodes are separate, right?
> 
> 
> > > Back to our case, though.  I guess the issue here is that we're the
> > > child of more than one bus.  Let's first pretend that the i2c lines of
> > > this hub are actually hooked up and establish how that would look
> > > first.  Then we can think about how it looks if this same device isn't
> > > hooked up via i2c.  In this case, it sounds as if you still don't want
> > > the device split among two nodes.  So I guess you'd prefer something
> > > like:
> > >
> > > i2c {
> > >   usb-hub@xx {
> > >     reg = <xx>;
> > >     compatible = "realtek,rts5411", "onboard-usb-hub";
> > >     vdd-supply = <&pp3300_hub>;
> > >     usb-devices = <&usb_controller 1>;
> >
> > Why would you even need this prop? What it's attached to may not be
> > the host controller nor even represented in DT. You've just defined a
> > 2nd way to represent USB devices in DT (there's always 2 ways: a tree
> > of nodes or a 'linked list' of phandles).
> 
> I'm certainly not wedded to the above representation, so let's drop it.
> 
> 
> > >   };
> > > };
> > >
> > > ...and then you wouldn't have anything under the USB controller
> > > itself.  Is that correct?
> >
> > Right, as the examples you pointed out do. They just avoid the issue
> > of representing USB bus in DT which probably was not defined at the
> > time at least the first one was done. It works as long as you only
> > have the hub that needs special setup. If you have child devices
> > hanging off the hub too, then you need to represent the USB bus
> > structure.
> >
> > >  So even though there are existing bindings
> > > saying that a USB device should be listed via VID/PID, the desire to
> > > represent this as a single node overrides that, right?  (NOTE: this is
> > > similar to what Matthias proposed in his response except that I've
> > > added an index so that we don't need _anything_ under the controller).
> > >
> > > Having this primarily listed under the i2c bus makes sense because the
> > > control logic for the hub is hooked up via i2c.  Having the power
> > > supply associated with it also makes some amount of sense since it's a
> > > control signal.  It's also convenient that i2c devices have their
> > > probe called _before_ we try to detect if they're there because it's
> > > common that i2c devices need power applied first.
> > >
> > > Now, just because we don't have the i2c bus hooked up doesn't change
> > > the fact that there is control logic.  We also certainly wouldn't want
> > > two ways of describing this same hub: one way if the i2c is hooked up
> > > and one way if it's not hooked up.  To me this means that the we
> > > should be describing this hub as a top-level node if i2c isn't hooked
> > > up, just like we do with "smsc,usb3503a"
> > >
> > > Said another way, we have these points:
> > >
> > > a) The control logic for this bus could be hooked up to an i2c bus.
> > >
> > > b) If the control logic is hooked up to an i2c bus it feels like
> > > that's where the device's primary node should be placed, not under the
> > > USB controller.
> > >
> > > c) To keep the i2c and non-i2c case as similar as possible, if the i2c
> > > bus isn't hooked up the hub's primary node should be a top-level node,
> > > not under the USB controller.
> >
> > If that was the goal,
> 
> Are you saying that's not a goal?  I'd still be happiest with allowing
> it to be split amongst multiple nodes.
> 
> 
> > then I'd say the device *always* belongs under
> > the USB bus as that is the primary interface.
> 
> So in the case that it's under the USB bus, how do you envision the
> i2c part probing?  I guess you'd add a "i2c-bus" property and provide
> a phandle to the i2c bus?  ...and, presumably, the device address on
> that i2c bus?  I know you pointed to examples of "ddc-i2c-bus" but I
> don't think this is exactly the same because we need to specify a bus
> plus a device address.  Did I miss an example where something like
> this is already done, or are we inventing something new?
> 
> 
> > As soon as someone wants to describe a device hanging off a
> > "smsc,usb3503a" port, they're going to need to describe it all as a
> > USB bus, not under I2C. I could be wrong, but I think all the cases so
> > far do this. And it's not just devices, but possibly connectors (which
> > is a whole other set of binding issues :)), too.
> 
> I mean, the thing that would make me happiest is to allow the
> different parts of this device to be described in different places, as
> Matthias's patch does.  In other words, I agree with you that the best
> solution is to have nodes for hubs under the USB bus.  I'm still of
> the opinion that the device is best described by _also_ having a
> separate node for the control logic part of the IC either under the
> i2c bus or at the top level.  In the i2c case, at least, this avoids
> coming up with a different way to specify a device that is a child of
> an i2c bus.
> 
> 
> So, just to summarize, I guess options still being discussed:
> 
> a) Only represent the hub under the USB controller, not anywhere else.
> If the hub is also on an i2c bus, invent a new way to specify which
> bus it's under and what address it's using.  Add some sort of
> pre-probe stage and have the hub driver register for it so it can turn
> on the power, which might be needed in order for the USB devices to be
> detected and probed normally.
> 
> b) Give up trying to model this and just whack in a regulator and some
> logic in the xhci-platform driver to do this.
> 
> c) Decide that it's OK to represent the control logic as a separate
> node, either under an i2c bus or at the top level.  Use phandles to
> link.  Basically, I think this is nearly Matthias's current patch.
> 
> 
> Did I miss anything that's currently under proposal?

I did some prototyping, it seems a binding like this would work for
case a) or b):

&usb_1_dwc3 {
        hub_2_0: hub@1 {
                compatible = "usbbda,5411";
                reg = <1>;
	};

        hub_3_0: hub@2 {
                compatible = "usbbda,411";
                reg = <2>;
                vdd-supply = <&pp3300_hub>;
		companion-hubs = <&hub_2_0>;
        };
};

It still requires specifying both hubs (which reflects the actual wiring).
Supporting something like "reg = <1 2>" seems more complex due to the need to
obtain the hub USB device at runtime (a DT node makes that trivial), possibly
this could be solved by adding new APIs.

In terms of implementation would I envision to keep a platform driver. This
would keep the hubby parts out of xhci-plat (except for populating the platform
devices), support systems with cascaded hubs and provide a device for the sysfs
attribute.

The same binding could be used for a hub with I2C bus, however it would need
an additional I2C client node, unless we invent something new (case a). On
such a hub the "power down in suspend" feature would only work if the "USB
regulator" is not needed to preserve context of the I2C portion of the chip
during system suspend.
