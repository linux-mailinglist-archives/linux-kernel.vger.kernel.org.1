Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8213929C9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830992AbgJ0UNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:13:20 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:34028 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830982AbgJ0UNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:13:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4C56480307C2;
        Tue, 27 Oct 2020 20:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R07BQISyW5GJ; Tue, 27 Oct 2020 23:13:16 +0300 (MSK)
Date:   Tue, 27 Oct 2020 23:13:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Youn <John.Youn@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] usb: dwc3: ulpi: Use VStsDone to detect PHY regs
 access completion
Message-ID: <20201027201315.zp7tmb2eztz5gwjj@mobilestation>
References: <20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru>
 <20201010222351.7323-2-Sergey.Semin@baikalelectronics.ru>
 <87k0vcc9n7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87k0vcc9n7.fsf@kernel.org>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:15:24AM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Serge Semin <Sergey.Semin@baikalelectronics.ru> writes:
> 
> > In accordance with [1] the DWC_usb3 core sets the GUSB2PHYACCn.VStsDone
> > bit when the PHY vendor control access is done and clears it when the
> > application initiates a new transaction. The doc doesn't say anything
> > about the GUSB2PHYACCn.VStsBsy flag serving for the same purpose. Moreover
> > we've discovered that the VStsBsy flag can be cleared before the VStsDone
> > bit. So using the former as a signal of the PHY control registers
> > completion might be dangerous. Let's have the VStsDone flag utilized
> > instead then.
> >
> > [1] Synopsys DesignWare Cores SuperSpeed USB 3.0 xHCI Host Controller
> >     Databook, 2.70a, December 2013, p.388
> >
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/usb/dwc3/core.h | 1 +
> >  drivers/usb/dwc3/ulpi.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 2f04b3e42bf1..8d5e5bba1bc2 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -284,6 +284,7 @@
> >  
> >  /* Global USB2 PHY Vendor Control Register */
> >  #define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
> > +#define DWC3_GUSB2PHYACC_DONE		BIT(24)
> >  #define DWC3_GUSB2PHYACC_BUSY		BIT(23)
> >  #define DWC3_GUSB2PHYACC_WRITE		BIT(22)
> >  #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
> > diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
> > index e6e6176386a4..20f5d9aba317 100644
> > --- a/drivers/usb/dwc3/ulpi.c
> > +++ b/drivers/usb/dwc3/ulpi.c
> > @@ -24,7 +24,7 @@ static int dwc3_ulpi_busyloop(struct dwc3 *dwc)
> >  
> >  	while (count--) {
> >  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYACC(0));
> > -		if (!(reg & DWC3_GUSB2PHYACC_BUSY))
> > +		if (reg & DWC3_GUSB2PHYACC_DONE)
> 

> are you sure this works in all supported versions of the core?

I can't be sure about that since I've got only the 2.70a version of the
core. But as I said in the patch log it was a bit incorrect to use the
BUSY flag here in the first place. So if there is no IP core peculiarity
here which had been workarounded by polling the BUSY-flag, then I'd stick
with the DONE-flag in the busy-loop. In the former case I'd suggest to add
a useful comment why the BUSY-flag is required to be polled though...

-Sergey

> 
> John, could you confirm this for us?
> 
> thanks
> 
> -- 
> balbi


