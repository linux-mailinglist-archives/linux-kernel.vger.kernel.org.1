Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697292C8375
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgK3Lr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgK3Lr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:47:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:46:47 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1kjhdi-0004tk-W9; Mon, 30 Nov 2020 12:46:43 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1kjhdh-0000nU-FT; Mon, 30 Nov 2020 12:46:41 +0100
Date:   Mon, 30 Nov 2020 12:46:41 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Thinh.Nguyen@synopsys.com, kernel@pengutronix.de
Subject: Re: [PATCH] usb: dwc3: gadget: Restart DWC3 gadget when enabling
 pullup
Message-ID: <20201130114641.GD28656@pengutronix.de>
References: <20201120001321.773-1-wcheng@codeaurora.org>
 <20201120150804.GJ23024@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120150804.GJ23024@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:35:45 up 284 days, 19:06, 104 users,  load average: 0.39, 0.23,
 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 16:08:04 +0100, Michael Tretter wrote:
> On Thu, 19 Nov 2020 16:13:21 -0800, Wesley Cheng wrote:
> > usb_gadget_deactivate/usb_gadget_activate does not execute the UDC start
> > operation, which may leave EP0 disabled and event IRQs disabled when
> > re-activating the function. Move the enabling/disabling of USB EP0 and
> > device event IRQs to be performed in the pullup routine.
> > 
> > Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting the
> > controller")
> > 
> > Reported-by: Michael Tretter <m.tretter@pengutronix.de>
> > Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> 
> Tested-by: Michael Tretter <m.tretter@pengutronix.de>

Gentle ping. I didn't see this fix being picked up into any of the usb trees.

Michael

> 
> > ---
> >  drivers/usb/dwc3/gadget.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 5d879b7606d5..922c8b76e534 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -1988,6 +1988,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
> >  
> >  static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
> >  static void __dwc3_gadget_stop(struct dwc3 *dwc);
> > +static int __dwc3_gadget_start(struct dwc3 *dwc);
> >  
> >  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >  {
> > @@ -2050,6 +2051,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >  			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
> >  						dwc->ev_buf->length;
> >  		}
> > +	} else {
> > +		__dwc3_gadget_start(dwc);
> >  	}
> >  
> >  	ret = dwc3_gadget_run_stop(dwc, is_on, false);
> > @@ -2224,10 +2227,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
> >  	}
> >  
> >  	dwc->gadget_driver	= driver;
> > -
> > -	if (pm_runtime_active(dwc->dev))
> > -		__dwc3_gadget_start(dwc);
> > -
> >  	spin_unlock_irqrestore(&dwc->lock, flags);
> >  
> >  	return 0;
> > @@ -2253,13 +2252,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
> >  	unsigned long		flags;
> >  
> >  	spin_lock_irqsave(&dwc->lock, flags);
> > -
> > -	if (pm_runtime_suspended(dwc->dev))
> > -		goto out;
> > -
> > -	__dwc3_gadget_stop(dwc);
> > -
> > -out:
> >  	dwc->gadget_driver	= NULL;
> >  	spin_unlock_irqrestore(&dwc->lock, flags);
> >  
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
> > 
> 
