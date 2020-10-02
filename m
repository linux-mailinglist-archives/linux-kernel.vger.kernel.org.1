Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295B8280BE7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 03:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbgJBBVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 21:21:55 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40051 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727780AbgJBBVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 21:21:55 -0400
Received: (qmail 271540 invoked by uid 1000); 1 Oct 2020 21:21:53 -0400
Date:   Thu, 1 Oct 2020 21:21:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
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
Message-ID: <20201002012153.GA270859@rowland.harvard.edu>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus>
 <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <20201001012413.GA232049@rowland.harvard.edu>
 <20201001215412.GB2362632@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001215412.GB2362632@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 02:54:12PM -0700, Matthias Kaehlcke wrote:
> Hi,
> 
> thanks for providing more insights on the USB hardware!

Sure.

> On Wed, Sep 30, 2020 at 09:24:13PM -0400, Alan Stern wrote:
> > A hub that attaches only to the USB-3 data wires in a cable is not USB
> > compliant.  A USB-2 device plugged into such a hub would not work.
> > 
> > But ports can be wired up in weird ways.  For example, it is possible
> > to have the USB-3 wires from a port going directly to the host
> > controller, while the USB-2 wires from the same port go through a
> > USB-2 hub which is then connected to a separate host controller.  (In
> > fact, my office computer has just such an arrangement.)
> 
> It's not clear to me how this case would be addressed when (some of) the
> handling is done in xhci-plat.c We have two host controllers now, which one
> is supposed to be in charge? I guess the idea is to specify the hub only
> for one of the controllers?

I don't grasp the point of this question.  It doesn't seem to be
relevant to the case you're concerned about -- your board isn't going to
wire up the special hub in this weird way, is it?

> > > Yes, I've been saying for some time we need a pre-probe. Or we need a
> > > forced probe where the subsystem walks the DT nodes for the bus and
> > > probes the devices in DT (if they're in DT, we know they are present).
> > > This was the discussion only a few weeks ago for MDIO (which I think
> > > concluded with they already do the latter).
> > 
> > This is why I suggested putting the new code into the xhci-platform
> > driver.  That is the right place for doing these "pre-probes" of DT
> > nodes for hubs attached to the host controller.
> 
> Reminder that the driver is not exclusively about powering the hub, but
> also about powering it off conditionally during system suspend, depending
> on what devices are connected to either of the busses. Should this also
> be done in the xhci-platform driver?

It certainly could be.  The platform-specific xhci suspend and resume
routines could power the hub on and off as needed, along with powering
the host controller.

> Since we are talking about "pre-probes" I imagine the idea is to have a
> USB device driver that implements the power on/off sequence (in pre_probe()
> and handles the suspend/resume case. I already went through a variant of
> this with an earlier version of the onboard_hub_driver, where suspend/resume
> case was handled by the USB hub device. One of the problems with this was
> that power must only be turned off after both USB hub devices have been
> suspended. Some instance needs to be aware that there are two USB devices
> and make the decision whether to cut the power during system suspend
> or not, which is one of the reasons I ended up with the platform
> driver. It's not clear to me how this would be addressed by using
> "pre-probes". Potentially some of the handling could be done by
> xhci-platform, but would that be really better than a dedicated driver?

_All_ of the handling could be done by xhci-plat.  Since the xHCI
controller is the parent of both the USB-2 and USB-3 incarnations of
the special hub, it won't get suspended until they are both in
suspend, and it will get resumed before either of them.  Similarly,
the power to the special hub could be switched on as part of the host
controller's probe routine and switched off during the host
controller's remove routine.

Using xhci-plat in this way would be better than a dedicated driver in
the sense that it wouldn't then be necessary to make up a fictitious
platform device and somehow describe it in DT.

The disadvantage is that we would end up with a driver that's
nominally meant to handle host controllers but now also manages (at
least in part) hubs.  A not-so-clean separation of functions.  But
that's not terribly different from the way your current patch works,
right?

Alan Stern
