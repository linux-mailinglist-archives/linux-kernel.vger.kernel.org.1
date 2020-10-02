Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B580281E55
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgJBW2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBW2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:28:37 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 182B420754;
        Fri,  2 Oct 2020 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601677716;
        bh=aVFJUmf5dlsHyJyNX0AvhUntUU22ECQPxOFxyn0UoE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1DSmmCtihSdFBNqMlsvgH0B9mu/kwm+cDisX1d3Rt2E7ZxoizSZlca+JGTLafVN9q
         JLaRHPEwx/5FzMkuUPK+TcdTYIiLmzbOSE+UmlXyIIGCCZ96WaqtFU23siV1cC/hL9
         z81lx0rzpH6PeuBDIk7+MA9yTC1A47v81MzOfPMc=
Received: by mail-oo1-f44.google.com with SMTP id r10so754196oor.5;
        Fri, 02 Oct 2020 15:28:36 -0700 (PDT)
X-Gm-Message-State: AOAM533zzCktrPm8mlTf/tBwbb8+xzihgcrdsu7CF3FLnk1nKRF7WKJ9
        3DDBOejMIGsD4oOuk2RWsckm1h6NADN3bwPWKg==
X-Google-Smtp-Source: ABdhPJzCxlGNKI8ydQjl2pWsGbv9sCNttsSuEVCs53DNgCx1aaGylu3rxKMhIAIydLtttaApiQsBxf23s1Bmgz4jk0o=
X-Received: by 2002:a4a:b30d:: with SMTP id m13mr3432909ooo.50.1601677715341;
 Fri, 02 Oct 2020 15:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus> <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu> <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com> <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
In-Reply-To: <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Oct 2020 17:28:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
Message-ID: <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Doug Anderson <dianders@chromium.org>
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

On Fri, Oct 2, 2020 at 12:08 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Sep 30, 2020 at 1:20 PM Rob Herring <robh@kernel.org> wrote:
> >
> > > > > Datasheets from different manufacturers refer to these ICs as "USB hub
> > > > > controller". Calling the node "usb-hub-controller" would indeed help to
> > > > > distinguish it from the USB hub devices and represent existing hardware.
> > > > > And the USB device could have a "hub-controller" property, which also
> > > > > would be clearer than the current "hub" property.
> > > >
> > > > There aren't 2 (or 3) devices here. There's a single USB device (a
> > > > hub) and the DT representation should reflect that.
> > >
> > > That's not completely true, though, is it?
> >
> > I was referring to the hub. I only see 1 datasheet, 1 IC and 1 block
> > diagram... Lots of devices have more than one interface though usually
> > not different speeds of the same thing.
>
> Right, there is certainly more than one way to look at it and the way
> to look at it is based on how it's most convenient, I guess.  I mean,
> an SoC often has 1 (very long) datasheet, 1 IC, and 1 block diagram
> too...
>
> As a more similar example of single device that is listed in more than
> one location in the device tree, we can also look at embedded SDIO
> BT/WiFi combo cards.  This single device often provides WiFi under an
> SDIO bus and BT under a serial / USB bus.  I'm not 100% sure there are
> actually cases were the same board provides device tree data to both
> at the same time, but "brcm,bcm43540-bt" is an example of providing
> data to the Bluetooth (connected over serial port) and
> "brcm,bcm4329-fmac" to the WiFi (connected over the SDIO bus).  Of
> course WiFi/BT cheat in that the control logic is represented by the
> SDIO power sequencing stuff...

I figured you would mention this and it was brought up in the prior
version. We've gotten lucky on these that the BT and WiFi are almost
completely independent and any shared resources are easily shared
(refcounted). I don't know if this case is the same. It seems less so
to me. In any case, 2 independent devices is not what's been done here
so far. The question is does representing USB2 and USB3 buses
independently make sense, not whether just representing this hub as 2
devices makes sense.

> Back to our case, though.  I guess the issue here is that we're the
> child of more than one bus.  Let's first pretend that the i2c lines of
> this hub are actually hooked up and establish how that would look
> first.  Then we can think about how it looks if this same device isn't
> hooked up via i2c.  In this case, it sounds as if you still don't want
> the device split among two nodes.  So I guess you'd prefer something
> like:
>
> i2c {
>   usb-hub@xx {
>     reg = <xx>;
>     compatible = "realtek,rts5411", "onboard-usb-hub";
>     vdd-supply = <&pp3300_hub>;
>     usb-devices = <&usb_controller 1>;

Why would you even need this prop? What it's attached to may not be
the host controller nor even represented in DT. You've just defined a
2nd way to represent USB devices in DT (there's always 2 ways: a tree
of nodes or a 'linked list' of phandles).

>   };
> };
>
> ...and then you wouldn't have anything under the USB controller
> itself.  Is that correct?

Right, as the examples you pointed out do. They just avoid the issue
of representing USB bus in DT which probably was not defined at the
time at least the first one was done. It works as long as you only
have the hub that needs special setup. If you have child devices
hanging off the hub too, then you need to represent the USB bus
structure.

>  So even though there are existing bindings
> saying that a USB device should be listed via VID/PID, the desire to
> represent this as a single node overrides that, right?  (NOTE: this is
> similar to what Matthias proposed in his response except that I've
> added an index so that we don't need _anything_ under the controller).
>
> Having this primarily listed under the i2c bus makes sense because the
> control logic for the hub is hooked up via i2c.  Having the power
> supply associated with it also makes some amount of sense since it's a
> control signal.  It's also convenient that i2c devices have their
> probe called _before_ we try to detect if they're there because it's
> common that i2c devices need power applied first.
>
> Now, just because we don't have the i2c bus hooked up doesn't change
> the fact that there is control logic.  We also certainly wouldn't want
> two ways of describing this same hub: one way if the i2c is hooked up
> and one way if it's not hooked up.  To me this means that the we
> should be describing this hub as a top-level node if i2c isn't hooked
> up, just like we do with "smsc,usb3503a"
>
> Said another way, we have these points:
>
> a) The control logic for this bus could be hooked up to an i2c bus.
>
> b) If the control logic is hooked up to an i2c bus it feels like
> that's where the device's primary node should be placed, not under the
> USB controller.
>
> c) To keep the i2c and non-i2c case as similar as possible, if the i2c
> bus isn't hooked up the hub's primary node should be a top-level node,
> not under the USB controller.

If that was the goal, then I'd say the device *always* belongs under
the USB bus as that is the primary interface.

As soon as someone wants to describe a device hanging off a
"smsc,usb3503a" port, they're going to need to describe it all as a
USB bus, not under I2C. I could be wrong, but I think all the cases so
far do this. And it's not just devices, but possibly connectors (which
is a whole other set of binding issues :)), too.

> NOTE ALSO: the fact that we might want to list this hub under an i2c
> controller also seems like it's a good argument against putting this
> logic in the xhci-platform driver?
>
>
> I _think_ the above representation would be OK with Rob (right?) and I
> think it'd be pretty easy to adapt Matthias's existing code to work
> with it.  We'd have to make sure we were careful that things worked in
> either probe ordering (in case the firmware happened to leave the
> power rail on sometimes and the USB devices started probing before the
> hub driver did), but it feels like it should be possible, right?

Being careful with probe ordering is a sign this belongs under USB bus
and integrated in some way to USB probing.

Rob
