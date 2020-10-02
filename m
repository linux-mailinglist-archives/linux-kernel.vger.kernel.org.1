Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32995281EC0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJBW6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBW6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:58:35 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398C7206FA;
        Fri,  2 Oct 2020 22:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601679514;
        bh=kcgoZa2FML0rIwT6XbrrIjjoXmqKbfCgFpDorfrshps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPNLZjPQ+Gie0FqEHETgS8rjP8PH1KEwxxTUj3iu/Rl3xP9qmXeHfPHJndVuss/Mm
         C/HteBa7MlygE9u3slxynzGh/Po+/KqQ/G1y0pn3Lg6a8GZhFn7emUoj4QKRZwFn7/
         c0KyXxvIIT9j0dV1ILSvPlVZwO5qI88sKl78g4VA=
Received: by mail-ot1-f52.google.com with SMTP id s66so3011477otb.2;
        Fri, 02 Oct 2020 15:58:34 -0700 (PDT)
X-Gm-Message-State: AOAM5318jS0sPP8v/x6KWr2ks422ZoKVF9l0Q1iTU59VsBLeXkhlr1cY
        mmmhrhPwJYJqS2mLL8c6IerUK/2XKBabGPPrRQ==
X-Google-Smtp-Source: ABdhPJxEmXxNEtMkiFWap/kdASetpxroZKkBdAu1ipH8rGGfLySK+JHQ9y8EdrYrLKHmls+JVOFTu1wBuZPYvSBAeZk=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr3123918otp.107.1601679513550;
 Fri, 02 Oct 2020 15:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus> <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu> <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com> <20201002183633.GA296334@rowland.harvard.edu>
In-Reply-To: <20201002183633.GA296334@rowland.harvard.edu>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Oct 2020 17:58:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
Message-ID: <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
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

On Fri, Oct 2, 2020 at 1:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Oct 02, 2020 at 10:08:17AM -0700, Doug Anderson wrote:
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
> >
> >
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
> >   };
> > };
> >
> > ...and then you wouldn't have anything under the USB controller
> > itself.  Is that correct?  So even though there are existing bindings
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
> >
> >
> > NOTE ALSO: the fact that we might want to list this hub under an i2c
> > controller also seems like it's a good argument against putting this
> > logic in the xhci-platform driver?
>
> More and more we are going to see devices that are attached to multiple
> buses.  In this case, one for power control and another for
> commands/data.  If DT doesn't already have a canonical way of handling
> such situations, it needs to develop one soon.

Attached to multiple buses directly is kind of rare from what I've
seen. Most of the time, it's regulators, GPIOs, clocks, etc. which are
well defined in DT. If there is a 2nd bus, it's almost always I2C.

> One can make a case that there should be multiple device nodes in this
> situation, somehow referring to each other so that the system knows they
> all describe the same device.  Maybe one "primary" node for the device
> and the others acting kind of like symbolic links.
>
> Regardless of how the situation is represented in DT, there remains the
> issue of where (i.e., in which driver module) the appropriate code
> belongs.  This goes far beyond USB.  In general, what happens when one
> sort of device normally isn't hooked up through a power regulator, so
> its driver doesn't have any code to enable a regulator, but then some
> system does exactly that?
>
> Even worse, what if the device is on a discoverable bus, so the driver
> doesn't get invoked at all until the device is discovered, but on the
> new system it can't be discovered until the regulator is enabled?

Yep, it's the same issue here with USB, MDIO which just came up a few
weeks ago, MMC/SD which hacked around it with 'mmc-pwrseq' binding
(not something I want to duplicate) and every other discoverable bus.
What do they all have in common? The kernel's driver model being
unable to cope with this situation. We really need a common solution
here and not bus or device specific hack-arounds.

Rob
