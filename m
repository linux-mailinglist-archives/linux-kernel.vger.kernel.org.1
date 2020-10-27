Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3629CAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832037AbgJ0VGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:06:13 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:34126 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370950AbgJ0VGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:06:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C7E348030718;
        Tue, 27 Oct 2020 21:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9jTbhXBZIp3Y; Wed, 28 Oct 2020 00:06:06 +0300 (MSK)
Date:   Wed, 28 Oct 2020 00:06:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        David Cohen <david.a.cohen@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3] usb: dwc3: ulpi: Replace CPU-based busyloop with
 Protocol-based one
Message-ID: <20201027210604.4jfecr6zjtdfamsb@mobilestation>
References: <20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru>
 <20201010222351.7323-3-Sergey.Semin@baikalelectronics.ru>
 <87h7qgc9hg.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87h7qgc9hg.fsf@kernel.org>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:18:51AM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Serge Semin <Sergey.Semin@baikalelectronics.ru> writes:
> 
> > Originally the procedure of the ULPI transaction finish detection has been
> > developed as a simple busy-loop with just decrementing counter and no
> > delays. It's wrong since on different systems the loop will take a
> > different time to complete. So if the system bus and CPU are fast enough
> > to overtake the ULPI bus and the companion PHY reaction, then we'll get to
> > take a false timeout error. Fix this by converting the busy-loop procedure
> > to take the standard bus speed, address value and the registers access
> > mode into account for the busy-loop delay calculation.
> >
> > Here is the way the fix works. It's known that the ULPI bus is clocked
> > with 60MHz signal. In accordance with [1] the ULPI bus protocol is created
> > so to spend 5 and 6 clock periods for immediate register write and read
> > operations respectively, and 6 and 7 clock periods - for the extended
> > register writes and reads. Based on that we can easily pre-calculate the
> > time which will be needed for the controller to perform a requested IO
> > operation. Note we'll still preserve the attempts counter in case if the
> > DWC USB3 controller has got some internals delays.
> >
> > [1] UTMI+ Low Pin Interface (ULPI) Specification, Revision 1.1,
> >     October 20, 2004, pp. 30 - 36.
> >
> > Fixes: 88bc9d194ff6 ("usb: dwc3: add ULPI interface support")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/usb/dwc3/ulpi.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
> > index 20f5d9aba317..0dbc826355a5 100644
> > --- a/drivers/usb/dwc3/ulpi.c
> > +++ b/drivers/usb/dwc3/ulpi.c
> > @@ -7,6 +7,8 @@
> >   * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >   */
> >  
> > +#include <linux/delay.h>
> > +#include <linux/time64.h>
> >  #include <linux/ulpi/regs.h>
> >  
> >  #include "core.h"
> > @@ -17,12 +19,22 @@
> >  		DWC3_GUSB2PHYACC_ADDR(ULPI_ACCESS_EXTENDED) | \
> >  		DWC3_GUSB2PHYACC_EXTEND_ADDR(a) : DWC3_GUSB2PHYACC_ADDR(a))
> >  
> > -static int dwc3_ulpi_busyloop(struct dwc3 *dwc)
> > +#define DWC3_ULPI_BASE_DELAY	DIV_ROUND_UP(NSEC_PER_SEC, 60000000L)
> > +
> > +static int dwc3_ulpi_busyloop(struct dwc3 *dwc, u8 addr, bool read)
> >  {
> > +	unsigned long ns = 5L * DWC3_ULPI_BASE_DELAY;
> >  	unsigned count = 1000;
> >  	u32 reg;
> >  
> > +	if (addr >= ULPI_EXT_VENDOR_SPECIFIC)
> > +		ns += DWC3_ULPI_BASE_DELAY;
> > +
> > +	if (read)
> > +		ns += DWC3_ULPI_BASE_DELAY;
> > +
> >  	while (count--) {
> > +		ndelay(ns);
> 

> could we allow for a sleep here instead of a delay?

The kernel ULPI-bus API isn't clear about that. I also couldn't find an example
of using the ULPI-bus accessors in the atomic context or being implemented with
the sleeping methods. So there is no certain answer to your question. Anyway I
added an ms-sleep in the later patch to fix the suspend-regression problem. I
thought it was reasonable since I couldn't find an example of using the
accessors in the atomic context.

Regarding this patch. I wouldn't suggest to replace the ndelay with sleeping
here, since 5-7 ref clock ticks is enough to finish the transaction for the vast
majority of the cases. It's just 80 - 115 ns, which can't be reached by the
sleeping procedures.

> Also, I wonder if
> you need to make this so complex or should we just take the larger
> access time of 7 clock cycles.

I wouldn't say it's complex. Here I've implemented a simple calculation of the
time needed to finish the ULPI-bus commands in accordance with the number of
ticks they normally require. Regarding the while-looping alas we can't get rid
of it here for the reason I've described in the patch 3 of the series.

-Sergey

> 
> -- 
> balbi


