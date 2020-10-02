Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119BB2818D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbgJBRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbgJBRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:08:32 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A6C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:08:32 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id 91so50266uas.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbIvQOosZgo3R2BZJc8GACD4WYs5J2seBOEgLzJ9hBM=;
        b=CZpsJgYy8Zu1oH8utkKUY6fcC7xmaRZvupW4XBuX1ERHa99qsoAgCEsacauygHGyOw
         a0sRG5fZlNs27aC1wNw//vRECILHOTEvvJja90QWG6g5CHF6BT5msQEGWa+NZiA1tFNb
         AiiJsTtFWWGUwe6oIWGmSlzioRe6qjG8nLib0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbIvQOosZgo3R2BZJc8GACD4WYs5J2seBOEgLzJ9hBM=;
        b=o3VEuclIfxSykTV37JhuKKzI0THG4dscpJjVyUUgohW5f8KU4u9KbeI2l1ksdn485l
         Z8lKCwadHYruNk7CEMZisbH8MgjdGG+SRS5R5ldG4EuBe999+7trQ0h/gTwIB0/XYWed
         YrXDc8urNbeYiZagxIFYyujvvafktg/u1ZJzVXk0bc35WP/fZOU3lgRmIkNHJ9F6khZY
         8rYAKDNVwCzc5njnymHFbHdsb9JXuTkKxPQ1kCsJoddO3i5cizYDtvWk8yeWb/7ohTot
         O5AC/YwH7nyvOpQboZ4owvhlkTFa/iyPktiFTfuJExnKaZ1oyOgjRuuJCoNckyIQuQ4A
         LwiQ==
X-Gm-Message-State: AOAM533qR+7bPGdDB3tyt90mfaln17PZct4JpYbuLBdsX0T3rjUmJUb5
        tgPzPls3MQUHaWi6Yec7mzEXgmefvkoIcg==
X-Google-Smtp-Source: ABdhPJyW+RQ1PZccxm0i6tu0+kJqJnFPzoaDAZk6NwfHOomKWzFGktMm4kgpVH5fKkDaholihPCaqg==
X-Received: by 2002:ab0:208a:: with SMTP id r10mr1847020uak.56.1601658510808;
        Fri, 02 Oct 2020 10:08:30 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a64sm338579vkh.3.2020.10.02.10.08.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 10:08:29 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id 7so956199vsp.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:08:29 -0700 (PDT)
X-Received: by 2002:a67:f4c2:: with SMTP id s2mr1917881vsn.4.1601658509277;
 Fri, 02 Oct 2020 10:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus> <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu> <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com> <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Oct 2020 10:08:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
Message-ID: <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
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

On Wed, Sep 30, 2020 at 1:20 PM Rob Herring <robh@kernel.org> wrote:
>
> > > > Datasheets from different manufacturers refer to these ICs as "USB hub
> > > > controller". Calling the node "usb-hub-controller" would indeed help to
> > > > distinguish it from the USB hub devices and represent existing hardware.
> > > > And the USB device could have a "hub-controller" property, which also
> > > > would be clearer than the current "hub" property.
> > >
> > > There aren't 2 (or 3) devices here. There's a single USB device (a
> > > hub) and the DT representation should reflect that.
> >
> > That's not completely true, though, is it?
>
> I was referring to the hub. I only see 1 datasheet, 1 IC and 1 block
> diagram... Lots of devices have more than one interface though usually
> not different speeds of the same thing.

Right, there is certainly more than one way to look at it and the way
to look at it is based on how it's most convenient, I guess.  I mean,
an SoC often has 1 (very long) datasheet, 1 IC, and 1 block diagram
too...

As a more similar example of single device that is listed in more than
one location in the device tree, we can also look at embedded SDIO
BT/WiFi combo cards.  This single device often provides WiFi under an
SDIO bus and BT under a serial / USB bus.  I'm not 100% sure there are
actually cases were the same board provides device tree data to both
at the same time, but "brcm,bcm43540-bt" is an example of providing
data to the Bluetooth (connected over serial port) and
"brcm,bcm4329-fmac" to the WiFi (connected over the SDIO bus).  Of
course WiFi/BT cheat in that the control logic is represented by the
SDIO power sequencing stuff...


Back to our case, though.  I guess the issue here is that we're the
child of more than one bus.  Let's first pretend that the i2c lines of
this hub are actually hooked up and establish how that would look
first.  Then we can think about how it looks if this same device isn't
hooked up via i2c.  In this case, it sounds as if you still don't want
the device split among two nodes.  So I guess you'd prefer something
like:

i2c {
  usb-hub@xx {
    reg = <xx>;
    compatible = "realtek,rts5411", "onboard-usb-hub";
    vdd-supply = <&pp3300_hub>;
    usb-devices = <&usb_controller 1>;
  };
};

...and then you wouldn't have anything under the USB controller
itself.  Is that correct?  So even though there are existing bindings
saying that a USB device should be listed via VID/PID, the desire to
represent this as a single node overrides that, right?  (NOTE: this is
similar to what Matthias proposed in his response except that I've
added an index so that we don't need _anything_ under the controller).

Having this primarily listed under the i2c bus makes sense because the
control logic for the hub is hooked up via i2c.  Having the power
supply associated with it also makes some amount of sense since it's a
control signal.  It's also convenient that i2c devices have their
probe called _before_ we try to detect if they're there because it's
common that i2c devices need power applied first.

Now, just because we don't have the i2c bus hooked up doesn't change
the fact that there is control logic.  We also certainly wouldn't want
two ways of describing this same hub: one way if the i2c is hooked up
and one way if it's not hooked up.  To me this means that the we
should be describing this hub as a top-level node if i2c isn't hooked
up, just like we do with "smsc,usb3503a"

Said another way, we have these points:

a) The control logic for this bus could be hooked up to an i2c bus.

b) If the control logic is hooked up to an i2c bus it feels like
that's where the device's primary node should be placed, not under the
USB controller.

c) To keep the i2c and non-i2c case as similar as possible, if the i2c
bus isn't hooked up the hub's primary node should be a top-level node,
not under the USB controller.


NOTE ALSO: the fact that we might want to list this hub under an i2c
controller also seems like it's a good argument against putting this
logic in the xhci-platform driver?


I _think_ the above representation would be OK with Rob (right?) and I
think it'd be pretty easy to adapt Matthias's existing code to work
with it.  We'd have to make sure we were careful that things worked in
either probe ordering (in case the firmware happened to leave the
power rail on sometimes and the USB devices started probing before the
hub driver did), but it feels like it should be possible, right?


 -Doug
