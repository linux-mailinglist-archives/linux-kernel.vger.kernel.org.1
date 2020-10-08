Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE82875B4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgJHOJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:09:30 -0400
Received: from netrider.rowland.org ([192.131.102.5]:42135 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730494AbgJHOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:09:28 -0400
Received: (qmail 496113 invoked by uid 1000); 8 Oct 2020 10:09:27 -0400
Date:   Thu, 8 Oct 2020 10:09:27 -0400
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
Message-ID: <20201008140927.GB495091@rowland.harvard.edu>
References: <20201006171524.GB423499@rowland.harvard.edu>
 <20201006192536.GB191572@google.com>
 <20201007010023.GA438733@rowland.harvard.edu>
 <20201007160336.GA620323@google.com>
 <20201007163838.GA457977@rowland.harvard.edu>
 <20201007172847.GB620323@google.com>
 <20201007192542.GA468921@rowland.harvard.edu>
 <20201007194229.GC620323@google.com>
 <20201007201732.GE468921@rowland.harvard.edu>
 <20201007214226.GA669360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007214226.GA669360@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:42:26PM -0700, Matthias Kaehlcke wrote:
> On Wed, Oct 07, 2020 at 04:17:32PM -0400, Alan Stern wrote:
> > The peering relation goes both ways, so it should be included in the 
> > hub_2_0 description too.  Given that, the driver could check hub_2_0's 
> > peer's DT description for the appropriate resources.
> 
> That mitigates the issue somewhat, however we still have to convince Rob that
> both references are needed.

Strictly speaking, the peering relation applies to ports, not
devices.  The representation in DT doesn't have to be symmetrical; as
long as the kernel understands it, the kernel can set up its own
internal symmetrical respresentation.

> > > All this mess can be avoided by having a single instance in control of the
> > > resources which is guaranteed to suspend after the USB devices.
> > 
> > Yes.  At the cost of registering, adding a driver for, and making users 
> > aware of a fictitious platform device.
> 
> Registration is trivial and the driver code will be needed anyway, I'm
> pretty convinced that a separate platform driver will be simpler than
> plumbing things into the hub driver, with the additional checks of who is
> suspended or not, etc. If other resources like resets are involved there
> could be further possible race conditions at probe time. Another issue is
> the sysfs attribute. We said to attach it to the primary hub. What happens
> when the primary hub goes away? I guess we could force unbinding the peers
> as we did in the driver under discussion to avoid confusion/inconsistencies,
> but it's another tradeoff.
> 
> My view of the pros and cons of extending the hub driver vs. having a platform
> driver:
> 
> - pros
>   - sysfs attribute is attached to a USB hub device
>   - no need to register a platform device (trivial)
>   - potentially more USB awareness (not clear if needed)
> 
> - cons
>   - possible races involving resources between peer hubs during initialization
>   - increased complexity from keeping track of peers, checking suspend order
>     and avoiding races
>   - peers are forced to unbind when primary goes away
>   - need DT links to peers for all USB hubs, not only in the primary
>   - pollution of the generic hub code with device specific stuff instead
>     of keeping it in a self contained driver
>   - sysfs attribute is attached to only one of the hubs, which is better than
>     having it on both, but not necessarily better than attaching it to the
>     platform device with the 'control logic'
> 
> So yes, there are tradeoffs, IMO balance isn't as clear as your comment
> suggests.

Well, I guess I'm okay with either approach.

One more thing to keep in mind, though: With the platform device,
there should be symlinks from the hubs' sysfs directories to the
platform device (and possibly symlinks going the other way as well).

Alan Stern
