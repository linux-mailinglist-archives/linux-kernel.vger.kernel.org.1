Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8127D281B20
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBSst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:48:49 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48935 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388495AbgJBSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:48:48 -0400
Received: (qmail 297073 invoked by uid 1000); 2 Oct 2020 14:48:47 -0400
Date:   Fri, 2 Oct 2020 14:48:47 -0400
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
Message-ID: <20201002184847.GB296334@rowland.harvard.edu>
References: <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <20201001012413.GA232049@rowland.harvard.edu>
 <20201001215412.GB2362632@google.com>
 <20201002012153.GA270859@rowland.harvard.edu>
 <20201002160847.GA2704892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002160847.GA2704892@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:08:47AM -0700, Matthias Kaehlcke wrote:
> On Thu, Oct 01, 2020 at 09:21:53PM -0400, Alan Stern wrote:
> > On Thu, Oct 01, 2020 at 02:54:12PM -0700, Matthias Kaehlcke wrote:
> > > Hi,
> > > 
> > > thanks for providing more insights on the USB hardware!
> > 
> > Sure.
> > 
> > > On Wed, Sep 30, 2020 at 09:24:13PM -0400, Alan Stern wrote:
> > > > A hub that attaches only to the USB-3 data wires in a cable is not USB
> > > > compliant.  A USB-2 device plugged into such a hub would not work.
> > > > 
> > > > But ports can be wired up in weird ways.  For example, it is possible
> > > > to have the USB-3 wires from a port going directly to the host
> > > > controller, while the USB-2 wires from the same port go through a
> > > > USB-2 hub which is then connected to a separate host controller.  (In
> > > > fact, my office computer has just such an arrangement.)
> > > 
> > > It's not clear to me how this case would be addressed when (some of) the
> > > handling is done in xhci-plat.c We have two host controllers now, which one
> > > is supposed to be in charge? I guess the idea is to specify the hub only
> > > for one of the controllers?
> > 
> > I don't grasp the point of this question.  It doesn't seem to be
> > relevant to the case you're concerned about -- your board isn't going to
> > wire up the special hub in this weird way, is it?
> 
> When doing upstream development I try to look beyond my specific use case
> and aim for solutions that are generally useful.
> 
> I don't know how common a configuration like the one on your office computer
> is. If it isn't a fringe case it seems like we should support it if feasible.

It isn't very common.  I think it was probably adopted as a stopgap kind 
of approach at a time when USB-3 was still relatively new and the 
chipsets didn't yet have full support for it.  On the other hand, it 
certainly isn't unheard of and it is compliant with the spec.

Of course, on any system that does this, the designers will be aware of 
it and could add the appropriate description (whatever it turns out to 
be) to DT.

> > _All_ of the handling could be done by xhci-plat.  Since the xHCI
> > controller is the parent of both the USB-2 and USB-3 incarnations of
> > the special hub, it won't get suspended until they are both in
> > suspend, and it will get resumed before either of them.  Similarly,
> > the power to the special hub could be switched on as part of the host
> > controller's probe routine and switched off during the host
> > controller's remove routine.
> > 
> > Using xhci-plat in this way would be better than a dedicated driver in
> > the sense that it wouldn't then be necessary to make up a fictitious
> > platform device and somehow describe it in DT.
> > 
> > The disadvantage is that we would end up with a driver that's
> > nominally meant to handle host controllers but now also manages (at
> > least in part) hubs.  A not-so-clean separation of functions.  But
> > that's not terribly different from the way your current patch works,
> > right?
> 
> Yes, this muddling of the xhci-plat code with the handling of hubs was
> one of my concerns, but who am I to argue if you as USB maintainer see
> that preferable over a dedicated driver. I suppose you are taking into
> account that there will be a need for code for different hub models that
> has to live somewhere (could be a dedicated file or directory).

This isn't really a difference in the hubs but rather in their support 
circuitry.  Still, if you look through the various *-platform.c files in 
drivers/usb/host (and also in pci-quirks.c), you'll see plenty of 
examples of platform-specific code for particular devices.

Ideally the new code would go into the hub driver.  But that won't work, 
since the hub driver doesn't get involved until the hub has been 
discovered on the USB bus, and that won't happen until its power has 
been enabled.

> And even if it is not my specific use case it would be nice to support
> hubs that are part of a hierarchy and not wired directly to the host
> controller. We don't necessarily have to implement all support for this
> initially, but should have it in mind at least for the bindings.
> 
> Also we would probably lose the ability to use a sysfs attribute to
> configure whether the hub should be always powered during suspend or
> not. This could be worked around with a DT property, however DT
> maintainers tend to be reluctant about configuration entries that
> don't translate directly to the hardware.

In theory the sysfs attribute could go under the host controller, but I 
agree it would be awkward.

This is just one example of a more general problem, as I mentioned in a 
recent email to Doug Anderson.

Alan Stern
