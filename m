Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602A82868E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgJGURe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:17:34 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33639 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728307AbgJGURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:17:33 -0400
Received: (qmail 471404 invoked by uid 1000); 7 Oct 2020 16:17:32 -0400
Date:   Wed, 7 Oct 2020 16:17:32 -0400
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
Message-ID: <20201007201732.GE468921@rowland.harvard.edu>
References: <20201006141820.GA416765@rowland.harvard.edu>
 <20201006165957.GA191572@google.com>
 <20201006171524.GB423499@rowland.harvard.edu>
 <20201006192536.GB191572@google.com>
 <20201007010023.GA438733@rowland.harvard.edu>
 <20201007160336.GA620323@google.com>
 <20201007163838.GA457977@rowland.harvard.edu>
 <20201007172847.GB620323@google.com>
 <20201007192542.GA468921@rowland.harvard.edu>
 <20201007194229.GC620323@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007194229.GC620323@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:42:29PM -0700, Matthias Kaehlcke wrote:
> On Wed, Oct 07, 2020 at 03:25:42PM -0400, Alan Stern wrote:
> > On Wed, Oct 07, 2020 at 10:28:47AM -0700, Matthias Kaehlcke wrote:
> > > On Wed, Oct 07, 2020 at 12:38:38PM -0400, Alan Stern wrote:
> > > > On Wed, Oct 07, 2020 at 09:03:36AM -0700, Matthias Kaehlcke wrote:
> > > > > Ok, I wasn't sure if the hubs suspend asynchronously from each other. If they
> > > > > do it should indeed not be a problem to have the "master" wait for its peers.
> > > > 
> > > > Well, order of suspending is selectable by the user.  It can be either 
> > > > asynchronous or reverse order of device registration, which might pose a 
> > > > problem.  We don't know in advance which of two peer hubs will be 
> > > > registered first.  It might be necessary to introduce some additional 
> > > > explicit synchronization.
> > > 
> > > I'm not sure we are understanding each other completely. I agree that
> > > synchronization is needed to have the primary hub wait for its peers, that
> > > was one of my initial concerns.
> > > 
> > > Lets use an example to clarify my secondary concern: a hub chip provides a
> > > USB 3 and a USB 2 hub, lets say the USB 3 hub is the primary.
> > > 
> > > Here is some pseudo-code for the suspend function:
> > > 
> > > hub_suspend(hub)
> > >   ...
> > > 
> > >   if (hub->primary) {
> > >     device_pm_wait_for_dev(hub->peer)
> > > 
> > >     // check for connected devices and turn regulator off
> > >   }
> > > 
> > >   ...
> > > }
> > > 
> > > What I meant with 'asynchronous suspend' in this context:
> > > 
> > > Can hub_suspend() of the peer hub be executed (asynchronously) while the
> > > primary is blocked on device_pm_wait_for_dev(),
> > 
> > Yes, that's exactly what would happen with async suspend.
> > 
> > >  or would the primary wait
> > > forever if the peer hub isn't suspended yet?
> > 
> > That wouldn't happen.  device_pm_wait_for_dev is smart; it will return 
> > immediately if neither device uses async suspend.  But in that case you 
> > could end up removing power from the peer hub before it had suspended.
> > 
> > That's why I said you might need to add additional synchronization.  The 
> > suspend routines for the two hubs could each check to see whether the 
> > other device had suspended yet, and the last one would handle the power 
> > regulator.  The additional synchronization is for the case where the two 
> > checks end up being concurrent.
> 
> That was exactly my initial concern and one of the reasons I favor(ed) a
> platform instead of a USB driver:

Clearly there's a tradeoff.

> > otherwise all hubs need to know their peers and check in suspend if they
> > are the last hub standing, only then the power can be switched off.
> 
> To which you replied:
> 
> > you just need to make the "master" hub wait for its peer to suspend, which
> > is easy to do.
> 
> However that apparently only works if async suspend is enabled, and we
> can't rely on that.

Yes, I had forgotten about the possibility of synchronous suspend.  My 
mistake.

> With the peers checking on each other you lose effectively the notion
> of a primary.

Well, you can still want to put the sysfs power-control attribute file 
into just one of the hubs' directories, and that one would be considered 
the primary.  But I agree, it's a weak notion.

> Going back to the binding:
> 
>   &usb_1_dwc3 {
>     hub_2_0: hub@1 {
>       compatible = "usbbda,5411";
>       reg = <1>;
>     };
> 
>     hub_3_0: hub@2 {
>       compatible = "usbbda,411";
>       reg = <2>;
>       vdd-supply = <&pp3300_hub>;
>       companion-hubs = <&hub_2_0>;
>     };
>   };
> 
> How does 'hub_2_0' know that its peer is hub_3_0 and that it has a regulator
> (and potentially other resources)?

The peering relation goes both ways, so it should be included in the 
hub_2_0 description too.  Given that, the driver could check hub_2_0's 
peer's DT description for the appropriate resources.

> All this mess can be avoided by having a single instance in control of the
> resources which is guaranteed to suspend after the USB devices.

Yes.  At the cost of registering, adding a driver for, and making users 
aware of a fictitious platform device.

Alan Stern
