Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5B27F27A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgI3TTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:19:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38401 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728270AbgI3TTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:19:19 -0400
Received: (qmail 223323 invoked by uid 1000); 30 Sep 2020 15:19:17 -0400
Date:   Wed, 30 Sep 2020 15:19:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20200930191917.GA221711@rowland.harvard.edu>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus>
 <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 08:28:17AM -0700, Doug Anderson wrote:
> > The 2nd issue is where do extra properties for a device go. That's
> > nothing new nor special to USB. They go with the device node. We
> > already went thru that with the last attempt.
> >
> > So for this case, we'd have something like this:
> >
> >     usb_controller {
> >         dr_mode = "host";
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >
> >         hub@1 {
> >             compatible = "usbbda,5411";
> >             reg = <1>;
> >             vdd-supply = <&pp3300_hub>;
> >         };
> >     };
> >
> > This is no different than needing a reset line deasserted as the prior
> > attempt did.
> 
> I'd believe that the above could be made to work with enough software
> change in the USB stack.  Presumably we wouldn't want to actually do a
> full probe of the device until USB actually enumerated it, but I guess
> you could add some type of optional "pre-probe" step where a driver is
> called?  So you'd call a pre-probe on whatever driver implements
> "usbbda,5411" and it would turn on the power supply.  ...then, if the
> device is actually there, the normal probe would be called?  I guess
> that'd work...

Would a better approach be to move the code into the xhci-platform
driver, rather than adding a new artificial platform device as
Matthias's patch does?  That's the way other platform-specific DT
issues have generally been handled in the USB stack.

> One thing that strikes me as a possible problem, though, is that I
> totally envision HW guys coming back and saying: "oh, we want to
> second source that USB hub and randomly stuff a different hub on some
> boards".  In theory that's a reasonable suggestion, right?  USB is a
> probable bus.  We turn on power to the USB hub (and the regulator to
> turn on power is the same no matter which hub is stuffed) and then we
> can just check which device got enumerated.  It's likely that both
> hubs would behave the same from a software point of view, but they
> would have different VID/PID.
> 
> As far as I understand the current USB bindings account for the fact
> that the device(s) specified in the device tree might or might not be
> there.  Adding a node under the controller like you show above means:
> "if something is plugged into port 1 of this USB hub and if that thing
> matches 0x0bda/0x5411 then here are the extra properties (vdd-supply)
> for it".  With your proposal I believe we're changing it to mean
> "there will definitely be a device plugged into port 1 of this USB hub
> and it will match 0x0bda/0x5411."  Unless I'm mistaken, that will have
> potential impacts on the ability to second source things.  I guess
> both pre-probe functions could be called and (since there can be
> multiple users of a regulator) it'd be OK, but if we get into reset
> lines it's not much fun.  However, describing the device more like
> Matthias has done it will be nicely compatible with second sourcing.

Can the matching be done purely by port number under the controller's root
hub without regard to the VID/PID?

Alan Stern
