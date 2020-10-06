Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698A828508A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJFRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:15:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48761 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726267AbgJFRPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:15:25 -0400
Received: (qmail 424636 invoked by uid 1000); 6 Oct 2020 13:15:24 -0400
Date:   Tue, 6 Oct 2020 13:15:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
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
Message-ID: <20201006171524.GB423499@rowland.harvard.edu>
References: <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
 <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
 <20201006004510.GD4135817@google.com>
 <20201006141820.GA416765@rowland.harvard.edu>
 <20201006165957.GA191572@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006165957.GA191572@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:59:57AM -0700, Matthias Kaehlcke wrote:
> On Tue, Oct 06, 2020 at 10:18:20AM -0400, Alan Stern wrote:
> > On Mon, Oct 05, 2020 at 05:45:10PM -0700, Matthias Kaehlcke wrote:
> > > I did some prototyping, it seems a binding like this would work for
> > > case a) or b):
> > > 
> > > &usb_1_dwc3 {
> > >         hub_2_0: hub@1 {
> > >                 compatible = "usbbda,5411";
> > >                 reg = <1>;
> > > 	};
> > > 
> > >         hub_3_0: hub@2 {
> > >                 compatible = "usbbda,411";
> > >                 reg = <2>;
> > >                 vdd-supply = <&pp3300_hub>;
> > > 		companion-hubs = <&hub_2_0>;
> > >         };
> > > };
> > > 
> > > It still requires specifying both hubs (which reflects the actual wiring).
> > > Supporting something like "reg = <1 2>" seems more complex due to the need to
> > > obtain the hub USB device at runtime (a DT node makes that trivial), possibly
> > > this could be solved by adding new APIs.
> > > 
> > > In terms of implementation would I envision to keep a platform driver. This
> > > would keep the hubby parts out of xhci-plat (except for populating the platform
> > > devices), support systems with cascaded hubs and provide a device for the sysfs
> > > attribute.
> > 
> > What will you do if a system has more than one of these power-regulated 
> > hubs?  That is, how will the user know which platform device handles the 
> > power control for a particular hub (and vice versa)?  You'd probably 
> > have to create a pair of symlinks going back and forth in the sysfs 
> > directories.
> 
> The platform device would use the same DT node as the USB device, hence the
> sysfs path of the platform device could be derived from the DT.

That doesn't do the user (or a program the user is running) any good.  
You can't expect them to go searching through the system's DT 
description looking for this information.  All they know is the hub's 
location in sysfs.

> > Wouldn't it be easier to put the power-control attribute directly in the 
> > hub's sysfs directory (or .../power subdirectory)?
> 
> Not sure. In terms of implementation it would be more complex (but not rocket
> science either), from a userspace perspective there are pros and cons.
> 
> A platform driver (or some other control instance) is needed anyway, to check
> the connected devices on both hubs and cut power only after the USB devices
> are suspended. With the sysfs attribute associated with the platform device
> it wouldn't even be necessary to have a separate USB driver. The platform
> driver would have to evaluate the sysfs attribute of the USB device(s), which
> can be done but is a bit odd.

You don't need a platform device or a new driver to do this.  The code 
can go in the existing hub driver.

> For a user it might be slightly simpler if they don't have to care about the
> existence of a platform device (but it's just a matter of knowing). The
> attribute must only be associated with one of the USB devices, which might
> be confusing, however it would be messy if each hub had an attribute. The
> attribute could be only associated with the 'primary hub', i.e. the one that
> specifies 'vdd-supply' or other attributes needed by the driver.

Okay.  Or you could always put it in the USB-2 hub.

Incidentally, the peering information is already present in sysfs, 
although it is associated with a device's port on its upstream hub 
rather than with the device itself.

Alan Stern
