Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113622D4118
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgLIL2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbgLIL2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:28:44 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01258C0613D6;
        Wed,  9 Dec 2020 03:28:03 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D186CDD;
        Wed,  9 Dec 2020 12:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1607513281;
        bh=iMZ/MdwMrQyEtzHeeza99WrLdvvODJuHJmMrkn9wFBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcqx1vmQkSxAxr1meC2h6m69JtY+gzxFVKAwzEcriT5hcq5ap+jOr0+6K48Qq3QKK
         CoTDTWaUQAlgrEAgVKkdTPakKidrBD6WUzE6DJjzU+Aj9PY4AsLgC/lV3tegsHQowb
         E4vFthJgZdBIHcivhQg/w3raZpO4NwN+tVbbooHI=
Date:   Wed, 9 Dec 2020 13:27:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org, leoyang.li@nxp.com,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] drivers: usb: gadget: prefer pr_*() functions over raw
 printk()
Message-ID: <X9C0vOLZOnLZoPR8@pendragon.ideasonboard.com>
References: <20201208144403.22097-1-info@metux.net>
 <X8+howyVRiTR9gv/@pendragon.ideasonboard.com>
 <9aaa06ad-0bd8-486d-b16b-66927d57cf96@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9aaa06ad-0bd8-486d-b16b-66927d57cf96@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Wed, Dec 09, 2020 at 12:11:36PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 08.12.20 16:54, Laurent Pinchart wrote:
> >> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> >> index 2b893bceea45..4834fafb3f70 100644
> >> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> >> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> >> @@ -1573,7 +1573,7 @@ static void usba_control_irq(struct usba_udc *udc, struct usba_ep *ep)
> >>  		 * generate or receive a reply right away. */
> >>  		usba_ep_writel(ep, CLR_STA, USBA_RX_SETUP);
> >>  
> >> -		/* printk(KERN_DEBUG "setup: %d: %02x.%02x\n",
> >> +		/* pr_debug("setup: %d: %02x.%02x\n",
> >>  			ep->state, crq.crq.bRequestType,
> >>  			crq.crq.bRequest); */
> > 
> > I wonder if this shouldn't be dropped instead, commented-out code isn't
> > very useful.
> 
> Indeed. Shall I send a separate patch for that ?

Yes, that would make sense.

> > When a pointer to a struct device is available, dev_err() would be much
> > better. That's however out of scope for this patch, but it would be nice
> > to address it. This would become
> > 
> > 		dev_err(&pdev->dev, "Check IRQ setup!\n");
> > 
> 
> You're right. I didn't check for that yet. I'll do it in a separate
> patch.

As most of the files touched by this patch are device drivers, dev_*()
functions should be used instead of pr_*() where possible. I'd recommend
a first patch that converts to dev_*(), and then a second patch that
converts the remaining printk()s, if any, to pr_*() in the contexts
where no struct device is available or can easily be made available.

-- 
Regards,

Laurent Pinchart
